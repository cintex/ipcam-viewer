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
    procedure SetHost(const Value: string);
    { Déclarations privées }

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  published
    procedure Connect;
    procedure Disconnect;
    property Host : string read FHost write SetHost;
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


{ TIPCamViewerVCL }

constructor TIPCamViewerVCL.Create(AOwner: TComponent);
begin
  inherited;
  IdIOHandlerStack := TIdIOHandlerStack.Create(Self);

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
    Enabled := True;
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


procedure TIPCamViewerVCL.UpdateTimer(Sender: TObject);
var
  JpgStream: TMemoryStream;
  Picture: TJPEGImage;
begin
  Update.Enabled := false;
  wget.ConnectTimeout := 100;
  wget.ReadTimeout := 2000;

  try
    JpgStream := TMemoryStream.Create;
    wget.Get('http://'+FHost+'/imagep/picture.jpg', JpgStream);
    JpgStream.Position := 0;
    RxTx.Status := not RxTx.Status;

    Picture := TJPEGImage.Create;
    Picture.LoadFromStream(JpgStream);
    Image.Picture.Assign(Picture);
    Picture.Free;
    Update.Interval := 100;
    CxStatus.Status := True;
  except
    Update.Interval := 5000;
    CxStatus.Status := false;
  end;

  JpgStream.Free;

  if Update.Tag = 0 then
  begin
    Update.Enabled := True;
    IPAddress.Visible := true;
  end
    else
  begin
    IPAddress.Visible := False;
  end;
end;


procedure TIPCamViewerVCL.Connect;
begin
  Update.Tag := 0;
  Update.Enabled := True;

end;

procedure TIPCamViewerVCL.Disconnect;
begin
  Update.Tag := 1;
end;

procedure TIPCamViewerVCL.SetHost(const Value: string);
begin
  FHost := Value;
  IPAddress.Caption := FHost;
end;

end.
