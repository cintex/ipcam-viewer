program IPCamViewer;

uses
  ExceptionLog,
  Forms,
  IPCamViewerVCL in 'IPCamViewerVCL.pas',
  GuiTestUnit in 'GuiTestUnit.pas' {TestUnitForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTestUnitForm, TestUnitForm);
  Application.Run;
end.
