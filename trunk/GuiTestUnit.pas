unit GuiTestUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IPCamViewerVCL, StdCtrls, ExtCtrls, JvComponentBase, JvThread,
  IdBaseComponent ;

type
  TTestUnitForm = class(TForm)
    Button1: TButton;
    JvThread1: TJvThread;
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
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


  Viewer := TIPCamViewerVCL.Create(Self);
  Viewer.Align := alTop;
  Viewer.Parent := Self;
  Viewer.Height := 240;
  Viewer.Host := '192.168.1.62';
  Viewer.JpgURL := '/imagep/picture.jpg';
  Viewer.Autoconnect := True;

end;

end.
