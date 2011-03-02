program IPCamViewer;

uses
  Forms,
  IPCamViewerVCL in 'IPCamViewerVCL.pas',
  GuiTestUnit in 'GuiTestUnit.pas' {TestUnitForm},
  BarGraphVCL in 'BarGraphVCL.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTestUnitForm, TestUnitForm);
  Application.Run;
end.
