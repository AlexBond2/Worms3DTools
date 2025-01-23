unit PanelX;

interface

uses
  SysUtils, Classes, Controls, ExtCtrls, Windows,
  Messages, Variants, Graphics, Forms, StdCtrls, Math;
{
type
  TSpeedButton = class(ButtonsX.TSpeedButton)
  end;
type
  TBitBtn = class(ButtonsX.TBitBtn)
  end;

type
  TPanel = class(ExtCtrls.TPanel)
    procedure Paint; override;
  end;  }


const
  ConstUnActiveColor: TColor = $bbab9d;//$7F5A33; //ColorToRGB(clBtnFace);//$00A06F00;
  ConstActiveColor: TColor   = $ffffff;//$CFAE89; //ColorToRGB(clWindow);

var
  UnActiveColor: TColor = $7F5A33; //ColorToRGB(clBtnFace);//$00A06F00;
  ActiveColor: TColor = $CFAE89;   //ColorToRGB(clWindow);

type 
  TgrPos = (grVert, grHorz);
type 
  GrStyle = (grStandard, grInside);

type
  TPanelPlus = class(TPanel)
  private
    FOnPaint: TNotifyEvent;
    //   FValText: TCaption;
    //   FCollPanel:TPanelCollapse;
    FCollapse: Boolean;
    FMakeEdit: Boolean;
    FEdit: TEdit;
    FHeight: Integer;
    FEditText: TCaption;
    Init: Boolean;
    FEColor: TColor;
    FCaption:TCaption;
    //   FOnClick: TNotifyEvent;
    //    procedure SetOnOpenGL(Value: Boolean);
    //    function GetActive:Boolean;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetFullHeight(Value: Integer);
//    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer;
//      AHeight: Integer); override;
  protected
    procedure Paint; override;
    procedure SetText(const Value: TCaption);
    procedure SetEditText(Value: TCaption);
    procedure SetCollapse(Value: Boolean);
    procedure SetMakeEdit(Value: Boolean);
    procedure SetEditColor(Value: TColor);
    //    procedure SetFHeight(Value:Integer);
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
      override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
  published
    property Caption: TCaption read FCaption write SetText;
    //  property OnClick: TNotifyEvent read FOnClick write FOnClick;
    // property Edit:TEdit read FEdit write FEdit;
    property OnPaint: TNotifyEvent read FOnPaint write FOnPaint;
    //  property ValText: TCaption read FValText write FValText;
    //  property CollapsePanel:TPanelCollapse read FCollPanel write FCollPanel;
    property Collapse: Boolean read FCollapse write SetCollapse;
    property FullHeight: Integer read FHeight write FHeight;
    property EditText: TCaption read FEditText write SetEditText;
    property MakeEdit: Boolean read FMakeEdit write SetMakeEdit;
    property EditColor: TColor read FEColor write SetEditColor;
  end;

type
  EventProc     = function(Value: Real): Integer stdcall;
  TEventProc    = EventProc;
  TEventProcVal = procedure(Value: Real) of object;
  TEventProcD = procedure of object;
  //  PEditX = ^TEditX;
  
type
  TSpinFloatX = class(TGraphicControl)
  private
    crUpDown: HIcon;
    FDown: Boolean;
    FBitmap: TBitmap;
    FFloatVal: Real;
    FUpDownTemp: Real;
    FFloatDiv2: Real;
    TempX: Integer;
    TempY: Integer;
    FFloatDiv: Real;
 //   FFloatFunc: TEventProc;
    FPParentEdit: Pointer;
  protected
    procedure SetFloat(Value: Real);
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
      override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    //  procedure Click; override;
  published
    property Enabled;
    property FloatVal: Real read FFloatVal write SetFloat;
    property FloatDiv: Real read FFloatDiv write FFloatDiv;
    // property SetFloatFunc: TEventProc read FFloatFunc write FFloatFunc;
//    procedure SetFloatFunc(Func: TEventProc);
  end;

  TEditX = class(TCustomLabeledEdit)
  private
    FSpinFloat: TSpinFloatX;
    //  FLoad:Boolean;
    FFloatVal: Real;
    FFloatDiv: Real;
    FMaxValue: Real;
    FMinValue: Real;
    FPrecision: Integer;
    Fstr: string;
    //  FOutVal:Pointer;
    FFloatFunc: TEventProcVal;
    FOnDone:TEventProcD;
    procedure SetFloatToEdit(Value: Real);
    procedure TestFloat;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    function GetLabelText: TCaption;
    procedure SetLabelText(Value: TCaption);
    procedure SetFloatVal(Value: Real);
    procedure SetFloatDiv(Value: Real);
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure DoExit; override;
    procedure SetPrecision(Value: Integer);
    procedure CMEnabledchanged(var Message: TMessage);
      message CM_ENABLEDCHANGED;
    // function GetFloatDiv:real;
  public
    OutVal: Pointer;
    constructor Create(AOwner: TComponent); override;
    //    destructor Destroy; override;
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer;
      AHeight: Integer); override;
    function GetFloatVal: Real;
  published
    property Anchors;
    property Color;
    property Constraints;
    property Enabled;
    //    property EditLabel;
    property Font;
    property FloatVal: Real read FFloatVal write SetFloatVal;
    property FloatDiv: Real read FFloatDiv write SetFloatDiv;
    property FloatFunc: TEventProcVal read FFloatFunc write FFloatFunc;
    property OnDone: TEventProcD read FOnDone write FOnDone;    
    property Precision: Integer read FPrecision write SetPrecision;
    property HideSelection;
    property LabelPosition;
    property LabelText: TCaption read GetLabelText write SetLabelText;
    property LabelSpacing;
    property MaxLength;
    property MaxValue: Real read FMaxValue write FMaxValue;
    property MinValue: Real read FMinValue write FMinValue;
    property ReadOnly;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange;
    property OnClick;
    property OnEnter;
    property OnExit;
  end;

type
  TCheckBoxX = class(TCustomCheckBox)
  private
    FEditLabel: TBoundLabel;
    FLabelPosition: TLabelPosition;
    FLabelSpacing: Integer;
    FCaption: TCaption;
    procedure SetLabelPosition(const Value: TLabelPosition);
    procedure SetLabelSpacing(const Value: Integer);
    procedure SetCaption(const Value: TCaption);
  public
    constructor Create(AOwner: TComponent); override;
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer;
      AHeight: Integer); override;
    procedure SetupInternalLabel;
    property EditLabel: TBoundLabel read FEditLabel;
    property LabelPosition: TLabelPosition 
      read FLabelPosition write SetLabelPosition;
    property LabelSpacing: Integer read FLabelSpacing write SetLabelSpacing;
  protected
    procedure SetParent(AParent: TWinControl); override;
  published
    property Action;
    property Alignment;
    property AllowGrayed;
    property Anchors;
    property BiDiMode;
    property Caption: TCaption read FCaption write SetCaption;
    property Checked;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property State;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

type
  PEditX = ^TEditX;

procedure Register;
function GetGradient(grPos: TgrPos; Leng: Integer; Rcolor, Lcolor: TColor;
  Style: GrStyle): TBitmap;

implementation
  {$R PanelX.res}
  //------------------------------------------------------------------------------
//{$DEFINE DEBUG}
{$IFDEF DEBUG}
uses LogFiles;
{$ENDIF}
//--------------------
procedure Register;
begin
  RegisterComponents('PanelX', [TPanelPlus]);
  RegisterComponents('PanelX', [TEditX]);
  RegisterComponents('PanelX', [TSpinFloatX]);
  RegisterComponents('PanelX', [TCheckBoxX]);
  //  RegisterComponents('PanelX', [TPanelCollapse]);
end;
// Tpanel.Paint

 {
procedure TPanel.Paint;
const
  Alignments: array[TAlignment] of Longint = (DT_LEFT, DT_RIGHT, DT_CENTER);
var
  Rect: TRect;
  TopColor, BottomColor: TColor;
  FontHeight: Integer;
  Flags: Longint;

  procedure AdjustColors(Bevel: TPanelBevel);
  begin
    TopColor := clBtnHighlight;
    if Bevel = bvLowered then 
      TopColor := clBtnShadow;
    BottomColor := clBtnShadow;
    if Bevel = bvLowered then 
      BottomColor := clBtnHighlight;
  end;
begin
  Rect := GetClientRect;
  if BevelOuter <> bvNone then
  begin
    AdjustColors(BevelOuter);
    Frame3D(Canvas, Rect, TopColor, BottomColor, BevelWidth);
  end;
  Frame3D(Canvas, Rect, Color, Color, BorderWidth);
  if BevelInner <> bvNone then
  begin
    AdjustColors(BevelInner);
    Frame3D(Canvas, Rect, TopColor, BottomColor, BevelWidth);
  end;
  with Canvas do
  begin
    Brush.Color := Color;
    //FillRect(Rect);
    StretchDraw(Rect,
      GetGradient(grHorz, Rect.Right, UnActiveColor, ActiveColor, grInside));

    Brush.Style := bsClear;
    Font        := Self.Font;
    FontHeight  := TextHeight('W');
    with Rect do
    begin
      Top := ((Bottom + Top) - FontHeight) div 2;
      Bottom := Top + FontHeight;
    end;
    Flags := DT_EXPANDTABS or DT_VCENTER or Alignments[Alignment];
    Flags := DrawTextBiDiModeFlags(Flags);
    DrawText(Handle, PChar(Caption), - 1, Rect, Flags);
  end;
end;          }
//------------------------------------------------------------------------------

{ TCheckBoxX }

//------------------------------------------------------------------------------
constructor TCheckBoxX.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FLabelPosition := lpRight;
  FLabelSpacing := 3;
  Width := 13;
  Height := 13;
  SetupInternalLabel;
end;

procedure TCheckBoxX.SetLabelPosition(const Value: TLabelPosition);
var
  P: TPoint;
begin
  if FEditLabel = nil then 
    Exit;
  FLabelPosition := Value;
  case Value of
    lpAbove: 
      P := Point(Left, Top - FEditLabel.Height - FLabelSpacing);
    lpBelow: 
      P := Point(Left, Top + Height + FLabelSpacing);
    lpLeft: 
      P := Point(Left - FEditLabel.Width - FLabelSpacing,
        Top + ((Height - FEditLabel.Height) div 2));
    lpRight: 
      P := Point(Left + Width + FLabelSpacing,
        Top + ((Height - FEditLabel.Height) div 2));
  end;
  FEditLabel.SetBounds(P.x, P.y, FEditLabel.Width, FEditLabel.Height);
end;

procedure TCheckBoxX.SetLabelSpacing(const Value: Integer);
begin
  FLabelSpacing := Value;
  SetLabelPosition(FLabelPosition);
end;

procedure TCheckBoxX.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  SetLabelPosition(FLabelPosition);
end;

procedure TCheckBoxX.SetCaption(const Value: TCaption);
begin
  FCaption := Value;
  if FEditLabel = nil then 
    Exit;
  FEditLabel.Caption := Value;
end;


procedure TCheckBoxX.SetupInternalLabel;
begin
  if Assigned(FEditLabel) then 
    Exit;
  FEditLabel := TBoundLabel.Create(Self);
  FEditLabel.FreeNotification(Self);
  //  FEditLabel.Caption:=Caption;
  // FEditLabel.FocusControl := Self;
end;

procedure TCheckBoxX.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);
  if FEditLabel = nil then 
    Exit;
  FEditLabel.Parent := AParent;
  FEditLabel.Transparent := true;
  //  FEditLabel.Caption:='test';
  FEditLabel.Visible := true;
end;

//------------------------------------------------------------------------------

{ TPanelPlus }

//------------------------------------------------------------------------------
constructor TPanelPlus.Create(AOwner: TComponent);
  ///var
  //X:Integer;
begin
  inherited Create(AOwner);

  Constraints.MinHeight := 25;
  Constraints.MinWidth := 170;
  Init := true;
end;
//--------------------------

procedure TPanelPlus.SetMakeEdit(Value: Boolean);
var 
  X: Integer;
begin
  if Value then 
  begin
    if FEdit = nil then 
    begin
      FEdit := TEdit.Create(Self);
      FEdit.Parent := Self;
      //  Edit:=TEdit.Create(AOwner);
      X := Canvas.TextWidth(Caption);
      X := X - (X mod 20) + 20;
      FEdit.SetBounds(X + 9, 3, Width - X - 37, 19);
      FEdit.Anchors := [akLeft, akTop, akRight];
      FEdit.BevelEdges := [];
      FEdit.BevelInner := bvSpace;
      FEdit.BevelKind := bkTile;
      FEdit.BevelOuter := bvNone;
      FEdit.Color := UnActiveColor;// clBtnFace;
      FEColor := UnActiveColor;
      FEdit.Ctl3D := false;
      FEdit.ParentCtl3D := false;
      FEdit.ReadOnly := true;
      FEdit.TabOrder := 0;
      FEdit.Text := FEditText;
    end 
    else 
      FEdit.Visible := true;
    FMakeEdit := true;
  end 
  else 
  begin
    if FEdit <> nil then 
      FEdit.Visible := false;
    FMakeEdit := false;
  end;
end;
//-------------------------

procedure TPanelPlus.SetEditText(Value: TCaption);
begin
  FEditText := Value;
  FEdit.Text := Value;
end;
//-------------------------

procedure TPanelPlus.SetEditColor(Value: TColor);
begin
  if FEdit <> nil then 
    FEdit.Color := Value;
  FEColor := Value;
end;
//-------------------------

procedure TPanelPlus.SetCollapse(Value: Boolean);
var
  SBvisible: Boolean;
begin
//{$IFDEF DEBUG}
//  LogFile.WriteLog('TPanelPlus['+Caption+'].SetCollapse('+BoolToStr(Value,True)+')');
//{$ENDIF}
{  if Init then
  begin
    Init  := false;
    Value := true;
  end;     }
  FCollapse := Value;
  SBvisible := (Parent is TScrollBox) and
    not TScrollBox(Parent).VertScrollBar.IsScrollBarVisible;
  if SBvisible then 
    TScrollBox(Parent).AutoScroll := false;
  if Value then 
  begin
    Height := 25 
  end
  else
    Height := FullHeight;
  if SBvisible then
    TScrollBox(Parent).AutoScroll := true;
{$IFDEF DEBUG}
  LogFile.WriteLog('TPanelPlus['+Caption+'].SetCollapse('+BoolToStr(Value,True)+
  ')...Height['+IntToStr(Height)+']..Done');
{$ENDIF}
  Paint;
end;
//-------------------------
      {
procedure TPanelPlus.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  if AHeight <> 25 then
    FHeight := AHeight;
end;       }

procedure TPanelPlus.SetText(const Value: TCaption);
var X:integer;
begin
//  inherited  SetText(Value);
      FCaption:=Value;
      if FEdit <> nil then
      begin
      X := Canvas.TextWidth(Value);
      X := X - (X mod 20) + 20;
      FEdit.SetBounds(X + 9, 3, Width - X - 37, 19);
      end;
//      FEdit.Anchors := [akLeft, akTop, akRight];
end;
//-------------------------
{procedure TPanelPlus.SetFHeight(Value:Integer);
begin
if FHeight<> Value then
FHeight:=Value;
SetCollapse(FCollapse);
end;           }
//-------------------------

procedure TPanelPlus.SetFullHeight(Value: Integer);
begin
  FHeight := Value;
  SetCollapse(FCollapse);
end;
//-------------------------

procedure TPanelPlus.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if Cursor = crHandPoint then
    Collapse := not Collapse
  else 
    self.Parent.SetFocus;
end;
//-------------------------

procedure TPanelPlus.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  W, H, S: Integer;
begin
  W := Width - 26;
  H := 3;
  S := 19;
  if (X > W) and (X < W + S) and (Y > H) and (Y < H + S) then
    Cursor := crHandPoint 
  else  
    Cursor := crDefault;
end;
//------------------------------------------------------------------------------
var 
  TempBmp: TBitmap;

function GetGradient(grPos: TgrPos; Leng: Integer; Rcolor, Lcolor: TColor;
  Style: GrStyle): TBitmap;
var
  x, y: Integer;
  ByteArray: PByteArray;
  procent: Real;
  function GetPerCol(rbyte, lbyte: Integer; pers: Real): Integer;
  var 
    Rescol: Integer;
  begin
    Rescol := rbyte - lbyte;
    if Rescol >= 0 then 
      Rescol := Round(Min(lbyte, rbyte) + pers * Rescol)
    else 
      Rescol := Round(Max(lbyte, rbyte) + pers * Rescol);
    Result := Rescol;
  end;
begin
  TempBmp.Free;
  TempBmp := TBitmap.Create;
  case grPos of
    grHorz: 
    begin
      TempBmp.Width := Leng;
      TempBmp.Height := 1;
      TempBmp.PixelFormat := pf24bit;
      ByteArray := TempBmp.ScanLine[0];
      for x := 0 to TempBmp.Width - 1 do 
      begin
        if Style = GrStandard then 
          procent := x / (Leng - 1) 
        else 
          procent := Abs((x * 2 - (Leng - 1)) / (Leng - 1));
        ByteArray[x * 3] := GetPerCol(GetBvalue(Rcolor), GetBvalue(Lcolor), procent);
        ByteArray[x * 3 + 1] := GetPerCol(GetGvalue(Rcolor),
          GetGvalue(Lcolor), procent);
        ByteArray[x * 3 + 2] := GetPerCol(GetRvalue(Rcolor),
          GetRvalue(Lcolor), procent);
      end;
    end;
    grVert: 
    begin
      TempBmp.Width := 1;
      TempBmp.Height := Leng;
      TempBmp.PixelFormat := pf24bit;
      for y := 0 to TempBmp.Height - 1 do 
      begin
        ByteArray := TempBmp.ScanLine[y];
        if Style = grStandard then 
          procent := y / (Leng - 1) 
        else 
          procent := Abs((y * 2 - (Leng - 1)) / (Leng - 1));
        // procent:=abs((y*2-(Leng-1))/(Leng-1));
        ByteArray[0] := GetPerCol(GetBvalue(Rcolor), GetBvalue(Lcolor), procent);
        ByteArray[1] := GetPerCol(GetGvalue(Rcolor), GetGvalue(Lcolor), procent);
        ByteArray[2] := GetPerCol(GetRvalue(Rcolor), GetRvalue(Lcolor), procent);
      end;
    end;
  end;
  Result := TempBmp;
end;
//------------------------------------------------------------------------------

procedure TPanelPlus.Paint;
var
  X, Y, W, H, S: Integer;
  //  TempPen:TPen;
begin
  //inherited;
  Canvas.Brush.Color := Color;
  Canvas.Brush.Style := bsClear;
  Canvas.Pen.Color := clBlack;
  Canvas.FillRect(Canvas.ClipRect);
  S := 4;
  W := Width - S;
  H := 25;
  X := s;
  Y := 0;
  //Canvas.Brush.Color:=clWindow;
  //Canvas.StretchDraw(Rect(X+1,Y+1,W-2,H-2),GetGradient(grVert,W-2,clBtnFace,clWindow));
  //Canvas.Draw(X+1,Y+1,GetGradient(grVert,H-2,clBtnFace,clWindow));
  Canvas.StretchDraw(Rect(X + 1, Y + 1, W - 1, H - 1),
    GetGradient(grVert, H - 1, UnActiveColor, ActiveColor, grStandard));
  Canvas.RoundRect(X, Y, W, H, 6, 6);
  Canvas.TextOut(7, 5, Caption);
  W := Width - 26;
  Y := 3;
  S := 19;
  // Canvas.Brush.Color:=Color;
  //
  Canvas.RoundRect(W, Y, W + S, Y + S, 6, 6);
  //  TempPen:=Canvas.Pen;
  // Canvas.Pen.Width:=3;
  //   Canvas.Pen.Color:=Color;
  Canvas.MoveTo(W + 4, Y + 9);
  Canvas.LineTo(W + 15, Y + 9);
  if FCollapse then 
  begin
    Canvas.MoveTo(W + 9, Y + 4);
    Canvas.LineTo(W + 9, Y + 15);
  end;
  //
  //   Canvas.Pen:=TempPen;
  //  Canvas.Pen.Width:=1;
  S := 10;
  W := Width;
  H := Height;
  if not FCollapse then  
    Canvas.StretchDraw(Rect(s, 25, W - S, H - 1),
      GetGradient(grHorz, W - 2 * S, UnActiveColor, ActiveColor, grInside));
  Canvas.Rectangle(s, 24, W - S, H);
    {    Canvas.MoveTo(S,25);
        Canvas.LineTo(S,H);
        Canvas.MoveTo(W-S,25);
        Canvas.LineTo(W-S,H);    }
  if Assigned(FOnPaint) then
    FOnPaint(Self);
end;
//------------------------------------------------------------------------------}
destructor TPanelPlus.Destroy;
begin
  //  FEdit.Free;
  inherited Destroy;
end;
//-------------------------------------

{TSpinFloatX}

//------------------------------------------------------------------------------

constructor TSpinFloatX.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  crUpDown := LoadCursor(HInstance, 'UPDOWN');
  SetBounds(0, 0, 23, 22);
  ControlStyle := [csCaptureMouse, csDoubleClicks];
  ParentFont := true;
  Color := UnActiveColor;
  FBitmap := TBitmap.Create;
  FBitmap.LoadFromResourceName(hInstance, 'UPDOWN');
  FBitmap.Transparent := true;
end;
//------------------------------------------------------------------------------

procedure TSpinFloatX.Paint;
var
  PaintRect, Rect2: TRect;
  DrawFlags: Integer;
  X, Y: Integer;
begin
  //  Canvas.Font := Self.Font;
  PaintRect := Rect(0, 0, Width, Height);
  DrawFlags := DFCS_BUTTONPUSH or DFCS_ADJUSTRECT;
  if FDown then
    DrawFlags := DrawFlags or DFCS_PUSHED;
  DrawFrameControl(Canvas.Handle, PaintRect, DFC_BUTTON, DrawFlags);
  X := (Width - FBitmap.Width) div 2;
  Y := (Height - FBitmap.Height) div 2;
  if FDown then 
  begin
    Inc(x);
    Inc(y);
  end;
{  if not Enabled then FBitmap.Monochrome:=true else
  FBitmap.Monochrome:=false;  } //Gradient!
  Rect2.Left := 1;
  Rect2.Top := 1;
  if FDown then 
  begin
    Rect2.Left := 2;
    Rect2.Top  := 2;
  end;
  Rect2.Right := PaintRect.Right;
  Rect2.Bottom := PaintRect.Bottom;
 { Canvas.StretchDraw(Rect2, GetGradient(grVert, Rect2.Bottom,
    UnActiveColor, ActiveColor, grInside));  }
  Canvas.Draw(X, Y, FBitmap);
end;
{
procedure TSpinFloatX.SetFloatFunc(Func: TEventProc);
begin
  FFloatFunc := Func;
end;   }
//--------------------

procedure TSpinFloatX.SetFloat(Value: Real);
begin
  FFloatVal := Value;
//  if @FFloatFunc <> nil then
//    FFloatFunc(Value);
  if FPParentEdit <> nil then
    TEditX(FPParentEdit).SetFloatToEdit(Value);
end;
//------------------------------------------------------------------------------

procedure TSpinFloatX.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  CurPoint: TPoint;
begin
  inherited MouseDown(Button, Shift, X, Y);
  // Cursor:=crUpDown;
  FDown := true;
  GetCursorPos(CurPoint);
  TempX := CurPoint.X;
  TempY := CurPoint.Y;
  //  FUpDownVal:=CurPoint.Y;
  FUpDownTemp := FFloatVal;
  FFloatDiv2 := log10(FFloatDiv);
  Invalidate;
end;
//------------------------------------------------------------------
const 
  BrdScr = 16;

procedure TSpinFloatX.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  CurPoint: TPoint;
  tX, tY: Integer;
begin
  inherited MouseMove(Shift, X, Y);
  if FDown then
  begin
    GetCursorPos(CurPoint);
    tX := TempX - CurPoint.X;
    tY := TempY - CurPoint.Y;

    SetCursor(crUpDown);

    FFloatDiv2 := FFloatDiv2 + (tX) * 0.01;
    if FFloatDiv2 > 0 then 
      FFloatDiv2 := 0;
    if FFloatDiv2<-7 then 
      FFloatDiv2 := -7;
    FloatVal := FloatVal + (tY) * Power(10, Round(FFloatDiv2));

    TempX := CurPoint.X;
    TempY := CurPoint.Y;
    if CurPoint.X > screen.DesktopRect.Right - BrdScr then 
    begin 
      TempX := BrdScr - 1; 
      setcursorpos(TempX, CurPoint.y);
    end;
    if CurPoint.X < BrdScr - 1 then 
    begin 
      TempX := screen.DesktopRect.Right - BrdScr; 
      setcursorpos(TempX, CurPoint.y); 
    end;
    if CurPoint.y > screen.DesktopRect.Bottom - BrdScr then 
    begin 
      TempY := BrdScr - 1; 
      setcursorpos(CurPoint.x, TempY); 
    end;
    if CurPoint.y < BrdScr - 1 then 
    begin 
      TempY := screen.DesktopRect.Bottom - BrdScr; 
      setcursorpos(CurPoint.x, TempY); 
    end;
  end
  else 
    Cursor := crDefault;
end;
//------------------------------------------------------------------------------

procedure TSpinFloatX.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  FDown := false;
  if FPParentEdit <> nil then
    if Assigned(TEditX(FPParentEdit).FOnDone) then
        TEditX(FPParentEdit).FOnDone;
  //  FloatVal:=FUpDownTemp+(FUpDownVal-Y)*FFloatDiv;;
  Invalidate;
end;
//------------------------------------------------------------------------------}
destructor TSpinFloatX.Destroy;
begin
  inherited Destroy;
  FBitmap.Free;
end;
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------

{TEditX}

//------------------------------------------------------------------------------
constructor TEditX.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  //  Anchors := [akLeft, akTop, akRight];
  BevelEdges := [];
  BevelInner := bvSpace;
  BevelKind := bkTile;
  BevelOuter := bvNone;
  //  FEdit.Color := $00A06F00;// clBtnFace;
  Ctl3D := false;
  ParentCtl3D := false;
  LabelPosition := lpLeft;
  LabelSpacing := 5;
  SetPrecision(6);
  EditLabel.Transparent := true;
  //  ReadOnly := True;
end;

  //destructor TEditX.Destroy;
  //  inherited Destroy;
  //  FSpinFloat.
  //end;
  //------------------------------------------------------------------------------
function TEditX.GetLabelText: TCaption;
begin
  Result := EditLabel.Caption;
end;

procedure TEditX.SetLabelText(Value: TCaption);
begin
  EditLabel.Caption := Value;
end;
//------------------------------

procedure TEditX.SetFloatVal(Value: Real);
begin
  if FSpinFloat <> nil then
    FSpinFloat.FFloatVal := Value;
  FFloatVal := Value;
  SetFloatToEdit(Value);
  Fstr := Text;
end;

procedure TEditX.SetFloatDiv(Value: Real);
begin
  if FSpinFloat <> nil then
    FSpinFloat.FFloatDiv := Value;
  FFloatDiv := Value;
end;
  
function TEditX.GetFloatVal: Real;
begin
  if FSpinFloat <> nil then
    Result := FSpinFloat.FFloatVal 
  else 
    Result := 0;
end;
{
function TEditX.GetFloatDiv:real;
begin
if FSpinFloat<>nil then
result:=FSpinFloat.FFloatDiv;
end;  }

procedure TEditX.SetPrecision(Value: Integer);
begin
  FPrecision := Value;
  if Value < 0 then 
    FPrecision := 0;
  if Value > 16 then 
    FPrecision := 16;
  SetFloatToEdit(FFloatVal);
end;

procedure TEditX.SetFloatToEdit(Value: Real);
begin
  //Text:=format('%f',[Value]);
  //Text:=FloatToStr(Value);
  if not (FMaxValue = FMinValue) then
  begin
    if Value > FmaxValue then 
    begin
      FloatVal := FmaxValue;
      Exit;
    end;
    if Value < FMinValue then 
    begin
      FloatVal := FMinValue;
      Exit;
    end;
  end;
  if OutVal <> nil then 
    Single(OutVal^) := Value;
  if Assigned(FloatFunc) then 
    FloatFunc(Value);
  Text := FloatToStrF(Value, ffFixed, 16, FPrecision);
end;
//------------------------------------------------------------------------------

procedure TEditX.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  if FSpinFloat <> nil then 
  begin
    FSpinFloat.Left   := ALeft + AWidth;
    FSpinFloat.Top    := ATop;
    FSpinFloat.Width  := 13;
    FSpinFloat.Height := AHeight;
  end;
end;
//------------------------------------------------------------------------------

procedure TEditX.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or ES_RIGHT;
  FSpinFloat := TSpinFloatX.Create(Self.Parent);
  FSpinFloat.Parent := TWinControl(Self.Parent);
  SetBounds(Left, Top, Width, Height);
  TEditX(FSpinFloat.FPParentEdit) := self;
  FSpinFloat.FFloatDiv := FloatDiv;
  FSpinFloat.FFloatVal := FloatVal;
  // FSpinFloat.SetFloatFunc(@SetFloatToEdit);
end;
//-----------------------

procedure TEditX.TestFloat;
var
  v: Extended;
begin
  if not TextToFloat(PChar(Text), v, fvExtended) then
    Text := Fstr
  else
  begin
    SetFloatToEdit(v);
    Fstr := Text;
    // Fstr:=FloatToStrF(v,ffFixed,8,6);
    // Text:=Fstr;
    FloatVal := v;
  end;
end;
//-----------------------

procedure TEditX.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited  KeyDown(Key, Shift);

  if Key = VK_RETURN then
  begin
    TestFloat;
    if Assigned(FOnDone) then FOnDone;
    SelectAll;
  end;
end;
//-----------------------

procedure TEditX.DoExit;
begin
  inherited DoExit;
  TestFloat;
  if Assigned(FOnDone) then FOnDone;
end;

procedure TEditX.CMEnabledchanged(var Message: TMessage);
begin
  //  inherited;
  ReadOnly := not Enabled;
  if FSpinFloat <> nil then 
    FSpinFloat.Enabled := Enabled;
  if Enabled then
    Color := ActiveColor
  else
    Color := UnActiveColor;
end;

end.
