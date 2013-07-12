unit IPCamViewerVCL;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ExtCtrls,
  jpeg,
  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdHTTP,
  IdAuthentication,
  IdIOHandler,
  IdIOHandlerSocket,
  IdIOHandlerStack;

type

  TIPCamResult =
  (
    ipcUnknown,
    ipcWaiting,
    ipcWorking,
    ipcFailed,
    ipcOk
  );

  TLedPanel = class(TPanel)
  private
    FStatus: Boolean;
    FColorOff: TColor;
    FColorOn: TColor;
    procedure SetStatus(const Value: Boolean);
    procedure SetColorOff(const Value: TColor);
    procedure SetColorOn(const Value: TColor);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  published
    property Status : Boolean read FStatus write SetStatus;
    property ColorOn : TColor read FColorOn write SetColorOn;
    property ColorOff : TColor read FColorOff write SetColorOff;
  end;

  TIPCamViewerVCL = class;

  TIPCamThread = class(TThread)
  private
    procedure OnAuthorization(Sender: TObject; Authentication: TIdAuthentication; var Handled: Boolean);
  protected
    FGui: TIPCamViewerVCL;
    FName: string;
    FPicture : TJPEGImage;
    Fwget: TIdHTTP;
    FLastCapture: Cardinal;
    procedure Execute; override;
    procedure UpdateGui;
  public
    FResult : TIPCamResult ;
    constructor Create(CreateSuspended:boolean; Gui: TIPCamViewerVCL; Name: string);
    destructor Destroy; override;
    procedure Init;
  end;

  TIPCamViewerVCL = class(TPanel)
    Image: TImage;
    UpPanel: TPanel;
    IPAddress: TLabel;
    CxStatus: TLedPanel;
    RxTx: TLedPanel;
  strict private
    FThread : TIPCamThread;
    FHost: string;
    FJpgURL: string;
    FAutoconnect: Boolean;
    FPort: Word;
    FPassword: string;
    FUsername: string;
    FWaitTime: word;
    FCapturePath: string;
    FCaptureInterval: Cardinal;
    FAutocapture: Boolean;
    FCameraName: string;
    procedure SetHost(const Value: string);
    procedure SetJpgURL(const Value: string);
    procedure SetAutoconnect(const Value: Boolean);
    procedure SetPort(const Value: Word);
    procedure SetPassword(const Value: string);
    procedure SetUsername(const Value: string);
    procedure SetWaitTime(const Value: word);
    procedure SetCapturePath(const Value: string);
    procedure SetCaptureInterval(const Value: Cardinal);
    procedure SetAutocapture(const Value: Boolean);
    procedure SetCameraName(const Value: string);
    function GetCameraName: string;
  protected
    procedure Loaded; override;
    procedure ThreadCreate;
    procedure ThreadDestroy;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    procedure Connect;
    procedure Disconnect;
    property Autoconnect : Boolean read FAutoconnect write SetAutoconnect;
    property Autocapture: Boolean read FAutocapture write SetAutocapture;
    property Host : string read FHost write SetHost;
    property Port: Word read FPort write SetPort default 80;
    property JpgURL : string read FJpgURL write SetJpgURL;
    property Username: string read FUsername write SetUsername;
    property Password: string read FPassword write SetPassword;
    property WaitTime: word read FWaitTime write SetWaitTime default 100;
    property CapturePath: string read FCapturePath write SetCapturePath;
    property CaptureInterval: Cardinal read FCaptureInterval write SetCaptureInterval default 1000;
    property CameraName: string read GetCameraName write SetCameraName;
  end;


procedure Register;

implementation


procedure Register;
begin
  RegisterComponents('Samples', [TIPCamViewerVCL]);
end;

function IsWrongIP(ip: string): Boolean;
var
  z, i: byte;
  st: array[1..3] of byte;
const
  ziff = ['0'..'9'];
begin
  st[1]  := 0;
  st[2]  := 0;
  st[3]  := 0;
  z      := 0;
  Result := False;
  for i := 1 to Length(ip) do if ip[i] in ziff then
  else
  begin
    if ip[i] = '.' then
    begin
      Inc(z);
      if z < 4 then st[z] := i
      else
      begin
        IsWrongIP := True;
        Exit;
      end;
    end
    else
    begin
      IsWrongIP := True;
      Exit;
    end;
  end;
  if (z <> 3) or (st[1] < 2) or (st[3] = Length(ip)) or (st[1] + 2 > st[2]) or
    (st[2] + 2 > st[3]) or (st[1] > 4) or (st[2] > st[1] + 4) or (st[3] > st[2] + 4) then
  begin
    IsWrongIP := True;
    Exit;
  end;
  z := StrToInt(Copy(ip, 1, st[1] - 1));
  if (z > 255) or (ip[1] = '0') then
  begin
    IsWrongIP := True;
    Exit;
  end;
  z := StrToInt(Copy(ip, st[1] + 1, st[2] - st[1] - 1));
  if (z > 255) or ((z <> 0) and (ip[st[1] + 1] = '0')) then
  begin
    IsWrongIP := True;
    Exit;
  end;
  z := StrToInt(Copy(ip, st[2] + 1, st[3] - st[2] - 1));
  if (z > 255) or ((z <> 0) and (ip[st[2] + 1] = '0')) then
  begin
    IsWrongIP := True;
    Exit;
  end;
  z := StrToInt(Copy(ip, st[3] + 1, Length(ip) - st[3]));
  if (z > 255) or ((z <> 0) and (ip[st[3] + 1] = '0')) then
  begin
    IsWrongIP := True;
    Exit;
  end;
end;



{ TIPCamThread }

constructor TIPCamThread.Create(CreateSuspended: boolean; Gui: TIPCamViewerVCL; Name: string);
begin
  inherited Create(CreateSuspended);
  FreeOnTerminate:=false;
  Priority:=tpNormal;
  FGui := Gui;
  FName := Name;

  FPicture := TJPEGImage.Create;
  Fwget := TIdHTTP.Create(nil);
  with Fwget do
  begin
    Name := 'wget';
    ConnectTimeout := 10000;
    OnAuthorization := Self.OnAuthorization;
  end;

  FLastCapture := 0;
  FGui.IPAddress.Visible := true;
end;


destructor TIPCamThread.Destroy;
begin
  FGui.IPAddress.Visible := true;
  FGui.CxStatus.Status := false;
  FGui.RxTx.Status := false;

  Fwget.Free;
  FPicture.Free;
  inherited;
end;

procedure TIPCamThread.OnAuthorization(Sender: TObject; Authentication: TIdAuthentication; var Handled: Boolean);
begin
  Authentication.Username := FGui.Username;
  Authentication.Password := FGui.Password;
  Handled:=true;
end;


procedure TIPCamThread.Execute;
var
  JpgStream: TMemoryStream;
  Picture: TJPEGImage;
CONST
  TIME_WAIT_FAILED_MS = 3000;
begin
  inherited;
  NameThreadForDebugging(FName);
  repeat
    if FResult = ipcWorking then
    begin
      JpgStream := TMemoryStream.Create;
      try
        Fwget.Get(Format('http://%s:%d%s', [FGui.Host, FGui.Port, FGui.JpgURL]), JpgStream);
        JpgStream.Position := 0;
        FPicture.LoadFromStream(JpgStream);
        FResult := ipcOk;
      except
        FResult := ipcFailed;
      end;
      JpgStream.Free;
    end
      else
    if FResult = ipcFailed then
    begin
      Sleep(TIME_WAIT_FAILED_MS);
      FResult := ipcWaiting;
    end
      else
    if FResult = ipcWaiting then
    begin
      Sleep(FGui.WaitTime);
      FResult := ipcWorking;
    end
      else
    if FResult = ipcOk then
    begin
      FResult := ipcWaiting;
    end;

    Synchronize(UpdateGui);
  until
    Terminated;
end;

procedure TIPCamThread.Init;
begin
  FResult := ipcWaiting;
end;

procedure TIPCamThread.UpdateGui;
var
  Filename: string;
begin

  if FResult = ipcWaiting then
  begin
    FGui.RxTx.Status := not FGui.RxTx.Status;
  end;

  if FResult = ipcOk then
  begin
    FGui.Image.Picture.Assign(FPicture);
    FGui.CxStatus.Status := True;
    FGui.IPAddress.Caption := FGui.Host;

    if FGui.Autocapture and DirectoryExists(FGui.CapturePath) then
    begin
      if (GetTickCount - FLastCapture) > FGui.CaptureInterval then
      begin
        Filename := Format('%s-%s.jpg', [FGui.CameraName, FormatDateTime('yy-mm-dd-hh-nn-ss', now)]);
        FGui.Image.Picture.SaveToFile(IncludeTrailingPathDelimiter(FGui.CapturePath)+Filename);

        FLastCapture := GetTickCount;
      end;
    end;


  end
  else
  if FResult = ipcFailed then
  begin
    FGui.CxStatus.Status := false;
    FGui.RxTx.Status := false;
    FGui.IPAddress.Caption := FGui.IPAddress.Caption + '.';
  end;
(*
  if Update.Tag = 0 then
  begin
    Update.Enabled := True;
    IPAddress.Visible := true;
  end
    else
  begin
    FThread.Result := ipcUnknown;
  end;
*)
end;



{ TIPCamViewerVCL }

constructor TIPCamViewerVCL.Create(AOwner: TComponent);
begin
  inherited;
  FPort := 80;
  FWaitTime := 100;
  FCaptureInterval := 1000;

  BevelOuter := bvNone;
  Caption := 'IPCam-Viewer';
  //Font.Size := 24;
  Font.Color := clGrayText;

  Image := TImage.Create(Self);
  with Image do
  begin
    Name := 'Image';
    Parent := Self;
    Align := alClient;
    Stretch := True;
  end;


  UpPanel := TPanel.Create(Self);
  IPAddress := TLabel.Create(Self);
  CxStatus := TLedPanel.Create(Self);
  RxTx := TLedPanel.Create(Self);

  with UpPanel do
  begin
    Name := 'UpPanel';
    Parent := Self;
    Left := 0;
    Top := 0;
    Width := 468;
    Height := 20;
    Align := alTop;
    BevelOuter := bvNone;
    Caption := '';
    Color := -1;
    ParentBackground := False;
    TabOrder := 0;
  end;
  with IPAddress do
  begin
    Name := 'IPAddress';
    Parent := UpPanel;
    AlignWithMargins := True;
    Align := alClient;
    Caption := '...';
    Font.Color := clWhite;
    Font.Style := [fsBold];
    Layout := tlCenter;
  end;
  with CxStatus do
  begin
    Name := 'CxStatus';
    Parent := UpPanel;
    Caption := '';
    Left := 448;
    Top := 0;
    Width := 8;
    Margins.SetBounds(0,6,6,6);
    Align := alRight;
    Status := False;
    AlignWithMargins := true;
  end;
  with RxTx do
  begin
    Name := 'RxTx';
    Parent := UpPanel;
    Caption := '';
    Left := 428;
    Top := 0;
    Width := 8;
    Margins.SetBounds(0,6,6,6);
    Align := alRight;
    ColorOn := clYellow;
    ColorOff := clBlack;
    Status := False;
    AlignWithMargins := true;
  end;

  Disconnect;
end;


destructor TIPCamViewerVCL.Destroy;
begin
  ThreadDestroy;
  Disconnect;
  RxTx.Free;
  CxStatus.Free;
  IPAddress.Free;
  UpPanel.Free;
  Image.Free;
  inherited;
end;

procedure TIPCamViewerVCL.Loaded;
begin
  inherited;

end;


procedure TIPCamViewerVCL.Connect;
begin
  IPAddress.Caption := 'Connecting';
  ThreadCreate;
  FThread.Init;
end;

procedure TIPCamViewerVCL.Disconnect;
begin
  ThreadDestroy;
  IPAddress.Caption := 'Disconnected';
end;





procedure TIPCamViewerVCL.SetAutocapture(const Value: Boolean);
begin
  FAutocapture := Value;
  if Assigned(FThread) then
    FThread.FLastCapture := 0;
end;

procedure TIPCamViewerVCL.SetAutoconnect(const Value: Boolean);
begin
  FAutoconnect := Value;

  if FAutoconnect then
    Connect
  else
    Disconnect;

end;

function TIPCamViewerVCL.GetCameraName: string;
begin
  if FCameraName = EmptyStr then
    Result := 'NoName'
  else
    Result := FCameraName;
end;

procedure TIPCamViewerVCL.SetCameraName(const Value: string);
begin
  FCameraName := Value;
end;

procedure TIPCamViewerVCL.SetCaptureInterval(const Value: Cardinal);
begin
  FCaptureInterval := Value;
end;

procedure TIPCamViewerVCL.SetCapturePath(const Value: string);
begin
  FCapturePath := Value;
end;

procedure TIPCamViewerVCL.SetHost(const Value: string);
begin
  if not IsWrongIP(Value) then
    FHost := Value;
end;

procedure TIPCamViewerVCL.SetJpgURL(const Value: string);
begin
  FJpgURL := Value;
end;

procedure TIPCamViewerVCL.SetPassword(const Value: string);
begin
  FPassword := Value;
end;

procedure TIPCamViewerVCL.SetPort(const Value: Word);
begin
  FPort := Value;
end;

procedure TIPCamViewerVCL.SetUsername(const Value: string);
begin
  FUsername := Value;
end;

procedure TIPCamViewerVCL.SetWaitTime(const Value: word);
begin
  FWaitTime := Value;
end;

procedure TIPCamViewerVCL.ThreadCreate;
begin
  Assert(FThread = nil);
  FThread := TIPCamThread.Create(False, Self, 'IPCamThread');
end;

procedure TIPCamViewerVCL.ThreadDestroy;
begin
  if Assigned(FThread) then
  begin
    FThread.Terminate;
    if not FThread.Suspended then
    begin
      Assert(FThread.Terminated);
      FThread.WaitFor;
      FThread.Free;
    end;
    FThread := nil;
  end;
end;
{ TLedPanel }

constructor TLedPanel.Create(AOwner: TComponent);
begin
  inherited;
  BevelOuter := bvNone;
  ParentBackground := False;
  ColorOn := clLime;
  ColorOff := clRed;
end;

destructor TLedPanel.Destroy;
begin

  inherited;
end;

procedure TLedPanel.SetColorOff(const Value: TColor);
begin
  FColorOff := Value;
  Status := FStatus;
end;

procedure TLedPanel.SetColorOn(const Value: TColor);
begin
  FColorOn := Value;
  Status := FStatus;
end;

procedure TLedPanel.SetStatus(const Value: Boolean);
begin
  FStatus := Value;

  if FStatus then
    Color := ColorOn
  else
    Color := ColorOff;
end;


end.
