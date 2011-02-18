unit GuiTestUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IPCamViewerVCL, StdCtrls;

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
  Viewer.Host := '192.168.1.63';
end;

procedure TTestUnitForm.FormCreate(Sender: TObject);
begin

  Viewer := TIPCamViewerVCL.Create(Self);
  Viewer.Parent := Self;
  Viewer.Width := 640;
  Viewer.Height := 480;


end;

procedure TTestUnitForm.FormDestroy(Sender: TObject);
begin
  Viewer.Free;
end;

end.
