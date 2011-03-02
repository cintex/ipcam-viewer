library BarGraph;

uses
  ExceptionLog,
  ComServ,
  BarGraph_TLB in 'BarGraph_TLB.pas',
  BarGraphAx in 'BarGraphAx.pas' {BarGraphAx: CoClass},
  BarGraphVCL in '..\BarGraphVCL.pas';

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
