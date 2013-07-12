unit GuiTestUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IPCamViewerVCL, StdCtrls, ExtCtrls, JvComponentBase,
  IdBaseComponent, BarGraphVCL, ComCtrls, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP ;

type
  TTestUnitForm = class(TForm)
    TrackBar1: TTrackBar;
    IdHTTP1: TIdHTTP;
    procedure FormCreate(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
  private
    { Déclarations privées }
    FBarGraph: TBarGraph;
  public
    { Déclarations publiques }

  end;

var
  TestUnitForm: TTestUnitForm;

implementation

{$R *.dfm}



procedure TTestUnitForm.FormCreate(Sender: TObject);
var
  Viewer : TIPCamViewerVCL;
begin

  Viewer := TIPCamViewerVCL.Create(Self);
  Viewer.Align := alTop;
  Viewer.Parent := Self;
  Viewer.Height := 240;
  Viewer.Host := '192.168.1.90';
  Viewer.Port := 80;
  Viewer.JpgURL := '/jpg/image.jpg?1373621682813';
  Viewer.Username := 'admin';
  Viewer.Password := 'admin';
  Viewer.Autoconnect := True;

  Viewer.CapturePath := 'c:\temp';
  Viewer.Autocapture := True;

  Viewer := TIPCamViewerVCL.Create(Self);
  Viewer.Align := alTop;
  Viewer.Parent := Self;
  Viewer.Height := 240;
  Viewer.Host := '192.168.1.64';
  Viewer.JpgURL := '/imagep/picture.jpg';
  Viewer.Autoconnect := False;

  FBarGraph := TBarGraph.Create(Self);
  FBarGraph.Parent := Self;
  FBarGraph.Align := alClient;

  FBarGraph.Color1 := clYellow;
  FBarGraph.Color2 := clRed;

  FBarGraph.Min := 0;
  FBarGraph.Max := 10;

  //FBarGraph.ParentBackground := false;
  //FBarGraph.Color := clBlack;
  TrackBar1.Position := 5;
end;



procedure TTestUnitForm.TrackBar1Change(Sender: TObject);
begin
  FBarGraph.Position := TrackBar1.Position;
end;

end.
