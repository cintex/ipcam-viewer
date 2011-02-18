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
  ExtCtrls,
  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdHTTP,
  StdCtrls,
  JvExControls,
  JvLED,
  IdIOHandler,
  IdIOHandlerSocket,
  IdIOHandlerStack;

type
  TIPCamViewerVCL = class(TPanel)
    wget: TIdHTTP;
    Image: TImage;
    Update: TTimer;
    UpPanel: TPanel;
    IPAddress: TLabel;
    CxStatus: TJvLED;
    RxTx: TJvLED;
    IdIOHandlerStack: TIdIOHandlerStack;
    procedure UpdateTimer(Sender: TObject);
  private
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

uses
  jpeg;

procedure Register;
begin
  RegisterComponents('GLDali', [TIPCamViewerVCL]);
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
  IdIOHandlerStack := TIdIOHandlerStack.Create(Self);
  BevelOuter := bvNone;

  wget := TIdHTTP.Create(Self);
  with wget do
  begin
    Name := 'wget';
    IOHandler := IdIOHandlerStack;
  end;

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
  CxStatus := TJvLED.Create(Self);
  RxTx := TJvLED.Create(Self);

  with UpPanel do
  begin
    Name := 'UpPanel';
    Parent := Self;
    Left := 0;
    Top := 0;
    Width := 468;
    Height := 28;
    Align := alTop;
    BevelOuter := bvNone;
    Caption := 'Panel1';
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
    Left := 448;
    Top := 0;
    Width := 20;
    Height := 28;
    Align := alRight;
    Status := False;
  end;
  with RxTx do
  begin
    Name := 'RxTx';
    Parent := UpPanel;
    Left := 428;
    Top := 0;
    Width := 20;
    Height := 28;
    Align := alRight;
    ColorOn := clYellow;
    ColorOff := clBlack;
    Status := False;
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
  wget.Free;
  IdIOHandlerStack.Free;
  inherited;
end;

procedure TIPCamViewerVCL.Loaded;
begin
  inherited;

  if Autoconnect then
    Connect;
end;


procedure TIPCamViewerVCL.UpdateTimer(Sender: TObject);
var
  JpgStream: TMemoryStream;
  Picture: TJPEGImage;
begin
  Update.Enabled := false;
  wget.ConnectTimeout := 100;
  wget.ReadTimeout := 1500;

  try
    JpgStream := TMemoryStream.Create;
    wget.Get('http://'+FHost+FJpgURL, JpgStream);
    JpgStream.Position := 0;
    RxTx.Status := not RxTx.Status;

    Picture := TJPEGImage.Create;
    Picture.LoadFromStream(JpgStream);
    Image.Picture.Assign(Picture);
    Picture.Free;
    Update.Interval := 100;
    CxStatus.Status := True;
    IPAddress.Caption := FHost;
  except
    Update.Interval := 2000;
    CxStatus.Status := false;
    IPAddress.Caption := IPAddress.Caption + '.';
  end;

  JpgStream.Free;

  if Update.Tag = 0 then
  begin
    Update.Enabled := True;
    IPAddress.Visible := true;
  end
    else
  begin

  end;
end;


procedure TIPCamViewerVCL.Connect;
begin
  Update.Tag := 0;
  Update.Enabled := True;
  IPAddress.Caption := 'Connecting';
end;

procedure TIPCamViewerVCL.Disconnect;
begin
  Update.Tag := 1;
  IPAddress.Caption := 'Disconnected';
end;



procedure TIPCamViewerVCL.SetAutoconnect(const Value: Boolean);
begin
  FAutoconnect := Value;
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

end.
