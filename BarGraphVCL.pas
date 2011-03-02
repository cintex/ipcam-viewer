unit BarGraphVCL;

interface

uses
  Classes, Graphics, Controls, ExtCtrls, Windows, Generics.Collections, Math;

type

  TBarItem = class(TShape)

  public
    constructor Create(AOwner: TComponent); override;
  end;

  TBarList = TObjectlist<TBarItem>;

  TBarGraph = class(TCustomPanel)
  private
    FBarList: TBarList;
    FColors: array [0 .. 255] of TColor;
    FMax: Integer;
    FColor2: TColor;
    FColor1: TColor;
    FMin: Integer;
    FQuantity: Integer;
    FPosition: Integer;
    procedure SetColor1(const Value: TColor);
    procedure SetColor2(const Value: TColor);
    procedure SetMax(const Value: Integer);
    procedure SetMin(const Value: Integer);
    procedure SetPosition(const Value: Integer);
    procedure SetQuantity(const Value: Integer);
  protected
    procedure Rebuild;
    procedure ComputeColors;
    procedure ApplyColors;
    procedure UpdatePosition;
    procedure Loaded; override;
    procedure Resize; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  published
    property Min: Integer read FMin write SetMin default 1;
    property Max: Integer read FMax write SetMax default 10;
    property Position: Integer read FPosition write SetPosition;
    property Color1: TColor read FColor1 write SetColor1 default clBlack;
    property Color2: TColor read FColor2 write SetColor2 default clWhite;
    property Quantity: Integer read FQuantity write SetQuantity default 2;

    property ParentBackground;
    property Color;
  end;


procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TBarGraph]);
end;


{ TBarItem }

constructor TBarItem.Create(AOwner: TComponent);
begin
  inherited;
  // Pen.Style := psClear;
end;

{ TBarGraph }

constructor TBarGraph.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FMin := 1;
  FMax := 10;
  FColor1 := clBlack;
  FColor2 := clWhite;
  FQuantity := 2;

  BevelOuter := bvNone;
  Caption := '';

  FBarList := TBarList.Create;
  Rebuild;
  ComputeColors;
end;

destructor TBarGraph.Destroy;
begin
  FBarList.Free;
  inherited;
end;

procedure TBarGraph.Loaded;
begin
  inherited;

end;

procedure TBarGraph.Rebuild;
var
  i: Integer;
  BarItem: TBarItem;
begin
  FBarList.Clear;

  for i := FMin + 1 to FMax do
  begin
    BarItem := TBarItem.Create(Self);
    BarItem.Parent := Self;
    FBarList.Add(BarItem);
  end;

  ComputeColors;
end;

procedure TBarGraph.Resize;
var
  i, NewLeft: Integer;
begin
  inherited;
  NewLeft := 0;
  for i := 0 to FBarList.Count - 1 do
  begin
    FBarList[i].Height := Height div FBarList.Count * (i + 1);
    FBarList[i].Width := Width div FBarList.Count;
    FBarList[i].Left := NewLeft;

    FBarList[i].Top := Height - FBarList[i].Height;

    NewLeft := NewLeft + FBarList[i].Width;
  end;
end;

procedure TBarGraph.ApplyColors;
var
  i: Integer;
  ColorIndex: Integer;
begin

  for i := 0 to FBarList.Count - 1 do
  begin
    ColorIndex := (i + 1) * 255 div FBarList.Count;

    ColorIndex := Math.Min(255, ColorIndex);
    ColorIndex := Math.Max(0, ColorIndex);

    FBarList[i].Brush.Color := FColors[ColorIndex];
    FBarList[i].Pen.Color := FColors[ColorIndex];
  end;
end;

function RGBToColor(R, G, B: Byte): TColor;
begin
  Result := B shl 16 or G shl 8 or R;
end;

procedure TBarGraph.ComputeColors;
var
  dRed, dGreen, dBlue: Integer;
  RGBColor1, RGBColor2: TColor;
  RGB1, RGB2: TRGBQuad;
  i: Integer;
  rgbRed, rgbGreen, rgbBlue: Byte;
begin

  RGBColor1 := ColorToRGB(Color1);
  RGBColor2 := ColorToRGB(Color2);

  RGB1.rgbRed := GetRValue(RGBColor1);
  RGB1.rgbGreen := GetGValue(RGBColor1);
  RGB1.rgbBlue := GetBValue(RGBColor1);
  RGB1.rgbReserved := 0;

  RGB2.rgbRed := GetRValue(RGBColor2);
  RGB2.rgbGreen := GetGValue(RGBColor2);
  RGB2.rgbBlue := GetBValue(RGBColor2);
  RGB2.rgbReserved := 0;

  dRed := RGB2.rgbRed - RGB1.rgbRed;
  dGreen := RGB2.rgbGreen - RGB1.rgbGreen;
  dBlue := RGB2.rgbBlue - RGB1.rgbBlue;

  for i := 0 to 255 do
  begin
    rgbRed := RGB1.rgbRed + (i * dRed) div 255;
    rgbGreen := RGB1.rgbGreen + (i * dGreen) div 255;
    rgbBlue := RGB1.rgbBlue + (i * dBlue) div 255;
    FColors[i] := RGBToColor(rgbRed, rgbGreen, rgbBlue);
  end;

  ApplyColors;
  UpdatePosition;
end;

procedure TBarGraph.UpdatePosition;
var
  i: Integer;
begin

  for i := 0 to FBarList.Count - 1 do
  begin
    FBarList[i].Visible := (FMin + i < FPosition);
  end;
end;

procedure TBarGraph.SetColor1(const Value: TColor);
begin
  FColor1 := Value;
  ComputeColors;
end;

procedure TBarGraph.SetColor2(const Value: TColor);
begin
  FColor2 := Value;
  ComputeColors;
end;

procedure TBarGraph.SetMax(const Value: Integer);
begin
  FMax := Value;
  Rebuild;
end;

procedure TBarGraph.SetMin(const Value: Integer);
begin
  FMin := Value;
  Rebuild;
end;

procedure TBarGraph.SetPosition(const Value: Integer);
begin
  if FPosition <> Value then
  begin
    FPosition := Value;
    UpdatePosition;
  end;
end;

procedure TBarGraph.SetQuantity(const Value: Integer);
begin
  FQuantity := Value;
  Rebuild;
end;

end.
