unit XTrackPanel;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, ExtCtrls,Graphics;
type
  TSingleRect = record
   MaxHeight:Single;
   MaxWidth:Single;
   MinHeight:Single;
   MinWidth:Single;
  end;

type
TEventProcDrawGraph = procedure(Canvas: TCanvas; Rect:TRect; XDiv,YDiv:Single) of object;

type
   TSingleRectPers = class(TPersistent)
   private
     FSingleRect : TSingleRect;
     FOnChange: TNotifyEvent;
     function GetRect: TSingleRect;
     procedure SetRect(const Value: TSingleRect);
     procedure SetRectValue(Index:integer;const Value: Single);
   protected
     procedure AssignTo(Dest: TPersistent); override;
   public
     property AsRect : TSingleRect read GetRect Write SetRect;
     constructor create; virtual;
   published
     property MinHeight : single index 0  read FSingleRect.MinHeight write SetRectValue;
     property MinWidth : single index 1 read FSingleRect.MinWidth write SetRectValue;
     property MaxHeight : single index 2 read FSingleRect.MaxHeight write SetRectValue;
     property MaxWidth : single index 3 read FSingleRect.MaxWidth write SetRectValue;
     property OnChange : TNotifyEvent read FOnChange write FOnChange;
   end;


type
  TTrackPanel = class(TPanel)
  private
    { Private declarations }
    FAreaSize:TSingleRectPers;
    FAreaDiv:Single;
    FAreaTick:Integer;
    FOnDrawGraph:TEventProcDrawGraph;
    FSlider:Single;
    FConvX:Single;
    FConvY:Single;
    FSliderRect: TRect;
    FDown: Boolean;
    TempX: Integer;
    TempY: Integer;
    FCanSlide: Boolean;
    FOnPaint: TNotifyEvent;
  protected
    { Protected declarations }
    procedure AreaChanged(Sender : TObject);
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
      override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure SetAreaTick(Value:Integer);
    function fGetFloatX:Single;
    function fGetFloatY:Single;
  public
    { Public declarations }
    Graph:TBitmap;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
    property GetFloatX:Single read fGetFloatX;
    property GetFloatY:Single read fGetFloatY;
    property AreaSize:TSingleRectPers read FAreaSize write FAreaSize;
    property AreaDiv:Single read FAreaDiv write FAreaDiv;
    property AreaTick:Integer read FAreaTick write SetAreaTick default 5;
    property Slider: Single read FSlider write FSlider;
    property OnDrawGraph:TEventProcDrawGraph read FOnDrawGraph write FOnDrawGraph ;
    property CanSlide:Boolean read FCanSlide write FCanSlide;
    property OnPaint: TNotifyEvent read FOnPaint write FOnPaint;
  end;

procedure Register;

implementation

{ TSingleRectPers }
  
procedure TSingleRectPers.AssignTo(Dest: TPersistent);
begin
   if Dest is TSingleRectPers then
     with TSingleRectPers(Dest) do
     begin
       AsRect := Self.AsRect;
     end
   else inherited AssignTo(Dest);
end;
  
constructor TSingleRectPers.Create;
begin
   inherited;
   FOnChange := nil;
end;

function TSingleRectPers.GetRect: TSingleRect;
begin
   Result := FSingleRect;
end;
  
procedure TSingleRectPers.SetRect(const Value: TSingleRect);
begin
   FSingleRect.MaxHeight := Value.MaxHeight;
   FSingleRect.MaxWidth := Value.MaxWidth;
   FSingleRect.MinHeight := Value.MinHeight;
   FSingleRect.MinWidth := Value.MinWidth;
   if Assigned(FOnChange) then FOnChange(self);
end;

procedure TSingleRectPers.SetRectValue(Index:integer; const Value: Single);
begin
 case index of
  0: FSingleRect.MinHeight:=Value;
  1: If (Value<FSingleRect.MaxWidth)or(Value>=0) then FSingleRect.MinWidth:=Value;
  2: FSingleRect.MaxHeight:=Value;
  3: If (Value>FSingleRect.MinWidth) then FSingleRect.MaxWidth:=Value;
  end;
   if Assigned(FOnChange) then FOnChange(self);
end;

{ TrackPanel }

constructor TTrackPanel.Create(AOwner: TComponent);
begin
  FAreaTick:=7;
  inherited Create(AOwner);
 // DoubleBuffered:=true;
 Graph:=TBitmap.Create;
  Graph.Width:=10;
  Graph.Height:=10;
  Graph.PixelFormat:=pf24bit;
  FAreaSize := TSingleRectPers.Create;
  FAreaSize.OnChange := AreaChanged;
  FAreaSize.MinHeight:=0;
  FAreaSize.MinWidth:=0;
  FAreaSize.MaxHeight:=100;
  FAreaSize.MaxWidth:=1.0;
  FAreaDiv:=5.0;
end;

procedure TTrackPanel.SetAreaTick(Value:Integer);
begin
if Value<7 then FAreaTick := 7 else
if Value>10 then FAreaTick := 10 else
FAreaTick := Value;
Repaint;
end;

procedure TTrackPanel.Paint;
const
  Alignments: array[TAlignment] of Longint = (DT_LEFT, DT_RIGHT, DT_CENTER);
Label
  MaxXAgain,MaxYAgain;
var
  cRect: TRect;
  HRect:TRect;
  TopColor, BottomColor: TColor;
  FontHeight: Integer;
  Flags: Longint;
  Dh,i,BLeft,tH,tB,j,divY,MaxY,divX,MaxX,BTop,LeftText,posSlider:integer;
  DivFX,DivFY,val:Single;
  fRect:TRect;

  procedure AdjustColors(Bevel: TPanelBevel);
  begin
    TopColor := clBtnHighlight;
    if Bevel = bvLowered then TopColor := clBtnShadow;
    BottomColor := clBtnShadow;
    if Bevel = bvLowered then BottomColor := clBtnHighlight;
  end;

begin


  cRect := GetClientRect;
with Graph do begin
  Graph.Width:=cRect.Right;
  Graph.Height:=cRect.Bottom;
  if BevelOuter <> bvNone then
  begin
    AdjustColors(BevelOuter);
    Frame3D(Canvas, cRect, TopColor, BottomColor, BevelWidth);
  end;
  Frame3D(Canvas, cRect, Color, Color, BorderWidth);
  if BevelInner <> bvNone then
  begin
    AdjustColors(BevelInner);
    Frame3D(Canvas, cRect, TopColor, BottomColor, BevelWidth);
  end;

  with Canvas do
  begin
  //  Brush.Color := Color;
    Brush.Color := clBlack;
    FillRect(cRect);
    Brush.Style := bsClear;
    Font := Self.Font;
    Font.Color:=clGray;
    FontHeight := TextHeight('W');

 {   with Rect do
    begin
      Top := ((Bottom + Top) - FontHeight) div 2;
      Bottom := Top + FontHeight;
    end;   }
   // Flags := DT_EXPANDTABS or DT_VCENTER or Alignments[Alignment];
  //  Flags := DrawTextBiDiModeFlags(Flags);
   //rawText(Handle, PChar(Caption), -1, Rect, Flags);
   Dh:= FontHeight+2;
   HRect:=cRect;
   HRect.Top:=cRect.Bottom-Dh;
   tH:=HRect.Bottom-4;
   tB:=HRect.Bottom-2;
   LeftText:=40;
   fRect:=Rect(cRect.Left+LeftText,10,cRect.Right,HRect.Top);

   MaxX:=10;
   MaxXAgain:
   DivFX:=(AreaSize.MaxWidth-AreaSize.MinWidth)/MaxX;
   divX:=(HRect.Right-LeftText) div (MaxX*10); // min 6  max 12
   if ((divX<6) and (MaxX>2))  then begin dec(MaxX); goto MaxXAgain; end;
   if divX>8 then begin inc(MaxX); goto MaxXAgain; end;


   MaxY:= 10;
   MaxYAgain:
   DivFY:=(AreaSize.MaxHeight-AreaSize.MinHeight)/MaxY;
   DivY:=(hRect.Top-10) div MaxY;  // min 20  max 50
   if ((divY<20) and (MaxY>2))  then begin dec(MaxY); goto MaxYAgain; end;
   if divY>30 then begin inc(MaxY); goto MaxYAgain; end;

   BTop:=fRect.Top;
   Pen.Color:= TColor(3421236);
   // вертикальная сетка
   for j:=0 to MaxY do begin
        Pen.Width:=1;
        val:=FAreaSize.MaxHeight-j*DivFY ;
        if (val = 0) then Pen.Width:=2;
        MoveTo(fRect.Left,BTop);
        LineTo(cRect.Right,BTop);
        TextOut(cRect.Left+3,BTop-(FontHeight div 2),format('%.2f',[val]));
        BTop:=BTop+divY;
        end;
   Pen.Width:=1;
   // горизонтальная
   BLeft:=fRect.Left;
   for j:=0 to MaxX do begin
        Pen.Width:=1;
        if (j*DivFX = 0) then Pen.Width:=2;
        MoveTo(BLeft,fRect.Top);
        LineTo(BLeft,HRect.Top-1);
        BLeft:=BLeft+divX*10;
        end;
   Pen.Width:=1;
   // тут рисуем рисунок
    FConvX:=divX/DivFX*10;
    FConvY:=divY/DivFY;
   if Assigned(FOnDrawGraph) then FOnDrawGraph(Canvas,
   fRect,FConvX,FConvY);
   // наносим координаты
   Brush.Color := clBtnShadow;//TColor(8546127);
   FillRect(HRect);
   // рисуем ползунок
   posSlider:=fRect.Left+Round(FSlider*FConvX);
   FSliderRect.Left:=posSlider-2;
   FSliderRect.Right:=posSlider+2;
   FSliderRect.Top:=fRect.Top;
   FSliderRect.Bottom:=fRect.Bottom;
   if FCanSlide then begin
        Pen.Color:=clYellow;
        Pen.Width:=2;
        MoveTo(posSlider,fRect.Top);
        LineTo(posSlider,fRect.Bottom);
   end;
   Pen.Width:=1;
   Pen.Color:=clBlack;
   MoveTo(cRect.Left,HRect.Top-1);
   LineTo(cRect.Right,HRect.Top-1);

   // окно для времени
   Pen.Color:=clGray;//TColor(1644825);
   MoveTo(cRect.Left,HRect.Bottom-2);
   LineTo(cRect.Right,HRect.Bottom-2);
   Frame3D(Canvas, HRect, clGray, clBlack, 1);
   // рисуем ползунок  .
{   Pen.Width:=2;
   Pen.Color:=clYellow;
   MoveTo(posSlider,HRect.Top);
   LineTo(posSlider,HRect.Bottom-2);}
   Pen.Width:=1;
   // рисуем ось времени
   Pen.Color:=clBlack;
   BLeft:=fRect.Left;
   Brush.Style := bsClear;
   // минимум 5 максимус 10 пикселей
   Font.Color:=clBlack;
   for j:=0 to MaxX do begin
        MoveTo(BLeft,HRect.Bottom);
        LineTo(BLeft,HRect.Top-1);

        TextOut(BLeft+3,HRect.Top-2,format('%.2f',[j*DivFX]));
        BLeft:=BLeft+divX;
        for i:=0 to 8  do begin
                MoveTo(BLeft,tB);
                LineTo(BLeft,tH);
                BLeft:=BLeft+divX;
                end;
   end;

  end;
end;
  Canvas.Draw(0,0,Graph);
  if Assigned(FOnPaint) then FOnPaint(Self);
end;

//------------------------------------------------------------------------------

procedure TTrackPanel.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  CurPoint: TPoint;
begin
  inherited MouseDown(Button, Shift, X, Y);
  if Cursor = crHSplit then
        FDown := true;
  Invalidate;
end;


function TTrackPanel.fGetFloatX:Single;
var
Pos:Tpoint;
begin
  GetCursorPos(Pos);
  Pos:=ScreenToClient(Pos);
  Result:=(Pos.X-40)/FConvX;
end;

function TTrackPanel.fGetFloatY:Single;
var
Pos:Tpoint;
begin
  GetCursorPos(Pos);
  Pos:=ScreenToClient(Pos);
  Result:=((Pos.Y-10)-(FConvY*FAreaSize.MaxHeight))/(-FConvY);
end;

procedure TTrackPanel.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  CurPoint: TPoint;
  tX, tY: Integer;
begin

  if FCanSlide then begin

  if FDown then
  begin
  //   posSlider:=fRect.Left+Round(FSlider*FConvX);

   Slider:=(X-40)/FConvX;
   if Slider<FAreaSize.MinWidth then Slider:=FAreaSize.MinWidth;
   if Slider>FAreaSize.MaxWidth then Slider:=FAreaSize.MaxWidth;
   RePaint;
  end else
  begin
    if (FSliderRect.Left<X) and (FSliderRect.Right>X) and
     (FSliderRect.Top<Y) and (FSliderRect.Bottom>Y) then
      Cursor := crHSplit
     else
     Cursor := crDefault;
  end;
  end;

  inherited MouseMove(Shift, X, Y);

end;
//------------------------------------------------------------------------------
procedure TTrackPanel.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  FDown := false;
  Invalidate;
end;
//--------------

procedure TTrackPanel.AreaChanged(Sender : TObject);
begin
  // перерисовываем график с новыми размерами
  Repaint;
end;

destructor TTrackPanel.Destroy;
begin
   FreeAndNil(FAreaSize);
   inherited;
end;

procedure Register;
begin
  RegisterComponents('PanelX', [TTrackPanel]);
end;

end.
