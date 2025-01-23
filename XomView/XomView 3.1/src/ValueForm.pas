unit ValueForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, XomLib, XomCntrLib, StdCtrls, ExtCtrls, Math, PanelX;

type
  TChgValForm = class(TForm)
    Page: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    ValXFloat: TEditX;
    ValXVectorX: TEditX;
    ValXVectorY: TEditX;
    ValXVectorZ: TEditX;
    Apply: TButton;
    ValXString: TComboBox;
    ValXInt: TEditX;
    ValXBool: TComboBox;
    ValXUint: TEditX;
    ValXPointX: TEditX;
    ValXPointY: TEditX;
    Panel1: TPanel;
    ValXByte: TEditX;
    TabSheet10: TTabSheet;
    ValXFColorB: TEditX;
    ValXFColorG: TEditX;
    ValXFColorR: TEditX;
    TabSheet12: TTabSheet;
    ValRVectorX: TEditX;
    ValRVectorY: TEditX;
    ValRVectorZ: TEditX;
    ColorD: TColorDialog;
    TabSheet11: TTabSheet;
    ListIntVal: TComboBox;
    TabSheet13: TTabSheet;
    TabSheet14: TTabSheet;
    Vec4_1: TEditX;
    Vec4_2: TEditX;
    Vec4_3: TEditX;
    Vec4_4: TEditX;
    M1_1: TEditX;
    M2_1: TEditX;
    M3_1: TEditX;
    M4_1: TEditX;
    M1_2: TEditX;
    M2_2: TEditX;
    M3_2: TEditX;
    M4_2: TEditX;
    M1_3: TEditX;
    M2_3: TEditX;
    M3_3: TEditX;
    M4_3: TEditX;
    M1_4: TEditX;
    M2_4: TEditX;
    M3_4: TEditX;
    M4_4: TEditX;
    TabSheet15: TTabSheet;
    EditX4Char: TEdit;
    TabSheet16: TTabSheet;
    ValXText: TRichEdit;
    TabSheet7: TTabSheet;
    ValXColorA: TEditX;
    Button1: TButton;
    ColorP: TPanel;
    TabSheet17: TTabSheet;
    Button2: TButton;
    ColorB: TPanel;
    procedure FormShow(Sender: TObject);
    procedure ApplyClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ChgValForm: TChgValForm;
  CntrVal: TCntrVal;

implementation

{$R *.dfm}



function GetValues(const Strings:TStrings):TStrings;
var i,ValPos:integer;
Res:String;
begin
Result:=TStringList.Create;
for  i:=0 to Strings.Count-1 do begin
      Res := Strings.Strings[i];
      ValPos := Pos('=', Res);
      if ValPos > 0 then
        Delete(Res, 1, ValPos);
      Result.Add(Res);
end;
end;

procedure TChgValForm.FormShow(Sender: TObject);
var
Pnt,vp:Pointer;
vc:Cardinal;
StrPar:array[1..4]of char;
begin
 Panel1.Caption:=CntrVal.IdName;
 Pnt:=CntrVal.Point;
 case CntrVal.XType of
      XBool:    begin
                Page.ActivePageIndex:=4;
                ValXBool.Text:=BoolToStr(Boolean(byte(Pnt^)), true);
                end;
      XByte:    begin
                Page.ActivePageIndex:=7;
                ValXByte.FloatVal:=byte(Pnt^);
                end;
      XString:  begin
                Page.ActivePageIndex:=0;
                ValXString.Items:=GetValues(But.GlValueList.Strings);
                ValXString.Text:=Xom.GetStr128(Pnt);
                end;
      XText:    begin
                Page.ActivePageIndex:=15;
                ValXText.Text:=Xom.GetStr128(Pnt);
                end;
      XFFloat,XFloat:   begin
                Page.ActivePageIndex:=1;
                ValXFloat.FloatVal:=single(Pnt^);
                end;
      XEnum: begin
                Page.ActivePageIndex:=10;
                ListIntVal.Items:=StringListFromStrings(CntrVal.XList^,CntrVal.XListSize);
                ListIntVal.ItemIndex:=Integer(Pnt^);
                end;
      XEnumByte: begin
                Page.ActivePageIndex:=10;
                ListIntVal.Items:=StringListFromStrings(CntrVal.XList^,CntrVal.XListSize);
                ListIntVal.ItemIndex:=byte(Pnt^);
                end;
      XInt:     begin
                Page.ActivePageIndex:=3;
                ValXInt.FloatVal:=integer(Pnt^);
                end;
      X4Char:   begin
                Page.ActivePageIndex:=14;
                Move(Pnt^,StrPar[1],4);
                EditX4Char.Text:=StrPar;
                end;
      XCode:    begin

                end;
      XVectorR: begin
                Page.ActivePageIndex:=11;
                vc:=Longword(Pnt);
                ValRVectorX.FloatVal:=RadToDeg(Single(Pointer(vc)^));
                ValRVectorY.FloatVal:=RadToDeg(Single(Pointer(vc + 4)^));
                ValRVectorZ.FloatVal:=RadToDeg(Single(Pointer(vc + 8)^));
                end;
      XVector4,XSBound:  Begin
                Page.ActivePageIndex:=12;
                vc:=Longword(Pnt);
                Vec4_1.FloatVal:=Single(Pointer(vc)^);
                Vec4_2.FloatVal:=Single(Pointer(vc + 4)^);
                Vec4_3.FloatVal:=Single(Pointer(vc + 8)^);
                Vec4_4.FloatVal:=Single(Pointer(vc + 12)^);
                end;
      XVector:  Begin
                Page.ActivePageIndex:=2;
                vc:=Longword(Pnt);
                ValXVectorX.FloatVal:=Single(Pointer(vc)^);
                ValXVectorY.FloatVal:=Single(Pointer(vc + 4)^);
                ValXVectorZ.FloatVal:=Single(Pointer(vc + 8)^);
                end;
      XFColor:  Begin
                Page.ActivePageIndex:=9;
                vc:=Longword(Pnt);
                ValXFColorR.FloatVal:=Single(Pointer(vc)^);
                ValXFColorG.FloatVal:=Single(Pointer(vc + 4)^);
                ValXFColorB.FloatVal:=Single(Pointer(vc + 8)^);
                end;
      XMatrix4: begin
                Page.ActivePageIndex:=13;
                vp:=Pnt;
                M1_1.FloatVal:=Single(vp^); Inc(Longword(vp),4);
                M1_2.FloatVal:=Single(vp^); Inc(Longword(vp),4);
                M1_3.FloatVal:=Single(vp^); Inc(Longword(vp),4);
                M1_4.FloatVal:=Single(vp^); Inc(Longword(vp),4);
                M2_1.FloatVal:=Single(vp^); Inc(Longword(vp),4);
                M2_2.FloatVal:=Single(vp^); Inc(Longword(vp),4);
                M2_3.FloatVal:=Single(vp^); Inc(Longword(vp),4);
                M2_4.FloatVal:=Single(vp^); Inc(Longword(vp),4);
                M3_1.FloatVal:=Single(vp^); Inc(Longword(vp),4);
                M3_2.FloatVal:=Single(vp^); Inc(Longword(vp),4);
                M3_3.FloatVal:=Single(vp^); Inc(Longword(vp),4);
                M3_4.FloatVal:=Single(vp^); Inc(Longword(vp),4);
                M4_1.FloatVal:=Single(vp^); Inc(Longword(vp),4);
                M4_2.FloatVal:=Single(vp^); Inc(Longword(vp),4);
                M4_3.FloatVal:=Single(vp^); Inc(Longword(vp),4);
                M4_4.FloatVal:=Single(vp^); Inc(Longword(vp),4);
                end;
      XMatrix3: begin
                Page.ActivePageIndex:=13;
                vp:=Pnt;
                M1_1.FloatVal:=Single(vp^); Inc(Longword(vp),4);
                M1_2.FloatVal:=Single(vp^); Inc(Longword(vp),4);
                M1_3.FloatVal:=Single(vp^); Inc(Longword(vp),4);
                M1_4.FloatVal:=0.0;
                M2_1.FloatVal:=Single(vp^); Inc(Longword(vp),4);
                M2_2.FloatVal:=Single(vp^); Inc(Longword(vp),4);
                M2_3.FloatVal:=Single(vp^); Inc(Longword(vp),4);
                M2_4.FloatVal:=0.0;
                M3_1.FloatVal:=Single(vp^); Inc(Longword(vp),4);
                M3_2.FloatVal:=Single(vp^); Inc(Longword(vp),4);
                M3_3.FloatVal:=Single(vp^); Inc(Longword(vp),4);
                M3_4.FloatVal:=0.0;
                M4_1.FloatVal:=Single(vp^); Inc(Longword(vp),4);
                M4_2.FloatVal:=Single(vp^); Inc(Longword(vp),4);
                M4_3.FloatVal:=Single(vp^); Inc(Longword(vp),4);
                M4_4.FloatVal:=1.0;
                end;
      XColor:   begin
                Page.ActivePageIndex:=6;
                vc:=Longword(Pnt);
                ColorD.Color:=RGB(byte(Pointer(vc)^),byte(Pointer(vc + 1)^),byte(Pointer(vc + 2)^));
                ColorP.Color:=ColorD.Color;
                ValXColorA.FloatVal:=byte(Pointer(vc + 3)^);
                end;
      XBColor:  begin
                Page.ActivePageIndex:=16;
                vc:=Longword(Pnt);
                ColorD.Color:=RGB(byte(Pointer(vc)^),byte(Pointer(vc + 1)^),byte(Pointer(vc + 2)^));
                ColorB.Color:=ColorD.Color;
                end;
      XUInt:    begin
                Page.ActivePageIndex:=5;
                ValXUInt.FloatVal:=SmallInt(Pnt^);
                end;
      XIndex:   begin
                Page.ActivePageIndex:=5;
                ValXInt.FloatVal:=TestByte128(Pnt);
                end;
      XPoint:   begin
                Page.ActivePageIndex:=8;
                vc:=Longword(Pnt);
                ValXPointX.FloatVal:=Single(Pointer(vc)^);
                ValXPointY.FloatVal:=Single(Pointer(vc + 4)^);
                end;
      end;

end;


procedure TChgValForm.ApplyClick(Sender: TObject);
var
OldPnt,Pnt,NewPnt:Pointer;
Buf: TMemoryStream;
Size:Integer;
vc:Cardinal;
val:Cardinal;
valf:Single;
StrPar:array[1..4]of char;
begin
// создать копию

 Buf := TMemoryStream.Create;
 Pnt:=CntrVal.Point;   // точка на значение
 CntrVal.Cntr.CopyBufTo(Buf,Pnt);
 case CntrVal.XType of
      XBool:    begin
                val:=ValXBool.ItemIndex;
                Buf.Write(val,1);
                Inc(Longword(Pnt),1);
                end;
      XByte:    begin
                val:=Round(ValXByte.GetFloatVal);
                Buf.Write(val,1);
                Inc(Longword(Pnt),1);
                end;
      XString:  begin
                Xom.WriteXName(Buf,ValXString.Text);
                TestByte128(Pnt);
                end;
      XText:    begin
                Xom.WriteXName(Buf,ValXText.Text);
                TestByte128(Pnt);
                end;
      X4Char:   begin
                Move(PChar(EditX4Char.Text)^,StrPar[1],4);
                Buf.Write(StrPar[1],4);
                Inc(Longword(Pnt),4);
                end;
      XIndex:   begin
                WriteXByte(Buf,Round(ValXInt.GetFloatVal));
                TestByte128(Pnt);
                end;
      XFFloat,XFloat:   begin
                valf:=ValXFloat.GetFloatVal;
                Buf.Write(valf,4);
                Inc(Longword(Pnt),4);
                end;
      XEnum:    begin
                val:=ListIntVal.ItemIndex;
                Buf.Write(val,4);
                Inc(Longword(Pnt),4);
                end;
      XEnumByte: begin
                val:=ListIntVal.ItemIndex;
                if ListIntVal.Text='NONE' then val:=255;
                Buf.Write(val,1);
                Inc(Longword(Pnt),1);
                end;
      XInt:     begin
                val:=Round(ValXInt.GetFloatVal);
                Buf.Write(val,4);
                Inc(Longword(Pnt),4);
                end;
      XCode:    begin

                end;
      XVectorR:  Begin
                valf:=DegToRad(ValRVectorX.GetFloatVal);
                Buf.Write(valf,4);
                valf:=DegToRad(ValRVectorY.GetFloatVal);
                Buf.Write(valf,4);
                valf:=DegToRad(ValRVectorZ.GetFloatVal);
                Buf.Write(valf,4);
                Inc(Longword(Pnt),4*3);
                end;
      XVector:  Begin
                valf:=ValXVectorX.GetFloatVal;
                Buf.Write(valf,4);
                valf:=ValXVectorY.GetFloatVal;
                Buf.Write(valf,4);
                valf:=ValXVectorZ.GetFloatVal;
                Buf.Write(valf,4);
                Inc(Longword(Pnt),4*3);
                end;
      XVector4,XSBound:  Begin
                valf:=Vec4_1.GetFloatVal; Buf.Write(valf,4);
                valf:=Vec4_2.GetFloatVal; Buf.Write(valf,4);
                valf:=Vec4_3.GetFloatVal; Buf.Write(valf,4);
                valf:=Vec4_4.GetFloatVal; Buf.Write(valf,4);
                Inc(Longword(Pnt),4*4);
                end;
      XMatrix4: begin
                valf:=M1_1.GetFloatVal; Buf.Write(valf,4);
                valf:=M1_2.GetFloatVal; Buf.Write(valf,4);
                valf:=M1_3.GetFloatVal; Buf.Write(valf,4);
                valf:=M1_4.GetFloatVal; Buf.Write(valf,4);
                valf:=M2_1.GetFloatVal; Buf.Write(valf,4);
                valf:=M2_2.GetFloatVal; Buf.Write(valf,4);
                valf:=M2_3.GetFloatVal; Buf.Write(valf,4);
                valf:=M2_4.GetFloatVal; Buf.Write(valf,4);
                valf:=M3_1.GetFloatVal; Buf.Write(valf,4);
                valf:=M3_2.GetFloatVal; Buf.Write(valf,4);
                valf:=M3_3.GetFloatVal; Buf.Write(valf,4);
                valf:=M3_4.GetFloatVal; Buf.Write(valf,4);
                valf:=M4_1.GetFloatVal; Buf.Write(valf,4);
                valf:=M4_2.GetFloatVal; Buf.Write(valf,4);
                valf:=M4_3.GetFloatVal; Buf.Write(valf,4);
                valf:=M4_4.GetFloatVal; Buf.Write(valf,4);
                Inc(Longword(Pnt),4*4*4);
                end;
      XMatrix3: begin
                valf:=M1_1.GetFloatVal; Buf.Write(valf,4);
                valf:=M1_2.GetFloatVal; Buf.Write(valf,4);
                valf:=M1_3.GetFloatVal; Buf.Write(valf,4);

                valf:=M2_1.GetFloatVal; Buf.Write(valf,4);
                valf:=M2_2.GetFloatVal; Buf.Write(valf,4);
                valf:=M2_3.GetFloatVal; Buf.Write(valf,4);

                valf:=M3_1.GetFloatVal; Buf.Write(valf,4);
                valf:=M3_2.GetFloatVal; Buf.Write(valf,4);
                valf:=M3_3.GetFloatVal; Buf.Write(valf,4);

                valf:=M4_1.GetFloatVal; Buf.Write(valf,4);
                valf:=M4_2.GetFloatVal; Buf.Write(valf,4);
                valf:=M4_3.GetFloatVal; Buf.Write(valf,4);

                Inc(Longword(Pnt),4*4*3);
                end;
      XFColor:  Begin
                valf:=ValXFColorR.GetFloatVal;
                Buf.Write(valf,4);
                valf:=ValXFColorG.GetFloatVal;
                Buf.Write(valf,4);
                valf:=ValXFColorB.GetFloatVal;
                Buf.Write(valf,4);
                Inc(Longword(Pnt),4*3);
                end;
      XColor:  Begin
                val:=GetRValue(ColorD.Color);
                Buf.Write(val,1);
                val:=GetGValue(ColorD.Color);
                Buf.Write(val,1);
                val:=GetBValue(ColorD.Color);
                Buf.Write(val,1);
                val:=Round(ValXColorA.GetFloatVal);
                Buf.Write(val,1);
                Inc(Longword(Pnt),1*4);
                end;
      XBColor:  Begin
                val:=GetRValue(ColorD.Color);
                Buf.Write(val,1);
                val:=GetGValue(ColorD.Color);
                Buf.Write(val,1);
                val:=GetBValue(ColorD.Color);
                Buf.Write(val,1);
                Inc(Longword(Pnt),1*3);
                end;
      XUInt:    begin
                val:=Round(ValXUInt.GetFloatVal);
                Buf.Write(val,2);
                Inc(Longword(Pnt),2);
                end;
      XPoint:   begin
                valf:=ValXPointX.GetFloatVal;
                Buf.Write(valf,4);
                valf:=ValXPointY.GetFloatVal;
                Buf.Write(valf,4);
                Inc(Longword(Pnt),4*2);
                end;
 end;
 CntrVal.Cntr.CopyBufFrom(Buf,Pnt);
 CntrVal.Cntr.WriteBuf(Buf);
 Buf.Free;
end;

procedure TChgValForm.Button1Click(Sender: TObject);
begin
If ColorD.Execute then
ColorP.Color:=ColorD.Color;
end;

procedure TChgValForm.Button2Click(Sender: TObject);
begin
If ColorD.Execute then
ColorB.Color:=ColorD.Color;
end;


end.
