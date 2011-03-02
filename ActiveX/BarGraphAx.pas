unit BarGraphAx;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, ActiveX, Classes, Controls, Graphics, Menus, Forms, StdCtrls,
  ComServ, StdVCL, AXCtrls, BarGraph_TLB, BarGraphVCL, ExtCtrls;

type
  TBarGraphAx = class(TActiveXControl, IBarGraphAx)
  private
    { Déclarations privées }
    FDelphiControl: TBarGraph;
    FEvents: IBarGraphAxEvents;
  protected
    { Déclarations protégées }
    procedure DefinePropertyPages(DefinePropertyPage: TDefinePropertyPage); override;
    procedure EventSinkChanged(const EventSink: IUnknown); override;
    procedure InitializeControl; override;
    function DrawTextBiDiModeFlagsReadingOnly: Integer; safecall;
    function Get_AlignDisabled: WordBool; safecall;
    function Get_AlignWithMargins: WordBool; safecall;
    function Get_Color: OLE_COLOR; safecall;
    function Get_Color1: OLE_COLOR; safecall;
    function Get_Color2: OLE_COLOR; safecall;
    function Get_DockSite: WordBool; safecall;
    function Get_DoubleBuffered: WordBool; safecall;
    function Get_Enabled: WordBool; safecall;
    function Get_ExplicitHeight: Integer; safecall;
    function Get_ExplicitLeft: Integer; safecall;
    function Get_ExplicitTop: Integer; safecall;
    function Get_ExplicitWidth: Integer; safecall;
    function Get_Max: Integer; safecall;
    function Get_Min: Integer; safecall;
    function Get_MouseInClient: WordBool; safecall;
    function Get_ParentBackground: WordBool; safecall;
    function Get_ParentCustomHint: WordBool; safecall;
    function Get_ParentDoubleBuffered: WordBool; safecall;
    function Get_Position: Integer; safecall;
    function Get_Quantity: Integer; safecall;
    function Get_UseDockManager: WordBool; safecall;
    function Get_Visible: WordBool; safecall;
    function Get_VisibleDockClientCount: Integer; safecall;
    function IsRightToLeft: WordBool; safecall;
    function UseRightToLeftReading: WordBool; safecall;
    function UseRightToLeftScrollBar: WordBool; safecall;
    procedure InitiateAction; safecall;
    procedure Set_AlignWithMargins(Value: WordBool); safecall;
    procedure Set_Color(Value: OLE_COLOR); safecall;
    procedure Set_Color1(Value: OLE_COLOR); safecall;
    procedure Set_Color2(Value: OLE_COLOR); safecall;
    procedure Set_DockSite(Value: WordBool); safecall;
    procedure Set_DoubleBuffered(Value: WordBool); safecall;
    procedure Set_Enabled(Value: WordBool); safecall;
    procedure Set_Max(Value: Integer); safecall;
    procedure Set_Min(Value: Integer); safecall;
    procedure Set_ParentBackground(Value: WordBool); safecall;
    procedure Set_ParentCustomHint(Value: WordBool); safecall;
    procedure Set_ParentDoubleBuffered(Value: WordBool); safecall;
    procedure Set_Position(Value: Integer); safecall;
    procedure Set_Quantity(Value: Integer); safecall;
    procedure Set_UseDockManager(Value: WordBool); safecall;
    procedure Set_Visible(Value: WordBool); safecall;
    procedure SetDesignVisible(Value: WordBool); safecall;
    procedure SetSubComponent(IsSubComponent: WordBool); safecall;
  end;

implementation

uses ComObj, ImgList;

{ TBarGraphAx }

procedure TBarGraphAx.DefinePropertyPages(DefinePropertyPage: TDefinePropertyPage);
begin
  {TODO: Définir des pages de propriétés ici. Les pages de propriétés sont définies en
   appelant DefinePropertyPage avec l'id de classe de la page. Exemple :
      DefinePropertyPage(Class_BarGraphAxPage); }
end;

procedure TBarGraphAx.EventSinkChanged(const EventSink: IUnknown);
begin
  FEvents := EventSink as IBarGraphAxEvents;
end;

procedure TBarGraphAx.InitializeControl;
begin
  FDelphiControl := Control as TBarGraph;
end;

function TBarGraphAx.DrawTextBiDiModeFlagsReadingOnly: Integer;
begin
  Result := FDelphiControl.DrawTextBiDiModeFlagsReadingOnly;
end;

function TBarGraphAx.Get_AlignDisabled: WordBool;
begin
  Result := FDelphiControl.AlignDisabled;
end;

function TBarGraphAx.Get_AlignWithMargins: WordBool;
begin
  Result := FDelphiControl.AlignWithMargins;
end;

function TBarGraphAx.Get_Color: OLE_COLOR;
begin
  Result := OLE_COLOR(FDelphiControl.Color);
end;

function TBarGraphAx.Get_Color1: OLE_COLOR;
begin
  Result := OLE_COLOR(FDelphiControl.Color1);
end;

function TBarGraphAx.Get_Color2: OLE_COLOR;
begin
  Result := OLE_COLOR(FDelphiControl.Color2);
end;

function TBarGraphAx.Get_DockSite: WordBool;
begin
  Result := FDelphiControl.DockSite;
end;

function TBarGraphAx.Get_DoubleBuffered: WordBool;
begin
  Result := FDelphiControl.DoubleBuffered;
end;

function TBarGraphAx.Get_Enabled: WordBool;
begin
  Result := FDelphiControl.Enabled;
end;

function TBarGraphAx.Get_ExplicitHeight: Integer;
begin
  Result := FDelphiControl.ExplicitHeight;
end;

function TBarGraphAx.Get_ExplicitLeft: Integer;
begin
  Result := FDelphiControl.ExplicitLeft;
end;

function TBarGraphAx.Get_ExplicitTop: Integer;
begin
  Result := FDelphiControl.ExplicitTop;
end;

function TBarGraphAx.Get_ExplicitWidth: Integer;
begin
  Result := FDelphiControl.ExplicitWidth;
end;

function TBarGraphAx.Get_Max: Integer;
begin
  Result := FDelphiControl.Max;
end;

function TBarGraphAx.Get_Min: Integer;
begin
  Result := FDelphiControl.Min;
end;

function TBarGraphAx.Get_MouseInClient: WordBool;
begin
  Result := FDelphiControl.MouseInClient;
end;

function TBarGraphAx.Get_ParentBackground: WordBool;
begin
  Result := FDelphiControl.ParentBackground;
end;

function TBarGraphAx.Get_ParentCustomHint: WordBool;
begin
  Result := FDelphiControl.ParentCustomHint;
end;

function TBarGraphAx.Get_ParentDoubleBuffered: WordBool;
begin
  Result := FDelphiControl.ParentDoubleBuffered;
end;

function TBarGraphAx.Get_Position: Integer;
begin
  Result := FDelphiControl.Position;
end;

function TBarGraphAx.Get_Quantity: Integer;
begin
  Result := FDelphiControl.Quantity;
end;

function TBarGraphAx.Get_UseDockManager: WordBool;
begin
  Result := FDelphiControl.UseDockManager;
end;

function TBarGraphAx.Get_Visible: WordBool;
begin
  Result := FDelphiControl.Visible;
end;

function TBarGraphAx.Get_VisibleDockClientCount: Integer;
begin
  Result := FDelphiControl.VisibleDockClientCount;
end;

function TBarGraphAx.IsRightToLeft: WordBool;
begin
  Result := FDelphiControl.IsRightToLeft;
end;

function TBarGraphAx.UseRightToLeftReading: WordBool;
begin
  Result := FDelphiControl.UseRightToLeftReading;
end;

function TBarGraphAx.UseRightToLeftScrollBar: WordBool;
begin
  Result := FDelphiControl.UseRightToLeftScrollBar;
end;

procedure TBarGraphAx.InitiateAction;
begin
  FDelphiControl.InitiateAction;
end;

procedure TBarGraphAx.Set_AlignWithMargins(Value: WordBool);
begin
  FDelphiControl.AlignWithMargins := Value;
end;

procedure TBarGraphAx.Set_Color(Value: OLE_COLOR);
begin
  FDelphiControl.Color := TColor(Value);
end;

procedure TBarGraphAx.Set_Color1(Value: OLE_COLOR);
begin
  FDelphiControl.Color1 := TColor(Value);
end;

procedure TBarGraphAx.Set_Color2(Value: OLE_COLOR);
begin
  FDelphiControl.Color2 := TColor(Value);
end;

procedure TBarGraphAx.Set_DockSite(Value: WordBool);
begin
  FDelphiControl.DockSite := Value;
end;

procedure TBarGraphAx.Set_DoubleBuffered(Value: WordBool);
begin
  FDelphiControl.DoubleBuffered := Value;
end;

procedure TBarGraphAx.Set_Enabled(Value: WordBool);
begin
  FDelphiControl.Enabled := Value;
end;

procedure TBarGraphAx.Set_Max(Value: Integer);
begin
  FDelphiControl.Max := Value;
end;

procedure TBarGraphAx.Set_Min(Value: Integer);
begin
  FDelphiControl.Min := Value;
end;

procedure TBarGraphAx.Set_ParentBackground(Value: WordBool);
begin
  FDelphiControl.ParentBackground := Value;
end;

procedure TBarGraphAx.Set_ParentCustomHint(Value: WordBool);
begin
  FDelphiControl.ParentCustomHint := Value;
end;

procedure TBarGraphAx.Set_ParentDoubleBuffered(Value: WordBool);
begin
  FDelphiControl.ParentDoubleBuffered := Value;
end;

procedure TBarGraphAx.Set_Position(Value: Integer);
begin
  FDelphiControl.Position := Value;
end;

procedure TBarGraphAx.Set_Quantity(Value: Integer);
begin
  FDelphiControl.Quantity := Value;
end;

procedure TBarGraphAx.Set_UseDockManager(Value: WordBool);
begin
  FDelphiControl.UseDockManager := Value;
end;

procedure TBarGraphAx.Set_Visible(Value: WordBool);
begin
  FDelphiControl.Visible := Value;
end;

procedure TBarGraphAx.SetDesignVisible(Value: WordBool);
begin
  FDelphiControl.SetDesignVisible(Value);
end;

procedure TBarGraphAx.SetSubComponent(IsSubComponent: WordBool);
begin
  FDelphiControl.SetSubComponent(IsSubComponent);
end;

initialization
  TActiveXControlFactory.Create(
    ComServer,
    TBarGraphAx,
    TBarGraph,
    Class_BarGraphAx,
    2,
    '',
    0,
    tmApartment);
end.
