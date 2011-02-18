unit GuiTestUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IPCamViewerVCL, StdCtrls, ExtCtrls;

type
  TTestUnitForm = class(TForm)
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    Viewer : TIPCamViewerVCL;
  end;

var
  TestUnitForm: TTestUnitForm;

implementation

{$R *.dfm}



procedure TTestUnitForm.Button1Click(Sender: TObject);
begin
  Viewer.Host := '192.168.1.61';
  Viewer.JpgURL := '/imagep/picture.jpg';
  Viewer.Connect;
end;

procedure TTestUnitForm.FormCreate(Sender: TObject);
begin

  Viewer := TIPCamViewerVCL.Create(Self);
  Viewer.Parent := Self;
  Viewer.Width := 640;
  Viewer.Height := 480;
  Viewer.Host := '192.168.1.63';
  Viewer.JpgURL := '/imagep/picture.jpg';
  Viewer.Autoconnect := True;


end;

procedure TTestUnitForm.FormDestroy(Sender: TObject);
begin
  Viewer.Free;
end;

end.
