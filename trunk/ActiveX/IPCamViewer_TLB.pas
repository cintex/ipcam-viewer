unit IPCamViewer_TLB;

// ************************************************************************ //
// AVERTISSEMENT
// -------
// Les types déclarés dans ce fichier ont été générés à partir de données lues
// depuis la bibliothèque de types. Si cette dernière (via une autre bibliothèque de types
// s'y référant) est explicitement ou indirectement ré-importée, ou la commande "Actualiser"
// de l'éditeur de bibliothèque de types est activée lors de la modification de la bibliothèque
// de types, le contenu de ce fichier sera régénéré et toutes les modifications
// manuellement apportées seront perdues.
// ************************************************************************ //

// $Rev: 45604 $
// Fichier généré le 08/07/2013 17:03:49 depuis la bibliothèque de types ci-dessous.

// ************************************************************************  //
// Biblio. types : C:\Users\Yann\Documents\temp\ipcam-viewer\ActiveX\IPCamViewer (1)
// LIBID : {B10193AD-4992-4157-A9E5-F70B0972C657}
// LCID : 0
// Fichier d'aide :
// Chaîne d'aide :
// DepndLst :
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
// SYS_KIND: SYS_WIN32
// ************************************************************************ //
{$TYPEDADDRESS OFF} // L'unité doit être compilée sans pointeur à type contrôlé.
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}

interface

uses Winapi.Windows, System.Classes, System.Variants, System.Win.StdVCL, Vcl.Graphics, Vcl.OleCtrls, Winapi.ActiveX;

// *********************************************************************//
// GUIDS déclarés dans la bibliothèque de types. Préfixes utilisés:
//   Bibliothèques de types : LIBID_xxxx
//   CoClasses              : CLASS_xxxx
//   Interfaces DISP        : DIID_xxxx
//   Interfaces Non-DISP    : IID_xxxx
// *********************************************************************//
const
  // Versions mineure et majeure de la bibliothèque de types
  IPCamViewerMajorVersion = 1;
  IPCamViewerMinorVersion = 0;

  LIBID_IPCamViewer: TGUID = '{B10193AD-4992-4157-A9E5-F70B0972C657}';

  IID_IIPCamViewerAx: TGUID = '{CC29466E-32EC-4423-988F-1333233560FC}';
  DIID_IIPCamViewerAxEvents: TGUID = '{0AD441BA-A311-4B1C-8477-53959A0C3F23}';
  CLASS_IPCamViewerAx: TGUID = '{AFC8FF50-EF3C-4E15-BB28-1B40B44631EA}';

// *********************************************************************//
// Déclaration d'énumérations définies dans la bibliothèque de types
// *********************************************************************//
// Constantes pour enum TxAlignment
type
  TxAlignment = TOleEnum;
const
  taLeftJustify = $00000000;
  taRightJustify = $00000001;
  taCenter = $00000002;

// Constantes pour enum TxBevelCut
type
  TxBevelCut = TOleEnum;
const
  bvNone = $00000000;
  bvLowered = $00000001;
  bvRaised = $00000002;
  bvSpace = $00000003;

// Constantes pour enum TxBevelKind
type
  TxBevelKind = TOleEnum;
const
  bkNone = $00000000;
  bkTile = $00000001;
  bkSoft = $00000002;
  bkFlat = $00000003;

// Constantes pour enum TxBorderStyle
type
  TxBorderStyle = TOleEnum;
const
  bsNone = $00000000;
  bsSingle = $00000001;

// Constantes pour enum TxDragMode
type
  TxDragMode = TOleEnum;
const
  dmManual = $00000000;
  dmAutomatic = $00000001;

// Constantes pour enum TxVerticalAlignment
type
  TxVerticalAlignment = TOleEnum;
const
  taAlignTop = $00000000;
  taAlignBottom = $00000001;
  taVerticalCenter = $00000002;

// Constantes pour enum TxMouseButton
type
  TxMouseButton = TOleEnum;
const
  mbLeft = $00000000;
  mbRight = $00000001;
  mbMiddle = $00000002;

type

// *********************************************************************//
// Déclaration Forward des types définis dans la bibliothèque de types
// *********************************************************************//
  IIPCamViewerAx = interface;
  IIPCamViewerAxDisp = dispinterface;
  IIPCamViewerAxEvents = dispinterface;

// *********************************************************************//
// Déclaration de CoClasses définies dans la bibliothèque de types
// (REMARQUE: On affecte chaque CoClasse à son Interface par défaut)
// *********************************************************************//
  IPCamViewerAx = IIPCamViewerAx;


// *********************************************************************//
// Déclaration de structures, d'unions et d'alias.
// *********************************************************************//
  PPUserType1 = ^IFontDisp; {*}


// *********************************************************************//
// Interface :   IIPCamViewerAx
// Indicateurs : (4416) Dual OleAutomation Dispatchable
// GUID :        {CC29466E-32EC-4423-988F-1333233560FC}
// *********************************************************************//
  IIPCamViewerAx = interface(IDispatch)
    ['{CC29466E-32EC-4423-988F-1333233560FC}']
    procedure Connect; safecall;
    procedure Disconnect; safecall;
    function Get_Autoconnect: WordBool; safecall;
    procedure Set_Autoconnect(Value: WordBool); safecall;
    function Get_Host: WideString; safecall;
    procedure Set_Host(const Value: WideString); safecall;
    function Get_Port: Word; safecall;
    procedure Set_Port(Value: Word); safecall;
    function Get_JpgURL: WideString; safecall;
    procedure Set_JpgURL(const Value: WideString); safecall;
    function Get_Alignment: TxAlignment; safecall;
    procedure Set_Alignment(Value: TxAlignment); safecall;
    function Get_AutoSize: WordBool; safecall;
    procedure Set_AutoSize(Value: WordBool); safecall;
    function Get_BevelInner: TxBevelCut; safecall;
    procedure Set_BevelInner(Value: TxBevelCut); safecall;
    function Get_BevelKind: TxBevelKind; safecall;
    procedure Set_BevelKind(Value: TxBevelKind); safecall;
    function Get_BevelOuter: TxBevelCut; safecall;
    procedure Set_BevelOuter(Value: TxBevelCut); safecall;
    function Get_BevelWidth: Integer; safecall;
    procedure Set_BevelWidth(Value: Integer); safecall;
    function Get_BorderWidth: Integer; safecall;
    procedure Set_BorderWidth(Value: Integer); safecall;
    function Get_BorderStyle: TxBorderStyle; safecall;
    procedure Set_BorderStyle(Value: TxBorderStyle); safecall;
    function Get_Caption: WideString; safecall;
    procedure Set_Caption(const Value: WideString); safecall;
    function Get_Color: OLE_COLOR; safecall;
    procedure Set_Color(Value: OLE_COLOR); safecall;
    function Get_Ctl3D: WordBool; safecall;
    procedure Set_Ctl3D(Value: WordBool); safecall;
    function Get_UseDockManager: WordBool; safecall;
    procedure Set_UseDockManager(Value: WordBool); safecall;
    function Get_DockSite: WordBool; safecall;
    procedure Set_DockSite(Value: WordBool); safecall;
    function Get_DoubleBuffered: WordBool; safecall;
    procedure Set_DoubleBuffered(Value: WordBool); safecall;
    function Get_DragCursor: Smallint; safecall;
    procedure Set_DragCursor(Value: Smallint); safecall;
    function Get_DragMode: TxDragMode; safecall;
    procedure Set_DragMode(Value: TxDragMode); safecall;
    function Get_Enabled: WordBool; safecall;
    procedure Set_Enabled(Value: WordBool); safecall;
    function Get_FullRepaint: WordBool; safecall;
    procedure Set_FullRepaint(Value: WordBool); safecall;
    function Get_Font: IFontDisp; safecall;
    procedure Set_Font(const Value: IFontDisp); safecall;
    procedure _Set_Font(var Value: IFontDisp); safecall;
    function Get_Locked: WordBool; safecall;
    procedure Set_Locked(Value: WordBool); safecall;
    function Get_ParentBackground: WordBool; safecall;
    procedure Set_ParentBackground(Value: WordBool); safecall;
    function Get_ParentColor: WordBool; safecall;
    procedure Set_ParentColor(Value: WordBool); safecall;
    function Get_ParentCtl3D: WordBool; safecall;
    procedure Set_ParentCtl3D(Value: WordBool); safecall;
    function Get_ParentDoubleBuffered: WordBool; safecall;
    procedure Set_ParentDoubleBuffered(Value: WordBool); safecall;
    function Get_ShowCaption: WordBool; safecall;
    procedure Set_ShowCaption(Value: WordBool); safecall;
    function Get_VerticalAlignment: TxVerticalAlignment; safecall;
    procedure Set_VerticalAlignment(Value: TxVerticalAlignment); safecall;
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(Value: WordBool); safecall;
    procedure SetDesignVisible(Value: WordBool); safecall;
    function Get_AlignDisabled: WordBool; safecall;
    function Get_MouseInClient: WordBool; safecall;
    function Get_VisibleDockClientCount: Integer; safecall;
    function DrawTextBiDiModeFlagsReadingOnly: Integer; safecall;
    procedure InitiateAction; safecall;
    function IsRightToLeft: WordBool; safecall;
    function UseRightToLeftReading: WordBool; safecall;
    function UseRightToLeftScrollBar: WordBool; safecall;
    function Get_ExplicitLeft: Integer; safecall;
    function Get_ExplicitTop: Integer; safecall;
    function Get_ExplicitWidth: Integer; safecall;
    function Get_ExplicitHeight: Integer; safecall;
    function Get_AlignWithMargins: WordBool; safecall;
    procedure Set_AlignWithMargins(Value: WordBool); safecall;
    function Get_ParentCustomHint: WordBool; safecall;
    procedure Set_ParentCustomHint(Value: WordBool); safecall;
    procedure SetSubComponent(IsSubComponent: WordBool); safecall;
    function QualifiedClassName: WideString; safecall;
    function UnitScope: WideString; safecall;
    property Autoconnect: WordBool read Get_Autoconnect write Set_Autoconnect;
    property Host: WideString read Get_Host write Set_Host;
    property Port: Word read Get_Port write Set_Port;
    property JpgURL: WideString read Get_JpgURL write Set_JpgURL;
    property Alignment: TxAlignment read Get_Alignment write Set_Alignment;
    property AutoSize: WordBool read Get_AutoSize write Set_AutoSize;
    property BevelInner: TxBevelCut read Get_BevelInner write Set_BevelInner;
    property BevelKind: TxBevelKind read Get_BevelKind write Set_BevelKind;
    property BevelOuter: TxBevelCut read Get_BevelOuter write Set_BevelOuter;
    property BevelWidth: Integer read Get_BevelWidth write Set_BevelWidth;
    property BorderWidth: Integer read Get_BorderWidth write Set_BorderWidth;
    property BorderStyle: TxBorderStyle read Get_BorderStyle write Set_BorderStyle;
    property Caption: WideString read Get_Caption write Set_Caption;
    property Color: OLE_COLOR read Get_Color write Set_Color;
    property Ctl3D: WordBool read Get_Ctl3D write Set_Ctl3D;
    property UseDockManager: WordBool read Get_UseDockManager write Set_UseDockManager;
    property DockSite: WordBool read Get_DockSite write Set_DockSite;
    property DoubleBuffered: WordBool read Get_DoubleBuffered write Set_DoubleBuffered;
    property DragCursor: Smallint read Get_DragCursor write Set_DragCursor;
    property DragMode: TxDragMode read Get_DragMode write Set_DragMode;
    property Enabled: WordBool read Get_Enabled write Set_Enabled;
    property FullRepaint: WordBool read Get_FullRepaint write Set_FullRepaint;
    property Font: IFontDisp read Get_Font write Set_Font;
    property Locked: WordBool read Get_Locked write Set_Locked;
    property ParentBackground: WordBool read Get_ParentBackground write Set_ParentBackground;
    property ParentColor: WordBool read Get_ParentColor write Set_ParentColor;
    property ParentCtl3D: WordBool read Get_ParentCtl3D write Set_ParentCtl3D;
    property ParentDoubleBuffered: WordBool read Get_ParentDoubleBuffered write Set_ParentDoubleBuffered;
    property ShowCaption: WordBool read Get_ShowCaption write Set_ShowCaption;
    property VerticalAlignment: TxVerticalAlignment read Get_VerticalAlignment write Set_VerticalAlignment;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property AlignDisabled: WordBool read Get_AlignDisabled;
    property MouseInClient: WordBool read Get_MouseInClient;
    property VisibleDockClientCount: Integer read Get_VisibleDockClientCount;
    property ExplicitLeft: Integer read Get_ExplicitLeft;
    property ExplicitTop: Integer read Get_ExplicitTop;
    property ExplicitWidth: Integer read Get_ExplicitWidth;
    property ExplicitHeight: Integer read Get_ExplicitHeight;
    property AlignWithMargins: WordBool read Get_AlignWithMargins write Set_AlignWithMargins;
    property ParentCustomHint: WordBool read Get_ParentCustomHint write Set_ParentCustomHint;
  end;

// *********************************************************************//
// DispIntf :    IIPCamViewerAxDisp
// Indicateurs : (4416) Dual OleAutomation Dispatchable
// GUID :        {CC29466E-32EC-4423-988F-1333233560FC}
// *********************************************************************//
  IIPCamViewerAxDisp = dispinterface
    ['{CC29466E-32EC-4423-988F-1333233560FC}']
    procedure Connect; dispid 201;
    procedure Disconnect; dispid 202;
    property Autoconnect: WordBool dispid 203;
    property Host: WideString dispid 204;
    property Port: Word dispid 205;
    property JpgURL: WideString dispid 206;
    property Alignment: TxAlignment dispid 207;
    property AutoSize: WordBool dispid 208;
    property BevelInner: TxBevelCut dispid 209;
    property BevelKind: TxBevelKind dispid 210;
    property BevelOuter: TxBevelCut dispid 211;
    property BevelWidth: Integer dispid 212;
    property BorderWidth: Integer dispid 213;
    property BorderStyle: TxBorderStyle dispid 214;
    property Caption: WideString dispid -518;
    property Color: OLE_COLOR dispid -501;
    property Ctl3D: WordBool dispid 215;
    property UseDockManager: WordBool dispid 216;
    property DockSite: WordBool dispid 217;
    property DoubleBuffered: WordBool dispid 218;
    property DragCursor: Smallint dispid 219;
    property DragMode: TxDragMode dispid 220;
    property Enabled: WordBool dispid -514;
    property FullRepaint: WordBool dispid 221;
    property Font: IFontDisp dispid -512;
    property Locked: WordBool dispid 222;
    property ParentBackground: WordBool dispid 223;
    property ParentColor: WordBool dispid 224;
    property ParentCtl3D: WordBool dispid 225;
    property ParentDoubleBuffered: WordBool dispid 226;
    property ShowCaption: WordBool dispid 227;
    property VerticalAlignment: TxVerticalAlignment dispid 228;
    property Visible: WordBool dispid 229;
    procedure SetDesignVisible(Value: WordBool); dispid 230;
    property AlignDisabled: WordBool readonly dispid 231;
    property MouseInClient: WordBool readonly dispid 232;
    property VisibleDockClientCount: Integer readonly dispid 233;
    function DrawTextBiDiModeFlagsReadingOnly: Integer; dispid 234;
    procedure InitiateAction; dispid 235;
    function IsRightToLeft: WordBool; dispid 236;
    function UseRightToLeftReading: WordBool; dispid 237;
    function UseRightToLeftScrollBar: WordBool; dispid 238;
    property ExplicitLeft: Integer readonly dispid 239;
    property ExplicitTop: Integer readonly dispid 240;
    property ExplicitWidth: Integer readonly dispid 241;
    property ExplicitHeight: Integer readonly dispid 242;
    property AlignWithMargins: WordBool dispid 243;
    property ParentCustomHint: WordBool dispid 244;
    procedure SetSubComponent(IsSubComponent: WordBool); dispid 245;
    function QualifiedClassName: WideString; dispid 246;
    function UnitScope: WideString; dispid 247;
  end;

// *********************************************************************//
// DispIntf :    IIPCamViewerAxEvents
// Indicateurs : (0)
// GUID :        {0AD441BA-A311-4B1C-8477-53959A0C3F23}
// *********************************************************************//
  IIPCamViewerAxEvents = dispinterface
    ['{0AD441BA-A311-4B1C-8477-53959A0C3F23}']
    procedure OnCanResize(var NewWidth: Integer; var NewHeight: Integer; var Resize: WordBool); dispid 201;
    procedure OnClick; dispid 202;
    procedure OnConstrainedResize(var MinWidth: Integer; var MinHeight: Integer;
                                  var MaxWidth: Integer; var MaxHeight: Integer); dispid 203;
    procedure OnDblClick; dispid 204;
    procedure OnMouseEnter; dispid 205;
    procedure OnMouseLeave; dispid 206;
    procedure OnResize; dispid 207;
  end;

implementation

uses System.Win.ComObj;

end.

