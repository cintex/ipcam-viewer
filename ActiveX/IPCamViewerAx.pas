unit IPCamViewerAx;

{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Windows, ActiveX, Classes, Controls, Graphics, Menus, Forms, StdCtrls,
  ComServ, StdVCL, AXCtrls, IPCamViewer_TLB, IPCamViewerVCL, Vcl.ExtCtrls;

type
  TIPCamViewerAx = class(TActiveXControl, IIPCamViewerAx)
  private
    { Déclarations privées }
    FDelphiControl: TIPCamViewerVCL;
    FEvents: IIPCamViewerAxEvents;
    procedure CanResizeEvent(Sender: TObject; var NewWidth, NewHeight: Integer; var Resize: Boolean);
    procedure ClickEvent(Sender: TObject);
    procedure ConstrainedResizeEvent(Sender: TObject; var MinWidth, MinHeight, MaxWidth, MaxHeight: Integer);
    procedure DblClickEvent(Sender: TObject);
    procedure MouseEnterEvent(Sender: TObject);
    procedure MouseLeaveEvent(Sender: TObject);
    procedure ResizeEvent(Sender: TObject);
  protected
    { Déclarations protégées }
    procedure DefinePropertyPages(DefinePropertyPage: TDefinePropertyPage); override;
    procedure EventSinkChanged(const EventSink: IUnknown); override;
    procedure InitializeControl; override;
    function DrawTextBiDiModeFlagsReadingOnly: Integer; safecall;
    function Get_AlignDisabled: WordBool; safecall;
    function Get_Alignment: TxAlignment; safecall;
    function Get_AlignWithMargins: WordBool; safecall;
    function Get_Autocapture: WordBool; safecall;
    function Get_Autoconnect: WordBool; safecall;
    function Get_AutoSize: WordBool; safecall;
    function Get_BevelInner: TxBevelCut; safecall;
    function Get_BevelKind: TxBevelKind; safecall;
    function Get_BevelOuter: TxBevelCut; safecall;
    function Get_BevelWidth: Integer; safecall;
    function Get_BorderStyle: TxBorderStyle; safecall;
    function Get_BorderWidth: Integer; safecall;
    function Get_CameraName: WideString; safecall;
    function Get_Caption: WideString; safecall;
    function Get_CaptureInterval: LongWord; safecall;
    function Get_CapturePath: WideString; safecall;
    function Get_Color: OLE_COLOR; safecall;
    function Get_Ctl3D: WordBool; safecall;
    function Get_DockSite: WordBool; safecall;
    function Get_DoubleBuffered: WordBool; safecall;
    function Get_DragCursor: Smallint; safecall;
    function Get_DragMode: TxDragMode; safecall;
    function Get_Enabled: WordBool; safecall;
    function Get_ExplicitHeight: Integer; safecall;
    function Get_ExplicitLeft: Integer; safecall;
    function Get_ExplicitTop: Integer; safecall;
    function Get_ExplicitWidth: Integer; safecall;
    function Get_Font: IFontDisp; safecall;
    function Get_FullRepaint: WordBool; safecall;
    function Get_Host: WideString; safecall;
    function Get_JpgURL: WideString; safecall;
    function Get_Locked: WordBool; safecall;
    function Get_MouseInClient: WordBool; safecall;
    function Get_ParentBackground: WordBool; safecall;
    function Get_ParentColor: WordBool; safecall;
    function Get_ParentCtl3D: WordBool; safecall;
    function Get_ParentCustomHint: WordBool; safecall;
    function Get_ParentDoubleBuffered: WordBool; safecall;
    function Get_Password: WideString; safecall;
    function Get_Port: Word; safecall;
    function Get_ShowCaption: WordBool; safecall;
    function Get_UseDockManager: WordBool; safecall;
    function Get_Username: WideString; safecall;
    function Get_VerticalAlignment: TxVerticalAlignment; safecall;
    function Get_Visible: WordBool; safecall;
    function Get_VisibleDockClientCount: Integer; safecall;
    function Get_WaitTime: Word; safecall;
    function IsRightToLeft: WordBool; safecall;
    function QualifiedClassName: WideString; safecall;
    function UnitScope: WideString; safecall;
    function UseRightToLeftReading: WordBool; safecall;
    function UseRightToLeftScrollBar: WordBool; safecall;
    procedure _Set_Font(var Value: IFontDisp); safecall;
    procedure Connect; safecall;
    procedure Disconnect; safecall;
    procedure InitiateAction; safecall;
    procedure Set_Alignment(Value: TxAlignment); safecall;
    procedure Set_AlignWithMargins(Value: WordBool); safecall;
    procedure Set_Autocapture(Value: WordBool); safecall;
    procedure Set_Autoconnect(Value: WordBool); safecall;
    procedure Set_AutoSize(Value: WordBool); safecall;
    procedure Set_BevelInner(Value: TxBevelCut); safecall;
    procedure Set_BevelKind(Value: TxBevelKind); safecall;
    procedure Set_BevelOuter(Value: TxBevelCut); safecall;
    procedure Set_BevelWidth(Value: Integer); safecall;
    procedure Set_BorderStyle(Value: TxBorderStyle); safecall;
    procedure Set_BorderWidth(Value: Integer); safecall;
    procedure Set_CameraName(const Value: WideString); safecall;
    procedure Set_Caption(const Value: WideString); safecall;
    procedure Set_CaptureInterval(Value: LongWord); safecall;
    procedure Set_CapturePath(const Value: WideString); safecall;
    procedure Set_Color(Value: OLE_COLOR); safecall;
    procedure Set_Ctl3D(Value: WordBool); safecall;
    procedure Set_DockSite(Value: WordBool); safecall;
    procedure Set_DoubleBuffered(Value: WordBool); safecall;
    procedure Set_DragCursor(Value: Smallint); safecall;
    procedure Set_DragMode(Value: TxDragMode); safecall;
    procedure Set_Enabled(Value: WordBool); safecall;
    procedure Set_Font(const Value: IFontDisp); safecall;
    procedure Set_FullRepaint(Value: WordBool); safecall;
    procedure Set_Host(const Value: WideString); safecall;
    procedure Set_JpgURL(const Value: WideString); safecall;
    procedure Set_Locked(Value: WordBool); safecall;
    procedure Set_ParentBackground(Value: WordBool); safecall;
    procedure Set_ParentColor(Value: WordBool); safecall;
    procedure Set_ParentCtl3D(Value: WordBool); safecall;
    procedure Set_ParentCustomHint(Value: WordBool); safecall;
    procedure Set_ParentDoubleBuffered(Value: WordBool); safecall;
    procedure Set_Password(const Value: WideString); safecall;
    procedure Set_Port(Value: Word); safecall;
    procedure Set_ShowCaption(Value: WordBool); safecall;
    procedure Set_UseDockManager(Value: WordBool); safecall;
    procedure Set_Username(const Value: WideString); safecall;
    procedure Set_VerticalAlignment(Value: TxVerticalAlignment); safecall;
    procedure Set_Visible(Value: WordBool); safecall;
    procedure Set_WaitTime(Value: Word); safecall;
    procedure SetDesignVisible(Value: WordBool); safecall;
    procedure SetSubComponent(IsSubComponent: WordBool); safecall;
  end;

implementation

uses ComObj, ImgList;

{ TIPCamViewerAx }

procedure TIPCamViewerAx.DefinePropertyPages(DefinePropertyPage: TDefinePropertyPage);
begin
  {TODO : Définir les pages de propriétés ici.  Les pages de propriétés sont définies en appelant
    DefinePropertyPage avec l'id de classe de la page.  Par exemple,
      DefinePropertyPage(Class_IPCamViewerAxPage); }
end;

procedure TIPCamViewerAx.EventSinkChanged(const EventSink: IUnknown);
begin
  FEvents := EventSink as IIPCamViewerAxEvents;
end;

procedure TIPCamViewerAx.InitializeControl;
begin
  FDelphiControl := Control as TIPCamViewerVCL;
  FDelphiControl.OnCanResize := CanResizeEvent;
  FDelphiControl.OnClick := ClickEvent;
  FDelphiControl.OnConstrainedResize := ConstrainedResizeEvent;
  FDelphiControl.OnDblClick := DblClickEvent;
  FDelphiControl.OnMouseEnter := MouseEnterEvent;
  FDelphiControl.OnMouseLeave := MouseLeaveEvent;
  FDelphiControl.OnResize := ResizeEvent;
end;

function TIPCamViewerAx.DrawTextBiDiModeFlagsReadingOnly: Integer;
begin
  Result := FDelphiControl.DrawTextBiDiModeFlagsReadingOnly;
end;

function TIPCamViewerAx.Get_AlignDisabled: WordBool;
begin
  Result := FDelphiControl.AlignDisabled;
end;

function TIPCamViewerAx.Get_Alignment: TxAlignment;
begin
  Result := Ord(FDelphiControl.Alignment);
end;

function TIPCamViewerAx.Get_AlignWithMargins: WordBool;
begin
  Result := FDelphiControl.AlignWithMargins;
end;

function TIPCamViewerAx.Get_Autocapture: WordBool;
begin
  Result := FDelphiControl.Autocapture;
end;

function TIPCamViewerAx.Get_Autoconnect: WordBool;
begin
  Result := FDelphiControl.Autoconnect;
end;

function TIPCamViewerAx.Get_AutoSize: WordBool;
begin
  Result := FDelphiControl.AutoSize;
end;

function TIPCamViewerAx.Get_BevelInner: TxBevelCut;
begin
  Result := Ord(FDelphiControl.BevelInner);
end;

function TIPCamViewerAx.Get_BevelKind: TxBevelKind;
begin
  Result := Ord(FDelphiControl.BevelKind);
end;

function TIPCamViewerAx.Get_BevelOuter: TxBevelCut;
begin
  Result := Ord(FDelphiControl.BevelOuter);
end;

function TIPCamViewerAx.Get_BevelWidth: Integer;
begin
  Result := Integer(FDelphiControl.BevelWidth);
end;

function TIPCamViewerAx.Get_BorderStyle: TxBorderStyle;
begin
  Result := Ord(FDelphiControl.BorderStyle);
end;

function TIPCamViewerAx.Get_BorderWidth: Integer;
begin
  Result := Integer(FDelphiControl.BorderWidth);
end;

function TIPCamViewerAx.Get_CameraName: WideString;
begin
  Result := WideString(FDelphiControl.CameraName);
end;

function TIPCamViewerAx.Get_Caption: WideString;
begin
  Result := WideString(FDelphiControl.Caption);
end;

function TIPCamViewerAx.Get_CaptureInterval: LongWord;
begin
  Result := LongWord(FDelphiControl.CaptureInterval);
end;

function TIPCamViewerAx.Get_CapturePath: WideString;
begin
  Result := WideString(FDelphiControl.CapturePath);
end;

function TIPCamViewerAx.Get_Color: OLE_COLOR;
begin
  Result := OLE_COLOR(FDelphiControl.Color);
end;

function TIPCamViewerAx.Get_Ctl3D: WordBool;
begin
  Result := FDelphiControl.Ctl3D;
end;

function TIPCamViewerAx.Get_DockSite: WordBool;
begin
  Result := FDelphiControl.DockSite;
end;

function TIPCamViewerAx.Get_DoubleBuffered: WordBool;
begin
  Result := FDelphiControl.DoubleBuffered;
end;

function TIPCamViewerAx.Get_DragCursor: Smallint;
begin
  Result := Smallint(FDelphiControl.DragCursor);
end;

function TIPCamViewerAx.Get_DragMode: TxDragMode;
begin
  Result := Ord(FDelphiControl.DragMode);
end;

function TIPCamViewerAx.Get_Enabled: WordBool;
begin
  Result := FDelphiControl.Enabled;
end;

function TIPCamViewerAx.Get_ExplicitHeight: Integer;
begin
  Result := FDelphiControl.ExplicitHeight;
end;

function TIPCamViewerAx.Get_ExplicitLeft: Integer;
begin
  Result := FDelphiControl.ExplicitLeft;
end;

function TIPCamViewerAx.Get_ExplicitTop: Integer;
begin
  Result := FDelphiControl.ExplicitTop;
end;

function TIPCamViewerAx.Get_ExplicitWidth: Integer;
begin
  Result := FDelphiControl.ExplicitWidth;
end;

function TIPCamViewerAx.Get_Font: IFontDisp;
begin
  GetOleFont(FDelphiControl.Font, Result);
end;

function TIPCamViewerAx.Get_FullRepaint: WordBool;
begin
  Result := FDelphiControl.FullRepaint;
end;

function TIPCamViewerAx.Get_Host: WideString;
begin
  Result := WideString(FDelphiControl.Host);
end;

function TIPCamViewerAx.Get_JpgURL: WideString;
begin
  Result := WideString(FDelphiControl.JpgURL);
end;

function TIPCamViewerAx.Get_Locked: WordBool;
begin
  Result := FDelphiControl.Locked;
end;

function TIPCamViewerAx.Get_MouseInClient: WordBool;
begin
  Result := FDelphiControl.MouseInClient;
end;

function TIPCamViewerAx.Get_ParentBackground: WordBool;
begin
  Result := FDelphiControl.ParentBackground;
end;

function TIPCamViewerAx.Get_ParentColor: WordBool;
begin
  Result := FDelphiControl.ParentColor;
end;

function TIPCamViewerAx.Get_ParentCtl3D: WordBool;
begin
  Result := FDelphiControl.ParentCtl3D;
end;

function TIPCamViewerAx.Get_ParentCustomHint: WordBool;
begin
  Result := FDelphiControl.ParentCustomHint;
end;

function TIPCamViewerAx.Get_ParentDoubleBuffered: WordBool;
begin
  Result := FDelphiControl.ParentDoubleBuffered;
end;

function TIPCamViewerAx.Get_Password: WideString;
begin
  Result := WideString(FDelphiControl.Password);
end;

function TIPCamViewerAx.Get_Port: Word;
begin
  Result := FDelphiControl.Port;
end;

function TIPCamViewerAx.Get_ShowCaption: WordBool;
begin
  Result := FDelphiControl.ShowCaption;
end;

function TIPCamViewerAx.Get_UseDockManager: WordBool;
begin
  Result := FDelphiControl.UseDockManager;
end;

function TIPCamViewerAx.Get_Username: WideString;
begin
  Result := WideString(FDelphiControl.Username);
end;

function TIPCamViewerAx.Get_VerticalAlignment: TxVerticalAlignment;
begin
  Result := Ord(FDelphiControl.VerticalAlignment);
end;

function TIPCamViewerAx.Get_Visible: WordBool;
begin
  Result := FDelphiControl.Visible;
end;

function TIPCamViewerAx.Get_VisibleDockClientCount: Integer;
begin
  Result := FDelphiControl.VisibleDockClientCount;
end;

function TIPCamViewerAx.Get_WaitTime: Word;
begin
  Result := FDelphiControl.WaitTime;
end;

function TIPCamViewerAx.IsRightToLeft: WordBool;
begin
  Result := FDelphiControl.IsRightToLeft;
end;

function TIPCamViewerAx.QualifiedClassName: WideString;
begin
  Result := FDelphiControl.QualifiedClassName;
end;

function TIPCamViewerAx.UnitScope: WideString;
begin
  Result := FDelphiControl.UnitScope;
end;

function TIPCamViewerAx.UseRightToLeftReading: WordBool;
begin
  Result := FDelphiControl.UseRightToLeftReading;
end;

function TIPCamViewerAx.UseRightToLeftScrollBar: WordBool;
begin
  Result := FDelphiControl.UseRightToLeftScrollBar;
end;

procedure TIPCamViewerAx._Set_Font(var Value: IFontDisp);
begin
  SetOleFont(FDelphiControl.Font, Value);
end;

procedure TIPCamViewerAx.CanResizeEvent(Sender: TObject; var NewWidth, NewHeight: Integer; var Resize: Boolean);
var
  TempNewWidth: Integer;
  TempNewHeight: Integer;
  TempResize: WordBool;
begin
  TempNewWidth := Integer(NewWidth);
  TempNewHeight := Integer(NewHeight);
  TempResize := WordBool(Resize);
  if FEvents <> nil then FEvents.OnCanResize(TempNewWidth, TempNewHeight, TempResize);
  NewWidth := Integer(TempNewWidth);
  NewHeight := Integer(TempNewHeight);
  Resize := Boolean(TempResize);
end;

procedure TIPCamViewerAx.ClickEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnClick;
end;

procedure TIPCamViewerAx.Connect;
begin
  FDelphiControl.Connect;
end;

procedure TIPCamViewerAx.ConstrainedResizeEvent(Sender: TObject; var MinWidth, MinHeight, MaxWidth, MaxHeight: Integer);
var
  TempMinWidth: Integer;
  TempMinHeight: Integer;
  TempMaxWidth: Integer;
  TempMaxHeight: Integer;
begin
  TempMinWidth := Integer(MinWidth);
  TempMinHeight := Integer(MinHeight);
  TempMaxWidth := Integer(MaxWidth);
  TempMaxHeight := Integer(MaxHeight);
  if FEvents <> nil then FEvents.OnConstrainedResize(TempMinWidth, TempMinHeight, TempMaxWidth, TempMaxHeight);
  MinWidth := Integer(TempMinWidth);
  MinHeight := Integer(TempMinHeight);
  MaxWidth := Integer(TempMaxWidth);
  MaxHeight := Integer(TempMaxHeight);
end;

procedure TIPCamViewerAx.DblClickEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnDblClick;
end;

procedure TIPCamViewerAx.Disconnect;
begin
  FDelphiControl.Disconnect;
end;

procedure TIPCamViewerAx.InitiateAction;
begin
  FDelphiControl.InitiateAction;
end;

procedure TIPCamViewerAx.MouseEnterEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnMouseEnter;
end;

procedure TIPCamViewerAx.MouseLeaveEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnMouseLeave;
end;

procedure TIPCamViewerAx.ResizeEvent(Sender: TObject);
begin
  if FEvents <> nil then FEvents.OnResize;
end;

procedure TIPCamViewerAx.Set_Alignment(Value: TxAlignment);
begin
  FDelphiControl.Alignment := TAlignment(Value);
end;

procedure TIPCamViewerAx.Set_AlignWithMargins(Value: WordBool);
begin
  FDelphiControl.AlignWithMargins := Value;
end;

procedure TIPCamViewerAx.Set_Autocapture(Value: WordBool);
begin
  FDelphiControl.Autocapture := Value;
end;

procedure TIPCamViewerAx.Set_Autoconnect(Value: WordBool);
begin
  FDelphiControl.Autoconnect := Value;
end;

procedure TIPCamViewerAx.Set_AutoSize(Value: WordBool);
begin
  FDelphiControl.AutoSize := Value;
end;

procedure TIPCamViewerAx.Set_BevelInner(Value: TxBevelCut);
begin
  FDelphiControl.BevelInner := TBevelCut(Value);
end;

procedure TIPCamViewerAx.Set_BevelKind(Value: TxBevelKind);
begin
  FDelphiControl.BevelKind := TBevelKind(Value);
end;

procedure TIPCamViewerAx.Set_BevelOuter(Value: TxBevelCut);
begin
  FDelphiControl.BevelOuter := TBevelCut(Value);
end;

procedure TIPCamViewerAx.Set_BevelWidth(Value: Integer);
begin
  FDelphiControl.BevelWidth := TBevelWidth(Value);
end;

procedure TIPCamViewerAx.Set_BorderStyle(Value: TxBorderStyle);
begin
  FDelphiControl.BorderStyle := TBorderStyle(Value);
end;

procedure TIPCamViewerAx.Set_BorderWidth(Value: Integer);
begin
  FDelphiControl.BorderWidth := TBorderWidth(Value);
end;

procedure TIPCamViewerAx.Set_CameraName(const Value: WideString);
begin
  FDelphiControl.CameraName := string(Value);
end;

procedure TIPCamViewerAx.Set_Caption(const Value: WideString);
begin
  FDelphiControl.Caption := TCaption(Value);
end;

procedure TIPCamViewerAx.Set_CaptureInterval(Value: LongWord);
begin
  FDelphiControl.CaptureInterval := Cardinal(Value);
end;

procedure TIPCamViewerAx.Set_CapturePath(const Value: WideString);
begin
  FDelphiControl.CapturePath := string(Value);
end;

procedure TIPCamViewerAx.Set_Color(Value: OLE_COLOR);
begin
  FDelphiControl.Color := TColor(Value);
end;

procedure TIPCamViewerAx.Set_Ctl3D(Value: WordBool);
begin
  FDelphiControl.Ctl3D := Value;
end;

procedure TIPCamViewerAx.Set_DockSite(Value: WordBool);
begin
  FDelphiControl.DockSite := Value;
end;

procedure TIPCamViewerAx.Set_DoubleBuffered(Value: WordBool);
begin
  FDelphiControl.DoubleBuffered := Value;
end;

procedure TIPCamViewerAx.Set_DragCursor(Value: Smallint);
begin
  FDelphiControl.DragCursor := TCursor(Value);
end;

procedure TIPCamViewerAx.Set_DragMode(Value: TxDragMode);
begin
  FDelphiControl.DragMode := TDragMode(Value);
end;

procedure TIPCamViewerAx.Set_Enabled(Value: WordBool);
begin
  FDelphiControl.Enabled := Value;
end;

procedure TIPCamViewerAx.Set_Font(const Value: IFontDisp);
begin
  SetOleFont(FDelphiControl.Font, Value);
end;

procedure TIPCamViewerAx.Set_FullRepaint(Value: WordBool);
begin
  FDelphiControl.FullRepaint := Value;
end;

procedure TIPCamViewerAx.Set_Host(const Value: WideString);
begin
  FDelphiControl.Host := string(Value);
end;

procedure TIPCamViewerAx.Set_JpgURL(const Value: WideString);
begin
  FDelphiControl.JpgURL := string(Value);
end;

procedure TIPCamViewerAx.Set_Locked(Value: WordBool);
begin
  FDelphiControl.Locked := Value;
end;

procedure TIPCamViewerAx.Set_ParentBackground(Value: WordBool);
begin
  FDelphiControl.ParentBackground := Value;
end;

procedure TIPCamViewerAx.Set_ParentColor(Value: WordBool);
begin
  FDelphiControl.ParentColor := Value;
end;

procedure TIPCamViewerAx.Set_ParentCtl3D(Value: WordBool);
begin
  FDelphiControl.ParentCtl3D := Value;
end;

procedure TIPCamViewerAx.Set_ParentCustomHint(Value: WordBool);
begin
  FDelphiControl.ParentCustomHint := Value;
end;

procedure TIPCamViewerAx.Set_ParentDoubleBuffered(Value: WordBool);
begin
  FDelphiControl.ParentDoubleBuffered := Value;
end;

procedure TIPCamViewerAx.Set_Password(const Value: WideString);
begin
  FDelphiControl.Password := string(Value);
end;

procedure TIPCamViewerAx.Set_Port(Value: Word);
begin
  FDelphiControl.Port := Value;
end;

procedure TIPCamViewerAx.Set_ShowCaption(Value: WordBool);
begin
  FDelphiControl.ShowCaption := Value;
end;

procedure TIPCamViewerAx.Set_UseDockManager(Value: WordBool);
begin
  FDelphiControl.UseDockManager := Value;
end;

procedure TIPCamViewerAx.Set_Username(const Value: WideString);
begin
  FDelphiControl.Username := string(Value);
end;

procedure TIPCamViewerAx.Set_VerticalAlignment(Value: TxVerticalAlignment);
begin
  FDelphiControl.VerticalAlignment := TVerticalAlignment(Value);
end;

procedure TIPCamViewerAx.Set_Visible(Value: WordBool);
begin
  FDelphiControl.Visible := Value;
end;

procedure TIPCamViewerAx.Set_WaitTime(Value: Word);
begin
  FDelphiControl.WaitTime := Value;
end;

procedure TIPCamViewerAx.SetDesignVisible(Value: WordBool);
begin
  FDelphiControl.SetDesignVisible(Value);
end;

procedure TIPCamViewerAx.SetSubComponent(IsSubComponent: WordBool);
begin
  FDelphiControl.SetSubComponent(IsSubComponent);
end;

initialization
  TActiveXControlFactory.Create(
    ComServer,
    TIPCamViewerAx,
    TIPCamViewerVCL,
    Class_IPCamViewerAx,
    0,
    '',
    0,
    tmApartment);
end.
