unit BarGraph_TLB;

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

// $Rev: 17244 $
// Fichier généré le 02/03/2011 11:24:41 depuis la bibliothèque de types ci-dessous.

// ************************************************************************  //
// Biblio. types : C:\Users\Yann\Documents\RAD Studio\Projets\ipcam-viewer\ActiveX\BarGraph (1)
// LIBID : {B142ACA9-1C67-4D67-B457-2DD68F43ACB5}
// LCID : 0
// Fichier d'aide :
// Chaîne d'aide :
// DepndLst :
//   (1) v2.0 stdole, (C:\Windows\system32\stdole2.tlb)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // L'unité doit être compilée sans pointeur à type contrôlé.
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}
interface

uses Windows, ActiveX, Classes, Graphics, OleCtrls, StdVCL, Variants;

// *********************************************************************//
// GUIDS déclarés dans la bibliothèque de types. Préfixes utilisés:
//   Bibliothèques de types : LIBID_xxxx
//   CoClasses              : CLASS_xxxx
//   Interfaces DISP        : DIID_xxxx
//   Interfaces Non-DISP    : IID_xxxx
// *********************************************************************//
const
  // Versions mineure et majeure de la bibliothèque de types
  BarGraphMajorVersion = 1;
  BarGraphMinorVersion = 0;

  LIBID_BarGraph: TGUID = '{B142ACA9-1C67-4D67-B457-2DD68F43ACB5}';

  IID_IBarGraphAx: TGUID = '{D85E4BF8-B7FE-409F-820F-6CA8CF08B74B}';
  DIID_IBarGraphAxEvents: TGUID = '{593E9A7C-1026-4716-A2A2-77966703868C}';
  CLASS_BarGraphAx: TGUID = '{0C146C0E-9060-4C4F-BA6E-36701B8BAF51}';
type

// *********************************************************************//
// Déclaration Forward des types définis dans la bibliothèque de types
// *********************************************************************//
  IBarGraphAx = interface;
  IBarGraphAxDisp = dispinterface;
  IBarGraphAxEvents = dispinterface;

// *********************************************************************//
// Déclaration de CoClasses définies dans la bibliothèque de types
// (REMARQUE: On affecte chaque CoClasse à son Interface par défaut)
// *********************************************************************//
  BarGraphAx = IBarGraphAx;


// *********************************************************************//
// Interface :   IBarGraphAx
// Indicateurs : (4416) Dual OleAutomation Dispatchable
// GUID :        {D85E4BF8-B7FE-409F-820F-6CA8CF08B74B}
// *********************************************************************//
  IBarGraphAx = interface(IDispatch)
    ['{D85E4BF8-B7FE-409F-820F-6CA8CF08B74B}']
    function Get_Min: Integer; safecall;
    procedure Set_Min(Value: Integer); safecall;
    function Get_Max: Integer; safecall;
    procedure Set_Max(Value: Integer); safecall;
    function Get_Position: Integer; safecall;
    procedure Set_Position(Value: Integer); safecall;
    function Get_Color1: OLE_COLOR; safecall;
    procedure Set_Color1(Value: OLE_COLOR); safecall;
    function Get_Color2: OLE_COLOR; safecall;
    procedure Set_Color2(Value: OLE_COLOR); safecall;
    function Get_Quantity: Integer; safecall;
    procedure Set_Quantity(Value: Integer); safecall;
    function Get_ParentBackground: WordBool; safecall;
    procedure Set_ParentBackground(Value: WordBool); safecall;
    function Get_Color: OLE_COLOR; safecall;
    procedure Set_Color(Value: OLE_COLOR); safecall;
    function Get_DockSite: WordBool; safecall;
    procedure Set_DockSite(Value: WordBool); safecall;
    function Get_DoubleBuffered: WordBool; safecall;
    procedure Set_DoubleBuffered(Value: WordBool); safecall;
    procedure SetDesignVisible(Value: WordBool); safecall;
    function Get_AlignDisabled: WordBool; safecall;
    function Get_MouseInClient: WordBool; safecall;
    function Get_VisibleDockClientCount: Integer; safecall;
    function Get_ParentDoubleBuffered: WordBool; safecall;
    procedure Set_ParentDoubleBuffered(Value: WordBool); safecall;
    function Get_UseDockManager: WordBool; safecall;
    procedure Set_UseDockManager(Value: WordBool); safecall;
    function DrawTextBiDiModeFlagsReadingOnly: Integer; safecall;
    function Get_Enabled: WordBool; safecall;
    procedure Set_Enabled(Value: WordBool); safecall;
    procedure InitiateAction; safecall;
    function IsRightToLeft: WordBool; safecall;
    function UseRightToLeftReading: WordBool; safecall;
    function UseRightToLeftScrollBar: WordBool; safecall;
    function Get_ExplicitLeft: Integer; safecall;
    function Get_ExplicitTop: Integer; safecall;
    function Get_ExplicitWidth: Integer; safecall;
    function Get_ExplicitHeight: Integer; safecall;
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(Value: WordBool); safecall;
    function Get_AlignWithMargins: WordBool; safecall;
    procedure Set_AlignWithMargins(Value: WordBool); safecall;
    function Get_ParentCustomHint: WordBool; safecall;
    procedure Set_ParentCustomHint(Value: WordBool); safecall;
    procedure SetSubComponent(IsSubComponent: WordBool); safecall;
    property Min: Integer read Get_Min write Set_Min;
    property Max: Integer read Get_Max write Set_Max;
    property Position: Integer read Get_Position write Set_Position;
    property Color1: OLE_COLOR read Get_Color1 write Set_Color1;
    property Color2: OLE_COLOR read Get_Color2 write Set_Color2;
    property Quantity: Integer read Get_Quantity write Set_Quantity;
    property ParentBackground: WordBool read Get_ParentBackground write Set_ParentBackground;
    property Color: OLE_COLOR read Get_Color write Set_Color;
    property DockSite: WordBool read Get_DockSite write Set_DockSite;
    property DoubleBuffered: WordBool read Get_DoubleBuffered write Set_DoubleBuffered;
    property AlignDisabled: WordBool read Get_AlignDisabled;
    property MouseInClient: WordBool read Get_MouseInClient;
    property VisibleDockClientCount: Integer read Get_VisibleDockClientCount;
    property ParentDoubleBuffered: WordBool read Get_ParentDoubleBuffered write Set_ParentDoubleBuffered;
    property UseDockManager: WordBool read Get_UseDockManager write Set_UseDockManager;
    property Enabled: WordBool read Get_Enabled write Set_Enabled;
    property ExplicitLeft: Integer read Get_ExplicitLeft;
    property ExplicitTop: Integer read Get_ExplicitTop;
    property ExplicitWidth: Integer read Get_ExplicitWidth;
    property ExplicitHeight: Integer read Get_ExplicitHeight;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property AlignWithMargins: WordBool read Get_AlignWithMargins write Set_AlignWithMargins;
    property ParentCustomHint: WordBool read Get_ParentCustomHint write Set_ParentCustomHint;
  end;

// *********************************************************************//
// DispIntf :    IBarGraphAxDisp
// Indicateurs : (4416) Dual OleAutomation Dispatchable
// GUID :        {D85E4BF8-B7FE-409F-820F-6CA8CF08B74B}
// *********************************************************************//
  IBarGraphAxDisp = dispinterface
    ['{D85E4BF8-B7FE-409F-820F-6CA8CF08B74B}']
    property Min: Integer dispid 201;
    property Max: Integer dispid 202;
    property Position: Integer dispid 203;
    property Color1: OLE_COLOR dispid 204;
    property Color2: OLE_COLOR dispid 205;
    property Quantity: Integer dispid 206;
    property ParentBackground: WordBool dispid 207;
    property Color: OLE_COLOR dispid -501;
    property DockSite: WordBool dispid 208;
    property DoubleBuffered: WordBool dispid 209;
    procedure SetDesignVisible(Value: WordBool); dispid 210;
    property AlignDisabled: WordBool readonly dispid 211;
    property MouseInClient: WordBool readonly dispid 212;
    property VisibleDockClientCount: Integer readonly dispid 213;
    property ParentDoubleBuffered: WordBool dispid 214;
    property UseDockManager: WordBool dispid 215;
    function DrawTextBiDiModeFlagsReadingOnly: Integer; dispid 216;
    property Enabled: WordBool dispid -514;
    procedure InitiateAction; dispid 217;
    function IsRightToLeft: WordBool; dispid 218;
    function UseRightToLeftReading: WordBool; dispid 219;
    function UseRightToLeftScrollBar: WordBool; dispid 220;
    property ExplicitLeft: Integer readonly dispid 221;
    property ExplicitTop: Integer readonly dispid 222;
    property ExplicitWidth: Integer readonly dispid 223;
    property ExplicitHeight: Integer readonly dispid 224;
    property Visible: WordBool dispid 225;
    property AlignWithMargins: WordBool dispid 226;
    property ParentCustomHint: WordBool dispid 227;
    procedure SetSubComponent(IsSubComponent: WordBool); dispid 228;
  end;

// *********************************************************************//
// DispIntf :    IBarGraphAxEvents
// Indicateurs : (0)
// GUID :        {593E9A7C-1026-4716-A2A2-77966703868C}
// *********************************************************************//
  IBarGraphAxEvents = dispinterface
    ['{593E9A7C-1026-4716-A2A2-77966703868C}']
  end;

implementation

uses ComObj;

end.

