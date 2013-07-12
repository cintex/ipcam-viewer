library IPCamViewer;

uses
  ExceptionLog,
  ComServ,
  IPCamViewerVCL in '..\IPCamViewerVCL.pas',
  IPCamViewer_TLB in 'IPCamViewer_TLB.pas',
  IPCamViewerAx in 'IPCamViewerAx.pas' {IPCamViewerAx: CoClass};

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
