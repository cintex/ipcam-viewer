unit GuiTestUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IPCamViewerVCL, StdCtrls, ExtCtrls, JvComponentBase,
  IdBaseComponent, BarGraphVCL, ComCtrls ;

type
  TTestUnitForm = class(TForm)
    TrackBar1: TTrackBar;
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
  Viewer.Host := '192.168.1.63';
  Viewer.JpgURL := '/imagep/picture.jpg';
  Viewer.Autoconnect := True;

  Viewer := TIPCamViewerVCL.Create(Self);
  Viewer.Align := alTop;
  Viewer.Parent := Self;
  Viewer.Height := 240;
  Viewer.Host := '192.168.1.64';
  Viewer.JpgURL := '/imagep/picture.jpg';
  Viewer.Autoconnect := True;

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
