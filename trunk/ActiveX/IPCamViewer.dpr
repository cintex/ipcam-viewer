library IPCamViewer;

uses
  ExceptionLog,
  ComServ,
  IPCamViewerCtrl_TLB in 'IPCamViewerCtrl_TLB.pas',
  IPCamViewerAx in 'IPCamViewerAx.pas' {IPCamViewerAx: CoClass},
  IPCamViewerVCL in '..\IPCamViewerVCL.pas';

{$E ocx}

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer;

{$R *.TLB}

{$R *.RES}

begin
end.
