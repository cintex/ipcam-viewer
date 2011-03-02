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
    FWorking : Boolean;
  protected
    FIPCamViewer : TIPCamViewerVCL;
    FPicture : TJPEGImage;
    Fwget: TIdHTTP;
    procedure Execute; override;
  public
    Result : TIPCamResult ;
    constructor Create(CreateSuspended:boolean);
    destructor Destroy; override;
  end;

  TIPCamViewerVCL = class(TPanel)
    Image: TImage;
    Update: TTimer;
    UpPanel: TPanel;
    IPAddress: TLabel;
    CxStatus: TLedPanel;
    RxTx: TLedPanel;

    procedure UpdateTimer(Sender: TObject);
  private
    FThread : TIPCamThread;
    FHost: string;
    FJpgURL: string;
    FAutoconnect: Boolean;
    procedure SetHost(const Value: string);
    procedure SetJpgURL(const Value: string);
    procedure SetAutoconnect(const Value: Boolean);
  protected
    procedure Loaded; override;
    { Déclarations privées }

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  published

    procedure Connect;
    procedure Disconnect;
    property Autoconnect : Boolean read FAutoconnect write SetAutoconnect;
    property Host : string read FHost write SetHost;
    property JpgURL : string read FJpgURL write SetJpgURL;
    { Déclarations publiques }

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


{ TIPCamViewerVCL }

constructor TIPCamViewerVCL.Create(AOwner: TComponent);
begin
  inherited;
  FThread := TIPCamThread.Create(false);
  FThread.FIPCamViewer := Self;

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


  Update := TTimer.Create(Self);
  with Update do
  begin
    Name := 'Update';
    Interval := 100;
    OnTimer := UpdateTimer;
    Enabled := False;
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
  RxTx.Free;
  CxStatus.Free;
  IPAddress.Free;
  UpPanel.Free;
  Update.Free;
  Image.Free;
  FThread.Free;
  inherited;
end;

procedure TIPCamViewerVCL.Loaded;
begin
  inherited;

end;


procedure TIPCamViewerVCL.UpdateTimer(Sender: TObject);
var
  JpgStream: TMemoryStream;
  Picture: TJPEGImage;
begin
  Update.Enabled := false;

  if FThread.Result = ipcWaiting then
  begin
    FThread.Result := ipcWorking;
    RxTx.Status := true;
  end;

  if FThread.Result = ipcOk then
  begin
    Image.Picture.Assign(FThread.FPicture);
    Update.Interval := 400;
    CxStatus.Status := True;
    RxTx.Status := false;
    IPAddress.Caption := FHost;
    FThread.Result := ipcWaiting;
  end
  else
  if FThread.Result = ipcFailed then
  begin
    Update.Interval := 4000;
    CxStatus.Status := false;
    RxTx.Status := false;
    IPAddress.Caption := IPAddress.Caption + '.';
    FThread.Result := ipcWaiting;
  end;

  if Update.Tag = 0 then
  begin
    Update.Enabled := True;
    IPAddress.Visible := true;
  end
    else
  begin
    FThread.Result := ipcUnknown;
  end;
end;


procedure TIPCamViewerVCL.Connect;
begin
  Update.Tag := 0;
  Update.Enabled := True;
  IPAddress.Caption := 'Connecting';
  FThread.Result := ipcWaiting;
end;

procedure TIPCamViewerVCL.Disconnect;
begin
  Update.Tag := 1;
  IPAddress.Caption := 'Disconnected';
end;



procedure TIPCamViewerVCL.SetAutoconnect(const Value: Boolean);
begin
  FAutoconnect := Value;

  if FAutoconnect then
    Connect
  else
    Disconnect;

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

{ TIPCamThread }

constructor TIPCamThread.Create(CreateSuspended: boolean);
begin
  inherited Create(CreateSuspended);

  FreeOnTerminate:=false;
  Priority:=tpNormal;

  FPicture := TJPEGImage.Create;
  Fwget := TIdHTTP.Create(nil);
  with Fwget do
  begin
    Name := 'wget';
    ConnectTimeout := 10000;
  end;
end;


destructor TIPCamThread.Destroy;
begin
  Fwget.Free;
  FPicture.Free;
  inherited;
end;

procedure TIPCamThread.Execute;
var
  JpgStream: TMemoryStream;
  Picture: TJPEGImage;
begin
  inherited;
  repeat
    Sleep(100); //en millisecondes
    if Result = ipcWorking then
    begin
      Assert(not FWorking);
      FWorking := True;

      with FIPCamViewer do
      begin
        try
          JpgStream := TMemoryStream.Create;
          Fwget.Get('http://'+FHost+FJpgURL, JpgStream);
          JpgStream.Position := 0;
          FPicture.LoadFromStream(JpgStream);
          Result := ipcOk;
        except
          Result := ipcFailed;
        end;

        JpgStream.Free;
      end;
      FWorking := false
    end;

  until Terminated;

end;


end.
