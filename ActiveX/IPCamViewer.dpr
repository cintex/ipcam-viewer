library IPCamViewer;

uses
  ExceptionLog,
  ComServ,
  IPCamViewer_TLB in 'IPCamViewer_TLB.pas',
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
