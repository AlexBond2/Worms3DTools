unit XomMeshLib;

interface

uses OpenGLx, IdGlobal, SysUtils, Classes, Windows, ComCtrls, Graphics,
        OpenGLLib, Math, Menus, XomCntrLib;

{$DEFINE NOMULTI}
{$DEFINE NOGLARRAY}

type  

  TDrawType = (DrMesh, DrBlend, DrBone, DrGenAnim,DrSelect,DrBoxes);

  TMaterial = record
    Name: string;
    use: Boolean;
    Abi, Dif, Spe, Emi: Color4d;
    Shi: Single;
  end;

  TAttribute = record
    Material: TMaterial;
    Texture: Integer;
    TextureId: Integer;
    TextureClamp:Boolean;
    Texture2D: Boolean;
    T2DMatrix:TMatrix;
    ZBufferFuncVal: Integer;
    CullFace: Boolean;
    ZBuffer: Boolean;
    Multi: Boolean;
    AlphaTest: Boolean;
    AlphaTestVal: Single;
    Blend: Boolean;
    MultiT1: Integer;
    MultiT2: Integer;
    BlendVal1: Integer;
    BlendVal2: Integer;
    TGAName: string;
  end;

  TTransTypes = (TTNone, TTMatrix, TTVector, TTJoint);

  TTrans = record
    TransType: TTransTypes;
    Pos: Tver;
    Rot: Tver;
    RotOrient: Tver;
    JointOrient: Tver;
    Size: Tver;
    TrMatrix: TMatrix;
  end;

  TKeyFrame = array [0..5] of GLfloat;
  PKeyFrame = ^TKeyFrame;

  TGrafKey = record
        Frame:PKeyFrame;
        Rect:TRect;
        end;

  TTypeKey = record
    objname: string;
//    fullname: string;
    NoAddOp: Boolean;
    ktype: Integer;
  end;

  TKeyData = record
    keytype: TTypeKey;
    Data: array of TKeyFrame;
  end;

  PKeyData = ^TKeyData;

  TMenuItem = class (Menus.TMenuItem)
    public
    KeyType: TTypeKey;
    CntrIdx:Integer;
    end;

  TAnimInfo = record
    True:Boolean;
    Tm:TMatrix;
    TCoord: Tver;
    Child:Integer;
  end;

  AAnimInfo = array of TAnimInfo;

{ TAnimClip }

  TAnimClip = class
{  private
    FAnimInfo:AAnimInfo;
    FNamesObj:TStringList;  }
    constructor Create;
    destructor Destroy;override;
  public
    Name: string;
    Time: Single;
    Keys: array of TKeyData;

    function GenAnimFrame(Name: string; T: TTrans; Bone: Boolean; ActiveMove:Boolean):TAnimInfo;
 //   function  GetAnimFrame(Name: string):TAnimInfo;
    procedure LoadXAnimClip(FileName: string);
    procedure SaveXAnimClip(FileName: string);
    procedure AddKey(KData:PKeyData;CurTime:Single;FirstValue:Single;NewValue:Single;AType:Integer);
    function  FindKey(KData:PKeyData;SelKey:PKeyFrame):integer;
    function  FindTimeKey(KData:PKeyData;FTime:Single):integer;
    function  FindKeyNameType(FName:String;Atype:integer):PKeyData;
    procedure Copy(Source:TAnimClip);
    procedure SortKeys;
    procedure SortKeyData(KData:PKeyData);
    procedure AddKData(KType:TTypeKey);
    procedure DeleteKData(KType:TTypeKey);
    procedure DeleteKey(Key:PKeyFrame);
    procedure UpdateAnimClip;
    procedure Clear;
  end;

  AAnimClip = array of TAnimClip;

{ TAnimClips }


    TAnimClips = class
    constructor Create;
    destructor Destroy; override;
  private
    FAnimClips:AAnimClip;       
  //  FKeyList:TStringList;
  protected
    function GetItem(Index: String): TAnimClip;
    procedure SetItem(Index: String; Value: TAnimClip);
  public
    FStrings:TStringList;
    cIndx:integer;
    Name:String;

    procedure ClearClips;
    function AddClip(Clip:TAnimClip):Integer;
    function GetNameAnimType(AType: Cardinal): string;
    function BuildAnim(XCntr: TContainer):Integer;
    procedure SaveAnimToXom();
    function GetItemID(Index: Integer): TAnimClip;
    property Items[Index:String]:TAnimClip read GetItem write SetItem;
//    property KeyList:TStringList read FKeyList write FKeyList;
  end;

{ THRTimer }

  THRTimer = class(TObject)
    constructor Create;
    function StartTimer: Boolean;
    procedure ReadTimer;
  private
    StartTime: Single;
    ClockRate: Single;
  public
    Value: Single;
    MaxTime: Single;
    Exists: Boolean;
  end;

{ TMesh }

  TMesh = class
  //  AnimClips: AAnimClip;
    Indx: Integer;
    ColorIndx:Integer;
    Name: string;
    ChName:string;
    XType: string;
    Vert: AVer;
    RVert: AVer;
    Weight: AAVal;
    Normal: AVer;
    Face: AFace;

    DPos: AVer;

   FacesMat:Integer;
    MaxFace:Dword;
   ObjBlockLen,
   TrimeshLen,
   NameLen,
   VertsLen,
   FacesLen,
   TextCoordlen,
   MaxVert: Dword;
   Materials: array of ATexures;
   MaterialsName: array of String;

    Color: AUColor;
    ColorF:AFColor;
    TextCoord: ATCoord;
    TextCoord2: ATCoord;
    Transform: TTrans;
    Attribute: TAttribute;
    TextData: array of TRGBA;
    BoneName: string;
 //   BoneNoInv: Boolean;
    BoneMatrix: TMatrix;
    InvBoneMatrix: TMatrix;
    SizeBox: TBox;
    IsLink:Boolean;
    Bones: array of TMesh;
    Childs: array of TMesh;
    CntrArr: TContainers;
    constructor Create(Arr:TContainers);
    procedure InitSizeBox;
    procedure CalcBox(var Box:TBox; const Ver:TVer);    
    procedure CalcSizeBox(Const Ver:TVer);
    procedure Draw(DrawType: TDrawType);
    procedure GetBox(var Box: TBox);

    function GetBone(XCntr: TContainer; Mesh: TMesh): TMesh;

    class function FaceFromStrip(IndFace:IFace):AFace;
    class function FaceToStrip(inFace:AFace):IFace;
    procedure glBuildTriangleGeo(XCntr: TContainer);
    procedure glBuildCollGeo(XCntr: TContainer);
    procedure glLoad2DMipmaps(target: GLenum; Components, Width, Height: GLint;
      Format, atype: GLenum; Data: Pointer);
    procedure DrawSelectBox(SelectBox: TBox);
    procedure SaveAsXom3D(FileName: string);

    procedure SaveAs3DS(FileName: string);
    function GetChunkObjLen(Texture:Boolean):Dword;

    procedure Load3DS(FileName: string);
    procedure ReadVCFile(FileName: string);
    procedure TestApplyVC(VCMesh:TMesh);
    procedure UpdateMesh(XCntr: TContainer);

    function GetTextureGL(XImage:TContainer): Boolean;
    procedure ReadXNode(VirtualBufer: TMemoryStream;
      XTextureStr: TStringList; Tree: TTreeView; Node: TTreeNode);
    function GetMeshOfName(ObjName:String):TMesh;
    function GetMeshOfID(Id:Integer):TMesh;
    destructor Destroy;override;
  end;

  AMesh = array of TMesh;

  function GetMatrix2(Pos, Rot1, Rot2, Rot3, Size: Tver): TMatrix;
function GetMatrix(Pos, Rot, Size: Tver): TMatrix;
procedure MatrixDecompose(XMatrix: TMatrix; var XPos: Tver;
  var XRot: Tver; var XSize: Tver);
function MatrixInvert(const m: TMatrix): TMatrix;
function MatrXMatr(M1, M2: TMatrix): TMatrix;
function MatrXVert(Matrix: TMatrix; V0, V1, V2: Single): Tver;
function ValXVert(Val: Single; vect: TVer): TVer;
function VertAddVert(v1, v2: TVer): TVer;

procedure glxDrawBitmapText(Canvas:TCanvas; wdx, wdy, wdz: GLdouble; bitPoint2: Pointer;
  Name: string; select: Boolean);
procedure glxDrawText(Canvas:TCanvas; wdx, wdy, wdz: GLdouble; Name: string);
procedure GetProjectVert(X,Y:real;axis:TAxis;var p:TXYZ);

implementation

uses XomLib;

procedure glColorPointer(size: TGLint; _type: TGLenum;
  stride: TGLsizei; const _pointer: PGLvoid); stdcall; external opengl32;

procedure glTexCoordPointer(size: TGLint; _type: TGLenum;
  stride: TGLsizei; const _pointer: PGLvoid); stdcall; external opengl32;
//procedure glColorTable(target: TGLint; internalformat: TGLenum; width: TGLsizei;format:TGLenum;_type: TGLenum; const _pointer: PGLvoid);stdcall;external opengl32;

procedure glDisableClientState(_array: TGLenum); stdcall; external opengl32;

{ TAnimClip }

constructor TAnimClip.Create;
begin
end;

procedure TAnimClip.Copy(Source:TAnimClip);
var
 i,n,ii,nn:integer;
begin
 self.Name:=Source.Name;
 self.Time:=Source.Time;
 n:=Length(Source.Keys);
 SetLength(self.Keys,n);
 for i:=0 to n-1 do
        begin
        self.Keys[i].keytype:=Source.Keys[i].keytype;
        nn:=Length(Source.Keys[i].Data);
        SetLength(self.Keys[i].Data,nn);
        for ii:=0 to nn-1 do
                self.Keys[i].Data[ii]:=Source.Keys[i].Data[ii];
        end;
end;

procedure TAnimClip.LoadXAnimClip(FileName: string);
var
  VirtualBufer: TMemoryStream;
  inx2, Num, i, j: Integer;
begin
  VirtualBufer := TMemoryStream.Create;
  VirtualBufer.LoadFromFile(FileName);

//
  Name:=ReadName(VirtualBufer);
  VirtualBufer.Read(Time,4);
  Num:=0;
  VirtualBufer.Read(Num, 2);
  SetLength(Keys,Num);

  for i := 0 to num - 1 do
  begin
    Keys[i].keytype.objname:=ReadName(VirtualBufer);
//    Keys[i].keytype.fullname:=GetFullName(Keys[i].keytype.objname);
    VirtualBufer.Read(Keys[i].keytype.ktype, 4);
    inx2:=0;
    VirtualBufer.Read(inx2, 2);
    SetLength(Keys[i].Data,inx2);

    for j := 0 to inx2 - 1 do
    begin
      VirtualBufer.Read(Keys[i].Data[j][0], 6 * 4);
    end;
  end;
//  
  VirtualBufer.Free;
end;

procedure TAnimClip.SaveXAnimClip(FileName: string);
var
  VirtualBufer: TMemoryStream;
  inx2, Num, i, j: Integer;
  s: string;
begin
  VirtualBufer := TMemoryStream.Create;
  s := Name;
  VirtualBufer.Write(PChar(s)^, Length(s) + 1);
  VirtualBufer.Write(Time,4);
  Num := Length(Keys);
  VirtualBufer.Write(Num, 2);

  for i := 0 to num - 1 do
  begin
    s := Keys[i].keytype.objname;
    VirtualBufer.Write(PChar(s)^, Length(s) + 1);
    VirtualBufer.Write(Keys[i].keytype.ktype, 4);
    inx2 := Length(Keys[i].Data);
    VirtualBufer.Write(inx2, 2);
    for j := 0 to inx2 - 1 do
    begin
      VirtualBufer.Write(Keys[i].Data[j][0], 6 * 4);
    end;
  end;

  VirtualBufer.SaveToFile(FileName);
  VirtualBufer.Free;
end;

procedure TAnimClip.Clear;
var
  j: Integer;
begin
  for j := 0 to Length(Keys) - 1 do
    Keys[j].Data := nil;
  Keys := nil;
end;

destructor TAnimClip.Destroy;
begin
  Clear;
{  SetLength(FAnimInfo,0);
  FAnimInfo:=nil;
  FNamesObj.Free   }
end;

constructor THRTimer.Create;
var
  QW: Int64;
begin
  inherited Create;
  Exists := QueryPerformanceFrequency(QW);
  ClockRate := QW//.QuadPart;
end;

function THRTimer.StartTimer: Boolean;
var
  QW: Int64;
begin
  Result := QueryPerformanceCounter(QW);
  StartTime := QW;//.QuadPart;
  Value := 0.0;
end;

procedure THRTimer.ReadTimer;
var
  ET: Int64;
begin
  QueryPerformanceCounter(ET);
  // Result := 1000.0 * (ET.QuadPart - StartTime) / ClockRate;
  Value := (ET - StartTime) / ClockRate;
  if Value > MaxTime then
    StartTimer;
end;

{ TAnimClips}

constructor TAnimClips.Create;
begin
  FStrings:=TStringList.Create;
//  FKeyList:=TStringList.Create;
end;

destructor TAnimClips.Destroy;
begin
  ClearClips;
  FAnimClips:=nil;
//  FKeyList.Free;
  FStrings.Free;
end;

procedure TAnimClips.ClearClips;
  var
  i:integer;
begin
  for i := 0 to Length(FAnimClips) - 1 do
    FAnimClips[i].Destroy;
  FAnimClips := nil;
  FStrings.Clear;
//  FKeyList.Clear;
end;

procedure TAnimClips.SaveAnimToXom();
var
  inx, i, j, inx2, x, k, k2, k3: Integer;
  NumKeys,Zero,xSize:integer;
  VirtualBufer :TMemoryStream;
  KeyTypes: array of TTypeKey;

        function GetID(const KType:TTypeKey):Integer;
        var ik,nk:integer;
        begin
              nk:=Length(KeyTypes)-1;
              for ik:=0 to nk do
                if (KeyTypes[ik].ktype=KType.ktype) and
                 (KeyTypes[ik].objname=KType.objname)then
                 begin Result:=ik; exit; end;
         Result:=-1;
        end;

        procedure TestKeyType(const kType:TTypeKey);
        begin
          if GetID(KType)=-1 then
             begin
             Inc(NumKeys);
             SetLength(KeyTypes,NumKeys);
             KeyTypes[NumKeys-1]:=kType;
             end;
        end;


procedure  SortKeyTypes;
// сортировка ключей по дереву
var
i,j,n,test:integer;
X:TTypeKey;
begin
n:=Length(KeyTypes)-1;
for i:=1 to n do
  for j:=n downto i do
        begin
        test:=CompareStr(KeyTypes[j-1].objname,KeyTypes[j].objname);
        if (test>0)or ((test=0) and (
        (Word(KeyTypes[j-1].ktype)>Word(KeyTypes[j].ktype))
        or
        ((Word(KeyTypes[j-1].ktype)=Word(KeyTypes[j].ktype))
        and
        (KeyTypes[j-1].ktype>KeyTypes[j].ktype))))
                then begin
                X:=KeyTypes[j-1];
                KeyTypes[j-1]:=KeyTypes[j];
                KeyTypes[j]:=X;
                end;
        end;
end;


begin
  Zero:=0;
    VirtualBufer := TMemoryStream.Create;

    Xom.WriteXName(VirtualBufer, Name);  // Name
    // собрать все ключи по всем клипам
    NumKeys:=0;
    SetLength(KeyTypes,NumKeys);    

   j:=Length(FAnimClips)-1;

   for i:=0 to j do
   begin
      x:=Length(FAnimClips[i].Keys)-1;
      for inx:=0 to x do
        TestKeyType(FAnimClips[i].Keys[inx].keytype);
   end;

   // отсортировать ключи.
   SortKeyTypes;

   VirtualBufer.Write(NumKeys, 4);     // NumKeys
  for x := 0 to NumKeys - 1 do
  begin   // Keys
    VirtualBufer.Write(KeyTypes[x].ktype, 4);  //AnimType
    // выделить полные имена ключей
    Xom.WriteXName(VirtualBufer, KeyTypes[x].objname); //Object
  end;

   inx2:=Length(FAnimClips); // NumClips
   VirtualBufer.Write(inx2, 4);
  for j := 0 to inx2 - 1 do
  begin
    VirtualBufer.Write(FAnimClips[j].Time, 4); // time
    Xom.WriteXName(VirtualBufer, FAnimClips[j].Name); // name

    inx:=Length(FAnimClips[j].Keys); // NumAnimKeys
    VirtualBufer.Write(inx, 4);

    //    if inx = integer($0101) then inx := 1 else
    for x := 0 to inx - 1 do
    begin   // AnimKeys

      k2 := 257;
      VirtualBufer.Write(k2, 4); // 1 1 0 0
      // ключи должны быть уже отсортированы !!!
      k2:=GetID(FAnimClips[j].Keys[x].keytype);// KeyTypes[k2];
      VirtualBufer.Write(k2, 2);

      k3 := 0;
      If FAnimClips[j].Keys[x].keytype.NoAddOp then k3:= 2;
      VirtualBufer.Write(k3, 2);

      VirtualBufer.Write(Zero, 2);
      VirtualBufer.Write(Zero, 4);

      k := Length(FAnimClips[j].Keys[x].Data);
      VirtualBufer.Write(k, 4);
      for i := 0 to k - 1 do
        VirtualBufer.Write(FAnimClips[j].Keys[x].Data[i][0], 6*4);
    end;
  end;
    Xom.CntrArr[CIndx].WriteBuf(VirtualBufer);
    VirtualBufer.Free;
end;

Function TAnimClips.BuildAnim(XCntr: TContainer):Integer;
var
//  AB: TComboBox;
  inx, inx1, i, j, inx2, x, k, k2, k3: Integer;
  p2: Pointer;
  s, s1: string;
  KeyFrame: TKeyFrame;
  AnimType: Cardinal;
  AnimClip: TAnimClip;
  ExpAnim: Boolean;
//  StrList:TStringList;
  KeyTypes: array of TTypeKey;

  function GetOneName(Str: string): string;
  var
    k: Integer;
  begin
    k := RPos('|', Str);
    if k > 0 then
      Result := Copy(Str, k + 1, Length(Str) - k)
    else
      Result := Str;
  end;
begin
  // clear buffer
  ClearClips;
  //------
//  AB := But.AnimBox;
//  AB.Clear;
  cIndx:=XCntr.Index;
  BaseClip:=nil;
  p2 := XCntr.Point;
  Name := Xom.GetStr128(p2); // Name
  inx1 := Integer(p2^);
  Inc(Longword(p2), 4);   // NumKeys
  //    s:=format('"%s" KeyTypes[%d]',[s,inx]);
//  FKeyList.Duplicates:=dupIgnore;
  SetLength(KeyTypes, inx1);
  for x := 0 to inx1 - 1 do
  begin   // Keys
    AnimType := Cardinal(p2^);
    Inc(Longword(p2), 4);            //AnimType
    s := Xom.GetStr128(p2); //Object
 //   KeyTypes[x].fullname:=s;
    KeyTypes[x].objname := GetOneName(s);
//    FKeyList.Add(KeyTypes[x].objname);
    KeyTypes[x].ktype := AnimType;
  end;

  inx2 := Integer(p2^);
  Inc(Longword(p2), 4);  // NumClips

 // SetLength(AnimClips, inx2);

  for j := 0 to inx2 - 1 do
  begin

    AnimClip      := TAnimClip.Create;
    AnimClip.Time := Single(p2^);
    Inc(Longword(p2), 4);  // time
    s1 := Xom.GetStr128(p2);  // name
    if (s1='Base')then BaseClip:=AnimClip;
    AnimClip.Name := s1;
    AddClip(AnimClip);
  {  AnimClip.FNamesObj:=TStringList.Create;
    AnimClip.FNamesObj.Assign(StrList);
    SetLength(AnimClip.FAnimInfo,StrList.Count);   }
 //   AB.Items.Add(s1);
    inx     := Word(p2^);  // NumAnimKeys
    ExpAnim :=( (inx = 256) or (inx=257) )and not WR;
    if ExpAnim then
      inx := inx1
    else
      Inc(Longword(p2), 4);
    SetLength(AnimClip.Keys, inx);
    //    if inx = integer($0101) then inx := 1 else
    for x := 0 to inx - 1 do
    begin   // AnimKeys
      k2 := Word(p2^);
      if k2 = 256 then
      begin
        Inc(Longword(p2), 16);
        Continue;
      end;
      Inc(Longword(p2), 4); // 1 1 0 0
      if not ExpAnim then
      begin
        k2 := Word(p2^);
        Inc(Longword(p2), 2);
      end
      else
        k2 := x;
      k3 := Word(p2^);
      Inc(Longword(p2), 2);

      Inc(Longword(p2), 6);
      k := Integer(p2^);
      Inc(Longword(p2), 4);
      AnimClip.Keys[x].keytype := KeyTypes[k2];
      AnimClip.Keys[x].keytype.NoAddOp := (k3 = 2);
      SetLength(AnimClip.Keys[x].Data, k);
      for i := 0 to k - 1 do
      begin
        Move(p2^, KeyFrame[0], 6 * 4);
        Inc(Longword(p2), 6 * 4);
        AnimClip.Keys[x].Data[i] := KeyFrame;
      end;
    end;
  end;
//  StrList.Free;
  KeyTypes := nil;
  Result:=inx2;
end;

function TAnimClips.GetItem(Index:String):TAnimClip;
begin
  Result := FAnimClips[FStrings.IndexOf(Index)];
end;

function TAnimClips.GetItemID(Index: Integer): TAnimClip;
begin
  Result := FAnimClips[Index];
end;

function TAnimClips.AddClip(Clip:TAnimClip):Integer;
begin
  SetLength(FAnimClips, Length(FAnimClips)+1);
  Result:=FStrings.Add(Clip.Name);
  FAnimClips[Result]:=Clip;
end;

procedure TAnimClips.SetItem(Index:String;Value:TAnimClip);
var i:integer;
begin
// сначало ищем индекс, если не находим то изменяем.
  i:=FStrings.IndexOf(Index);
  if (i>-1) then FAnimClips[i]:=Value;
end;

function TAnimClips.GetNameAnimType(AType: Cardinal): string;
begin
  Result := '';
  case Word(AType) of
    ATypePosition: Result := 'pos';
    ATypeRotation: Result := 'rotation';
    ATypeScale:
    Result := 'scale';
    AType2DTex:    Result := 'texpos';
    ATypeReScale:  Result := 'rescale';
    ATypeTexture, ATypeChilds:
    begin
      Result := 'childs';
      Exit;
    end;
  end;
  case Byte(AType shr 24) of
    ATypeX: Result := Result + '.x';
    ATypeY: Result := Result + '.y';
    ATypeZ: Result := Result + '.z';
  end;
end;



function findBezier(x,a1,b1,c1,d1,a2,b2,c2,d2:Single):Single;

   function BezierF(t,a,b,c,d:Single):Single;
   var
   t1:Single;
   begin
   t1:=(1-t);
   result:=t1*t1*t1*a + 3*t*t1*t1*b + 3*t*t*t1*c + t*t*t*d;
   end;

   function find(t1,t2,t3:single):single;
   var xdiv:single;
   begin
   xdiv:=BezierF(t2,a1,b1,c1,d1);
   if abs(xdiv-x)<0.001 then begin result:=t2; exit; end;
   if xdiv>x then
        result:=find(t1,(t1+t2)/2,t2)
        else
        result:=find(t2,(t2+t3)/2,t3);
   end;
begin
   result:=BezierF(find(0,0.5,1.0),a2,b2,c2,d2);
end;

 
function GetAngle(x,y,x1,y1:single):single;
var z,z1,dir:single;
begin
if (y<0) then dir:=pi else dir:=0;
z:=dir+ArcTan(x/y);
if (y1<0) then dir:=pi else dir:=0;
z1:=dir+ArcTan(x1/y1);
//if z>z1 then dir:=pi else dir:=0;
result:=radtodeg(z-z1);
end;

function TAnimClip.GenAnimFrame(Name: string; T: TTrans; Bone: Boolean; ActiveMove:Boolean):TAnimInfo;
var
  i, j, m, n,m1,i1, k1, k2, inx: Integer;
  Value:Single;
  Key: TKeyData;
  AType: Cardinal;
  RotTmp: ^TVer;
  function GetMidValue(Key1, Key2: TKeyFrame): Single;
  var
    a,b,c,d:single;
  begin
  //  divTime := AnimTimer.Value - Key1[4];
    if (Key2[4] = Key1[4]) then
      Result := Key1[5]
    else
     begin
        a := Key1[4] + (Key2[4] - Key1[4]) * cos(Key1[3]) * Key1[2] / 3;
        b := Key1[5] + (Key2[5] - Key1[5]) * sin(Key1[3]) * Key1[2] / 3;
        c := Key2[4] - (Key2[4] - Key1[4]) * cos(Key2[1]) * Key2[0] / 3;
        d := Key2[5] - (Key2[5] - Key1[5]) * sin(Key2[1]) * Key2[0] / 3;
        result:=findBezier(AnimTimer.Value,Key1[4],a,c,Key2[4],Key1[5],b,d,Key2[5]);
        end;
     // Result := Key1[5] + (Key2[5] - Key1[5]) * divTime / (Key2[4] - Key1[4]);
  end;

  function GetMidValueInt(Key1, Key2: TKeyFrame): Single;
  var
    divTime: Single;
  begin
    divTime := AnimTimer.Value - Key1[4];
    if (Key2[4] = Key1[4]) then
      Result := Key1[5]
    else if divTime / (Key2[4] - Key1[4]) > 0.5 then
      Result := Key2[5]
    else
      Result := Key1[5];
  end;

begin
  if Name='' then exit;
  if But.TrackPanel.CanSlide then
  AnimTimer.Value:=But.TrackPanel.Slider;
{  if BaseClip<>nil then begin
   ZeroV[0]:=0;
   ZeroV[1]:=0;
   ZeroV[2]:=0;

  T.Pos:=ZeroV;
   T.Rot:=ZeroV;
   T.RotOrient:=ZeroV;
   T.JointOrient:=ZeroV;
   T.Size:=ZeroV;    
 end;                }

  m := Length(Keys) - 1;
  for i := 0 to m do
    if (Keys[i].keytype.objname = Name) then
    begin
      Key := Keys[i];
      Result.True:=True;
      n := Length(Key.Data) - 1;
      k1 := 0;
      k2 := 0;
      for j := 0 to n do
      begin
        if (j = 0) and (Key.Data[j][4] > AnimTimer.Value) then
        begin
          k1 := j; 
          k2 := j;
          Break;
        end;
        if (j = n) then
        begin
          k1 := n;
          k2 := n;
          Break;
        end
        else if (Key.Data[j][4] <= AnimTimer.Value) and
          (AnimTimer.Value < Key.Data[j + 1][4]) then
        begin
          k1 := j;
          k2 := j + 1;
          Break;
        end;
      end;

      AType := Key.keytype.ktype;
      Value :=  GetMidValue(Key.Data[k1], Key.Data[k2]);
      if (BaseClip<>nil)and (BaseClip<>self) then begin
                m1 := Length(BaseClip.Keys) - 1;
                for i1 := 0 to m1 do
                if (BaseClip.Keys[i1].keytype.objname = Name)
                and (BaseClip.Keys[i1].keytype.ktype = AType) then begin
                if Word(AType)=ATypeReScale then
                Value:=(Value+BaseClip.Keys[i1].Data[0][5]) /2 else
                Value:=(Value+BaseClip.Keys[i1].Data[0][5]);
                break;
                end;

      end;

      inx := Byte(AType shr 24);
      case Word(AType) of
        ATypePosition :
           // if Key.keytype.NoAddOp then
         //   T.Pos[inx]:=T.Pos[inx]+Value;// else
          T.Pos[inx] := Value;
        //?
        ATypeRotation:
          if Bone then
            T.JointOrient[inx] :=  Value
          else
            T.Rot[inx] := Value;
        ATypeScale:
          T.Size[inx] := Value;
        AType2DTex:
          Result.TCoord[inx]:=Value;//GetMidValueInt(Key.Data[k1], Key.Data[k2]);
        ATypeTexture,ATypeChilds:
          Result.Child := Trunc(GetMidValueInt(Key.Data[k1], Key.Data[k2]));
        ATypeReScale:
        T.Size[inx] := Value; // ???
      end;
     end;

  if ActiveMove then begin
  glPushMatrix;
        glGetFloatv(GL_MODELVIEW_MATRIX,@ActiveMatrix);// запоминаем текущую матрицу
        // тригер управления

        glTranslatef(T.Pos[0], T.Pos[1], T.Pos[2]); // Смещаем ее на уже заданное смещение

        if MoveReady then begin
                GetProjectVert(PTarget.X,PTarget.Y,MAxis,p);

                if MoveFirts then begin     // запоминаем начальную точку
                MoveFirts:=false; wd:=p;
                end;

                wdup.x:=-wd.x+p.x;   wdup.y:=-wd.y+p.y;  wdup.z:=-wd.z+p.z;

                glTranslatef(wdup.x, wdup.y, wdup.z);                              // перемещаем с курсором

               T.Pos[0]:=T.Pos[0]+wdup.x;   // записываем данные
               T.Pos[1]:=T.Pos[1]+wdup.y;
               T.Pos[2]:=T.Pos[2]+wdup.z;

        end;

        if But.Move^ then
                begin
                glGetFloatv(GL_MODELVIEW_MATRIX,@ObjMatrix);  // сохраняем матрицу
                NKey:=T.Pos;
                end;

        glGetFloatv(GL_MODELVIEW_MATRIX, @TempMatrix);

        glRotatef(RadToDeg(T.Rot[2]), 0, 0, 1); //Z
        glRotatef(RadToDeg(T.Rot[1]), 0, 1, 0); //y
        glRotatef(RadToDeg(T.Rot[0]), 1, 0, 0); //X

        if Bone then begin
                glGetFloatv(GL_MODELVIEW_MATRIX,@TempMatrix);
                glRotatef(RadToDeg(T.JointOrient[2]), 0, 0, 1);//Z
                glRotatef(RadToDeg(T.JointOrient[1]), 0, 1, 0);//y
                glRotatef(RadToDeg(T.JointOrient[0]), 1, 0, 0);//X
                RotTmp:=@T.JointOrient;
        end else
                RotTmp:=@T.Rot;

        if RotateReady then begin
           case MAxis of
                Axis_X:begin
                        GetProjectVert(PTarget.X,PTarget.Y,Axis_YZ,p);
                        end;
                Axis_Y:begin
                        glLoadMatrixf(@TempMatrix);
                        glRotatef(RadToDeg(RotTmp^[2]), 0, 0, 1); //Z
                        glRotatef(RadToDeg(RotTmp^[1]), 0, 1, 0); //y
                        GetProjectVert(PTarget.X,PTarget.Y,Axis_XZ,p);
                        end;
                Axis_Z:begin
                         glLoadMatrixf(@TempMatrix);
                         glRotatef(RadToDeg(RotTmp^[2]), 0, 0, 1); //Z
                         GetProjectVert(PTarget.X,PTarget.Y,Axis_XY,p);
                        end;
                end;

                if RotateFirts then begin
                        RotateFirts:=false; wd:=p;
                end;

                glPushAttrib(GL_COLOR_MATERIAL or GL_ENABLE_BIT);
                glDisable(GL_TEXTURE_2D);
                glDisable(GL_LIGHTING);
                glColor3f(1,1,0);
                glBegin(GL_LINES);
                        glVertex3f(0, 0, 0);
                        glVertex3f(p.x, p.y, p.z);
                        glVertex3f(0, 0, 0);
                        glVertex3f(wd.x, wd.y, wd.z);
                glEnd;
                glPopAttrib;

                glLoadMatrixf(@TempMatrix);

                alpha:=0;  beta:=0;  gamma:=0;

                case MAxis of
                Axis_X:alpha:=GetAngle(wd.y,wd.z,p.y,p.z);
                Axis_Y:beta:=GetAngle(wd.z,wd.x,p.z,p.x);
                Axis_Z:gamma:=GetAngle(wd.x,wd.y,p.x,p.y);
                end;
                RotatePoxPos[0]:=DegToRad(alpha);
                RotatePoxPos[1]:=DegToRad(beta);
                RotatePoxPos[2]:=DegToRad(gamma);

                RotTmp^[0]:=RotTmp^[0]+DegToRad(alpha);
                RotTmp^[1]:=RotTmp^[1]+DegToRad(beta);
                RotTmp^[2]:=RotTmp^[2]+DegToRad(gamma);
                
                glRotatef(RadToDeg(RotTmp^[2]), 0, 0, 1);//Z                     //
                glRotatef(RadToDeg(RotTmp^[1]), 0, 1, 0);//y                      //
                glRotatef(RadToDeg(RotTmp^[0]), 1, 0, 0);//X                     //
                glGetFloatv(GL_MODELVIEW_MATRIX,@ObjMatrix);
        end;
        if But.Rotate^ then  begin
                glGetFloatv(GL_MODELVIEW_MATRIX,@ObjMatrix);  // сохраняем матрицу
                NKey:=RotTmp^;
                end;
        if Bone then begin
                glRotatef(RadToDeg(T.RotOrient[2]), 0, 0, 1);//Z
                glRotatef(RadToDeg(T.RotOrient[1]), 0, 1, 0);//y
                glRotatef(RadToDeg(T.RotOrient[0]), 1, 0, 0);//X
        end;



        glGetFloatv(GL_MODELVIEW_MATRIX,@TempMatrix);

        glScalef(T.Size[0], T.Size[1], T.Size[2]);

        if ScaleReady then begin
           GetProjectVert(PTarget.X,PTarget.Y,MAxis,p);
                if ScaleFirts then begin
                ScalePoxPos:=T.Size;
                ScaleFirts:=false; wd:=p;
                end;
                wdup.x:=(-wd.x+p.x)+1;  wdup.y:=(-wd.y+p.y)+1; wdup.z:=(-wd.z+p.z)+1;

              if wdup.x<0 then  wdup.x:=0;
               if wdup.y<0 then  wdup.y:=0;
                if wdup.z<0 then  wdup.z:=0;

                   if ShiftOn then begin
                                 case MAxis of
                                 Axis_XY:begin wdup.x:=Max(wdup.x, wdup.y);wdup.y:=wdup.x;end;
                                 Axis_YZ:begin wdup.y:=Max(wdup.y, wdup.z);wdup.z:=wdup.y;end;
                                 Axis_XZ:begin wdup.x:=Max(wdup.x, wdup.z);wdup.z:=wdup.x;end;
                                 end;
                        end;
                case MAxis of
                Axis_X:glScalef(wdup.x, 1, 1);
                Axis_Y:glScalef(1, wdup.y, 1);
                Axis_Z:glScalef(1, 1, wdup.z);
                Axis_XY:glScalef(wdup.x, wdup.y, 1);
                Axis_YZ:glScalef(1, wdup.y, wdup.z);
                Axis_XZ:glScalef(wdup.x, 1, wdup.z);
                Axis_XYZ:begin wdup.x:=Max(wdup.x, wdup.z);
                        wdup.y:=wdup.x; wdup.z:=wdup.x;
                        glScalef(wdup.x,wdup.y,wdup.z); end;
                end;

                case MAxis of
                Axis_X,Axis_XY,Axis_XZ,Axis_XYZ:
                T.Size[0]:=T.Size[0]*wdup.x;
                end;

                case MAxis of
                Axis_Y,Axis_XY,Axis_YZ,Axis_XYZ:
                T.Size[1]:=T.Size[1]*wdup.y;
                end;

                case MAxis of
                Axis_Z,Axis_XZ,Axis_YZ,Axis_XYZ:
                T.Size[2]:=T.Size[2]*wdup.z;
                end;
                
        end;
        if But.Scale^ then begin
                glGetFloatv(GL_MODELVIEW_MATRIX,@ObjMatrix);  // сохраняем матрицу
                NKey:=T.Size;
                end;
 // тригер управления завершен
  glPopMatrix;
   end;

if Result.True then begin
  glPushMatrix;
  if Bone then
      Result.Tm:=GetMatrix2(T.Pos, T.Rot, T.JointOrient, T.RotOrient, T.Size)
  else
      Result.Tm:=GetMatrix(T.Pos, T.Rot, T.Size);

  glPopMatrix;    end;

//  FAnimInfo[FNamesObj.IndexOf(Name)]:=AI;

end;

procedure  TAnimClip.SortKeys;
// сортировка ключей по дереву
var
i,j,n,test:integer;
X:TKeyData;
begin
n:=Length(Keys)-1;
for i:=1 to n do
  for j:=n downto i do
        begin
        test:=CompareStr(Keys[j-1].keytype.objname,Keys[j].keytype.objname);
        if (test>0)or ((test=0) and (
        (Word(Keys[j-1].keytype.ktype)>Word(Keys[j].keytype.ktype))
        or
        ((Word(Keys[j-1].keytype.ktype)=Word(Keys[j].keytype.ktype))
        and
        (Keys[j-1].keytype.ktype>Keys[j].keytype.ktype))))
                then begin
                X:=Keys[j-1];
                Keys[j-1]:=Keys[j];
                Keys[j]:=X;
                end;
        end;
end;

procedure  TAnimClip.SortKeyData(KData:PKeyData);
var
i,j,n:integer;
X:TKeyFrame;
begin
n:=Length(KData.Data)-1;
for i:=1 to n do
  for j:=n downto i do
        if KData.Data[j-1][4]>KData.Data[j][4] then begin
                X:=KData.Data[j-1];
                KData.Data[j-1]:=KData.Data[j];
                KData.Data[j]:=X;
        end;
end;

procedure TAnimClip.AddKData(KType:TTypeKey);
var
inx:integer;
Fval:single;
begin
ActiveMesh:=Xom.Mesh3D.GetMeshOfName(KType.objname);
inx:=byte(Ktype.ktype shr 24);
FVal:=0.0;
Case Word(Ktype.ktype) of
ATypePosition:FVal:=ActiveMesh.Transform.Pos[inx];
ATypeRotation:
begin
if ActiveMesh.Transform.TransType=TTJoint then
  FVal:=ActiveMesh.Transform.JointOrient[inx]
else
  FVal:=ActiveMesh.Transform.Rot[inx];
end;
ATypeScale:FVal:=ActiveMesh.Transform.Size[inx];
end;
AddKey(nil,0.0,FVal,FVal,KType.ktype);
end;

procedure TAnimClip.DeleteKData(KType:TTypeKey);
var i,n:integer;
DeleteFlag:Boolean;
begin
n:=Length(Keys)-1;
DeleteFlag:=false;
for i:=0 to n do   begin
if DeleteFlag then Keys[i-1]:=Keys[i] else
if (Keys[i].keytype.ktype=KType.ktype) and
(Keys[i].keytype.objname=KType.objname) then DeleteFlag:=true;
end;
SetLength(Keys[n].Data,0);
SetLength(Keys,n);
//KType.objname
end;

procedure TAnimClip.DeleteKey(Key:PKeyFrame);
var
i,ii,n,nn,inx:integer;
begin
n:=Length(Keys)-1;
for i:=0 to n do begin
        inx:=FindKey(@Keys[i],Key);
        if inx<>-1 then
         begin
         nn:=Length(Keys[i].Data);
         if nn=2 then exit;
         for ii:=inx to nn-2 do
                Keys[i].Data[ii]:=Keys[i].Data[ii+1];
         SetLength(Keys[i].Data,nn-1);
         exit;
         end;
        end;
end;

function TAnimClip.FindKey(KData:PKeyData;SelKey:PKeyFrame):integer;
var
  ii,num:integer;
begin
   Result:=-1;
   num:=Length(KData.Data);
   for ii:=0 to num-1 do
     if @KData.Data[ii]=SelKey then begin Result:=ii; Exit; end;
end;

function TAnimClip.FindTimeKey(KData:PKeyData;FTime:Single):integer;
var
  ii,num:integer;
begin
   Result:=-1;
   num:=Length(KData.Data);
   for ii:=0 to num-1 do
     if KData.Data[ii][4]=FTime then begin Result:=ii; Exit; end;
end;

function TAnimClip.FindKeyNameType(FName:String;AType:integer):PKeyData;
var
i,j:integer;
begin
Result:=nil;
      j:=Length(Keys);
      for i:=0 to j-1 do
        if  (Keys[i].keytype.ktype=AType)and(Keys[i].keytype.objname=FName) then
                begin Result:=@Keys[i]; exit; end;
end;

procedure  TAnimClip.AddKey(KData:PKeyData;CurTime:Single;FirstValue:Single;NewValue:Single;AType:Integer);
var
 n,i,m1,i1,t:integer;
begin
  //    Value :=  GetMidValue(Key.Data[k1], Key.Data[k2]);
      if (BaseClip<>nil)and (BaseClip<>self) then begin
                m1 := Length(BaseClip.Keys) - 1;
                for i1 := 0 to m1 do
                if (BaseClip.Keys[i1].keytype.objname = ActiveMesh.Name)
                and (BaseClip.Keys[i1].keytype.ktype = AType) then begin
                if Word(AType)=ATypeReScale then
                  begin
                  NewValue:=2*NewValue-BaseClip.Keys[i1].Data[0][5];
                  FirstValue:=2.0;
                  end
                  else
                  begin
                  NewValue:=NewValue-BaseClip.Keys[i1].Data[0][5];
                  FirstValue:=0;
                  end;
                break;
                end;
      end;
    // создать ключ, добавить в массив или создать массив.
    // отсортировать массив
    if KData=nil then begin
        n:=Length(Keys);
        SetLength(Keys,n+1);
        Keys[n].keytype.objname:=ActiveMesh.Name;
    //    Keys[n].keytype.fullname:=GetFullName(ActiveMesh.Name);
        Keys[n].keytype.ktype:=AType;
        SetLength(Keys[n].Data,2);
        Keys[n].Data[0][0]:=1.0;
        Keys[n].Data[0][1]:=0.0;
        Keys[n].Data[0][2]:=1.0;
        Keys[n].Data[0][3]:=0.0;
        Keys[n].Data[0][4]:=0.0;
        Keys[n].Data[0][5]:=FirstValue;

        Keys[n].Data[1]:=Keys[n].Data[0];
        Keys[n].Data[1][4]:=CurTime;
        Keys[n].Data[1][5]:=NewValue;
        SelectKey:=@Keys[n].Data[1];
    end else begin
        If (SelectKey<>nil) and
        (SelectKey[4]=But.TrackPanel.Slider) and
        (FindKey(KData,SelectKey)<>-1) then
        begin
        SelectKey[5]:=NewValue;
        exit;
        end;
        t:=FindTimeKey(KData,CurTime);
        if t<>-1 then begin
        KData.Data[t][5]:=NewValue;
        exit;
        end;
        n:=Length(KData.Data);
        SetLength(KData.Data,n+1);
        KData.Data[n][0]:=1.0;
        KData.Data[n][1]:=0.0;
        KData.Data[n][2]:=1.0;
        KData.Data[n][3]:=0.0;
        KData.Data[n][4]:=CurTime;
        KData.Data[n][5]:=NewValue;
        SortKeyData(KData);
        for i:=0 to n-1 do
        if KData.Data[i][4]=CurTime then
                SelectKey:=@KData.Data[i];
    end;
    // надо найти место для ключа,
    // заменить или вставить ключ
    // отнять базу если она есть.
end;

procedure TAnimClip.UpdateAnimClip;
var
 FrameTime:Single;
 i,num,inx:integer;

 M,R,S,RS,T2d,Ch: array [0..2]of  PKeyData;
begin
 if not
 ((MoveMode and MoveReady )or
  (RotateMode and RotateReady)or
   (ScaleMode and ScaleReady)) then exit;
  FrameTime:=But.TrackPanel.Slider;
  for i:=0 to 2 do begin
        M[i]:=nil;
        R[i]:=nil;
        S[i]:=nil;
        T2d[i]:=nil;
        Ch[i]:=nil;
        RS[i]:=nil;
  end;

  num := Length(Keys) - 1;
  for i := 0 to num do
    if (Keys[i].keytype.objname = ActiveMesh.Name) then
    begin
     inx := Byte(Keys[i].keytype.ktype shr 24);
     case Word(Keys[i].keytype.ktype) of
       ATypePosition: M[inx]:=@Keys[i];
       ATypeRotation: R[inx]:=@Keys[i];
       ATypeScale: S[inx]:=@Keys[i];
       AType2DTex: T2d[inx]:=@Keys[i];
       ATypeTexture,ATypeChilds: Ch[inx]:=@Keys[i];
       ATypeReScale: RS[inx]:=@Keys[i];
     end;

    end;

    if MoveMode and MoveReady then begin
      MoveReady:=false;
      case MAxis of
                Axis_X,Axis_XY,Axis_XZ,Axis_XYZ:
                AddKey(M[ATypeX],FrameTime,
                ActiveMesh.Transform.Pos[ATypeX],NKey[ATypeX],
                ATypePosition+(ATypeX shl 24));
      end;
      case MAxis of
                Axis_Y,Axis_XY,Axis_YZ,Axis_XYZ:
                AddKey(M[ATypeY],FrameTime,
                ActiveMesh.Transform.Pos[ATypeY],NKey[ATypeY],
                ATypePosition+(ATypeY shl 24));
      end;
      case MAxis of
                Axis_Z,Axis_XZ,Axis_YZ,Axis_XYZ:
                AddKey(M[ATypeZ],FrameTime,
                ActiveMesh.Transform.Pos[ATypeZ],NKey[ATypeZ],
                ATypePosition+(ATypeZ shl 24));
      end;
   end;

if RotateMode and RotateReady then begin
      RotateReady:=false;
      case MAxis of
                Axis_X,Axis_XY,Axis_XZ,Axis_XYZ:
                AddKey(R[ATypeX],FrameTime,
                ActiveMesh.Transform.Rot[ATypeX],NKey[ATypeX],
                ATypeRotation+(ATypeX shl 24));
      end;
      case MAxis of
                Axis_Y,Axis_XY,Axis_YZ,Axis_XYZ:
                AddKey(R[ATypeY],FrameTime,
                ActiveMesh.Transform.Rot[ATypeY],NKey[ATypeY],
                ATypeRotation+(ATypeY shl 24));
      end;
      case MAxis of
                Axis_Z,Axis_XZ,Axis_YZ,Axis_XYZ:
                AddKey(R[ATypeZ],FrameTime,
                ActiveMesh.Transform.Rot[ATypeZ],NKey[ATypeZ],
                ATypeRotation+(ATypeZ shl 24));
      end;
end;

if ScaleMode and ScaleReady then begin
      ScaleReady:=false;
      case MAxis of
                Axis_X,Axis_XY,Axis_XZ,Axis_XYZ:
                AddKey(S[ATypeX],FrameTime,
                ActiveMesh.Transform.Size[ATypeX],NKey[ATypeX],
                ATypeScale+(ATypeX shl 24));
      end;
      case MAxis of
                Axis_Y,Axis_XY,Axis_YZ,Axis_XYZ:
                AddKey(S[ATypeY],FrameTime,
                ActiveMesh.Transform.Size[ATypeY],NKey[ATypeY],
                ATypeScale+(ATypeY shl 24));
      end;
      case MAxis of
                Axis_Z,Axis_XZ,Axis_YZ,Axis_XYZ:
                AddKey(S[ATypeZ],FrameTime,
                ActiveMesh.Transform.Size[ATypeZ],NKey[ATypeZ],
                ATypeScale+(ATypeZ shl 24));
      end;
end;
SortKeys;
end;

{TMesh}

constructor TMesh.Create;
var
  n: Integer;
begin
  inherited Create;
  CntrArr:=Arr;
  Name := 'dummy';
  Attribute.ZBufferFuncVal := 1;
  Attribute.ZBuffer := true;
  Attribute.CullFace := true;
  Transform.TransType := TTNone;
  for n := 0 to 2 do
    Transform.Size[n] := 1.0;
  for n := 1 to 4 do
    Transform.TrMatrix[n][n] := 1.0;
end;

type
  TVector4 = array[1..4] of Single;

function VertAddVert(v1, v2: TVer): TVer;
begin
  Result[0] := v1[0] + v2[0];
  Result[1] := v1[1] + v2[1];
  Result[2] := v1[2] + v2[2];
end;

function ValXVert(Val: Single; vect: TVer): TVer;
begin
  Result[0] := Val * vect[0];
  Result[1] := Val * vect[1];
  Result[2] := Val * vect[2];
end;

function MatrixInvert(const m: TMatrix): TMatrix;
var
  i: Integer;
  l: array [1..3] of Glfloat;
begin
  for i := 1 to 3 do
  begin
    l[i] := 1.0 / (Sqr(m[i, 1]) + Sqr(m[i, 2]) + Sqr(m[i, 3]));
    Result[1, i] := m[i, 1] * l[i];
    Result[2, i] := m[i, 2] * l[i];
    Result[3, i] := m[i, 3] * l[i];
    Result[i, 4] := 0.0;
  end;
  Result[4, 4] := 1.0;

  for i := 1 to 3 do
    Result[4, i] := -(m[4, 1] * m[i, 1] * l[i] + m[4,
      2] * m[i, 2] * l[i] + m[4, 3] * m[i, 3] * l[1]);
end;

function MatrXMatr(M1, M2: TMatrix): TMatrix;
var
  i, j, k: Integer;
begin
  for i := 1 to 4 do
    for j := 1 to 4 do
    begin
      Result[i, j] := 0;
      for k := 1 to 4 do
        Result[i, j] := Result[i, j] + m1[i, k] * m2[k, j];
    end;
end;

function MatrXVert(Matrix: TMatrix; V0, V1, V2: Single): Tver;
var
  i, j: Integer;
  b, c: TVector4;
begin
  b[1] := V0;
  b[2] := V1;
  b[3] := V2;
  b[4] := 1;
  //SetLEngth(c,Length(b));
  for i := 1 to 4 do 
  begin
    c[i] := 0;
    for j := 1 to 4 do 
      c[i] := c[i] + Matrix[j, i] * b[j];
  end;
  Result[0] := c[1];
  Result[1] := c[2];
  Result[2] := c[3];
end;

procedure TMesh.GetBox(var Box: TBox);
var
  i: Integer;
  //TempBox:Tbox;
  vector: Tver;
  Matrix: TMatrix; 
begin
  glPushMatrix();
  glMultMatrixf(@Transform.TrMatrix);
  if not ((SizeBox.Xmax = 0) and (SizeBox.Xmin = 0) and
    (SizeBox.Ymax = 0) and (SizeBox.Ymin = 0) and
    (SizeBox.Zmax = 0) and (SizeBox.Zmin = 0)) then
  begin
    glGetFloatv(GL_MODELVIEW_MATRIX, @Matrix);

    with SizeBox do 
    begin
      Vector := MatrXVert(Matrix, Xmin, Ymin, Zmin);
      CalcBox(Box,Vector);
      Vector := MatrXVert(Matrix, Xmax, Ymax, Zmax);
      CalcBox(Box,Vector);
  {    Vector := MatrXVert(Matrix, Xmin, Ymax, Zmin);
      CalcBox(Box,Vector);
      Vector := MatrXVert(Matrix, Xmax, Ymin, Zmax);
      CalcBox(Box,Vector);

      Vector := MatrXVert(Matrix, Xmin, Ymin, Zmax);
      CalcBox(Box,Vector);
      Vector := MatrXVert(Matrix, Xmax, Ymax, Zmin);
      CalcBox(Box,Vector);
      Vector := MatrXVert(Matrix, Xmax, Ymin, Zmin);
      CalcBox(Box,Vector);
      Vector := MatrXVert(Matrix, Xmin, Ymax, Zmax);
      CalcBox(Box,Vector);     }
    end;
  end;

  for i := 0 to Length(Childs) - 1 do
    if Childs[i] <> nil then
      Childs[i].GetBox(Box);
  glPopMatrix();
end;


procedure TMesh.DrawSelectBox(SelectBox: TBox);
var
  Xsize, Ysize, Zsize: Single;
  Border, BordOffset: Single;
  TempSelectBox: TBox;
  procedure DrawTetra(X, Y, Z, Xs, Ys, Zs: Single);
  begin
    glVertex3f(X, Y, Z);
    glVertex3f(X + Xs, Y, Z);
    glVertex3f(X, Y, Z);
    glVertex3f(X, Y + Ys, Z);
    glVertex3f(X, Y, Z);
    glVertex3f(X, Y, Z + Zs);
  end;
begin
  Border := 0.3;
  BordOffset := 0.1;

  Xsize := (SelectBox.Xmax - SelectBox.Xmin) * Border;
  Ysize := (SelectBox.Ymax - SelectBox.Ymin) * Border;
  Zsize := (SelectBox.Zmax - SelectBox.Zmin) * Border;
  //  end;
  TempSelectBox.Xmin := SelectBox.Xmin - Xsize * BordOffset;
  TempSelectBox.Ymin := SelectBox.Ymin - Ysize * BordOffset;
  TempSelectBox.Zmin := SelectBox.Zmin - Zsize * BordOffset;
  TempSelectBox.Xmax := SelectBox.Xmax + Xsize * BordOffset;
  TempSelectBox.Ymax := SelectBox.Ymax + Ysize * BordOffset;
  TempSelectBox.Zmax := SelectBox.Zmax + Zsize * BordOffset;
  //  glPushMatrix;
  //  glScalef(Size.X, Size.Y, Size.Z);
  glPushAttrib(GL_COLOR_MATERIAL);
  glDisable(GL_LIGHTING);
  with TempSelectBox do
  begin
    glColor3f(1, 1, 1);
    glBegin(GL_LINES);
    DrawTetra(Xmin, Ymin, Zmin, Xsize, Ysize, Zsize);
    DrawTetra(Xmax, Ymax, Zmax, - Xsize, - Ysize, - Zsize);

    DrawTetra(Xmin, Ymax, Zmin, Xsize, - Ysize, Zsize);
    DrawTetra(Xmax, Ymin, Zmax, - Xsize, Ysize, - Zsize);

    DrawTetra(Xmin, Ymin, Zmax, Xsize, Ysize, - Zsize);
    DrawTetra(Xmax, Ymax, Zmin, - Xsize, - Ysize, Zsize);

    DrawTetra(Xmax, Ymin, Zmin, - Xsize, Ysize, Zsize);
    DrawTetra(Xmin, Ymax, Zmax, Xsize, - Ysize, - Zsize);
    glEnd;
  end;
  glEnable(GL_LIGHTING);
  glPopAttrib;
  //  glPopMatrix;
end;

function TMesh.GetMeshOfName(ObjName:String):TMesh;
var i:integer;
begin
Result:=nil;
If Name=ObjName then begin
 Result :=Self; exit;
 end;
  for i := 0 to Length(Childs) - 1 do
    if Childs[i] <> nil then
      begin
      Result:=Childs[i].GetMeshOfName(ObjName);
      if Result<>nil then exit;
      end;
end;

function TMesh.GetMeshOfID(Id:Integer):TMesh;
var i:integer;
begin
Result:=nil;
If Indx=Id then begin
 Result :=Self; exit;
 end;
  for i := 0 to Length(Childs) - 1 do
    if Childs[i] <> nil then
      begin
      Result:=Childs[i].GetMeshOfID(Id);
      if Result<>nil then exit;
      end;
end;


function GetMatrix(Pos, Rot, Size: Tver): TMatrix;
begin
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity();
  glTranslatef(Pos[0], Pos[1], Pos[2]);
  glRotatef(RadToDeg(Rot[2]), 0, 0, 1);//Z
  glRotatef(RadToDeg(Rot[1]), 0, 1, 0);//y
  glRotatef(RadToDeg(Rot[0]), 1, 0, 0);//X
  glScalef(Size[0], Size[1], Size[2]);
  glGetFloatv(GL_MODELVIEW_MATRIX, @Result);
end;

function GetMatrix2(Pos, Rot1, Rot2, Rot3, Size: Tver): TMatrix;
begin
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity();
  glTranslatef(Pos[0], Pos[1], Pos[2]);

  glRotatef(RadToDeg(Rot1[2]), 0, 0, 1); //Z
  glRotatef(RadToDeg(Rot1[1]), 0, 1, 0); //y
  glRotatef(RadToDeg(Rot1[0]), 1, 0, 0); //X

  glRotatef(RadToDeg(Rot2[2]), 0, 0, 1);//Z
  glRotatef(RadToDeg(Rot2[1]), 0, 1, 0);//y
  glRotatef(RadToDeg(Rot2[0]), 1, 0, 0);//X
  
  glRotatef(RadToDeg(Rot3[2]), 0, 0, 1);//Z
  glRotatef(RadToDeg(Rot3[1]), 0, 1, 0);//y
  glRotatef(RadToDeg(Rot3[0]), 1, 0, 0);//X
  glScalef(Size[0], Size[1], Size[2]);  //??????
  glGetFloatv(GL_MODELVIEW_MATRIX, @Result);

end;

procedure MatrixDecompose(XMatrix: TMatrix; var XPos: Tver;
  var XRot: Tver; var XSize: Tver);
  //var Matrix:Tmatrix;
var
  angle_x, angle_y, angle_z, D, C, trx, tr_y: Real;
  mat: array [0..15] of Real;
begin
  XPos[0] := XMatrix[4][1];
  XPos[1] := XMatrix[4][2];
  XPos[2] := XMatrix[4][3];
  XSize[0] := Sqrt(Sqr(XMatrix[1][1]) + Sqr(XMatrix[1][2]) + Sqr(XMatrix[1][3]));
  XSize[1] := Sqrt(Sqr(XMatrix[2][1]) + Sqr(XMatrix[2][2]) + Sqr(XMatrix[2][3]));
  XSize[2] := Sqrt(Sqr(XMatrix[3][1]) + Sqr(XMatrix[3][2]) + Sqr(XMatrix[3][3]));

  mat[0] := XMatrix[1][1] / XSize[0];
  mat[1] := XMatrix[1][2] / XSize[0];
  mat[2] := XMatrix[1][3] / XSize[0];

  mat[4] := XMatrix[2][1] / XSize[1];
  mat[5] := XMatrix[2][2] / XSize[1];

  mat[6] := XMatrix[2][3] / XSize[1];
  mat[10] := XMatrix[3][3] / XSize[2];
  D := -arcsin(mat[2]);
  angle_y := D;   //     /* Calculate Y-axis angle */
  C := Cos(angle_y);
  angle_y := angle_y * RADIANS;

  if (Abs(C) > 0.005) then         //   /* Gimball lock? */
  begin
    trx  := mat[10] / C;           //* No, so get X-axis angle */
    tr_y := -mat[6] / C;

    angle_x := ArcTan2(tr_y, trx) * RADIANS;

    trx  := mat[0] / C;            //* Get Z-axis angle */
    tr_y := -mat[1] / C;

    angle_z := ArcTan2(tr_y, trx) * RADIANS;
  end
  else                                 //* Gimball lock has occurred */
  begin
    angle_x := 0;                      //* Set X-axis angle to zero */

    trx  := mat[5];                 //* And calculate Z-axis angle */
    tr_y := mat[4];

    angle_z := ArcTan2(tr_y, trx) * RADIANS;
  end;
  //--------------
  XRot[0] := -angle_x;
  XRot[1] := angle_y;
  XRot[2] := -angle_z;
end;


Procedure glLoadMulti;
begin
glPushAttrib(GL_TEXTURE_BIT or GL_EVAL_BIT);

{$IFDEF NOMULTI}
   glActiveTextureARB(GL_TEXTURE1    );
   glEnable          (GL_TEXTURE_2D      );

   glTexEnvi         (GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE ,GL_COMBINE    );
   glTexEnvi         (GL_TEXTURE_ENV,GL_COMBINE_RGB  ,GL_REPLACE        );

   glActiveTextureARB(GL_TEXTURE0    );
   glEnable          (GL_TEXTURE_2D      );

   glTexEnvi         (GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE ,GL_COMBINE    );
   glTexEnvi         (GL_TEXTURE_ENV,GL_COMBINE_RGB  ,GL_INTERPOLATE);

    glTexEnvi ( GL_TEXTURE_ENV, GL_SOURCE0_RGB,  GL_TEXTURE1      );
    glTexEnvi ( GL_TEXTURE_ENV, GL_OPERAND0_RGB, GL_SRC_COLOR    );

    glTexEnvi ( GL_TEXTURE_ENV, GL_SOURCE1_RGB,  GL_TEXTURE);
    glTexEnvi ( GL_TEXTURE_ENV, GL_OPERAND1_RGB, GL_SRC_COLOR );

    glTexEnvi ( GL_TEXTURE_ENV, GL_SOURCE2_RGB,  GL_PRIMARY_COLOR);
    glTexEnvi ( GL_TEXTURE_ENV, GL_OPERAND2_RGB, GL_SRC_ALPHA    );

   glActiveTextureARB(GL_TEXTURE1   );
   glEnable          (GL_TEXTURE_2D      );

   glTexEnvi         (GL_TEXTURE_ENV,GL_TEXTURE_ENV_MODE ,GL_COMBINE    );
   glTexEnvi         (GL_TEXTURE_ENV,GL_COMBINE_RGB  ,GL_MODULATE        );

    glTexEnvi ( GL_TEXTURE_ENV, GL_SOURCE0_RGB,  GL_PREVIOUS      );
    glTexEnvi ( GL_TEXTURE_ENV, GL_OPERAND0_RGB, GL_SRC_COLOR    );

    glTexEnvi ( GL_TEXTURE_ENV, GL_SOURCE1_RGB,   GL_PRIMARY_COLOR);
    glTexEnvi ( GL_TEXTURE_ENV, GL_OPERAND1_RGB, GL_SRC_COLOR );
{$ENDIF}
end;

Procedure glUnLoadMulti;
begin
glPopAttrib;
end;

procedure TMesh.Draw(DrawType: TDrawType);
label
  ToChilds;
label
  normal2;
var
  i, j, ActChild, NormalLen, FaceNum, VCount, BCount: Integer;
  Matrix: TMatrix;
  point31, point32, BVert: Tver;
  AnimInfo: TAnimInfo;
    PushMatrix: TMatrix;
{$IFDEF NOGLARRAY}
  texture_cs, color_cs, normal_cs, vertex_cs, multi_cs, color4ub_cs: boolean;
  texturesArr_cs, colorsArr_cs, normalArr_cs, vertArr_cs: Pointer;
{$ENDIF}

  procedure glEnableClientState(_array: GLenum);
  begin
  // GL_EDGE_FLAG_ARRAY
  // GL_INDEX_ARRAY
  // GL_TEXTURE_COORD_ARRAY
  // GL_COLOR_ARRAY
  // GL_NORMAL_ARRAY
  // GL_VERTEX_ARRAY
{$IFDEF NOGLARRAY}
    case (_array) of
 //   GL_EDGE_FLAG_ARRAY:
 //   GL_INDEX_ARRAY:
    GL_TEXTURE_COORD_ARRAY: texture_cs := true;
    GL_COLOR_ARRAY: color_cs := true;
    GL_NORMAL_ARRAY: normal_cs := true;
    GL_VERTEX_ARRAY: vertex_cs := true;
    end;
{$ELSE}
    OpenGLx.glEnableClientState(_array);
{$ENDIF}
  end;

  procedure glDisableClientState(_array: GLenum);
  begin
{$IFDEF NOGLARRAY}
    case (_array) of
 //   GL_EDGE_FLAG_ARRAY:
 //   GL_INDEX_ARRAY:
    GL_TEXTURE_COORD_ARRAY: texture_cs := false;
    GL_COLOR_ARRAY: color_cs := false;
    GL_NORMAL_ARRAY: normal_cs := false;
    GL_VERTEX_ARRAY: vertex_cs := false;
    end;
{$ELSE}
    XomMeshLib.glDisableClientState(_array);
{$ENDIF}
  end;

  procedure glClientActiveTextureARB(texture: GLenum);
  begin
    // GL_TEXTURE1
    // GL_TEXTURE0
{$IFDEF NOGLARRAY}
    multi_cs:=true;
{$ELSE}
    OpenGLx.glClientActiveTextureARB(texture);
{$ENDIF}
  end;

  procedure glTexCoordPointer(size: TGLint; _type: TGLenum;
  stride: TGLsizei; const _pointer: PGLvoid);
  begin
    // GL_FLOAT
{$IFDEF NOGLARRAY}
   texture_cs:=true;
   texturesArr_cs:=_pointer;
{$ELSE}
    XomMeshLib.glTexCoordPointer(size, _type,  stride, _pointer);
{$ENDIF}
  end;

  procedure glColorPointer(size: TGLint; _type: TGLenum;
  stride: TGLsizei; const _pointer: PGLvoid);
  begin
    // GL_UNSIGNED_BYTE
    // GL_FLOAT
{$IFDEF NOGLARRAY}
    color4ub_cs := _type = GL_UNSIGNED_BYTE;
    colorsArr_cs := _pointer;
{$ELSE}
    XomMeshLib.glColorPointer(size, _type, stride, _pointer);
{$ENDIF}
  end;

  procedure glNormalPointer(_type: GLenum; stride: GLsizei; const p: Pointer);
  begin
    // GL_FLOAT
{$IFDEF NOGLARRAY}
    normalArr_cs := p;
{$ELSE}
    OpenGLx.glNormalPointer(_type, stride, p);
{$ENDIF}
  end;

  procedure glVertexPointer(size: GLint; _type: GLenum; stride: GLsizei;
  const p: Pointer);
  begin
    // GL_FLOAT
{$IFDEF NOGLARRAY}
    vertArr_cs := p;
{$ELSE}
    OpenGLx.glVertexPointer(size, _type, stride, p);
{$ENDIF}
  end;

  procedure glDrawElements(mode: GLenum; Count: GLsizei;
  _type: GLenum; const indices: Pointer);
  var i:integer;
  index:word;
  begin
    // GL_TRIANGLES
    // GL_UNSIGNED_SHORT
{$IFDEF NOGLARRAY}
   glBegin(mode);
      for i:=0 to count-1 do begin
        index:=Word(pointer(longword(indices)+i*2)^);
        if texture_cs then begin
                if multi_cs then begin
                        glMultiTexCoord2fvARB(GL_TEXTURE0, pointer(longword(texturesArr_cs)+index*4*2));
                        glMultiTexCoord2fvARB(GL_TEXTURE1, pointer(longword(texturesArr_cs)+index*4*2));
                end
                else
                        glTexCoord2fv(pointer(longword(texturesArr_cs)+index*4*2));
        end;
        if color_cs then begin
                if color4ub_cs then
                        glColor4ubv(pointer(longword(colorsArr_cs)+index*4*1))
                else
                        glColor4fv(pointer(longword(colorsArr_cs)+index*4*4));
        end;
        if normal_cs then
                glNormal3fv(pointer(longword(normalArr_cs)+index*3*4));
        if vertex_cs then
                glVertex3fv(pointer(longword(vertArr_cs)+index*3*4));
      end;
   glEnd();
{$ELSE}
    OpenGLx.glDrawElements(mode, Count, _type, indices);
{$ENDIF}
  end;


begin     // кидаем в стек текущую матрицу
  if GLError then exit;
   glGetFloatv(GL_MODELVIEW_MATRIX,@PushMatrix);
//  glPushMatrix();
  AnimInfo.True:=False;
  AnimInfo.Child:=0;
  AnimInfo.TCoord[0]:=0;
  AnimInfo.TCoord[1]:=0;
  AnimInfo.Tm:=Transform.TrMatrix;
  {

  if (DrawType = DrGenAnim) then
   begin
       CurAnimClip.GenAnimFrame(AnimInfo,Name, Transform, XType = 'BG');
       goto ToChilds;
   end;                   }

  if AnimReady and (But.AnimButton^ or But.EditAnimBut^) then
        AnimInfo:=CurAnimClip.GenAnimFrame(Name, Transform, XType = 'BG',SelectObj = Indx);

  if (DrawType = DrBone) then
  begin
    if (XType = 'BO') then
      glCallList(objAxes);
    if (XType = 'BG') then
    begin
      glGetFloatv(GL_MODELVIEW_MATRIX, @Matrix);
      point31 := MatrXVert(Matrix, 0, 0, 0);
      //  glDepthMask(GL_FALSE);
    end;
  end;

  if Transform.TransType <> TTNone then
        glMultMatrixf(@AnimInfo.Tm);   // тут или нет?

  if (XType = 'BO') then
  begin
    glGetFloatv(GL_MODELVIEW_MATRIX, @BoneMatrix);
  end;

  if (DrawType = DrBone) then
  begin
    if (XType = 'BG') then
    begin
      //  glColor3f(0.1, 0.8, 0.1);
      glGetFloatv(GL_MODELVIEW_MATRIX, @Matrix);
      point32 := MatrXVert(Matrix, 0, 0, 0);
      glDisable(GL_LIGHTING);
      glColor3f(1, 1, 1);
      glPointSize(6);
      glBegin(GL_POINTS);
      glVertex3f(0, 0, 0);
      glEnd;
      glPushMatrix();
      glLoadIdentity();
      glBegin(GL_Lines);
      glVertex3f(point31[0], point31[1], point31[2]);
      glVertex3f(point32[0], point32[1], point32[2]);
      glEnd;
      glPopMatrix();
    end;
  end;

  //if (XType = 'BO') then goto
  if (SelectObj = Indx) and (Indx<>0) then
   begin
     ActiveMesh:= Self;
 end;

  if (DrawType = DrBoxes) and (Transform.TransType <> TTNone) then
  begin
      glDisable(GL_LIGHTING);
      glColor3f(0.0, 1.0, 0.0);
      if ActiveMesh=Self  then
      glColor3f(1.0, 0.0, 0.0);
      glPointSize(8);
      glBegin(GL_POINTS);
      glVertex3f(0, 0, 0);
      glEnd;
      if But.Dummy^ then begin
      glColor3f(1.0, 1.0, 0.0);
      glRasterPos3f(0, 0, 0);
      glListBase(FontGL);
      glCallLists(Length(Space), GL_UNSIGNED_BYTE, Pointer(Space));
      glCallLists(Length(Name), GL_UNSIGNED_BYTE, Pointer(Name));
      end;

  end;

  if (DrawType = DrSelect) and (Transform.TransType <> TTNone)  then
  begin
      glDisable(GL_LIGHTING);
      glColor4_256(Indx);
      glxDrawBitmapText(But.Canvas, 0, 0, 0, BbitPoint2, '', true);
  end;

  if ((DrawType = DrBlend) and not Attribute.ZBuffer) or
    ((DrawType = DrMesh) and (Attribute.ZBuffer))then 
  begin
    glDisable(GL_TEXTURE_2D);
    glDisable(GL_LIGHTING);
    glEnable(GL_DEPTH_TEST);
    glDepthMask(GL_TRUE);
    if But.DrawBoxes^ and ((XType = 'SH') or (XType = 'SS')) then
      DrawSelectBox(SizeBox);
    glEnable(GL_LIGHTING);

    glDepthFunc(GL_NEVER + Attribute.ZBufferFuncVal);

    if Attribute.ZBuffer then
      glDepthMask(GL_TRUE)
    else
      glDepthMask(GL_FALSE);

    if Attribute.CullFace then
      glEnable(GL_CULL_FACE)
    else
      glDisable(GL_CULL_FACE);

 //   if not Attribute.Multi then
     glEnable(GL_BLEND);

    if Attribute.AlphaTest then
    begin
      glEnable(GL_ALPHA_TEST);
      glDisable(GL_BLEND);
      glAlphaFunc(GL_GEQUAL, Attribute.AlphaTestVal);
    end
    else  
      glDisable(GL_ALPHA_TEST);

    if Attribute.Blend then
    begin
      //     glEnable(GL_BLEND);
      glBlendFunc(BlendVal[Attribute.BlendVal1], BlendVal[Attribute.BlendVal2]);
    end
    else // glDisable(GL_BLEND);
      glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

    glColor3f(1.0, 1.0, 1.0);

    glPushAttrib(GL_COLOR_MATERIAL);
    if Attribute.Material.use then
      with Attribute.Material do
      begin
        glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT, @Abi);
        glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE, @Dif);
        glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR, @Spe);
     //   glMaterialfv(GL_FRONT_AND_BACK, GL_EMISSION, @Emi);
        //   glMaterialf(GL_FRONT_AND_BACK,GL_SHININESS,Material.Shi);
      end;

    // Dummy poxel
    if But.Dummy^ and (DrawType = DrMesh)
    and (XType = 'GR') and (not But.EditAnimBut^) then  // рисуем иконку с именем
    begin
 //   if System.Pos('build',Name)>0 then
  //    glxDrawBitmapText(But.Canvas, 0, 0, 0, BuildPoint, Name, false)
   // else
      glxDrawBitmapText(But.Canvas, 0, 0, 0, BbitPoint2, Name, false);
    end;

    if (Length(Face) <> 0) and (Length(Vert)<>0)  then
    begin
      NormalLen := Length(Normal);
      FaceNum := Length(Face);

      if NormalLen = 0 then
        glDisable(GL_LIGHTING);

    glDisableClientState(GL_EDGE_FLAG_ARRAY);
    glDisableClientState(GL_INDEX_ARRAY);

    if Attribute.Texture <> 0 then
    begin
      glEnable(GL_TEXTURE_2D);
      if Attribute.Multi then begin
        glLoadMulti;
        glActiveTextureARB(GL_TEXTURE0);
        glBindTexture     (GL_TEXTURE_2D, Attribute.MultiT1);
        glActiveTextureARB(GL_TEXTURE1);
        glBindTexture     (GL_TEXTURE_2D, Attribute.MultiT2);

        glDisable( GL_BLEND );

        glEnableClientState(GL_TEXTURE_COORD_ARRAY);
        glClientActiveTextureARB (GL_TEXTURE1);
        if TextCoord2<>nil then
        glTexCoordPointer(2, GL_FLOAT, 0, TextCoord2)
        else
        glTexCoordPointer(2, GL_FLOAT, 0, TextCoord);

        glEnableClientState(GL_TEXTURE_COORD_ARRAY);
        glClientActiveTextureARB (GL_TEXTURE0);
        glTexCoordPointer(2, GL_FLOAT, 0, TextCoord);
      end
      else  begin
        glBindTexture(GL_TEXTURE_2D, Attribute.Texture);

        glEnableClientState(GL_TEXTURE_COORD_ARRAY);
        glTexCoordPointer(2, GL_FLOAT, 0, TextCoord);
      end;

       glPushMatrix();
       glMatrixMode(GL_TEXTURE);
 //      if Attribute.Texture2D then begin
     {   glLoadMatrixf(@Attribute.T2DMatrix); }
 //end;
      if Attribute.Texture<>LastTexture then
        glLoadIdentity();
        LastTexture:=Attribute.Texture;
     
        glTranslatef(AnimInfo.TCoord[0],AnimInfo.TCoord[1],0);
       glMatrixMode(GL_MODELVIEW);
       glPopMatrix();

    end
    else
      glDisableClientState(GL_TEXTURE_COORD_ARRAY);

      if (Length(Color) <> 0) and
        (Cardinal(Pointer(@Color[0])^) <> $FF000000) then
      begin
        glEnableClientState(GL_COLOR_ARRAY);
        glColorPointer(4, GL_UNSIGNED_BYTE, 0, Color);
      end else
      if (Length(ColorF) <> 0)and
        ((ColorF[0][0]<>0.0)and (ColorF[0][1]<>0.0)and (ColorF[0][2]<>0.0)) then
      begin
        glEnableClientState(GL_COLOR_ARRAY);
        glColorPointer(4, GL_FLOAT, 0, ColorF);
      end
        else
      glDisableClientState(GL_COLOR_ARRAY);

      if NormalLen <> 0 then
      begin
        glEnableClientState(GL_NORMAL_ARRAY);
        glNormalPointer(GL_FLOAT, 0, Normal);
      end
      else
        glDisableClientState(GL_NORMAL_ARRAY);

      if Length(Vert)<>0 then begin
      glEnableClientState(GL_VERTEX_ARRAY);

      if (XType = 'SS') and (Weight <> nil) and (Bones[0] <> nil) then 
      begin
        VCount := Length(Vert);
        for i := 0 to VCount - 1 do
        begin
          RVert[i] := ZereVector;
          BCount := Length(Bones);
          for j := 0 to BCount - 1 do
          begin
            BVert := MatrXVert(MatrXMatr(Bones[j].InvBoneMatrix,
              Bones[j].BoneMatrix), Vert[i][0], Vert[i][1], Vert[i][2]);
            //  BVert:= MatrXVert(Bones[j].BoneMatrix, Vert[i][0],Vert[i][1],Vert[i][2]);
            RVert[i] := VertAddVert(RVert[i],
              ValXVert(Weight[i][j], BVert));
          end;
        end;

        glVertexPointer(3, GL_FLOAT, 0, RVert);
      end

      else
        glVertexPointer(3, GL_FLOAT, 0, Vert);

      end;

      if (XType='CG') then
      glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);

      try
      for j := 0 to FaceNum - 1 do
        glDrawElements(GL_TRIANGLES, 3, GL_UNSIGNED_SHORT, @Face[j]);
     {begin
        glBegin(GL_TRIANGLES);
         glArrayElement(Face[j][0]);
         glArrayElement(Face[j][1]);
         glArrayElement(Face[j][2]);
        glEnd();
        end;  }
      except
        GLError:=true;
        exit;
      //
      end;

      if (XType='CG') then begin
        glPolygonMode(GL_FRONT_AND_BACK, GL_FILL);
        glPushAttrib(GL_ENABLE_BIT);
        glEnable(GL_POLYGON_OFFSET_FILL);
        glDisable(GL_DEPTH_TEST);
        glEnable(GL_BLEND);
        glBlendFunc(GL_ONE_MINUS_SRC_ALPHA, GL_SRC_ALPHA);
        glcolor4f(1.0, 1.0, 1.0, 0.8);
        for j := 0 to FaceNum - 1 do
                glDrawElements(GL_TRIANGLES, 3, GL_UNSIGNED_SHORT, @Face[j]);
        glPopAttrib;
      end;

      //   if NormalLen=0 then
      glEnable(GL_LIGHTING);
      glDisable(GL_BLEND);
      if Attribute.Multi then glUnLoadMulti;
      glDisable(GL_TEXTURE_2D);
      
      glDepthFunc(GL_LESS);
    end;
    glPopAttrib();
  end;
  ToChilds:
  if (XType = 'CS') then 
  begin
      ActChild := AnimInfo.Child;
    if Childs[ActChild] <> nil then
      Childs[ActChild].Draw(DrawType)
  end
  else
  begin
    for i := 0 to Length(Childs) - 1 do
    begin
      if Childs[i] <> nil then 
        Childs[i].Draw(DrawType);
    end;
  end;
  glLoadMatrixf(@PushMatrix);  // возвращаем текущую матрицу
//  glPopMatrix();
end;


function TMesh.GetBone(XCntr: TContainer; Mesh: TMesh): TMesh;
var
  i, Len: Integer;
  //TempMesh:Tmesh;
begin
  if Mesh = nil then
  begin
    Result := nil;
    Exit;
  end;
  if Mesh.Indx = XCntr.Index then
    Result := Mesh
  else
    Result := nil;

  Len := Length(Mesh.Childs) - 1;
  for i := 0 to Len do
  begin
    Result := GetBone(XCntr, Mesh.Childs[i]);
    if Result <> nil then
      Break;
  end;
end;

procedure TMesh.glLoad2DMipmaps(target: GLenum;
  Components, Width, Height: GLint; Format, atype: GLenum; Data: Pointer);
var
  i: Integer;
begin
  for i := 0 to 10 do
  begin
    if (Width=0) then Width := 1;
    if (Height=0) then Height := 1;
    glTexImage2D(target, i, Components, Width, Height, 0, Format, atype, Data);
    Inc(Longword(Data), (Width * Height * Components));
    if ((Width = 1) and (Height = 1)) then
      Break;
    Width  := Width div 2;
    Height := Height div 2;
  end;
end;

function TMesh.GetTextureGL(XImage:TContainer): Boolean;
var
  VBuf, VBuf2, palette: Pointer;
  w, h, CntrIndx: Integer;
  NumMaps, IName, ISize, Mapsize, IFormat, IComponents: Integer;
  Bsize: Byte;
  Is24Bit, kImageFormat_P8: Boolean;
  Format:integer;
  p0, p1: PARGBA;
  p2, p4: PARGB;
  p3: PAB;
  i,j:integer;
  data:Pointer;
begin
  //////////////////////////////
  kImageFormat_P8:=False;
  VBuf := XImage.GetPoint;
  IName := TestByte128(VBuf);
  w := Word(VBuf^);
  Inc(Longword(VBuf), 2);
  h := Word(VBuf^);
  Inc(Longword(VBuf), 2);
  NumMaps := Word(VBuf^);
  Inc(Longword(VBuf), 2);
  Format:= Word(VBuf^);
  //  Is24Bit:=(byte(VBuf^)=0);  ????
  Inc(Longword(VBuf), 2);
  if WC then Inc(Longword(VBuf), 4);
  Bsize := Byte(VBuf^);
  Inc(Longword(VBuf));
  Mapsize:= Integer(VBuf^);
  Inc(Longword(VBuf), 4 * Bsize );
  Bsize := Byte(VBuf^);
  Inc(Longword(VBuf), 4 * Bsize+1);
  Format:= Integer(VBuf^);
  if (Format = 7) or (Format = 19) then
    kImageFormat_P8 := true;
  if Format > 8 then
  Inc(Longword(VBuf), 5);
  Is24Bit := (Format = 0);
  Inc(Longword(VBuf), 4);
  ISize := TestByte128(VBuf);

  VBuf2 := VBuf;
  Inc(Longword(VBuf2), ISize);
  CntrIndx := TestByte128(VBuf2);

  IFormat := GL_RGBA;
  IComponents := 4;
  Result := false;
  if Is24Bit then
  begin
    IFormat     := GL_RGB;
    IComponents := 3;
    Result      := true;
  end;
  if kImageFormat_P8 then
  begin
    SetLength(TextData,w*h);

    p1    := Pointer(Longword(CntrArr[CntrIndx].point) + 11);
    for j := 0 to h - 1 do
    begin
      p0 := @TextData[j*w];
      p3 := Pointer(Longword(VBuf) + j * w * 1);
      for i := 0 to w - 1 do
      begin
        p0[i] := p1[p3[i]];
        p0[i].b:=p1[p3[i]].r;
        p0[i].r:=p1[p3[i]].b;
      end;
    end;
    VBuf:= @TextData[0];
    Result      := true;
   // glEnable(GL_COLOR_TABLE);
    //palette:= pointer(Longword(StrArray[CntrIndx].point)+11);
   // glColorTable(GL_COLOR_TABLE, GL_RGBA, 256, GL_RGBA, GL_UNSIGNED_BYTE, palette);
 //   IFormat:=GL_COLOR_INDEX;
  //  IComponents:=1;
  end;
  glTexParameteri(GL_TEXTURE_2D, GL_GENERATE_MIPMAP, 1);
 if Format = 9 then
   glCompressedTexImage2DARB(GL_TEXTURE_2D, 0, GL_COMPRESSED_RGBA_S3TC_DXT1_EXT , w, h, 0, Mapsize, VBuf);
 if Format = 10 then
   glCompressedTexImage2DARB(GL_TEXTURE_2D, 0, GL_COMPRESSED_RGBA_S3TC_DXT3_EXT , w, h, 0, Mapsize, VBuf);
 if Format = 11 then
   glCompressedTexImage2DARB(GL_TEXTURE_2D, 0, GL_COMPRESSED_RGBA_S3TC_DXT5_EXT , w, h, 0, Mapsize, VBuf);
{  if NumMaps > 1 then    // Глючит!!!
    glLoad2DMipmaps(GL_TEXTURE_2D, IComponents, w, h, IFormat,
      GL_UNSIGNED_BYTE, VBuf)
  else  }
 if Format < 9 then
 glTexImage2D(GL_TEXTURE_2D, 0, IComponents, w, h, 0, IFormat, GL_UNSIGNED_BYTE, VBuf);
   // gluBuild2DMipmaps(GL_TEXTURE_2D, IComponents, w, h, IFormat,
   //   GL_UNSIGNED_BYTE, VBuf)
    //////////////////////////////
end;

procedure  TMesh.InitSizeBox;
begin
  with   SizeBox do
  begin
    Xmax := -MaxSingle;
    Xmin := MaxSingle;
    Ymax := -MaxSingle;
    Ymin := MaxSingle;
    Zmax := -MaxSingle;
    Zmin := MaxSingle;
  end;
end;

procedure TMesh.CalcBox(var Box:TBox; const Ver:TVer);
begin
    with Box do
    begin
      if Ver[0] > Xmax then Xmax := Ver[0];
      if Ver[0] < Xmin then Xmin := Ver[0];
      if Ver[1] > Ymax then Ymax := Ver[1];
      if Ver[1] < Ymin then Ymin := Ver[1];
      if Ver[2] > Zmax then Zmax := Ver[2];
      if Ver[2] < Zmin then Zmin := Ver[2];
    end;
end;

procedure TMesh.CalcSizeBox(Const Ver:TVer);
begin
    CalcBox(SizeBox,Ver);
end;

class function TMesh.FaceToStrip(inFace:AFace):IFace;
var
FaceNum,j:integer;
FreeExist:Boolean;
FreeFace:TFace;
Index:Word;

  function SearchFace(Idx1,Idx2:Word;Flip:Boolean):Word;
  var i:integer;
  temp:Word;
  begin
    if Flip then
    begin
      temp:=Idx1;
      Idx1:=Idx2;
      Idx2:=temp;
    end;
    Result:=Idx2;

    if Idx1=Idx2 then   begin
    // если они равны?
    // то ищем свободный индекс, без пометки;
    // в перевернутом состоянии, но с условием,
    // что Idx2 там присутствует.
    FreeExist:=false;
    for i:=0 to FaceNum-1 do
      if inFace[i][3]<>MAXWORD then begin
       if not FreeExist then Result:= inFace[i][0];
       FreeExist:=true;

       if (inFace[i][0]=Idx1) then begin
         if Flip then Result:=inFace[i][1] else
         Result:=inFace[i][2];
         break;
       end;

       if (inFace[i][1]=Idx1) then begin
         if Flip then Result:=inFace[i][2] else
         Result:=inFace[i][0];
         break;
       end;

       if (inFace[i][2]=Idx1) then
       begin
         if Flip then Result:=inFace[i][0] else
         Result:=inFace[i][1];
         break
       end;

      end;

    // если же не найден, то ищем любой свободный;
    Exit;
    end;

    FreeExist:=false;
    for i:=0 to FaceNum-1 do
      if inFace[i][3]<>MAXWORD then begin
       FreeExist:=true;
        if (inFace[i][0]=Idx1) and (inFace[i][1]=Idx2) then
        begin
        Result:= inFace[i][2];
        inFace[i][3]:=MAXWORD;
        break;
        end;
        if (inFace[i][1]=Idx1) and (inFace[i][2]=Idx2) then
        begin
        Result:= inFace[i][0];
        inFace[i][3]:=MAXWORD;
        break;
        end;
        if (inFace[i][2]=Idx1) and (inFace[i][0]=Idx2) then
        begin
        Result:= inFace[i][1];
        inFace[i][3]:=MAXWORD;
        break;
        end;
      end;
  end;

begin
// Преобразование
// нужна функция поиска face по двум индексам

// Цикл. Берем индекс из фейса, добавляем следующий
// переворачиваем их если mod 2
// Ищем следующий неиспользуемый фейс, по двум последним точкам
// если не находим, то закрываем фейс линией.
    FaceNum := Length(inFace);
    SetLength(Result,FaceNum*4);

    Result[0]:=inFace[0][0];
    Result[1]:=inFace[0][1];
    Result[2]:=inFace[0][2];
    FreeExist:=true;
    inFace[0][3]:=MAXWORD;
    j:=3;

    while FreeExist do
    begin
      Result[j]:=SearchFace(Result[j-2],Result[j-1],(j mod 2) = 1);
      inc(j);
    end;
    FaceNum:=j;
    SetLength(Result,FaceNum);
end;

class function TMesh.FaceFromStrip(IndFace:IFace):AFace;
var
FaceNum,i,j:integer;
FaceStrip:TFace;
begin
    FaceNum := Length(IndFace);
    SetLength(Result,FaceNum);
    i:=0;
    for j := 0 to FaceNum - 3 do
    begin
      Move(IndFace[j], FaceStrip, 6);
      if (j mod 2) = 1 then
      begin
        FaceStrip[3] := FaceStrip[0];
        FaceStrip[0] := FaceStrip[2];
        //         Face[j][1]:=Face[j][2];
        FaceStrip[2] := FaceStrip[3];
      end;
      if (FaceStrip[1]=FaceStrip[0])or
         (FaceStrip[1]=FaceStrip[2]) then continue;
      Result[i]:=FaceStrip;
      inc(i);
    end;
    FaceNum:=i;
    SetLength(Result,FaceNum);
end;

procedure TMesh.glBuildTriangleGeo(XCntr: TContainer);
label
  normal_read, color_read;
var
  Strip: Boolean;
  p2, p3, p4, MaxSingle, FaceArrStrip, FaceArr: Pointer;
  IndFace,IndFace1,IndFace2,IndFace3,IndFace4:IFace;
  FaceStrip: TFace;
  Color1: AUColor;
  Normal1: AVer;
  TextCoord1: ATCoord;
  i,j, k, FaceNum, Count3dsPoints, cPoints, Faces: Integer;
  scale:Single;
//  IDtest: Boolean;
  //SizeBox:TBox;
  //Colors:AUColor;
  //TempNote:TTreeNode;
  NormalComp, ColorComp, TextureComp:Boolean;
  FaceCntr, VertexCntr,FaceCntr2,FaceCntr3,FaceCntr4, NormalCntr, ColorCntr, TextureCntr, WeightCntr,
  StreamCntr,SystemCntr,VertCntr,DataSize: Integer;
  s:string;

  function ReadIndexCntr(IndexCntr:Integer):IFace;
  var j:Integer;
  var p:Pointer;
  begin
    result:=nil;
    if XCntr.CntrArr[IndexCntr].Xtype = XIndexSet8 then
     begin
          p := XCntr.CntrArr[IndexCntr].GetPoint;
          FaceNum      := TestByte128(p);
          SetLength(result,FaceNum);
          for j := 0 to FaceNum - 1 do
              begin
                Move(p^, result[j], 1);
                Inc(Longword(p), 1);
              end;
    end else
    if XCntr.CntrArr[IndexCntr].Xtype = XIndexSet then
      begin
        p := XCntr.CntrArr[IndexCntr].GetPoint;
          FaceNum      := TestByte128(p);
          SetLength(result,FaceNum);
          Move(p^, result[0], FaceNum*2);
      end;
  end;
begin
WeightCntr:=0;
  FaceCntr2:=0;
  FaceCntr3:=0;
p4:=nil;

if (XCntr.XType = XPsGeoSet) then begin
      Strip:=false;
      p2 := XCntr.GetPoint;
      Faces := Word(p2^);  //PrimitiveCount
      Inc(Longword(p2), 4);
      k:= TestByte128(p2);
      for i:=1 to k do   //VertexData
      begin
       VertexCntr:= TestByte128(p2);
       if XCntr.CntrArr[VertexCntr].Xtype = XPsVertexDataSet then
       begin
        p3:= XCntr.CntrArr[VertexCntr].GetPoint;
        j:=TestByte128(p3);
        s:= XCntr.CntrArr[VertexCntr].Name;   //PsParameterName
        DataSize:=TestByte128(p3);
        if s = 'INvert.Position' then
        begin
          Count3dsPoints:=DataSize div 12;
          SetLength(Vert, Count3dsPoints);
          Move(p3^, Vert[0], DataSize);
          Inc(Longword(p3), DataSize);
        end;
        if s = 'INvert.Normal' then
        begin
          cPoints:=DataSize div 12;
          SetLength(Normal, cPoints);
          Move(p3^, Normal[0], DataSize);
          Inc(Longword(p3), DataSize);
        end;
        if s = 'INvert.Colour' then
        begin
          cPoints:=DataSize div 12;
          SetLength(ColorF, cPoints);
          Move(p3^, ColorF[0], DataSize);
          Inc(Longword(p3), DataSize);
        end;
        if s = 'INvert.TexCoord1' then
        begin
          cPoints:=DataSize div 8;
          SetLength(TextCoord, cPoints);
          Move(p3^, TextCoord[0], DataSize);
          Inc(Longword(p3), DataSize);
        end;
        if s = 'INvert.TexCoord2' then
        begin
          cPoints:=DataSize div 8;
          SetLength(TextCoord2, cPoints);
          Move(p3^, TextCoord2[0], DataSize);
          Inc(Longword(p3), DataSize);
        end;
         if s = 'INvert.skinIndxs' then
        begin
          cPoints:=DataSize div 3;
          p4:=p3;
        end;
        if (s = 'INvert.skinWeights') and (p4<>nil) and (Length(Bones)>0)then
        begin
          cPoints:=DataSize div 12;
          SetLength(Weight, cPoints, Length(Bones));
              for j := 0 to cPoints - 1 do
                begin
                Weight[j][Byte(p4^)] := Single(p3^);
                Inc(Longword(p4));
                Inc(Longword(p3), 4);

                Weight[j][Byte(p4^)] := Single(p3^);
                Inc(Longword(p4));
                Inc(Longword(p3), 4);

                Weight[j][Byte(p4^)] := Single(p3^);
                Inc(Longword(p4));
                Inc(Longword(p3), 4);
              end;
        end;


       // Data  XInt
      // Format XByte
      // Dimensions  XByte
      // ElementCount XByte
      // VbHandle XByte
      // LittleEndian XBool
      // UsageType XEnum
      // Dynamic XBool
       end;
      end;

      FaceCntr := TestByte128(p2); // IndexSet XCntr
end
else
if (XCntr.XType = XIndexedCustomTriangleSet) or
   (XCntr.XType = XIndexedCustomTriangleStripSet)
        then begin
    Strip := XCntr.XType = XIndexedCustomTriangleStripSet;
    p2 := XCntr.GetPoint;

   if Strip then
   begin
    Inc(Longword(p2));
    Faces := Word(p2^); Inc(Longword(p2),2);
    // get Faces
    FaceCntr := TestByte128(p2);   //5
    Inc(Longword(p2), 4);
    StreamCntr := TestByte128(p2);
   end
   else
   begin
    // get Faces
    FaceCntr := TestByte128(p2);   //5
    Faces := Integer(p2^);  Inc(Longword(p2), 4);
    StreamCntr := TestByte128(p2);
   end;


    if XCntr.CntrArr[StreamCntr].Xtype = XStreamSet then
    begin
      p2 := XCntr.CntrArr[StreamCntr].GetPoint;
      k := TestByte128(p2);
      SystemCntr:=0;
      if k>0 then SystemCntr:= TestByte128(p2);
      k := TestByte128(p2);
      VertCntr:=0;
      for i:=1 to k do VertCntr:= TestByte128(p2);
      WeightCntr  := TestByte128(p2);

      if (XCntr.CntrArr[SystemCntr].Xtype = XSystemStream) then
      begin
        p2 := XCntr.CntrArr[SystemCntr].GetPoint;
        Inc(Longword(p2), 4+2+4); // FourCC  Stride  FVF
        Count3dsPoints := Integer(p2^);// VertexCount
        Inc(Longword(p2), 4);
        NormalComp:=false;
        TextureComp:=false;
        k := TestByte128(p2); // ComponentFourCC
        for i:=1 to k do begin
                NormalComp:=NormalComp or (Cardinal(p2^)=$4E4F524D);//NORM
                TextureComp:=TextureComp or (Cardinal(p2^)=$54455830)or
                (Cardinal(p2^)=$4F555454);//TEX0 OUTT
                Inc(Longword(p2), 4);
                end;
        k := TestByte128(p2); // ComponentOffset
        for i:=1 to k do
                 Inc(Longword(p2), 1);
        Inc(Longword(p2), 4+4+4); // BoundsComponentOffset  ComponentRotationMask ComponentTranslationMask

        k := TestByte128(p2); //Data
        SetLength(Vert, Count3dsPoints);
        if NormalComp then
        SetLength(Normal, Count3dsPoints);
        if TextureComp then
        SetLength(TextCoord, Count3dsPoints);
        for i:=0 to Count3dsPoints-1 do
        begin
         Move(p2^, Vert[i], 12); Inc(Longword(p2), 12);
         if NormalComp then begin
         Move(p2^, Normal[i], 12); Inc(Longword(p2), 12);
         end;
         if TextureComp then begin
         Move(p2^, TextCoord[i], 8); Inc(Longword(p2), 8);
         end;
        end;
      end;
    end else exit;

end else
begin

  Strip := XCntr.XType = XIndexedTriangleStripSet;
  p2    := XCntr.GetPoint;

  if Strip then
  begin
    Inc(Longword(p2));
    Faces := Word(p2^);
    // get Faces
    Inc(Longword(p2),2);
    FaceCntr := TestByte128(p2);   //5
    if XCntr.CntrArr[FaceCntr].Xtype=XMultiIndexSet then begin
      p3 :=  XCntr.CntrArr[FaceCntr].GetPoint;
      FaceCntr := TestByte128(p3);
      FaceCntr2 := TestByte128(p3);
      FaceCntr3 := TestByte128(p3);
      FaceCntr4 := TestByte128(p3);
      IndFace1:=ReadIndexCntr(FaceCntr);
      IndFace2:=ReadIndexCntr(FaceCntr2);
      IndFace3:=ReadIndexCntr(FaceCntr3);
      IndFace4:=ReadIndexCntr(FaceCntr4);
    end;
    Inc(Longword(p2), 8);
  end
  else
  begin
    // get Faces
    FaceCntr := TestByte128(p2);   //5
    Inc(Longword(p2), 4);
    Faces := Word(p2^);
    Inc(Longword(p2), 4);
  end;
    // get Vertex
    VertexCntr := TestByte128(p2);  //2
    // get Normal
    NormalCntr := TestByte128(p2);   //3
    // get Colors
    ColorCntr := TestByte128(p2);
    ColorIndx:= ColorCntr;
    // get TextureCoord
    TextureCntr := TestByte128(p2);  //4
    WeightCntr  := TestByte128(p2);

  Move(p2^, SizeBox, 2 * 12);
  // GetArrays
  // Vert
  if XCntr.CntrArr[VertexCntr].Xtype <> XCoord3fSet then
  begin
    if XCntr.CntrArr[VertexCntr].Xtype <> XCoord3sSet_1uScale then
    Exit;
    p2 := XCntr.CntrArr[VertexCntr].GetPoint;
    scale := 1 shl(15-Byte(p2^)); Inc(Longword(p2));
    Count3dsPoints := TestByte128(p2);
    SetLength(Vert, Count3dsPoints);
    for j := 0 to Count3dsPoints - 1 do
      begin
        Vert[j][0] := Smallint(p2^)/32768*scale;
        Inc(Longword(p2),2);

        Vert[j][1] := Smallint(p2^)/32768*scale;
        Inc(Longword(p2),2);

        Vert[j][2] := Smallint(p2^)/32768*scale;
        Inc(Longword(p2),2);
      end;
    goto normal_read;
  end;
  p2 := XCntr.CntrArr[VertexCntr].GetPoint;
  Count3dsPoints := TestByte128(p2);
  SetLength(Vert, Count3dsPoints);
  Move(p2^, Vert[0], Count3dsPoints * 12);
  normal_read:
  // Normal
  if NormalCntr <> 0 then
  begin
    if XCntr.CntrArr[NormalCntr].Xtype <> XNormal3fSet then
    begin
      if XCntr.CntrArr[NormalCntr].Xtype <> XNormal3sSet_1uScale then
      Exit;
      p2 := XCntr.CntrArr[NormalCntr].GetPoint;
      scale := 1 shl(15-Byte(p2^)); Inc(Longword(p2));
      k := TestByte128(p2);
      SetLength(Normal, k);
      for j := 0 to k - 1 do
        begin
        Normal[j][0] := Smallint(p2^)/32768*scale;
        Inc(Longword(p2),2);

        Normal[j][1] := Smallint(p2^)/32768*scale;
        Inc(Longword(p2),2);

        Normal[j][2] := Smallint(p2^)/32768*scale;
        Inc(Longword(p2),2);
        end;
      if (FaceCntr3>0) then begin
        // convert
        SetLength(Normal1,Count3dsPoints);
        FaceNum:=Length(IndFace1);
        for j:=0 to FaceNum-1 do begin
          Normal1[IndFace1[j]]:=Normal[IndFace2[j]];
        end;
        Normal:=Normal1;
      end;
      goto color_read;
    end;
    p2 := XCntr.CntrArr[NormalCntr].GetPoint;
    k := TestByte128(p2);
    SetLength(Normal, k);
    Move(p2^, Normal[0], k * 12);
  end;
  color_read:
  // Color
  if (ColorCntr <> 0) and (XCntr.CntrArr[ColorCntr].Xtype <> XConstColorSet) then
  begin
    if XCntr.CntrArr[ColorCntr].Xtype <> XColor4ubSet then
      Exit;
    p2 := XCntr.CntrArr[ColorCntr].GetPoint;
    k := TestByte128(p2);
    SetLength(Color, k);
    Move(p2^, Color[0], k * 4);
    if (FaceCntr3>0) then begin
      // convert
      SetLength(Color1,Count3dsPoints);
      FaceNum:=Length(IndFace1);
      for j:=0 to FaceNum-1 do begin
        Color1[IndFace1[j]]:=Color[IndFace3[j]];
      end;
      Color:=Color1;
    end;
  end;
  // TextCoord
  if XCntr.CntrArr[TextureCntr].Xtype = XTexCoord2fSet then
  begin
  p2 := XCntr.CntrArr[TextureCntr].GetPoint;
  k := TestByte128(p2);
  SetLength(TextCoord, k);
  Move(p2^, TextCoord[0], k * 8);
    if (FaceCntr2>0) then begin
      // convert
      SetLength(TextCoord1,Count3dsPoints);
      FaceNum:=Length(IndFace1);
      for j:=0 to FaceNum-1 do begin
        TextCoord1[IndFace1[j]]:=TextCoord[IndFace4[j]];
      end;
      TextCoord:=TextCoord1;
    end;
  end else if  XCntr.CntrArr[TextureCntr].Xtype = XMultiTexCoordSet then
  begin
  p2 := XCntr.CntrArr[TextureCntr].GetPoint;
  TestByte128(p2);
  p3:=XCntr.CntrArr[TestByte128(p2)].GetPoint;
  p2:=XCntr.CntrArr[TestByte128(p2)].GetPoint;

  k := TestByte128(p2);
  SetLength(TextCoord2, k);
  Move(p2^, TextCoord2[0], k * 8);

  k := TestByte128(p3);
  SetLength(TextCoord, k);
  Move(p3^, TextCoord[0], k * 8);

  end else Exit;

end;

 // Weight
  if (WeightCntr <> 0) then
  begin
    if (XCntr.CntrArr[WeightCntr].Xtype = XWeightSet) then
    begin
      p2 := XCntr.CntrArr[WeightCntr].GetPoint;
      k := Word(p2^);
      Inc(Longword(p2), 2);
      TestByte128(p2);
      SetLength(Weight, Count3dsPoints, k);
      for j := 0 to Count3dsPoints - 1 do
      begin
        Move(p2^, Weight[j][0], k * 4);
        Inc(Longword(p2), k * 4);
      end;
    end;
    if (XCntr.CntrArr[WeightCntr].Xtype = XPaletteWeightSet) then
    begin
      p2 := XCntr.CntrArr[WeightCntr].GetPoint;
      k := TestByte128(p2);
      p3 := p2;
      Inc(Longword(p3), k);
      k := Word(p3^);
      Inc(Longword(p3), 2);
      k := TestByte128(p3);
      k := Length(Bones);
      if k = 0 then
        k := 100;
      SetLength(Weight, Count3dsPoints, k);
      for j := 0 to Count3dsPoints - 1 do
      begin
        Weight[j][Byte(p2^)] := Single(p3^);
        Inc(Longword(p2));
        Inc(Longword(p3), 4);

        Weight[j][Byte(p2^)] := Single(p3^);
        Inc(Longword(p2));
        Inc(Longword(p3), 4);
     if WUM and (k>2) then begin
        Weight[j][Byte(p2^)] := Single(p3^);
        Inc(Longword(p2));
        Inc(Longword(p3), 4);
        end;
      end;

    end;
  end;
  // Face
  if XCntr.CntrArr[FaceCntr].Xtype = XIndexSet8 then
  begin
    if Strip then
      Face:=FaceFromStrip(IndFace1)  // Gen
    else
    begin
      p2 := XCntr.CntrArr[FaceCntr].GetPoint;
      FaceNum := TestByte128(p2) div 3;
      FaceArr := p2;
      SetLength(Face, FaceNum);
      for j := 0 to FaceNum - 1 do
      begin
        Move(FaceArr^, Face[j], 6);
        Inc(Longword(FaceArr), 6);
      end;
    end;
  end else
  begin
  if XCntr.CntrArr[FaceCntr].Xtype <> XIndexSet then
    Exit;
  p2 := XCntr.CntrArr[FaceCntr].GetPoint;
  if Strip then
  begin
    FaceNum      := TestByte128(p2);
    SetLength(IndFace,FaceNum);
    Move(p2^, IndFace[0], FaceNum*2);
    Face:=FaceFromStrip(IndFace);  // Gen
  end
  else
  begin
    FaceNum := TestByte128(p2) div 3;
    FaceArr := p2;
    SetLength(Face, FaceNum);
    // SetLength(FaceArr,FaceNum);
    // Move(p2^, FaceArr[0], FaceNum*6);
    for j := 0 to FaceNum - 1 do
    begin
      Move(FaceArr^, Face[j], 6);
      Inc(Longword(FaceArr), 6);
    end;
  end;
  end;
  if Length(Vert)>0 then begin
  MaxSingle := Pointer($FFFF7F7F);
  if SizeBox.Xmin = Single(MaxSingle) then
    for j := 0 to Count3dsPoints - 1 do
      CalcSizeBox(Vert[j]);
  end;
end;

procedure TMesh.glBuildCollGeo(XCntr: TContainer);
var
  p2, px, PointsArr, FaceArr: Pointer;
  Count3dsFace, Count3dsPoints,
  i, j, IndexNum,VertexNum: Integer;
  MaxZoom: Single;
  b,b1:byte;
  VertN:integer;
begin
  p2 := XCntr.GetPoint;
    Inc(Longword(p2),4*3);
    //  'Restitution',XFloat
    //  'Friction',XFloat
    //  'Mass',XFloat
  IndexNum := TestByte128(p2);
  if IndexNum = 0 then
    Exit;
  if Byte(p2^) = 255 then
    Exit; //?
    FaceArr      := p2;
    // чтобы узнать количество вертексов, нужно пробежать по массиву индексов,
    // найти максимальный и поделить количество вертексов на это число.
    MaxFace:=0;
    for i:=0 to IndexNum-1 do begin
      if MaxFace<Word(p2^) then MaxFace:=Word(p2^);
      Inc(Longword(p2), 2);
    end;
    Inc(MaxFace);
    VertexNum:=TestByte128(p2);
    VertN:=VertexNum div MaxFace;

  if VertN=4 then
  begin
    Inc(Longword(FaceArr),2);
    Count3dsFace := IndexNum div VertN;
    SetLength(Face, Count3dsFace);
    Move(FaceArr^, Face[0], Count3dsFace * 8);
    Face[Count3dsFace - 1][3] := 0;
  end
  else
  begin
    Count3dsFace := IndexNum div VertN;
    SetLength(Face, Count3dsFace);
    for j := 0 to Count3dsFace - 1 do
    begin
      px := Pointer(Longword(FaceArr) + j * 6);
      Move(px^, Face[j], 6);
    end;
    // FaceArr2[Count3dsFace-1][3]:=0;
  end;

  Count3dsPoints := (VertexNum div VertN);
  PointsArr := p2;
  SetLength(Vert, Count3dsPoints);
  // Move(PointsArr^, PointsArr2, Count3dsPoints);

  InitSizeBox;

  for j := 0 to Count3dsPoints - 1 do
  begin
    px := Pointer(Longword(PointsArr) + j * (4*VertN));
    Move(px^, Vert[j], 12);
    CalcSizeBox(Vert[j]);
  end;
  
  with SizeBox do
  begin
    TransView.Xpos := -(XMax + Xmin) / 2;
    TransView.Ypos := -(YMax + Ymin) / 2;
    TransView.Zpos := -(ZMax + Zmin) / 2;
    MaxZoom        := Max((Xmax - Xmin), (Ymax - Ymin));
    MaxZoom        := Max(MaxZoom, (Zmax - Zmin));
    TransView.zoom := MaxZoom * 3;
  end;


end;


procedure TMesh.ReadXNode(VirtualBufer: TMemoryStream;
  XTextureStr: TStringList; Tree: TTreeView; Node: TTreeNode);
var
  num, k: Word;
  i: Integer;
  IsPar: Boolean;
  //   p:pointer;
  TempNode: TTreeNode;
  s: string;


  function ReadColor(var Stream: TMemoryStream): Color4d;
  var
    b: Byte;
    i: Integer;
  begin
    Result[3] := 1;
    for i := 0 to 2 do
    begin
      Stream.Read(b, 1);
      Result[i] := b / 255
    end;
  end;
begin
  // P:=VirtualBufer.Memory;
  XType := ReadName(VirtualBufer);
  Name := ReadName(VirtualBufer);

  //    VirtualBufer.Write(PChar(Mesh.Name)^, Length(Mesh.Name) + 1);

  if XType = 'SH' then
    Node := Tree.Items.AddChild(Node, 'Shape');

  with Transform do
  begin
    VirtualBufer.Read(TransType, 1);

    if TransType = TTMatrix then
      for i := 1 to 4 do
        VirtualBufer.Read(TrMatrix[i], 3 * 4);

    if TransType = TTVector then
    begin
      VirtualBufer.Read(Pos[0], 3 * 4);
      VirtualBufer.Read(Rot[0], 3 * 4);
      VirtualBufer.Read(Size[0], 3 * 4);
      TrMatrix := GetMatrix(Pos, Rot, Size);
    end;
    if TransType = TTJoint then
    begin
      VirtualBufer.Read(Pos[0], 3 * 4);
      VirtualBufer.Read(Rot[0], 3 * 4);
      VirtualBufer.Read(JointOrient[0], 3 * 4);
      VirtualBufer.Read(RotOrient[0], 3 * 4);
      VirtualBufer.Read(Size[0], 3 * 4);
 //     for i := 1 to 4 do
 //       VirtualBufer.Read(InvBoneMatrix[i], 3 * 4);
      TrMatrix := GetMatrix2(Pos, Rot, JointOrient, RotOrient, Size);
    end;
  end;

  VirtualBufer.Read(Num, 2);

  if (Num > 0) and ((XType = 'SH')or(XType = 'SS')) then
  begin     // Mesh
    TempNode      := Tree.Items.AddChild(Node, 'Obj');
    TempNode.Data := Pointer(num);
    SetLength(Face, num);
    for i := 0 to Num - 1 do
      VirtualBufer.Read(Face[i], 2 * 3);
    Tree.Items.AddChild(TempNode, 'Face').Data := @Face;

    VirtualBufer.Read(Num, 2);
    SetLength(Vert, num);
    for i := 0 to Num - 1 do
      VirtualBufer.Read(Vert[i], 4 * 3);
    Tree.Items.AddChild(TempNode, 'Vert').Data := @Vert;

    VirtualBufer.Read(IsPar, 1);
    if IsPar then
    begin
      SetLength(Normal, Num);
      for i := 0 to Num - 1 do
        VirtualBufer.Read(Normal[i], 4 * 3);
      Tree.Items.AddChild(TempNode, 'Norm').Data := @Normal;
    end;

    VirtualBufer.Read(IsPar, 1);
   if IsPar then
    begin
      SetLength(Color, Num);

      for i := 0 to Num - 1 do
      begin
        VirtualBufer.Read(Color[i], 3);
        Color[i][3] := 255;
      end;
      Tree.Items.AddChild(TempNode, 'Color').Data := @Color;
      //        ColorUse:=true;
    end;
      
    VirtualBufer.Read(IsPar, 1);
    if IsPar then
    begin
      SetLength(TextCoord, Num);
      for i := 0 to Num - 1 do
        VirtualBufer.Read(TextCoord[i], 2 * 4);
      Tree.Items.AddChild(TempNode, 'TextCoord').Data := @TextCoord;
    end;

    VirtualBufer.Read(IsPar, 1);
    if IsPar then
    begin
      Tree.Items.AddChildFirst(TempNode.Parent, 'Material').Data :=
        @Attribute.Material;
      Attribute.Material.use := true;
      with Attribute do
      begin
        Material.Name := ReadName(VirtualBufer);
        Material.Abi := ReadColor(VirtualBufer);
        Material.Dif := ReadColor(VirtualBufer);
        Material.Spe := ReadColor(VirtualBufer);
        Material.Emi := ReadColor(VirtualBufer);
      end;
    end;

    VirtualBufer.Read(IsPar, 1);
    if IsPar then
    begin
      s := ReadName(VirtualBufer);
      Attribute.TextureId := XtextureStr.Add(s);
      Tree.Items.AddChildFirst(TempNode.Parent, 'Texture').Data :=
        PChar(XtextureStr.Strings[Attribute.TextureId]);
    end;

   if XType = 'SS' then
      begin
        VirtualBufer.Read(k, 2);
        for i := 0 to k - 1 do
        begin
          s := ReadName(VirtualBufer);
          Tree.Items.AddChild(TempNode.Parent, s+'_bone').Data := PChar(s);
        end;
        //XWeightSet
        SetLength(Weight, Num,k);
        for i := 0 to Num - 1 do
          VirtualBufer.Read(Weight[i][0], k * 4);
        Tree.Items.AddChild(TempNode, 'Weight').Data := @Weight;
      end;

  end
  else
  begin
    if XType = 'IN' then
      TempNode := Tree.Items.AddChild(Node, 'Node');
    if XType = 'GR' then
      TempNode := Tree.Items.AddChild(Node, 'Dummy');
    if XType = 'GO' then
      TempNode := Tree.Items.AddChild(Node, 'Group');
    if XType = 'BM' then
      TempNode := Tree.Items.AddChild(Node, 'BinModifier');
    if XType = 'BG' then
      TempNode := Tree.Items.AddChild(Node, 'BoneGroup');
    if XType = 'GS' then
      TempNode := Tree.Items.AddChild(Node, 'GroupShape');
    if XType = 'SK' then
      TempNode := Tree.Items.AddChild(Node, 'Skin');
    if XType = 'BO' then
      Tree.Items.AddChild(Node, 'Bone').Data := @Transform
    else
    if Transform.TransType <> TTNone then
      Tree.Items.AddChild(TempNode, 'Matrix').Data := @Transform;

 //   VirtualBufer.Read(Num, 2);
    SetLength(Childs, Num);
    for i := 0 to Num - 1 do
    begin
      Childs[i] := TMesh.Create(CntrArr);
      Childs[i].ReadXNode(VirtualBufer, XTextureStr, Tree, TempNode);
    end;
  end;
  //  TempNode.Data:=@Mesh;
end;

procedure TMesh.SaveAsXom3D(FileName: string);
const
  Zero: Integer = 0;
var
  VirtualBufer: TMemoryStream;
  s: string;
  TypeMatrix:TTransTypes;

  procedure WriteColor(Color: Color4d);
  var
    b: Byte;
    i: Integer;
  begin
    for i := 0 to 2 do
    begin
      b := Round(Color[i] * 255);
      VirtualBufer.Write(b, 1);
    end;
  end;

  procedure WriteXNode(Mesh: TMesh);
  var
    num: Word;
    i, k: Integer;
    IsPar: Boolean;
  begin
    if Mesh = nil then   // XNodeInterion
    begin
      VirtualBufer.Write(PChar('XN')^, 3);
      Exit;
    end;

    VirtualBufer.Write(PChar(Mesh.XType)^, 3);

    VirtualBufer.Write(PChar(Mesh.Name)^, Length(Mesh.Name) + 1);

    if Mesh.xtype = 'BO' then   // XBone
    begin
    TypeMatrix:=TTMatrix;
    VirtualBufer.Write(TypeMatrix, 1);
     for i := 1 to 4 do
          VirtualBufer.Write(Mesh.InvBoneMatrix[i], 3 * 4);
      Num := 0;
      VirtualBufer.Write(Num, 2);
      Exit;
    end;

    with Mesh.Transform do
    begin
      VirtualBufer.Write(TransType, 1);
      if TransType = TTMatrix then
        for i := 1 to 4 do
          VirtualBufer.Write(TrMatrix[i], 3 * 4);
      if TransType = TTVector then
      begin
        VirtualBufer.Write(Pos[0], 3 * 4);
        VirtualBufer.Write(Rot[0], 3 * 4);
        VirtualBufer.Write(Size[0], 3 * 4);
      end;
      if TransType = TTJoint then
      begin
        VirtualBufer.Write(Pos[0], 3 * 4);
        VirtualBufer.Write(Rot[0], 3 * 4);
        VirtualBufer.Write(JointOrient[0], 3 * 4);
        VirtualBufer.Write(RotOrient[0], 3 * 4);
        VirtualBufer.Write(Size[0], 3 * 4);
  //      for i := 1 to 4 do
  //       VirtualBufer.Write(Mesh.Childs[0].InvBoneMatrix[i], 3 * 4);
      end;
    end;


     // XSkinShape XShape
    if (Mesh.xtype = 'SS') or (Mesh.xtype = 'SH') then
    begin
      num := Length(Mesh.Face);
      VirtualBufer.Write(Num, 2);
      // Mesh
       //XVertexDataSet
      //XIndexSet
      for i := 0 to Num - 1 do
        VirtualBufer.Write(Mesh.Face[i], 2 * 3);
      //XCoordSet
      num := Length(Mesh.Vert);
      VirtualBufer.Write(Num, 2);
      for i := 0 to Num - 1 do
        VirtualBufer.Write(Mesh.Vert[i], 4 * 3);
      //XNormalSet
      IsPar := Length(Mesh.Normal) > 0;
      VirtualBufer.Write(IsPar, 1);
      if IsPar then
        for i := 0 to Num - 1 do
          VirtualBufer.Write(Mesh.Normal[i], 4 * 3);
      //XColorSet
      IsPar := Length(Mesh.Color) > 0;
      VirtualBufer.Write(IsPar, 1);
      if IsPar then
        for i := 0 to Num - 1 do
          VirtualBufer.Write(Mesh.Color[i], 3);
      //XTexCoordSet
      IsPar := Length(Mesh.TextCoord) > 0;
      VirtualBufer.Write(IsPar, 1);
      if IsPar then
        for i := 0 to Num - 1 do
          VirtualBufer.Write(Mesh.TextCoord[i], 2 * 4);
      //XMaterial
      IsPar := Mesh.Attribute.Material.use;
      VirtualBufer.Write(IsPar, 1);
      if IsPar then 
        with Mesh.Attribute do 
        begin
          VirtualBufer.Write(PChar(Material.Name)^, Length(Material.Name) + 1);
          WriteColor(Material.Abi);
          WriteColor(Material.Dif);
          WriteColor(Material.Spe);
          WriteColor(Material.Emi);
        end;
      //XImage
      IsPar := Mesh.Attribute.Texture > 0;
      VirtualBufer.Write(IsPar, 1);
      if IsPar then
      begin
        s := Format('XTexture#%d.tga', [Mesh.Attribute.TextureId]);
         CntrArr[Mesh.Attribute.TextureId].SaveTga(s, But.XImage, But.XImageLab);
        VirtualBufer.Write(PChar(s)^, Length(s) + 1);
      end;
      //XSkinShape
      if Mesh.xtype = 'SS' then
      begin
        k := Length(Mesh.Bones);
        VirtualBufer.Write(k, 2);
        for i := 0 to k - 1 do
        begin
          VirtualBufer.Write(PChar(Mesh.Bones[i].Name)^,
            Length(Mesh.Bones[i].Name) - 5);
          VirtualBufer.Write(Zero, 1);
        end;
        //XWeightSet
        for i := 0 to Num - 1 do
          VirtualBufer.Write(Mesh.Weight[i][0], k * 4);
      end;
    end
    else
    begin
      Num := Length(Mesh.Childs);
      VirtualBufer.Write(Num, 2);
      for i := 0 to Num - 1 do
        WriteXNode(Mesh.Childs[i]);
    end;
  end;
begin
  VirtualBufer := TMemoryStream.Create;
  VirtualBufer.Write(PChar('X3D')^, 4);
  WriteXNode(Self);
  VirtualBufer.SaveToFile(FileName);
  VirtualBufer.Free;
end;


destructor TMesh.Destroy;
var
  i: Integer;
begin
  Vert := nil;
  RVert := nil;
  DPos := nil;
  for i := 0 to Length(Weight) - 1 do
    Weight[i] := nil;
  Weight := nil;
  Face := nil;
  Normal := nil;
  TextCoord := nil;
  TextCoord2 := nil;
  Color := nil;
  ColorF := nil;
  for i := 0 to Length(Childs) - 1 do begin
    Childs[i].Free;
    Childs[i]:=nil;
    end;
  Childs := nil;
  Bones := nil;
  inherited Destroy;
end;


function Color256_4(color4: color4d): Cardinal;
var
RGBA:Cardinal;
begin
  RGBA:=0;
  RGBA := RGBA or (round(color4[3]*255) and $ff);
  RGBA := RGBA shl 8;
  RGBA := RGBA or (round(color4[2]*255) and $ff);
  RGBA := RGBA shl 8;
  RGBA := RGBA or (round(color4[1]*255) and $ff);
  RGBA := RGBA shl 8;
  RGBA := RGBA or (round(color4[0]*255) and $ff);
  result:=RGBA;
end;

function Color4_256(RGBA:Cardinal): color4d;
begin
  result[0] := (RGBA and $ff) / 255.0;
  RGBA := RGBA shr 8;
  result[1] := (RGBA and $ff) / 255.0;
  RGBA := RGBA shr 8;
  result[2] := (RGBA and $ff) / 255.0;
  RGBA := RGBA shr 8;
  result[3] := (RGBA and $ff) / 255.0;
end;

procedure glColor4_256(RGBA: Cardinal);
var
  color4: color4d;
begin
  color4 := Color4_256(RGBA);
  glColor4fv(@color4);
end;

procedure glxDrawBitmapText(Canvas:TCanvas; wdx, wdy, wdz: GLdouble; bitPoint2: Pointer;
  Name: string; select: Boolean);
var
  vp: TGLVectori4;
  PMatrix, MvMatrix: TGLMatrixd4;
  wtx, wty, wtz: GLdouble;
  Len: Integer;
begin
  // получаем координаты плоскости паралельной экрану
  glGetIntegerv(GL_VIEWPORT, @vp);
  glGetDoublev(GL_MODELVIEW_MATRIX, @MvMatrix);
  glGetDoublev(GL_PROJECTION_MATRIX, @PMatrix);
  gluProject(wdx, wdy, wdz, MvMatrix, PMatrix, vp,
    @wdx, @wdy, @wdz);
  // если выбор активен тогда рисуем прямоугольник на месте иконки и текста
  if select then
  begin
    glBegin(GL_QUADS);
    // учитываем длинну текста если он есть
  {  if not MainForm.HideName1.Checked then
      Len := MainForm.Canvas.TextWidth(Name) div 2
    else
      Len := 0;   }
      Len := Canvas.TextWidth(Name) div 2;

    gluUnProject(wdx + 4 + Len, wdy + 4, wdz, MvMatrix, PMatrix, vp,
      @wtx, @wty, @wtz);
    glVertex3f(wtx, wty, wtz);

    gluUnProject(wdx - 4, wdy + 4, wdz, MvMatrix, PMatrix, vp,
      @wtx, @wty, @wtz);
    glVertex3f(wtx, wty, wtz);

    gluUnProject(wdx - 4, wdy - 4, wdz, MvMatrix, PMatrix, vp,
      @wtx, @wty, @wtz);
    glVertex3f(wtx, wty, wtz);

    gluUnProject(wdx + 4 + Len, wdy - 4, wdz, MvMatrix, PMatrix, vp,
      @wtx, @wty, @wtz);
    glVertex3f(wtx, wty, wtz);

    glEnd;
  end 
  else // иначе просто отображаем иконку
  begin
  // Записываем в стек параметры цвета
  glPushAttrib(GL_COLOR_MATERIAL);
  glDisable(GL_LIGHTING);
  glEnable(GL_ALPHA_TEST);
  glColor3f(1, 1, 1);
    gluUnProject(wdx - 8, wdy - 8, wdz, MvMatrix, PMatrix, vp,
      @wtx, @wty, @wtz);
    glRasterPos3f(wtx, wty, wtz);
    glDrawPixels(16, 16, $80E1, GL_UNSIGNED_BYTE, bitPoint2);
    // если текст включен, выводим его на экран
 //   if not MainForm.HideName1.Checked then
 //   begin
      gluUnProject(wdx + 10, wdy, wdz, MvMatrix, PMatrix, vp,
        @wtx, @wty, @wtz);
      glRasterPos3f(wtx, wty, wtz);
      glListBase(FontGL);
      glCallLists(Length(Name), GL_UNSIGNED_BYTE, Pointer(Name));
  //  end;
  glDisable(GL_ALPHA_TEST);
  glEnable(GL_LIGHTING);
  glPopAttrib;  // возвращаем параметры из стека
  end;

end;


procedure glxDrawText(Canvas:TCanvas; wdx, wdy, wdz: GLdouble; Name: string);
var
  vp: TGLVectori4;
  PMatrix, MvMatrix: TGLMatrixd4;
  wtx, wty, wtz: GLdouble;
  Len: Integer;
begin
  // получаем координаты плоскости паралельной экрану
  glGetIntegerv(GL_VIEWPORT, @vp);
  glGetDoublev(GL_MODELVIEW_MATRIX, @MvMatrix);
  glGetDoublev(GL_PROJECTION_MATRIX, @PMatrix);
  gluProject(wdx, wdy, wdz, MvMatrix, PMatrix, vp,
    @wdx, @wdy, @wdz);
  glDisable(GL_LIGHTING);
    gluUnProject(wdx - 8, wdy - 8, wdz, MvMatrix, PMatrix, vp,
      @wtx, @wty, @wtz);
    glRasterPos3f(wtx, wty, wtz);
      gluUnProject(wdx + 10, wdy, wdz, MvMatrix, PMatrix, vp,
        @wtx, @wty, @wtz);
      glRasterPos3f(wtx, wty, wtz);
      glListBase(FontGL);
      glCallLists(Length(Name), GL_UNSIGNED_BYTE, Pointer(Name));
  glEnable(GL_LIGHTING);  
end;

{
function  TAnimClip.GetAnimFrame(Name: string):TAnimInfo;
var
  i,m:integer;
begin
  i:=FNamesObj.IndexOf(Name);
  if (i>-1) then
        Result:=FAnimInfo[FNamesObj.IndexOf(Name)];
end; }


function LineFacet(p1,p2:TXYZ;Axis:TAxis;var p:TXYZ;wd,wd0:TXYZ):boolean;
var
   d:real;
   denom,mu,length:real;
   n,pa,pb,pc:TXYZ;//,pa1,pa2,pa3
begin
   result:=FALSE;
    p.x:=0;p.y:=0;p.z:=0;
    pa.x:=0;pa.y:=0;pa.z:=0;
   case Axis of
   Axis_X: begin    pb.x:=1;pb.y:=0;pb.z:=0;    pc:=wd; end;
   Axis_XY: begin    pb.x:=1;pb.y:=0;pb.z:=0;    pc.x:=0;pc.y:=1;pc.z:=0; end;
   Axis_Y: begin    pb.x:=0;pb.y:=1;pb.z:=0;    pc:=wd;  end;
   Axis_YZ: begin    pb.x:=0;pb.y:=1;pb.z:=0;    pc.x:=0;pc.y:=0;pc.z:=1; end;
   Axis_Z: begin    pb.x:=0;pb.y:=0;pb.z:=1;    pc:=wd; end;
   Axis_XZ: begin    pb.x:=1;pb.y:=0;pb.z:=0;    pc.x:=0;pc.y:=0;pc.z:=1; end;
   Axis_XYZ: begin  pb:=wd;  pc:=wd0;end;
   end;
   //* Calculate the parameters for the plane */
   n.x := (pb.y - pa.y)*(pc.z - pa.z) - (pb.z - pa.z)*(pc.y - pa.y);
   n.y := (pb.z - pa.z)*(pc.x - pa.x) - (pb.x - pa.x)*(pc.z - pa.z);
   n.z := (pb.x - pa.x)*(pc.y - pa.y) - (pb.y - pa.y)*(pc.x - pa.x);
   //Normalize(n);
   length := Sqrt(n.x*n.x+n.y*n.y+n.z*n.z);
   n.x:= n.x/length;
   n.y:= n.y/length;
   n.z:= n.z/length;

   d := - n.x * pa.x - n.y * pa.y - n.z * pa.z;

   //* Calculate the position on the line that intersects the plane */
   denom := n.x * (p2.x - p1.x) + n.y * (p2.y - p1.y) + n.z * (p2.z - p1.z);
   if (ABS(denom) < 1.0E-8)        //* Line and plane don't intersect */
     then exit;
   mu := - (d + n.x * p1.x + n.y * p1.y + n.z * p1.z) / denom;
   if (mu < 0) or( mu > 1)  //* Intersection not along line segment */
      then exit;
  p.x := p1.x + mu * (p2.x - p1.x);
  p.y := p1.y + mu * (p2.y - p1.y);
  p.z := p1.z + mu * (p2.z - p1.z);
   case Axis of
   Axis_X:begin p.y:=0;p.z:=0;end;
   Axis_Y:begin p.x:=0;p.z:=0;end;
   Axis_Z:begin p.y:=0;p.x:=0;end;
   end;
   result:=TRUE;
end;

procedure GetProjectVert(X,Y:real;axis:TAxis;var p:TXYZ);
var
  p1,p2,wd,wd0,wd1:TXYZ;
  vp: TVector4i;
  PrMatrix, VmMatrix: TGLMatrixd4;
begin
    glGetIntegerv(GL_VIEWPORT, @vp);
    glGetDoublev(GL_MODELVIEW_MATRIX, @VmMatrix);
    glGetDoublev(GL_PROJECTION_MATRIX, @PrMatrix);
   case axis of
   Axis_Y,Axis_X,Axis_Z,Axis_XYZ:
        begin
        wd.x:=0;   wd.y:=0;   wd.z:=0;
        gluProject(wd.x, wd.y, wd.z, VmMatrix, PrMatrix, vp,
        @wd.x, @wd.y, @wd.z);
        gluUnProject(wd.x, wd.y+10, wd.z, VmMatrix, PrMatrix, vp,
        @wd0.x, @wd0.y, @wd0.z);
        gluUnProject(wd.x+10, wd.y, wd.z, VmMatrix, PrMatrix, vp,
        @wd1.x, @wd1.y, @wd1.z);
        if axis=Axis_XYZ then
        wd:=wd0 else begin
        wd.x:=(wd0.x+wd1.x)/2;
        wd.y:=(wd0.y+wd1.y)/2;
        wd.z:=(wd0.z+wd1.z)/2;
                        end;
        end;
   end;

    gluUnProject(X, Y, 0, VmMatrix, PrMatrix, vp,
    @p1.x, @p1.y, @p1.z);
    gluUnProject(X, Y, 1, VmMatrix, PrMatrix, vp,
    @p2.x, @p2.y, @p2.z);
//   case axis of
//   Axis_Y,Axis_X,Axis_Z: begin
//    test1:=LineFacet(p1,p2,axis, p,wd0);
//    test2:=LineFacet(p1,p2,axis, p0,wd1);
  //  if (p.x<>p0.x) and (p.y<>p0.y) and (p.z<>p0.z) then
  //  p:=p0;test1:=test2;
//    if not test1 then p:=p0;
 //   end;
 //  else
   LineFacet(p1,p2,axis, p,wd,wd1);
  // end;
 end;





function CreateVector(A, B: TVer): TVer;
  //Функция создает вектор из двух точек A,B.
  //АВ = (В.х-А.х,В.y-А.y,В.z-А.z)
begin
  Result[0] := B[0] - A[0];
  Result[1] := B[1] - A[1];
  Result[2] := B[2] - A[2];
end;

function VectorProduct(A, B: TVer): TVer;
  //Векторное произведение
begin
  Result[0] := A[1] * B[2] - B[1] * A[2];
  Result[1] := A[2] * B[0] - B[2] * A[0];
  Result[2] := A[0] * B[1] - B[0] * A[1];
end;

function GetLength(pn:Tver):Real;
begin
Result:=Sqrt(pn[0] * pn[0] + pn[1] * pn[1] + pn[2] * pn[2]);
end;

procedure Normalise(var pn: Tver);
var
  Length: Real;
begin
  Length := GetLength(pn);
  pn[0] := pn[0] / Length;
  pn[1] := pn[1] / Length;
  pn[2] := pn[2] / Length;
end;

function GenNormal(idx:integer;Face:AFace;Vert:AVer):Tver;
var
n,pa,pb,pc:Tver;
begin
        pa:=Vert[Face[idx][0]];
        pb:=Vert[Face[idx][1]];
        pc:=Vert[Face[idx][2]];
        n :=  VectorProduct(CreateVector(pa,pb),CreateVector(pa,pc));
        Normalise(n);
result:=n;
end;

function GenNormals(Face:AFace;Vert:AVer):AVer;
var
NumFace,NumVert,i,j:integer;
FaceNorm:TVer;
NormalCount:ATexures;
     {   procedure TestVector(var Ver:TVer;Norm:TVer);
        begin
        if GetLength(Ver)>0.5 then
         begin
         Ver[0]:=(Ver[0]+Norm[0])/2;
         Ver[1]:=(Ver[1]+Norm[1])/2;
         Ver[2]:=(Ver[2]+Norm[2])/2;
         end else
         Ver:=Norm;  
        end;           }
        procedure VertAdd(var Ver:TVer;Norm:Tver);
        begin
         Ver[0]:=Ver[0]+Norm[0];
         Ver[1]:=Ver[1]+Norm[1];
         Ver[2]:=Ver[2]+Norm[2];
        end;
begin
// высчитать нормаль для грани
// применить ко всем точкам
NumFace:=Length(Face);
NumVert:=Length(Vert);
SetLength(Result,NumVert);
SetLength(NormalCount,NumVert);
for i:=0 to NumFace-1 do
        begin
        FaceNorm:=GenNormal(i,Face,Vert);
        for j:=0 to 2 do begin
                VertAdd(Result[Face[i][j]],FaceNorm);
                NormalCount[Face[i][j]]:=NormalCount[Face[i][j]]+1;
                end;
        end;
for i:=0 to NumVert-1 do
        for j:=0 to 2 do
          Result[i][j]:=Result[i][j]/NormalCount[i];
end;


// 3ds File Format


//------------------------
const
CHUNK_RGBF                = $0010;  // float4 R; float4 G; float4 B
CHUNK_RGB                 = $0011; // int1 R; int1 G; int B
// Linear color values (gamma = 2.2?)
CHUNK_LINRGB              = $0012; // int1 R; int1 G; int B
CHUNK_LINRGBF             = $0013; // float4 R; float4 G; float4 B
CHUNK_INT_PERCENTAGE      = $0030;
CHUNK_PERCENTF            = $0031;  // float4  percentage

CHUNK_VERSION             = $0002;
CHUNK_3DSVERSION          = $0003;
CHUNK_HEAD                = $0006;
CHUNK_MAIN                = $4D4D; // [-] сцена
  CHUNK_OBJMESH           = $3D3D; // [-] всяческие объекты
  CHUNK_MESH_VERSION      = $3D3E;
    CHUNK_OBJBLOCK        = $4000; // [+] объект
      CHUNK_TRIMESH       = $4100; // [-] trimesh-объект
        CHUNK_VERTLIST    = $4110; // [+] список вершин
        CHUNK_FACELIST    = $4120; // [+] список граней
        CHUNK_FACEMAT     = $4130; // [+] материалы граней
        CHUNK_MAPLIST     = $4140; // [+] текстурные координаты
        CHUNK_TRMATRIX    = $4160; // [+] матрица перевода
      CHUNK_CAMERA        = $4700; // [+] объект-камера
  CHUNK_MATERIAL          = $AFFF; // [-] материал
    CHUNK_MATNAME         = $A000; // [+] название материала
    CHUNK_MAT_AMBIENT     = $A010;
    CHUNK_MAT_DIFFUSE     = $A020;
    CHUNK_MAT_SPECULAR    = $A030;
    CHUNK_MAT_SHININESS   = $A040;
    CHUNK_MAT_SHIN2PCT    = $A041;
    CHUNK_MAT_TRANSPARENCY= $A050;
    CHUNK_MAT_XPFALL      = $A052;
    CHUNK_MAT_REFBLUR     = $A053;
    CHUNK_MAT_SHADING     = $A100;
    CHUNK_MAT_SELF_ILPCT  = $A084;
    CHUNK_MAT_XPFALLIN    = $A08A;
    CHUNK_MAT_WIRESIZE    = $A087;


    CHUNK_TEXTURE         = $A200; // [-] текстура материала
      CHUNK_MAPFILE       = $A300; // [+] имя файла текстуры
CHUNK_KEYFRAMER           = $B000; // [-] информация об анимации
  CHUNK_TRACKINFO         = $B002; // [-] поведение объекта
    CHUNK_TRACKFRAMETIME  = $B009;
    CHUNK_TRACKSCENANAME  = $B00A;
    CHUNK_TRACKOBJNAME    = $B010; // [+] название этого объекта
    CHUNK_TRACKDUMMYNAME  = $B011; // [+] название этого объекта
    CHUNK_TRACKPIVOT      = $B013; // [+] центр вращения объекта
    CHUNK_TRACKPOS        = $B020; // [+] траектория объекта
    CHUNK_TRACKROTATE     = $B021; // [+] траектория вращения
    CHUNK_TRACKSCALE      = $B022; // [+] размер
                                    //     объекта
  CHUNK_TRACKCAMERA       = $B003; // [-] поведение камеры
    CHUNK_TRACKFOV        = $B023; // [+] поведение FOV камеры
    CHUNK_TRACKROLL       = $B024; // [+] поведение roll камеры
  CHUNK_TRACKCAMTGT       = $B004; // [-] поведение "цели" камеры

type
T3dsMaterial = class
     Name :String;
     NameLen:integer;
     Color :Cardinal;
     DifColor:Cardinal;
     SpeColor:Cardinal;
     Trans :Integer;
     TextureLen:Integer;
     TextName:String;
     TextNameLen:Integer;
     constructor Create;
    // destructor Destroy;
     function GetMaterialLen(Texture:Boolean):Dword;
 end;

constructor T3dsMaterial.Create;
begin
  inherited Create;
  Name:='';
   TextName:='';
end;

function T3dsMaterial.GetMaterialLen(Texture:Boolean):Dword;
begin
 NameLen:=Length(Name)+1;
 TextureLen:=0;
    if Texture then begin
    TextNameLen:=Length(TextName)+1;
    TextureLen:=CHUNK_HEAD+CHUNK_HEAD+TextNameLen+8;
   end;
 Result := CHUNK_HEAD+CHUNK_HEAD+NameLen+14+15+15+15+TextureLen;
end;

 //подститываем длинны chunk'ов
function TMesh.GetChunkObjLen(Texture:Boolean):Dword;
var
 i:integer;
begin
  MaxFace := Length(Face);
   FacesMat:=0;
  if Attribute.Material.use then
   for i:=0 to Length(Materials)-1 do
    FacesMat:=FacesMat+CHUNK_HEAD+2+2*Length(Materials[i])+Length(MaterialsName[i])+1;
  TextCoordlen:=0;
  FacesLen := CHUNK_HEAD+2+8*MaxFace+FacesMat;
  MaxVert := Length(Vert);
if Texture then TextCoordlen:=CHUNK_HEAD+2+8*MaxVert;
  VertsLen := CHUNK_HEAD+2+12*MaxVert;
  TrimeshLen := CHUNK_HEAD+VertsLen+FacesLen+TextCoordlen;
  NameLen := Length(ChName)+1;
  ObjBlockLen := CHUNK_HEAD+NameLen+TrimeshLen;
  Result := ObjBlockLen;
end;


procedure TMesh.SaveAs3DS(FileName: string);
var
  s:string;
  VirtualBufer: TMemoryStream;
  i,k: Integer;
 version_len,ObjMeshLen, KeyFramesLen,MaterialLen,
 main_len,v: Integer;
// Name:PChar;
 MolelsLen:integer;
//------------
 MatData: T3dsMaterial;
 Textures:boolean;

 procedure WriteChunk(CHUNK_ID:Word; ChunkLen:DWord);
 begin
        VirtualBufer.Write(CHUNK_ID,2);
        VirtualBufer.Write(ChunkLen,4);
 end;

 function CutString(s:String):String ;
  var i:integer;
 begin
  if Length(s)>10 then setlength(s,10);
  for i:=1 to Length(s) do
  if s[i]=' ' then s[i]:='_';
  result:=s;
 end;

 procedure WriteChunkObject(ChObj:TMesh);
 var i,j,v,zero:integer;
 begin

 // LogFile.WriteLog(ChObj.Name);
  //------------------
  WriteChunk(CHUNK_OBJBLOCK,ChObj.ObjBlockLen);
  VirtualBufer.Write(Pchar(ChObj.ChName)^,ChObj.NameLen);
  //------------------
   WriteChunk(CHUNK_TRIMESH,ChObj.TrimeshLen);
   //------------------
    WriteChunk(CHUNK_VERTLIST,ChObj.VertsLen);
    VirtualBufer.Write(ChObj.MaxVert,2);
    for i:=0 to ChObj.MaxVert-1 do
        for j:=0 to 2 do  VirtualBufer.Write(ChObj.Vert[i][j],4);
     //-----------------
    if Textures then begin
    WriteChunk(CHUNK_MAPLIST,ChObj.TextCoordlen);
    VirtualBufer.Write(ChObj.MaxVert,2);
    for i:=0 to ChObj.MaxVert-1 do
        for j:=0 to 1 do  VirtualBufer.Write(ChObj.TextCoord[i][j],4);
    end;
     //-----------------
    WriteChunk(CHUNK_FACELIST,ChObj.FacesLen);
    VirtualBufer.Write(ChObj.MaxFace,2);
    zero := 7;
    for i:=0 to ChObj.MaxFace-1 do begin
     VirtualBufer.Write(ChObj.Face[i][0],2);
     VirtualBufer.Write(ChObj.Face[i][1],2);
     VirtualBufer.Write(ChObj.Face[i][2],2);
     VirtualBufer.Write(zero,2);
    end;

    for i:=0 to Length(ChObj.Materials)-1 do
    begin
    WriteChunk(CHUNK_FACEMAT,CHUNK_HEAD+2+2*Length(ChObj.Materials[i])+Length(ChObj.MaterialsName[i])+1);
    VirtualBufer.Write(Pchar(ChObj.MaterialsName[i])^,Length(ChObj.MaterialsName[i])+1);
    v:=Length(ChObj.Materials[i]);
    VirtualBufer.Write(v,2);
    for j:=0 to v-1 do
         VirtualBufer.Write(ChObj.Materials[i][j],2);
    end;

 end;


procedure  WriteChunkMaterial(Mat:T3dsMaterial);
var i:word;
  begin
   WriteChunk(CHUNK_MATNAME,CHUNK_HEAD+Mat.NameLen);
     VirtualBufer.Write(Pchar(Mat.Name)^,Mat.NameLen);
   WriteChunk(CHUNK_MAT_AMBIENT,15);//
     WriteChunk(CHUNK_RGB,9);
      VirtualBufer.Write(Mat.Color,3);
   WriteChunk(CHUNK_MAT_DIFFUSE,15);//
     WriteChunk(CHUNK_RGB,9);
      VirtualBufer.Write(Mat.DifColor,3);
   WriteChunk(CHUNK_MAT_SPECULAR,15);//
     WriteChunk(CHUNK_RGB,9);
      VirtualBufer.Write(Mat.SpeColor,3);
   WriteChunk(CHUNK_MAT_TRANSPARENCY,14);//
     WriteChunk(CHUNK_INT_PERCENTAGE,8);
      VirtualBufer.Write(Mat.Trans,2);
   if Textures then begin
   WriteChunk(CHUNK_TEXTURE,Mat.TextureLen);//
     WriteChunk(CHUNK_INT_PERCENTAGE,8);
     i:=50;      VirtualBufer.Write(i,2);
     WriteChunk(CHUNK_MAPFILE,CHUNK_HEAD+Mat.TextNameLen);
     VirtualBufer.Write(Pchar(Mat.TextName)^,Mat.TextNameLen);
   end;
//    CHUNK_TEXTURE         = 0xA200; // [-] текстура материала
 //     CHUNK_MAPFILE       = 0xA300; // [+] имя файла текстуры
  end;

   function GetLast(TreeChild:TtreeNode):TTreeNode;
   begin
    if TreeChild.GetLastChild=nil then result:=TreeChild
    else result:=(GetLast(TreeChild.GetLastChild));
   end;

begin
  VirtualBufer := TMemoryStream.Create;
  Textures:=false;
  MaterialLen:=0;
  MolelsLen:=0;
// сам процесс конвертирования

  ChName:=CutString(Name);
if Attribute.Material.use then begin
  Textures:=Attribute.Texture > 0;
     MatData:=T3dsMaterial.Create;
     MatData.Name := 'mat';
     MatData.Color := Color256_4(Attribute.Material.Abi);
     MatData.DifColor := Color256_4(Attribute.Material.Dif);
     MatData.SpeColor := Color256_4(Attribute.Material.Spe);
     MatData.Trans := 0;

   SetLength(Materials,1);
 SetLength(MaterialsName,1);
 k:=Length(Face);
 SetLength(Materials[0],k);
 for i:=0 to k-1 do
        Materials[0][i]:=i;
 MaterialsName[0]:='mat';


  if Textures then   begin
        s := Format('#%d.tga', [Attribute.TextureId]);
        CntrArr[Attribute.TextureId].SaveTga(s, But.XImage, But.XImageLab);
        MatData.TextName := s;
  end;

  MaterialLen:=MatData.GetMaterialLen(Textures);
end;

  MolelsLen:=GetChunkObjLen(Textures);

  version_len := CHUNK_HEAD + 4;
  ObjMeshLen :=CHUNK_HEAD+version_len+ MaterialLen  + MolelsLen;
  KeyFramesLen:=0;
  main_len := CHUNK_HEAD+version_len + ObjMeshLen +KeyFramesLen;

 //-----------------
 WriteChunk(CHUNK_MAIN,main_len);
 //-----------------
 WriteChunk(CHUNK_VERSION,version_len);
 v :=CHUNK_3DSVERSION;   VirtualBufer.Write(v,4);
 //------object-----------
 WriteChunk(CHUNK_OBJMESH,ObjMeshLen);
  //-----------------
  WriteChunk(CHUNK_MESH_VERSION,version_len);
  v :=CHUNK_3DSVERSION;
  VirtualBufer.Write(v,4);
 //-------material----------
 if Attribute.Material.use then begin
   WriteChunk(CHUNK_MATERIAL,MatData.GetMaterialLen(Textures));
    WriteChunkMaterial(MatData);
 end;
  //--------mesh---------
     WriteChunkObject(self);

// Конец конвертирования

  VirtualBufer.SaveToFile(FileName);
  VirtualBufer.Free;

  MatData.Free;
end;

const MaxSingle: single = 1E34;
GeomZero: single = 1E-5;

procedure TMesh.UpdateMesh(XCntr: TContainer);
var
p,p2,p1,NewPoint,NewPoint2:pointer;
x,k,Num,j:integer;
FaceCntr,VertexCntr,NormalCntr,ColorCntr,TextureCntr,WeightCntr:integer;
VertC : AVer;
CurIndx:integer;
  i, VertN, IndexNum,VertexNum,Count3dsFace, Count3dsPoints,CName: Integer;
  fOne:Single;
  val:Integer;
  VB: TMemoryStream;
  Size:Integer;
  Strip:Boolean;
  InxFace:IFace;
begin

if XCntr.Xtype=XCollisionGeometry then
begin
/////////
  VB := TMemoryStream.Create;
  p2 :=  XCntr.GetPoint;
  Inc(Longword(p2), 4*3);
  XCntr.CopyBufTo(VB,p2); // запись

  IndexNum := TestByte128(p2);
    MaxFace:=0;
    for i:=0 to IndexNum-1 do begin
      if MaxFace<Word(p2^) then MaxFace:=Word(p2^);
      Inc(Longword(p2), 2);
    end;
    Inc(MaxFace);
    VertexNum:=TestByte128(p2);
    VertN:=VertexNum div MaxFace;
    Inc(Longword(p2), VertexNum*4);
  p1:=p2;

  IndexNum := Length(Face);
  VertexNum:= Length(Vert);
  Count3dsFace := IndexNum * VertN;
  Count3dsPoints := VertexNum * VertN;
/////////////
   fOne:=1.0;
   val:=0;
  // пишем индексы
  WriteXByte(VB, Count3dsFace);
  if VertN=4 then
  begin

    for j := 0 to IndexNum - 1 do
    begin
      VB.Write(val,2);
      VB.Write(Face[j], 6);
    end;
    // пишем вертексы
    WriteXByte(VB, Count3dsPoints);
    for j := 0 to VertexNum - 1 do
    begin
      VB.Write(Vert[j], 12);
      VB.Write(fOne,4);
    end;

  end
  else
  begin

    for j := 0 to IndexNum - 1 do
      VB.Write(Face[j], 6);
    // пишем вертексы
    WriteXByte(VB, Count3dsPoints);
    for j := 0 to VertexNum - 1 do
      VB.Write(Vert[j], 12);

  end;

  // остаточные данные
    XCntr.CopyBufFrom(VB,p1);
    XCntr.WriteBuf(VB);
    VB.Free;
end;


if XCntr.Xtype=XShape then begin
      p1 := XCntr.GetPoint;
      x := Byte(p1^);
      Inc(Longword(p1), 4);
      CurIndx:=TestByte128(p1); // XSimpleShader
      if CntrArr[CurIndx].Xtype=XSimpleShader then
      begin
      p2 := CntrArr[CurIndx].GetPoint;
      k := TestByte128(p2);
      for x := 1 to k do
        begin
        CurIndx:=TestByte128(p2); // XOglTextureMap
        if CntrArr[CurIndx].Xtype=XOglTextureMap then
                begin
                p := CntrArr[CurIndx].GetPoint;
                Inc(Longword(p), 4);
                Inc(Longword(p), 4 * 4);
                CurIndx := TestByte128(p);// XImage
                if CntrArr[CurIndx].Xtype=XImage then
                        CntrArr[CurIndx].ImportXImage(Attribute.TGAName);
                end;
        end;

      k := TestByte128(p2);
      for x := 1 to k do begin
         CurIndx:=TestByte128(p2); //XMaterial
         if CntrArr[CurIndx].Xtype=XMaterial then
              begin
       //       p2 := Pointer(Longword(StrArray[CurIndx].point) + 3);
                if Attribute.Material.use then begin

                CntrArr[CurIndx].NewCopy;
                p := CntrArr[CurIndx].GetPoint;
                Move(Attribute.Material.Abi[0], p^, 4 * 4);
                Inc(Longword(p), 4 * 4);
                Move(Attribute.Material.Dif[0], p^, 4 * 4);
                Inc(Longword(p), 4 * 4);
                Move(Attribute.Material.Spe[0], p^, 4 * 4);
                Inc(Longword(p), 4 * 4);
               { Move(p2^, Material.Emi[0], 4 * 4);
                Inc(Longword(p2), 4 * 4);
                Move(p2^, Material.Shi, 4);  }

                end;
              end;
      end;

      end;
      CurIndx:=TestByte128(p1); //XIndexedTriangleSet
      // Добавить поддержку XIndexedTriangleStripSet !!!
      Strip:= (CntrArr[CurIndx].Xtype=XIndexedTriangleStripSet);
      if (CntrArr[CurIndx].Xtype=XIndexedTriangleSet) or Strip then
      begin
      CntrArr[CurIndx].NewCopy;
      p2 := CntrArr[CurIndx].GetPoint;
    // get Faces
      if Strip then begin
        Inc(Longword(p2));
        InxFace:=FaceToStrip(Face);
        MaxFace := Length(InxFace);
        Move(MaxFace, p2^, 2);
        Inc(Longword(p2),2);
        FaceCntr := TestByte128(p2);   //5  XIndexSet
        Inc(Longword(p2), 8);
      end
      else
      begin
        FaceCntr := TestByte128(p2);   //5  XIndexSet
        Inc(Longword(p2), 4);
        Move(MaxFace, p2^, 2);
        Inc(Longword(p2), 4);
      end;

      if CntrArr[FaceCntr].Xtype=XIndexSet then
      begin
        if Strip then
        begin
          Num := Length(InxFace);
          CntrArr[FaceCntr].GetXMem(Num * 2 + 8);
          p := CntrArr[FaceCntr].GetPoint;
          WriteXByteP(p, Num);
          Move(InxFace[0], p^, Num*2);
          Inc(Longword(p), Num*2);
        end  else
        begin
          Num := Length(Face);
          CntrArr[FaceCntr].GetXMem(Num * 6 + 8);
          p := CntrArr[FaceCntr].GetPoint;
          WriteXByteP(p, Num * 3);
          for j := 0 to Num - 1 do
          begin
            Move(Face[j], p^, 6);
            Inc(Longword(p), 6);
          end;
        end;
        CntrArr[FaceCntr].CutSize(p);
      end;
    // get Vertex
        VertexCntr := TestByte128(p2);  //2   XCoord3fSet
      if CntrArr[VertexCntr].Xtype=XCoord3fSet then
                CntrArr[VertexCntr].WriteXArray(@Vert[0], Length(Vert), 12);
    // get Normal
        NormalCntr := TestByte128(p2);   //3  XNormal3fSet
      if CntrArr[NormalCntr].Xtype=XNormal3fSet then
              // WriteXArray(NormalCntr, @Vert[0], Length(Vert), 12);
              CntrArr[NormalCntr].WriteXArray(@Normal[0], Length(Normal), 12);
    // get Colors
        ColorCntr := TestByte128(p2);
      if CntrArr[ColorCntr].Xtype=XCoord3fSet then
    begin
      SetLength(VertC,0);
      SetLength(VertC,Length(Vert));
      CntrArr[ColorCntr].WriteXArray(@VertC[0], Length(VertC), 12);
    end;

      if CntrArr[ColorCntr].Xtype=XColor4ubSet then
    begin
      k:=Length(Vert);
      CntrArr[ColorCntr].FillColor(k,255);
    end;
    // get TextureCoord
        TextureCntr := TestByte128(p2);  //4   XTexCoord2fSet
      if CntrArr[TextureCntr].Xtype=XTexCoord2fSet then
                CntrArr[TextureCntr].WriteXArray(@TextCoord[0], Length(TextCoord), 8);

        WeightCntr  := TestByte128(p2);

      end;
end;
end;


procedure TMesh.Load3DS(FileName: string);
//function Open3DSModel(FileName:string;var ObjArray3D:TObjArray3D):boolean;
var
  VirtualBufer: TMemoryStream;
  ChankID, ChunkLength,ver:integer;
  Ch:char;
  Mesh3ds:TMesh;
  LenChunk:integer;
  CurChunkLen:integer;

  Color,MaxUV:cardinal;

  procedure    ReadChunk(var ID,Length:integer);
  begin
     ID:=0;
     VirtualBufer.ReadBuffer(ID, 2);
     VirtualBufer.ReadBuffer(Length, 4);
  end;

  procedure NextChunk;
  begin
  if VirtualBufer.Seek(ChunkLength-CHUNK_HEAD,soFromCurrent)=VirtualBufer.Size then exit;
  end;

  function NowChunk(Chunk_ID:integer):boolean;
  begin
  Result:=(ChankID=Chunk_ID);
  end;

  procedure ReadNextChunk;
  begin
  ReadChunk(ChankID,ChunkLength);
  end;

  function FindChunk(Chunk_ID:integer):boolean;
  begin
  Result:=false;
  while not NowChunk(Chunk_ID) do
    begin
    ReadNextChunk;
    if not NowChunk(Chunk_ID) then NextChunk;
    end;
  Result:=true;
  end;


  function GenChunkName():string;
  var
  s:String;
  begin
     S:='';
      Repeat
            VirtualBufer.ReadBuffer(Ch, 1);//Name of Object;
            S := S + Ch;
      until Ch = #0;
      result:=copy(s,0,Length(s)-1);
  end;

begin
Mesh3ds:=TMesh.Create(CntrArr);

// читаем блок, и все его состовляющие, пока не попадется нужное.
  VirtualBufer := TMemoryStream.Create;
  VirtualBufer.LoadFromFile(FileName);
  ReadChunk(ChankID,ChunkLength); // CHUNK_MAIN
//  if ChunkLength<>VirtualBufer.Size
  ReadChunk(ChankID,ChunkLength);//CHUNK_VERSION
  VirtualBufer.Read(ver,4);//version
  ReadChunk(ChankID,LenChunk);   // CHUNK_OBJMESH
  if not NowChunk(CHUNK_OBJMESH) then begin VirtualBufer.Free; exit; end;

  ReadNextChunk; //CHUNK_MESH_VERSION
  VirtualBufer.Read(ver,4);//version
  ReadNextChunk;
// загружаем 3ds файл в привычную структуру
// после загрузки пробегаемся по контейнету замещая данные
// если данных не хватает (нормали/цвета) создаем пустышку или генерируем
// генерация происходит так:
// 1. ищем все грани которые ссылаются на точку
// 2. выбираем для точки нормаль, среднюю с нормалям всех граней

if NowChunk(CHUNK_MATERIAL) then begin
CurChunkLen:=VirtualBufer.Position+ChunkLength;
Mesh3DS.Attribute.Material.use:=true;

while VirtualBufer.Position<CurChunkLen do
begin
ReadNextChunk;

if NowChunk(CHUNK_MATNAME) then   begin
 Mesh3DS.Attribute.Material.Name:=GenChunkName();
 ReadNextChunk;
 end;

Color:=$ffffffff;
if NowChunk(CHUNK_MAT_AMBIENT) then
     if FindChunk(CHUNK_RGB) then begin
     VirtualBufer.ReadBuffer(Color,3);
     Mesh3DS.Attribute.Material.Abi:=Color4_256(Color);
     ReadNextChunk;
     end;
if NowChunk(CHUNK_MAT_DIFFUSE) then
     if FindChunk(CHUNK_RGB) then begin
     VirtualBufer.ReadBuffer(Color,3);
     Mesh3DS.Attribute.Material.Dif:=Color4_256(Color);
     ReadNextChunk;
     end;
if NowChunk(CHUNK_MAT_SPECULAR) then
     if FindChunk(CHUNK_RGB) then begin
     VirtualBufer.ReadBuffer(Color,3);
     Mesh3DS.Attribute.Material.Spe:=Color4_256(Color);
     ReadNextChunk;
     end;
 // CHUNK_MAT_SHININESS
if NowChunk(CHUNK_TEXTURE) then
        if FindChunk(CHUNK_MAPFILE)then begin
        Mesh3DS.Attribute.TGAName:=GenChunkName();
        ReadNextChunk;
        end;
if not NowChunk(CHUNK_OBJBLOCK) then NextChunk;
end; end;

while //VirtualBufer.Position<LenChunk
   FindChunk(CHUNK_OBJBLOCK) //CHUNK_MATERIAL
     //читаем объекты
     do begin

     // для начала только один
     // считываем имя
     Mesh3DS.Name:=GenChunkName();  //CHUNK_OBJBLOCK

    FindChunk(CHUNK_TRIMESH);
    FindChunk(CHUNK_VERTLIST);
     Mesh3DS.MaxVert:=0;
     VirtualBufer.ReadBuffer(Mesh3DS.MaxVert,2);
//     Array_3DS:=nil;
     SetLength(Mesh3DS.Vert,Mesh3DS.MaxVert);
     VirtualBufer.ReadBuffer(Mesh3DS.Vert[0],sizeof(TVer)*Mesh3DS.MaxVert);
     ReadNextChunk;
     if NowChunk(CHUNK_MAPLIST) then
        begin
        MaxUV:=0;
        VirtualBufer.ReadBuffer(MaxUV,2);
        SetLength(Mesh3DS.TextCoord,MaxUV);
        VirtualBufer.ReadBuffer(Mesh3DS.TextCoord[0],sizeof(Tpnt)*MaxUV);
        ReadNextChunk;
        end;
     // создаем массив Face с по таблице индексов.
   if not NowChunk(CHUNK_FACELIST)then NextChunk;
   FindChunk(CHUNK_FACELIST); //CHUNK_FACELIST
   Mesh3DS.MaxFace:=0;
   VirtualBufer.ReadBuffer(Mesh3DS.MaxFace,2);

//   FaceArray_3DS:=nil;
   SetLength(Mesh3DS.Face,Mesh3DS.MaxFace);
   VirtualBufer.ReadBuffer(Mesh3DS.Face[0],Sizeof(TFace)*Mesh3DS.MaxFace);
   Break;
end;

// find CHUNK_OBJMESH, CHUNK_OBJBLOCK ,CHUNK_TRIMESH,CHUNK_VERTLIST,CHUNK_FACELIST
    VirtualBufer.Free;
    Mesh3DS.Normal:=GenNormals(Mesh3DS.Face,Mesh3DS.Vert);
    Mesh3DS.UpdateMesh(CntrArr[Indx]);

Mesh3ds.Free;

end;


procedure TMesh.ReadVCFile(FileName: string);
var
VirtualBufer: TMemoryStream;
Buf:Pointer;
Num,i:Integer;
begin
   VirtualBufer:=TMemoryStream.Create;
   VirtualBufer.LoadFromFile(FileName);
   VirtualBufer.Read(Num,4);
   SetLength(Vert, Num);
   for i := 0 to Num - 1 do
      VirtualBufer.Read(Vert[i], 4 * 3);
   VirtualBufer.Read(Num,4);
    SetLength(Face, num);
    for i := 0 to Num - 1 do
      VirtualBufer.Read(Face[i], 2 * 3);
   VirtualBufer.Read(Num,4);
   SetLength(Color, Num*3);
   for i := 0 to Num*3 - 1 do
      begin
        VirtualBufer.Read(Color[i], 3);
        Color[i][3] := 255;
      end;
   VirtualBufer.Free;
end;

procedure TMesh.TestApplyVC(VCMesh: TMesh);
var
Num, Num2,i, j, i1,i2,i3, j1, j2 , j3:Integer;
UpdateColor:boolean;
    function TestV(const v1,v2:TVer):boolean;
    begin
     Result:= ((abs(v1[0]-v2[0])<0.001) and
     (abs(v1[1]-v2[1])<0.001) and
      (abs(v1[2]-v2[2])<0.001) ) ;
    end;

begin
  UpdateColor:=false;
  Num:=Length(Face);
  Num2:=Length(VCMesh.Face);
  // нужно сверить точку с каждой из 3 вершин
  if Length(Color)>0 then
  for i:=0 to Num-1 do
   begin
     i1:=Face[i][0];
     i2:=Face[i][1];
     i3:=Face[i][2];
     for j:=0 to Num2-1 do begin
     j1:=VCMesh.Face[j][0];
     j2:=VCMesh.Face[j][1];
     j3:=VCMesh.Face[j][2];
     if TestV(Vert[i1],VCMesh.Vert[j1]) and
       TestV(Vert[i2],VCMesh.Vert[j2]) and
        TestV(Vert[i3],VCMesh.Vert[j3])
      then
        begin
        Color[i1]:=VCMesh.Color[j*3+0];
        Color[i2]:=VCMesh.Color[j*3+1];
        Color[i3]:=VCMesh.Color[j*3+2];
        UpdateColor:=true;
        break;
        end;
     if TestV(Vert[i2],VCMesh.Vert[j1]) and
       TestV(Vert[i3],VCMesh.Vert[j2]) and
        TestV(Vert[i1],VCMesh.Vert[j3])
      then
        begin
        Color[i2]:=VCMesh.Color[j*3+0];
        Color[i3]:=VCMesh.Color[j*3+1];
        Color[i1]:=VCMesh.Color[j*3+2];
        UpdateColor:=true;
        break;
        end;
    if TestV(Vert[i3],VCMesh.Vert[j1]) and
       TestV(Vert[i1],VCMesh.Vert[j2]) and
        TestV(Vert[i2],VCMesh.Vert[j3])
      then
        begin
        Color[i3]:=VCMesh.Color[j*3+0];
        Color[i1]:=VCMesh.Color[j*3+1];
        Color[i2]:=VCMesh.Color[j*3+2];
        UpdateColor:=true;
        break;
        end;

     end;

   end;

 if UpdateColor and (ColorIndx<>0) then
      CntrArr[ColorIndx].WriteXArray(@Color[0], Length(Color), 4);

 for i := 0 to Length(Childs) - 1 do
    if Childs[i] <> nil then
      Childs[i].TestApplyVC(VCMesh);
end;



end.
