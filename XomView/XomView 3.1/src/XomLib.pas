unit XomLib;

interface

uses OpenGLx, IdGlobal, SysUtils, Classes, Dialogs, Windows,Contnrs,
  ComCtrls, StdCtrls, ExtCtrls, Graphics, Buttons, Valedit, XTrackPanel, OpenGLLib,
  Math, XomCntrLib, XomMeshLib//, BitmapsUnit
  ;


type TXomType = packed record
        aType:array [0..3] of Char;
        bType:integer;
        Size:integer;
        nZero:integer;
        GUID:TGUID;
        Name:array [0..31] of Char;
        end;

type TXomHandle = packed record
        Head:array[0..3]of char;
        nType:Longword;
        nZero:array [0..3] of Integer;
        NumTypes:integer;
        MaxCount:integer;
        RootCount:integer;
        nZero2:array [0..6] of Integer;
        //------
        TypesInfo: array of TXomType;
        Guid:array[0..3]of char;
        GuidZero:array [0..2] of Integer;
        SCHM:array[0..3]of char;
        SCHMType:integer;
        SCHMZero:array [0..1] of Integer;
        Strs:array[0..3]of char;
        SizeStrs:Integer;
        LenStrs:Integer;
        StringTable:TStringList;
        end;

  TBuildData = record
        Name:String;
        StrIndex:String;
        Pos:TVector;
        Star:Boolean;
        BuildType:Byte;
        BonusType:Byte;
        BuildingName:String;
        PlayerID:Integer;
        Orientation:Single;
        Connections:Byte;
        end;

  TWFBuilds = record
        Count:Integer;
        Changed:Boolean;
        NewString:Boolean;
        Cntr:TContainer;
        Node:TTreeNode;
        Pnt1:Pointer;
        Pnt2:Pointer;
        Items: array of TBuildData;
        end;


  TTransView = record
    xpos, ypos, zpos: GLfloat;
    xrot, yrot, zrot: GLfloat;
    zoom, Per: GLfloat;
  end;

  T3DModel = record
    glList: Integer;
    SizeBox: TBox;
    Texture: Integer;
    Matrix: TMatrix;
    Mult: Boolean;
  end;
  A3DModels = array of T3DModel;

  TIndex = record
    ID: Integer;
    Values: array [0..12] of Integer;
  end;

  TStEdByte = record
    //sbyte,ebyte:smallint;
    id: Integer;
  end;

type
  TUVData = class
    constructor Create;
    destructor Destroy; override;
  private
    FLength: integer;
    function GetLength: Integer;
    procedure SetLength(const Value: Integer);
  public
     UVCoord0: ATCoord;
     UVCoord1: ATCoord;
     property Length:Integer read GetLength write SetLength; 
     procedure DrawUV(Bitmap:TBitmap);
  end;

type
  TXom = class
    constructor Create;
    destructor Destroy; override;
  public
    Mesh3D: TMesh;
//    AnimClips: TAnimClips;
    LastXImage: TContainer;
    LastUV: TUVData;
    ViewUV: Boolean;
    LastCounter: Integer;
    XGraphMode:boolean;
    InsertIndex: Integer;
    BaseNew: Integer;
    TreeArray: array of Boolean;
    TreeCount: Integer;
    saidx: Integer;
    BaseNode: TTreeNode;
    BaseCntr: TContainer;
    Buf: Pointer;
    XomHandle:TXomHandle;
    CntrArr:TContainers;
    OldStringTable:TStringList;
    NewStringTable:TStringList;
    ReBuild:boolean;
    AsW3D:boolean;
    Loading:boolean;
    UpdateAnimFlag:boolean;
    WFBuilds:TWFBuilds;

    function GetXType(XName:PChar;var XType:XTypes):Boolean;
    procedure LoadXomFileName(FileName: string; var OutCaption: string; ShowProgress:boolean=true);
    procedure AddToXDataBank(XCntr:TContainer;ResIndex:Integer;Name:String);
    procedure FixXDataBank(XCntr:TContainer);
    procedure InsertXom(NewXom: TXom; XCntr:TContainer; InsertMode: Boolean; CntrSet:TCntrSet);
    procedure InsertXGraphSetXom(NewXom: TXom; XCntr:TContainer; InsertMode: Boolean; CntrSet:TCntrSet);
    procedure SaveXom(SaveDialog: TSaveDialog);
    procedure XomImportObj(InNode, OutNode: TTreeNode);

    function BuildTree( XCntr: TContainer; Tree: TTreeView; Node: TTreeNode): XTypes;
    function ReadXContainer(p:pointer;NType:XTypes; var s:string; var IsCtnr:Boolean):Pointer;
    function AddClassTree(XCntr: TContainer; TreeView: TTreeView;
      TreeNode: TTreeNode): TTreeNode;
    procedure SelectClassTree(XCntr: TContainer; var Mesh: TMesh);

    procedure InitXomHandle;
    procedure SaveXomHandle(var p:pointer);
    procedure ReSizeTypes;
    procedure ReCalcCntr;
    procedure UpdateStringTable(ValueList:TValueListEditor);
    procedure LoadValueString(ValueList:TValueListEditor);
    procedure SaveStringTable(var p:Pointer;LStrings:TStringList);
    procedure WriteXName(var Memory:TMemoryStream; Name:String);
    function GetStr128(var p:Pointer;CurCntr:TContainer=nil): string;
    function DelFromTo(DelFrom,DelTo:Pointer;CurCntr:TContainer):pointer;
    function GetIdx128(var p:Pointer;CurCntr:TContainer=nil):Integer;
    function GetSize128(var p:Pointer;CurCntr:TContainer=nil):Integer;
    procedure ReBuildXomHandle(NewXom:TXom; Cntrs: TContainers);
    procedure BuildXomHandle(var Handle:TXomHandle;Cntrs:TContainers);
    procedure ReBuildTypeTree(TypeTree:TTreeView);
    function CopyType(XType:XTypes):TXomType;
    procedure SetSizeType(XType:XTypes;Size:integer);
    procedure SetType(Index:Integer;NewGUID:TGUID;XType:XTypes);
    procedure ClearSizeType;
    procedure TestClearType(XType:XTypes);
    function SearchType(XType:XTypes; var index:Integer):Boolean;
    function IsContainer(Data:Pointer):TContainer;
    function IsCntrSet(Data:Pointer):TCntrSet;
    procedure FortsBuildUpdate;
    function MakeBuildCopy(Index:integer):Integer;
    procedure BuildTestGrid(var pos:TXYZ);
    procedure DrawBuild(Build:TBuildData;select:boolean=false);

    function CreateNewCntr(XType:XTypes;NewName:String):TContainer;
  end;


//function GetFullName(Name:String):String;



type
  TStringArray = array of string;

function StringListFromStrings(const Strings: array of string;Size:integer): TStringList;

function ToTime(milisec: Longword): Single;

procedure oglAxes;
procedure oglGrid(GridMax: Integer);
procedure Light(var Color: Color4D);


  procedure UpdateDummyTree(TV:TTreeView;Mesh:TMesh);
  procedure UpdateDummyTreeMenu(AddItem:TMenuItem);
  procedure UpdateAnimTree(TV:TTreeView);
  procedure UpdateAnimTreeMenu(AddItem,DeleteItem:TMenuItem);

{type
 XTypesValue = record
 Str: PChar;
 Values : Array of XValTypes;
 end;    }

const
 APPVER = 'XomView v.3.1 by AlexBond';

  MaxMaps    = 10000;
  MaxType    = 1000;
  MODEL3DBUF = 10000;

  FontGL  = 2000;
  MaxDeph = 100000.0;  // максимальная глубина

  Blendval: array[0..7] of Integer =
    (GL_ZERO, GL_ONE,
    GL_SRC_COLOR, GL_ONE_MINUS_SRC_COLOR,
    GL_DST_COLOR, GL_ONE_MINUS_DST_COLOR,
    GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

  objAxes          = 1;
  objTarget        = 2;
  objGrid          = 3;
  objBox           = 4;
  objOrbitX        = 5;
  objOrbitY        = 6;
  objOrbitZ        = 7;
  objCollGeo       = 10;
  objTriangleGeo   = 11;

  ambient: color4d = (0.1, 0.1, 0.1, 1.0);
  //  ambient2: color4d = ( 0.1, 0.1, 0.1, 1.0 );
  l_position: color4d    = (0.0, 32.0, 0.0, 1.0);
  mat_diffuse: color4d   = (0.6, 0.6, 0.6, 1.0);
  mat_specular: color4d  = (1.0, 1.0, 1.0, 1.0);
  tmp_fog_color: color4d = (0.0, 0.2, 0.5, 1.0);
  mat_shininess: GLfloat = 50.0;

  ATypePosition = $0102;
  ATypeRotation = $0103;
  ATypeScale    = $0104;
  AType2DTex    = $0401;
  ATypeReScale  = $0904;
  ATypeTexture  = $1100;
  ATypeChilds   = $0100;
  ATypeX        = 0;
  ATypeY        = 1;
  ATypeZ        = 2;

  TORAD   = Pi / 180;
  RADIANS = 180 / Pi;

  ZereVector: Tver = (0, 0, 0);
  TestVert: Tver   = (0.0, 0, 0);

  nVn  = #13#10;

var
  Xom: TXom;
  GrafKeys:array of TGrafKey;
  EdMode,AnimEd:Boolean;
  SelectKey,SKey: PKeyFrame;
  SelectKdata:PKeyData;
  SelectType:Integer;
  SelectObjName:String;
  ShowGraph:Boolean;
//  AnimClip: TAnimClip;
  MAxis,AAxis:TAxis;
    PSelect, PTarget: TPoint;
    wd,wdup:TXYZ;
  SelectObj, SelectObjOn: Integer;
  Bbitpoint, bBitPoint2: Pointer;
  StarPoint,BuildPoint,LightPoint,PyramidPoint: Pointer;


  AnimTimer: THRTimer;
  AnimClips:TAnimClips;
  CurAnimClip:TAnimClip;
  BaseClip:TAnimClip;

  MaxAnimTime: Single;

  Active3DModel: Integer = MODEL3DBUF;
  TransView,TVModel: TTransView;
  GLwidth, GLheight: Integer;
  position2: color4d = (0.0, 0.0, 0.0, 1.0);
  MainBox: TBox;
  NTexture: Integer = 0;
  LastTexture: Integer = 0;
  XomImport, XomReplace,ImageReady, Xom3DReady, AnimReady: Boolean;
  SelectMode,
  MoveMode, MoveReady,
  RotateMode, RotateReady,
  ScaleMode, ScaleReady,
  Particle_mode,
  ZoomActivePox, TextureB, FillMode, MoveFirts,
  ScaleFirts,RotateFirts,
  CtrlMove, Ctrl,ShiftOn, FullSize, ChillMode: Boolean;
  ChillMax:Integer;
  AddClick,DeleteClick:TNotifyEvent;
  AddMesh,DeleteMesh:TNotifyEvent;
//  StrArray: XConteiners;
//      CntrArr:XContainers;
  ActiveMesh:TMesh;
  ObjMatrix:TMatrix;

  TEXTUREBASE:Integer = 0;
var
  ActiveMatrix, TempMatrix: TMatrix;
  NKey:Tver;
  MovePoxPos,  ScalePoxPos,RotatePoxPos:Tver;
  p:TXYZ;
  theta,alpha,beta,gamma:single;
  
implementation

// конвертирует цвет из RGBA в текущий цвет для GL

{function GetFullName(Name:String):String;
begin
Result:=Name;
end; }

procedure UpdateAnimTreeMenu(AddItem,DeleteItem:TMenuItem);
var
Item1,Item2,Item3:TMenuItem;
Item1d,Item2d:TMenuItem;
ObjMesh:TMesh;
SL:TStringList;

        function MakeItem(Item:TMenuItem;Name:String):TMenuItem;
        begin
        Result := TMenuItem.Create(AddItem);
        Result.Caption := Name;
        Item.Add(Result);
        end;



        procedure AddObjMenu(Mesh:TMesh;Skip:Boolean=False);
        var
        kData:PkeyData;
        i:integer;
        KeyType:TTypeKey;
                    function TestXYZItems(Item:TMenuItem;ktype:integer):TMenuItem;
                    begin
                    Result:=nil;
                    case Byte(ktype shr 24) of
                        ATypeX: Result:=MakeItem(Item,'X');
                        ATypeY: Result:=MakeItem(Item,'Y');
                        ATypeZ: Result:=MakeItem(Item,'Z');
                    end;
                    end;

                function TestTypeItem(kType:Integer):TMenuItem;

                begin
                kData:=CurAnimClip.FindKeyNameType(Mesh.Name,kType);
                if kData=nil then begin
                        if kType=ATypeTexture then
                                Result := MakeItem(Item1,'Childs')
                        else
                        Result := TestXYZItems(Item2,kType);
                        KeyType.objname:=Mesh.Name;
                        KeyType.ktype:=kType;
                        Result.KeyType:=KeyType;
                        Result.OnClick:=AddClick;
                        end else begin
                        if kType=ATypeTexture then
                                Result := MakeItem(Item1d,'Childs')
                        else
                        Result := TestXYZItems(Item2d,kType);
                        Result.KeyType:=kData.KeyType;
                        Result.OnClick:=DeleteClick;
                        end;
                end;
        begin
        if (not Skip)or( (Mesh.XType='SS')and Mesh.Attribute.Texture2D) then begin
        Item1 := MakeItem(AddItem,Mesh.Name);
        Item1d := MakeItem(DeleteItem,Mesh.Name);
        SL.Add(Mesh.Name);
        if Mesh.Transform.TransType<>TTNone then begin
                Item2 := MakeItem(Item1,'Position');
                Item2d := MakeItem(Item1d,'Position');
                        Item3:=TestTypeItem(ATypePosition+(ATypeX shl 24));
                        Item3:=TestTypeItem(ATypePosition+(ATypeY shl 24));
                        Item3:=TestTypeItem(ATypePosition+(ATypeZ shl 24));
                        if Item2.Count=0 then Item2.Destroy;
                        if Item2d.Count=0 then Item2d.Destroy;
                Item2 := MakeItem(Item1,'Rotate');
                Item2d := MakeItem(Item1d,'Rotate');
                        Item3:=TestTypeItem(ATypeRotation+(ATypeX shl 24));
                        Item3:=TestTypeItem(ATypeRotation+(ATypeY shl 24));
                        Item3:=TestTypeItem(ATypeRotation+(ATypeZ shl 24));
                         if Item2.Count=0 then Item2.Destroy;
                         if Item2d.Count=0 then Item2d.Destroy;
                Item2 := MakeItem(Item1,'Scale');
                Item2d := MakeItem(Item1d,'Scale');
                        Item3:=TestTypeItem(ATypeScale+(ATypeX shl 24));
                        Item3:=TestTypeItem(ATypeScale+(ATypeY shl 24));
                        Item3:=TestTypeItem(ATypeScale+(ATypeZ shl 24));
                         if Item2.Count=0 then Item2.Destroy;
                         if Item2d.Count=0 then Item2d.Destroy;
                Item2 := MakeItem(Item1,'ReScale');
                Item2d := MakeItem(Item1d,'ReScale');
                        Item3:=TestTypeItem(ATypeReScale+(ATypeX shl 24));
                        Item3:=TestTypeItem(ATypeReScale+(ATypeY shl 24));
                        Item3:=TestTypeItem(ATypeReScale+(ATypeZ shl 24));
                         if Item2.Count=0 then Item2.Destroy;
                         if Item2d.Count=0 then Item2d.Destroy;
                end;
        if Mesh.Attribute.Texture2D then  begin
                Item2 := MakeItem(Item1,'Texture');
                Item2d := MakeItem(Item1d,'Texture');
                        Item3:=TestTypeItem(AType2DTex+(ATypeX shl 24));
                        Item3:=TestTypeItem(AType2DTex+(ATypeY shl 24));
                         if Item2.Count=0 then Item2.Destroy;
                         if Item2d.Count=0 then Item2d.Destroy;
                        end;

        if Mesh.XType='CS' then begin
                Item2 := TestTypeItem(ATypeTexture);
                end;
        if Item1.Count=0 then Item1.Destroy;
        if Item1d.Count=0 then Item1d.Destroy;
                end;

        for i := 0 to Length(Mesh.Childs) - 1 do
                begin
                if (Mesh.Childs[i] <> nil)
                and (SL.IndexOf(Mesh.Childs[i].Name)=-1)
                and(Mesh.Childs[i].XType<>'BO')
                then
                        AddObjMenu(Mesh.Childs[i],
                        (Mesh.Childs[i].XType='BM')
                        or(Mesh.Childs[i].XType='SH')
                        or(Mesh.Childs[i].XType='SK')
                        or(Mesh.Childs[i].XType='SS')
                        );
                 end;
        end;


begin
ObjMesh:=Xom.Mesh3D;
SL:=TStringList.Create;
AddItem.Clear;
DeleteItem.Clear;
AddObjMenu(ObjMesh,True);
SL.Free;
end;

procedure UpdateDummyTreeMenu(AddItem:TMenuItem);
var
i:integer;
Item1,Item2,Item3:TMenuItem;
ObjMesh:TMesh;
SL:TStringList;

        function MakeItem(Item:TMenuItem;Name:String):TMenuItem;
        begin
        Result := TMenuItem.Create(AddItem);
        Result.Caption := Name;
        Item.Add(Result);
        end;


begin
//ObjMesh:=Xom.Mesh3D;
SL:=TStringList.Create;
AddItem.Clear;

 for i:=0 to Xom.CntrArr.Count-1 do
  if Xom.CntrArr[i].Xtype=XMeshDescriptor then
  begin
 // XMeshDesctiptor собрать все типы
 // создать массив из Mesh3D объектов

  Item1:=MakeItem(AddItem, Xom.CntrArr[i].Name);
  Item1.CntrIdx:=i;
  Item1.OnClick:= AddMesh;
   // NewXom.SelectClassTree(NewXom.CntrArr[i],Mesh);
//  Index:=StrMesh.AddObject(NewXom.CntrArr[i].Name,Mesh);
 // XMeshFound:=true;

  end;

SL.Free;
end;

procedure UpdateDummyTree(TV:TTreeView;Mesh:TMesh);
var
MainNode:TTreeNode;
N,i:integer;
        procedure MashGetDymmy(CurMesh:TMesh;CurNode:TTreeNode);
        var i,n:integer;
        Node:TTreeNode;
        begin
        if CurMesh.XType='GR' then begin
                Node:=TV.Items.AddChild(CurNode,CurMesh.Name);
                Node.ImageIndex:=5;
                Node.SelectedIndex:=5;
                Node.Data:=CurMesh;
        end
        else
                Node:=CurNode;
                N:=Length(CurMesh.Childs);
                for i:=0 to N-1 do begin
                        if CurMesh.Childs[i]<>nil then
                        MashGetDymmy(CurMesh.Childs[i],Node);
                end;
        end;

begin
if Mesh<>nil then
begin
        TV.Items.Clear;

        MainNode:=TV.Items.Add(nil,'Dummys');
        MainNode.ImageIndex:=4;
        MainNode.SelectedIndex:=4;
        // 5 dummy
        // 2 mesh
        N:=Length(Mesh.Childs);
        for i:=0 to N-1 do begin
        if Mesh.Childs[i]<>nil then
        MashGetDymmy(Mesh.Childs[i],MainNode);
        end;
MainNode.Expand(true);
end;
end;

Procedure UpdateAnimTree(TV:TTreeView);
var
MainNode,Node,Node2,Node3,Node4:TTreeNode;
N,i,ii,nn,KType:integer;
Test:boolean;
s:string;
begin
if CurAnimClip<>nil then
with CurAnimClip do begin
TV.Items.Clear;
ChillMode:=False;
        MainNode:=TV.Items.Add(nil,Name);
        MainNode.ImageIndex:=9;
        MainNode.SelectedIndex:=9;
        N:=Length(Keys);
        for i:=0 to N-1 do begin
          Test:=false;
          If (ActiveMesh<>nil) and (ActiveMesh.Name<>Keys[i].keytype.objname) then
          continue;
          if (i>0) then Test:=(Keys[i].keytype.objname = Keys[i-1].keytype.objname);
          if  Test then else
          begin
          Node:=TV.Items.AddChild(MainNode,Keys[i].keytype.objname);
          Node.ImageIndex:=5;
          Node.SelectedIndex:=5;
         // if ActiveMesh=nil then
          Node.Data:=Xom.Mesh3D.GetMeshOfName(Keys[i].keytype.objname);

          end;
          if Test and (word(Keys[i].keytype.ktype)=word(Keys[i-1].keytype.ktype)) then
          else begin

          case Word(Keys[i].keytype.ktype) of
          ATypePosition: begin
                Node2:=TV.Items.AddChild(Node,'Position');
                end;
          ATypeRotation: begin
                Node2:=TV.Items.AddChild(Node,'Rotate');
                end;
          ATypeScale: begin
                Node2:=TV.Items.AddChild(Node,'Scale');
                end;
          ATypeReScale: begin
                Node2:=TV.Items.AddChild(Node,'Rescale');
                end;
          ATypeTexture,ATypeChilds: begin
                Node2:=TV.Items.AddChild(Node,'Childs');
                if ActiveMesh<>nil then begin
                                ChillMode:=true;
                                ChillMax:=Length(ActiveMesh.Childs);
                                end;
                end;
          AType2DTex: begin
                Node2:=TV.Items.AddChild(Node,'Texture');
                end;
          end;
          end;
          if ActiveMesh=nil then Continue;
          if (SelectType<>0) and  (SelectType<>Keys[i].keytype.ktype) then
           Continue;

          case Byte(Keys[i].keytype.ktype shr 24) of
          ATypeX: Node3:=TV.Items.AddChild(Node2,'X');

          ATypeY: Node3:=TV.Items.AddChild(Node2,'Y');

          ATypeZ: Node3:=TV.Items.AddChild(Node2,'Z');
          end;
          Node3.ImageIndex:=7;
          Node3.SelectedIndex:=7;
          if ActiveMesh<>nil then begin
                Node3.Data:=Pointer(Keys[i].keytype.ktype);
                kType:=Word(Keys[i].keytype.ktype);

                if (kType=AType2DTex) or
                (kType=ATypeTexture) or
                (kType=ATypeChilds) or
                (ActiveMesh.Transform.TransType=TTNone)
                then EdMode:=false else EdMode:=true;

                end;
          nn:=Length(Keys[i].Data);
          for ii:=0 to nn-1 do begin
                s:=format('%.2fs = %.2f',[
                Keys[i].Data[ii][4],Keys[i].Data[ii][5]]);
                Node4:=TV.Items.AddChild(Node3,s);
                Node4.ImageIndex:=8;
                Node4.SelectedIndex:=8;
               if ActiveMesh<>nil then Node4.Data:=@Keys[i].Data[ii];
             end;
        end;
MainNode.Expand(true);
end;
end;



constructor TXom.Create;
begin
  inherited Create;
  UpdateAnimFlag:=true;
  CntrArr := TContainers.Create(true);
  Mesh3D := TMesh.Create(CntrArr);
  LastUV:=TUVData.Create;
end;


procedure TXom.WriteXName(var Memory:TMemoryStream; Name:String);
var
    Index,i:integer;
begin
        Index:=-1;
    for i:=0 to XomHandle.StringTable.Count-1 do
      if XomHandle.StringTable[i]=Name then
                begin Index:=i; break; end;

    if Index=-1 then begin
        Index:=XomHandle.StringTable.Add(Name);
    end;
    WriteXByte(Memory,Index);
end;



function TXom.GetSize128(var p:Pointer;CurCntr:TContainer=nil):Integer;
var
indx: Integer;
oldP:Pointer;
begin
oldP:=p;
indx:= TestByte128(p);
if CurCntr<>nil then
begin
CurCntr.CntrSet:=TCntrSet.Create;
CurCntr.CntrSet.Point:=oldP;
CurCntr.CntrSet.Size:=indx;
CurCntr.CntrSet.Cntr:=CurCntr;
end;
result:= indx;
end;

function TXom.GetIdx128(var p:Pointer;CurCntr:TContainer=nil):Integer;
var
indx, NewIndex: Integer;
oldP:Pointer;
OldPnt,Pnt,NewPnt:Pointer;
VirtualBufer: TMemoryStream;
_Size,offset:Integer;
insertmode,deletemode:boolean;
begin
if ReBuild then
begin
oldP:=p;
 // считываем индекс
indx := TestByte128(p);
 // меняем индекс
// нужно найти старый индекс и изменить на новый
// ошибка может быть при одинаковых индексах
// нужна дополнительная проверка;
insertmode:=false;
//deletemode:=false;
if (indx<>0) and (not CurCntr.isNew) and (indx=InsertIndex) then begin
        NewIndex:=CntrArr.FindNewIndex(BaseNew,true);
        LastCounter:=NewIndex;
        insertmode:=true;
        end
        else
        NewIndex:=CntrArr.FindNewIndex(indx,CurCntr.isNew);
// Если нужно вставить индекс, то нужно сместить все старые данные
//  для этого создадим переменную, и если индекс равен ей
// то вставляем новый индекс, для этого нужно его обнаружить...
if ((NewIndex<>0) and ((insertmode) or(indx<>NewIndex)))then begin
// если они не равны
 // записываем индекс в память
 // создать копию
 if NewIndex=-1 then begin
  //      if (indx>0) and (indx=DelIndex) then deletemode:=true;
 NewIndex:=0; // удаление ненайденых ссылок
 end;

 Pnt:=oldP;   // точка на значение
 VirtualBufer := TMemoryStream.Create;
 offset:=CurCntr.CopyBufTo(VirtualBufer,Pnt);

// if deletemode then
  //      DelIndex:=0
  //      else
  WriteXByte(VirtualBufer,NewIndex);

 if insertmode then begin
        InsertIndex:=0;
          if XGraphMode then TestByte128(Pnt);
        end
        else
        TestByte128(Pnt);

 CurCntr.CopyBufFrom(VirtualBufer,Pnt);
 CurCntr.WriteBuf(VirtualBufer);
 VirtualBufer.Free;
 // изменяем p на новое
  p:=Pointer(Longword(CurCntr.Point)+offset);
 // if deletemode then
 //       NewIndex:=GetIdx128(p,CurCntr)
//  else
        NewIndex:=TestByte128(p);
end;
result:=NewIndex;
end
else
result:= TestByte128(p);
end;

function TXom.GetStr128(var p:Pointer;CurCntr:TContainer=nil): string;
var
indx, NewIndex: Integer;
oldP:Pointer;
OldPnt,Pnt,NewPnt:Pointer;
VirtualBufer: TMemoryStream;
_Size,offset:Integer;
olds:string;
begin
if ReBuild then
begin
oldP:=p;
 // считываем строку
indx := TestByte128(p);
 olds:='';

 if CurCntr.isNew then begin
 if (indx < NewStringTable.Count) and (indx <> 0) then
      olds := NewStringTable[indx];
 end else
 begin
 if (indx < OldStringTable.Count) and (indx <> 0) then
      olds := OldStringTable[indx];
 end;

 Result:=olds;
 if (olds<>'') and (indx<XomHandle.StringTable.Count) and
 (XomHandle.StringTable[indx]=olds) then
 else
 begin
 // Если индексы не равны, то добавляем ее в массив
 // записываем индекс в память

 VirtualBufer := TMemoryStream.Create;
 Pnt:=oldP;   // точка на значение
 offset:=CurCntr.CopyBufTo(VirtualBufer,Pnt);
 WriteXName(VirtualBufer,olds);
 TestByte128(Pnt);
 CurCntr.CopyBufFrom(VirtualBufer,Pnt);
 CurCntr.WriteBuf(VirtualBufer);
 VirtualBufer.Free;

 // изменяем p на новое
  p:=Pointer(Longword(CurCntr.Point)+offset);
  NewIndex:=TestByte128(p);
 end
end
else
begin
indx := TestByte128(p);
 with XomHandle do
 if (indx < StringTable.Count) and (indx <> 0) then
      Result := StringTable[indx]
  else
      Result := '';
end;
end;

function TXom.DelFromTo(DelFrom,DelTo:Pointer;CurCntr:TContainer):pointer;
var
oldP:Pointer;
OldPnt,Pnt,NewPnt:Pointer;
VirtualBufer: TMemoryStream;
_Size,offset:Integer;
begin
 VirtualBufer := TMemoryStream.Create;
 offset:=CurCntr.CopyBufTo(VirtualBufer,DelFrom);
 CurCntr.CopyBufFrom(VirtualBufer,DelTo);
 CurCntr.WriteBuf(VirtualBufer);
 VirtualBufer.Free;
 result:=Pointer(Longword(CurCntr.Point)+offset);
end;

function TXom.BuildTree( XCntr: TContainer; Tree: TTreeView; Node: TTreeNode): XTypes;
var
  i , Len: Integer;
  // TempNode:TTreeNode;

  procedure AddNode(Name: string);
  begin
    Node := Tree.Items.AddChild(Node, Name);
    Node.Data := XCntr;
  end;
begin
  if XCntr=nil then exit;
  Result := XCntr.Xtype;
  Len:=Length(XCntr.Childs);
  case XCntr.Xtype of
XGroup:
    begin
      AddNode('Group');
      if Len=1 then Node.Text := 'Dummy';
      for i := 0 to Len - 1 do
      begin
        if BuildTree(XCntr.Childs[i], Tree, Node) = XShape then
          Node.Text := 'GroupShape';
      end;
    end;
XBinModifier:
    begin
      AddNode('BinModifier');
      for i := 0 to Len - 1 do
        BuildTree(XCntr.Childs[i], Tree, Node);
    end;
XSkin:
    begin
      AddNode('Skin');
      for i := 0 to Len - 1 do
        BuildTree(XCntr.Childs[i], Tree, Node);
    end;
XInteriorNode:
    begin
      AddNode('Node');
      for i := 0 to Len - 1 do
        BuildTree(XCntr.Childs[i], Tree, Node);
    end;
XTransform, XMatrix:
      AddNode('Matrix');
XOglTextureMap:
      Tree.Items.AddChild(Node, 'Texture').Data := XCntr.Childs[0];
XMaterial:
      AddNode('Material');
XColor4ubSet:
      //       if ColorUse then
      AddNode('Color');
XIndexSet:
      AddNode('Face');
XIndexedTriangleSet:
    begin
      AddNode('Obj');
      for i := 0 to Len - 1 do
        BuildTree(XCntr.Childs[i], Tree, Node);
    end;
XShape:
    begin
      AddNode('Shape');
      for i := 0 to Len - 1 do
        BuildTree(XCntr.Childs[i], Tree, Node);
    end;
XBone:
      AddNode('Bone');
XWeightSet:
      AddNode('Weight');
XSkinShape:
    begin
      AddNode('SkinShape');
      for i := 0 to Len - 1 do
        BuildTree(XCntr.Childs[i], Tree, Node);
    end;
XSimpleShader:
    begin
      for i := 0 to Len - 1 do
        BuildTree(XCntr.Childs[i], Tree, Node);
    end;
XCoord3fSet:
      AddNode('Vert');
XNormal3fSet:
      AddNode('Norm');
XTexCoord2fSet:
      AddNode('TextCoord');
{else
 if InNode.GetNext<>nil then
  BuildTree(XomTree,Tree,InNode.GetNext,Node);  }
  end;
end;



procedure oglGrid(GridMax: Integer);
var
  i, size: Integer;
begin
  size := 5;
  glBegin(GL_LINES);
  for i := -GridMax to GridMax do
  begin
    glVertex3f(-GridMax * size, 0, i * size);
    glVertex3f(GridMax * size, 0, i * size);
    glVertex3f(i * size, 0, - GridMax * size);
    glVertex3f(i * size, 0, GridMax * size);
  end;
  glEnd;
end;

procedure oglAxes;
var 
  S: string;
begin
  glDisable(GL_LIGHTING);
  glColor3f(1, 0, 0);
  glBegin(GL_LINES);
  glVertex3f(0, 0, 0);
  glVertex3f(1, 0, 0);
  glEnd;
  glRasterPos3f(1.2, 0, 0); 
  s := 'x';
  glListBase(2000);//FontGL
  glCallLists(1, GL_UNSIGNED_BYTE, Pointer(S));
  glColor3f(0, 1, 0);
  glBegin(GL_LINES);
  glVertex3f(0, 0, 0);
  glVertex3f(0, 1, 0);
  glEnd;
  glRasterPos3f(0, 1.2, 0);
  s := 'y';
  glCallLists(1, GL_UNSIGNED_BYTE, Pointer(S));
  glColor3f(0, 0, 1);
  glBegin(GL_LINES);
  glVertex3f(0, 0, 0);
  glVertex3f(0, 0, 1);
  glEnd;
  glRasterPos3f(0, 0, 1.2);
  s := 'z';
  glCallLists(1, GL_UNSIGNED_BYTE, Pointer(S));
  glEnable(GL_LIGHTING);
end;

procedure Light(var Color: Color4D);
var
  sinX, cosX, sinY, cosY, Step: Extended;
begin
  Step := TransView.zoom;
  SinCos((TransView.yrot - 90) * Pi / 180, sinY, cosY);
  SinCos((TransView.xrot - 90) * Pi / 180, sinX, cosX);

  Color[0] := -(Transview.xpos + Step * cosY * sinX);
  Color[1] := -(Transview.ypos + Step * cosX);
  Color[2] := -(Transview.zpos + Step * sinY * sinX);
end;


procedure TXom.ReBuildTypeTree(TypeTree:TTreeView);
var
  TreeN: array of TTreeNode;
  i,j,saidx:integer;
  TreeNode: TTreeNode;
begin
  TypeTree.Items.Clear;
  TypeTree.Visible := false;
  SetLength(TreeN, XomHandle.NumTypes);

  for i := 0 to XomHandle.NumTypes-1 do begin
        TreeN[i] := TypeTree.Items.Add(nil,
                Format('%s(%d)', [XomHandle.TypesInfo[i].Name,
                XomHandle.TypesInfo[i].Size]));
        end;
  saidx:=0;
try
  for j := 0 to XomHandle.NumTypes - 1 do
        with XomHandle.TypesInfo[j] do
        if Size > 0 then
        for i := 1 to Size do
                begin
                inc(saidx);
                TreeNode := TypeTree.Items.AddChild(TreeN[j],
                        Format('%d. %s', [saidx, CntrArr[saidx].Name]));
                if saidx = XomHandle.RootCount then
                        BaseNode := TreeNode;
                TreeNode.Data := CntrArr[saidx];
                end;
 Except
      on E : Exception do
      ShowMessage(Format('Error "%s" in ReBuildTypeTree() on [%d] ', [E.ClassName,saidx]));
  end;
end;

procedure TXom.LoadXomFileName(FileName: string; var OutCaption: string;ShowProgress:boolean=true);
var
  s: string;
  sizecount, sizeoffset, i, j, MaxInx, LenSTR : Integer;
  P, p2: Pointer;
  Xi: XTypes;
  IDtest, Outpoint, IsCtnr : Boolean;
  iFileHandle: Integer;
  iFileLength: Integer;
  L ,k:longword;
  NTypes: array of XTypes;
begin

// новый код

      // открываем файл и загружаем в память.
      iFileHandle := FileOpen(FileName, fmOpenRead);
      iFileLength := FileSeek(iFileHandle,0,2);
      FileSeek(iFileHandle,0,0);

  FreeMem(Buf);

      Buf := AllocMem(iFileLength + 1);
      FileRead(iFileHandle, Buf^, iFileLength);
      FileClose(iFileHandle);

// очищаем список

  s := ExtractFileName(FileName);
  OutCaption := Format('%s - [%s]', [APPVER,s]);


//--------
      InitXomHandle;
// Считываем данные
      Move(Buf^,XomHandle,64);
// Считываем количество контерйнеров
//      XomHandle.NumTypes:=word(pointer(Longword(Buf)+24)^);
// Инициализация данных
  saidx:=0;

  // очистка контейнеров
  CntrArr.Clear;
// количество контейнеров
//      XomHandle.MaxCount:=integer(pointer(Longword(Buf)+28)^);
 //     XomHandle.RootCount:=integer(pointer(Longword(Buf)+32)^);
// Считываем индексный контейнер
      CntrArr.Count:=XomHandle.MaxCount+1;

      SetLength(XomHandle.TypesInfo,XomHandle.NumTypes);
      SetLength(NTypes, XomHandle.NumTypes);
      if ShowProgress then  begin
        But.TreeProgress.Max:=XomHandle.MaxCount;
      end;
try
// Цикл покойтейнерного считывания Названий контейнеров
      for i := 0 to XomHandle.NumTypes-1 do begin
        p:=pointer(64+i*Sizeof(TXomType)+Longword(Buf));
        Move(p^,XomHandle.TypesInfo[i],Sizeof(TXomType));
      {  XomHandle.TypesInfo[i].aType:='TYPE';
        XomHandle.TypesInfo[i].bType:=Longword(pointer(Longword(p)+4)^);
        XomHandle.TypesInfo[i].Size:=Longword(pointer(Longword(p)+8)^);
        Move(pointer(Longword(p)+16)^,XomHandle.TypesInfo[i].GUID,16);
        Move(pointer(Longword(p)+32)^,XomHandle.TypesInfo[i].Name,32); }
        if GetXType(XomHandle.TypesInfo[i].Name,Xi) then
                NTypes[i]:=Xi;

      end;

      p:=pointer(Longword(Buf)+64+XomHandle.NumTypes*Sizeof(TXomType)+16);
//Считывание с проверкой начала таблицы
      if Longword(p^)<>Ctnr2 then
      p:=pointer(16+4+Longword(p))else
      p:=pointer(4+Longword(p));

 //   STOffset:=p;

      XomHandle.SizeStrs:=Longword(p^);
      inc(Longword(p),4);

      XomHandle.LenStrs:=Longword(p^);
      inc(Longword(p),4);
  if ShowProgress then
  But.Status.Text := Format('Strings: (%d)', [XomHandle.SizeStrs]);

      //<table str>
      k:=Longword(p)+XomHandle.SizeStrs*4;
      XomHandle.StringTable.Add('');
      // заполнение таблицы имен
      for i:=0 to XomHandle.SizeStrs-2 do begin
        L:=longword(pointer(i*4+Longword(p)+4)^);
        s:=Utf8Decode(Pchar(pointer(k+L)));
       // s:=Pchar(pointer(k+L));
        XomHandle.StringTable.Add(s); //
      end;
      k:=XomHandle.LenStrs+XomHandle.SizeStrs*4;
      inc(Longword(p),k);
 // if ShowProgress then
 // But.Status.Text := Format('Strings: (%d) - (%d)', [MaxInx, LenSTR]);
      //Tree adding

  CntrArr[0]:=TContainer.Create(0,CntrArr,p);
  Outpoint := false; // вылет из памяти

  for j := 0 to XomHandle.NumTypes - 1 do
  with XomHandle.TypesInfo[j] do
  begin

    if Size > 0 then
      for i := 1 to Size do
        if not Outpoint then
        begin
          IsCtnr := true;

          if (Longword(p^) = Ctnr) then
            sizeoffset := 4
          else
            sizeoffset := 0;

          sizecount := sizeoffset;

          p2:=ReadXContainer(p,NTypes[j],s,IsCtnr);

          if not IsCtnr then
            sizecount := Longword(p2) - Longword(p);

          Inc(saidx);


          CntrArr[saidx] := TContainer.Create(saidx, CntrArr,
                                        Pointer(Longword(p) + sizeoffset));
          CntrArr[saidx].XType := NTypes[j];
          CntrArr[saidx].CTNR := (Longword(p^) = Ctnr);
          CntrArr[saidx].Name := s;

          if saidx = XomHandle.RootCount then
                BaseCntr := CntrArr[saidx];

          if (IsCtnr) then  // ищем конец контейнера

            while (Longword(Pointer(Longword(p) + sizecount)^) <> Ctnr) do
            begin
              if ((Longword(p) + sizecount - Longword(Buf)) > iFileLength) then
              begin
                Outpoint := true;
                CntrArr[saidx].size := sizecount - sizeoffset - 1;
                Exit;
              end;
              Inc(sizecount);
            end;

          CntrArr[saidx].size := sizecount - sizeoffset;

          if  ShowProgress then
             But.TreeProgress.Position:=saidx;

          p := Pointer(Longword(p) + sizecount);
        end;
  end
Except
      on E : Exception do
      ShowMessage(Format('Error "%s" in LoadXomFileName() on [%d] ', [E.ClassName,saidx]));
  end;
end;


{ TXom }

procedure TXom.InitXomHandle;
begin
XomHandle.Head:='MOIK';
XomHandle.nType:=$2000000;
XomHandle.Guid:='GUID';
XomHandle.SCHM:='SCHM';
XomHandle.SCHMType:=1;
XomHandle.Strs:='STRS';
SetLength(XomHandle.TypesInfo,0);
XomHandle.StringTable:=TStringList.Create;
end;

function TXom.SearchType(XType: XTypes;var index:Integer): Boolean;
var i:integer;
begin
Result:=false;
for i:=0 to Length(XomHandle.TypesInfo)-1 do
 if  StrLComp(XomHandle.TypesInfo[i].Name,PCharXTypes[XType],31)=0 then begin
   Index:=i;
   Result:= true;
   Break;
  end;
end;

function TXom.CopyType(XType:XTypes):TXomType;
var i:integer;
begin
if SearchType(XType,i) then begin
   Result:= XomHandle.TypesInfo[i];
   // Move(XomHandle.TypesInfo[i],Result,Sizeof(TXomType));
   Result.Size:=0;
   end;
end;

procedure TXom.SetSizeType(XType:XTypes;Size:integer);
var i:integer;
begin
if SearchType(XType,i) then
   XomHandle.TypesInfo[i].Size:=Size;
end;

procedure TXom.TestClearType(XType: XTypes);
var i,len:integer;
begin
Len:=Length(XomHandle.TypesInfo)-1;
if SearchType(XType,i) then begin
   if i <> Len then
        Move(XomHandle.TypesInfo[i+1],XomHandle.TypesInfo[i],Sizeof(TXomType)*(Len-i));
   SetLength(XomHandle.TypesInfo,Len);
   end;
end;

function TXom.IsContainer(Data:Pointer):TContainer;
begin
Result:=nil;
if (Integer(Data)>10000) and (TObject(Data) is TContainer) then
        Result:=TContainer(Data);
end;

function CSComareCntrs(Cntr1, Cntr2: TContainer): Integer;
begin
  if Cntr1.Index = Cntr2.Index then
    Result := 0
  else if Cntr1.Index > Cntr2.Index then
    Result := 1
  else
    Result := -1;
end;

procedure TXom.BuildXomHandle(var Handle:TXomHandle;Cntrs:TContainers);
var
 len, i, j, LastTypeI:integer;
 LastType:XTypes;
 XRootCntr:TContainer;
begin
// отсортируем массив контейнеров по их индексам
// запомним корень
XRootCntr:=Cntrs[0];
Cntrs.Sort(@CSComareCntrs);
Cntrs.Insert(0,TContainer.Create(0,Cntrs,nil));
// поставить количество типов, контейнера и их главного
Handle.MaxCount:=Cntrs.Count-1;
//Cntrs.Insert(0,TContainer.Create(0,Cntrs,nil));
// перестроить индексы массива контейнеров.
For i:=1 to Cntrs.Count-1 do
begin
    Cntrs[i].OldIndex:=Cntrs[i].Index;
    Cntrs[i].Index:=i;
end;
Handle.RootCount:=XRootCntr.Index; // -1?
// собрать все уникальные типы из массива контейнеров
LastTypeI:=0;
LastType:=XNone;
for i:=1 to Cntrs.Count-1 do
begin
if Cntrs[i].Xtype=LastType then begin
inc(Handle.TypesInfo[LastTypeI].Size);
end else
begin
// добавить все типы в новый массив XomHandle.TypesInfo
LastTypeI:=Length(Handle.TypesInfo);
SetLength(Handle.TypesInfo,LastTypeI+1);
LastType:=Cntrs[i].Xtype;
Handle.TypesInfo[LastTypeI]:=CopyType(LastType);
inc(Handle.TypesInfo[LastTypeI].Size);
end;
end;
Handle.NumTypes:=Length(Handle.TypesInfo);
end;

procedure TXom.ReBuildXomHandle(NewXom:TXom; Cntrs: TContainers);
var
 len, i, j, LastTypeI,InsIndx:integer;
 LastType:XTypes;
begin
// добавить все контейнеры из нового Cntrs в старый CntrsArr
// учитывая индексы
// циклом по новому пробегаемся,
for i:=1 to Cntrs.Count-1 do
begin
 // ищем такой же тип в старом
  InsIndx:=CntrArr.FoundXType(Cntrs[i].Xtype);
  if (InsIndx=0) and SearchType(Cntrs[i].Xtype,LastTypeI)
        and (LastTypeI>0) and GetXType(XomHandle.TypesInfo[LastTypeI].Name,LastType) then
         InsIndx:=CntrArr.FoundXType(LastType);
  //!!! Ошибка, мы ищем контейнеры, но если мы их уже очистили, то остались еще
  // от них типы!!!
 // если находим, ищем место где контейнеры с этим типом заканчиваются,
 // вставляем туда контейнер
  if InsIndx<>0 then
        CntrArr.Insert(InsIndx,Cntrs[i].Copy(CntrArr))
  else
  begin
 // если не находим, то создаем новый тип, и добавляем в конец контейнер.
 // ищем предварительно тип, может он уже существует.

        // если тип уже существует то удаляем его и
        // создаем новый
        TestClearType(Cntrs[i].XType);
        LastTypeI:=Length(XomHandle.TypesInfo);
        SetLength(XomHandle.TypesInfo,LastTypeI+1);
        LastType:=Cntrs[i].Xtype;
        XomHandle.TypesInfo[LastTypeI]:=NewXom.CopyType(LastType);

        CntrArr.Add(Cntrs[i].Copy(CntrArr));
  end;
end;

// пересчитываем размеры всех типов в старом файле
ReSizeTypes;
// пересчет конейтейнеров;
ReCalcCntr;
end;

procedure TXom.ReCalcCntr;
var
i:integer;
begin
// поставить количество типов, контейнера и их главного
XomHandle.MaxCount:=CntrArr.Count-1;
// перестроить индексы массива контейнеров.
For i:=1 to CntrArr.Count-1 do
begin
    CntrArr[i].OldIndex:=CntrArr[i].Index;
    CntrArr[i].Index:=i;
end;
XomHandle.RootCount:=BaseCntr.Index; //
end;

procedure TXom.XomImportObj(InNode, OutNode: TTreeNode);
var
  i, j: Integer;
  XCntr: TContainer;
  NewPoint, p: Pointer;
  Vert: AVer;
  Normal: AVer;
  Face: AFace;
  Color: AUColor;
  TextCoord: ATCoord;
  Transform: TTrans;
  Num: Integer;
  InxFace: IFace;
  Strip:Boolean;
begin
  XCntr := TContainer(OutNode.Data);
  case XCntr.Xtype of
    // XGroup:
    // XInteriorNode:
    XTransform:
    begin
      XCntr.NewCopy;
      Transform := TTrans(InNode.Data^);
      //       MatrixDecompose(XMatrix,XPos,XRot,XSize);
      p := XCntr.GetPoint;
      Move(Transform.Pos[0], p^, 4 * 3);
      Inc(Longword(p), 4 * 3);
      Move(Transform.Rot[0], p^, 4 * 3); 
      Inc(Longword(p), 4 * 3);
      Move(Transform.Size[0], p^, 4 * 3);
      Inc(Longword(p), 4 * 3);
      Inc(Longword(p), 4);
      Move(Transform.TrMatrix[1][1], p^, 4 * 3); 
      Inc(Longword(p), 4 * 3);
      Move(Transform.TrMatrix[2][1], p^, 4 * 3); 
      Inc(Longword(p), 4 * 3);
      Move(Transform.TrMatrix[3][1], p^, 4 * 3); 
      Inc(Longword(p), 4 * 3);
      Move(Transform.TrMatrix[4][1], p^, 4 * 3);
      Inc(Longword(p), 4 * 3);
    end;
    XImage:
    begin
      XCntr.ImportXImage(string(InNode.Data));
    end;
    XMaterial:
    begin
    end;
    XIndexedTriangleSet:
    begin
      XCntr.NewCopy;
      p := XCntr.GetPoint;
      TestByte128(p);
      Inc(Longword(p), 4);
      Move(InNode.Data, p^, 2); // faces
    end;
    XIndexSet:
    begin
      Face := AFace(InNode.Data^);
  {
      if Strip then
      begin
        InxFace:=FaceToStrip(Face);
        Num := Length(InxFace);
        XCntr.GetXMem(Num * 2 + 8);
        p := XCntr.GetPoint;
        WriteXByteP(p, Num);
        Move(InxFace[0], p^, Num*2);
        Inc(Longword(p), Num*2);
      end
      else  }
      begin
        Num := Length(Face);
        XCntr.GetXMem(Num * 6 + 8);
        p := XCntr.GetPoint;
        WriteXByteP(p, Num * 3);
        for j := 0 to Num - 1 do
        begin
          Move(Face[j], p^, 6);
          Inc(Longword(p), 6);
        end;
      end;

      XCntr.CutSize(p);
    end;
    // XShape:
    XCoord3fSet:
    begin
      Vert := AVer(InNode.Data^);
      XCntr.WriteXArray(@Vert[0], Length(Vert), 12);
    end;
    XNormal3fSet:
    begin
      Normal := AVer(InNode.Data^);
      XCntr.WriteXArray(@Normal[0], Length(Normal), 12);
    end;
    XColor4ubSet:
    begin
      Color := AUColor(InNode.Data^);
      XCntr.WriteXArray(@Color[0], Length(Color), 4);
    end;
    XTexCoord2fSet:
    begin
      TextCoord := ATCoord(InNode.Data^);
      XCntr.WriteXArray(@TextCoord[0], Length(TextCoord), 8);
    end;
  end;

  for i := 0 to InNode.Count - 1 do
    XomImportObj(InNode[i], OutNode[i]);
end;

function StringListCS(List: TStringList; Index1, Index2: Integer): Integer;
var 
  s1, s2: string;
begin
  //inc(sortcount);
  s1 := List.Strings[Index1];
  s2 := List.Strings[Index2];
  if s1 = s2 then 
    Result := 0 
  else if s1 > s2 then 
    Result := 1 
  else 
    Result := -1;
end;

procedure TXom.SaveXomHandle(var p:pointer);
begin
Move(XomHandle.Head,p^,16*4);
inc(integer(p),16*4);
Move(XomHandle.TypesInfo[0],p^,16*4*XomHandle.NumTypes);
inc(integer(p),16*4*XomHandle.NumTypes);
Move(XomHandle.Guid,p^,11*4);
inc(integer(p),16*3);
end;

procedure TXom.SaveStringTable(var p:Pointer;LStrings:TStringList);
var
  p1,p3,p4:pointer;
  i,j,len: Integer;
  s: string;
  s2:Utf8String;
  SortStrings:TStringList;
begin
  j := LStrings.Count-1; // нулевой индекс занят
//  p2 := VBuf;
  p4 := Pointer(Longword(p) + j * 4);  // размер таблицы индексов текста
  Len := 1;
  SortStrings:=TStringList.Create;
  LStrings.CaseSensitive:=true;
  SortStrings.Assign(LStrings);
  SortStrings.Delete(0);
  SortStrings.CustomSort(StringListCS);
  //Str Table
  for i := 0 to j - 1 do
  begin
    s  := SortStrings.Strings[i];
    LongWord(Pointer((LStrings.IndexOf(s)-1) * 4 + Longword(p))^) := LongWord(Len);
 //   Smallint(Pointer(i * 4 + Longword(p))^) := Smallint(Len);  // заполняем длинны в индексы
    p3 := Pointer(Longword(p4) + Len);
    s2:= Utf8Encode(s);
   // s2:=s;
    p1  := PChar(s2);
    Move(p1^, p3^, Length(s2));// копируем текст в пямять
    Len := Len + Length(s2) + 1;
  end;
  SortStrings.Free;
  LongWord(Pointer(Longword(p) - 12)^) := LongWord(j + 1); // пишем количество слов
  LongWord(Pointer(Longword(p) - 8)^) := LongWord(Len);  // длинна слов
  p := Pointer(Longword(p4) + Len); // прыгаем после таблицы слов
end;

procedure TXom.LoadValueString(ValueList:TValueListEditor);
var
  i,j,n: Integer;
  s,s1:string;
begin
  ValueList.Strings.Clear;
  j:=XomHandle.StringTable.Count;
 for i:=1 to j-1 do begin
          // таблица
        s := XomHandle.StringTable[i];
        s1 := Format('%.2x', [byte128(i)]);
        But.GlValueList.InsertRow(s1, (s), true)
 end;
end;

procedure TXom.UpdateStringTable(ValueList:TValueListEditor);
var
  i,j,n: Integer;
begin
  // Begin String Table
  XomHandle.StringTable.Free;
  XomHandle.StringTable := TStringList.Create;
  j:=ValueList.RowCount;
  XomHandle.StringTable.Add('');
 // LStrings.Duplicates:=dupAccept;
  for i:=1 to j-1 do
       XomHandle.StringTable.Add(ValueList.Cells[1,i]);
end;

procedure TXom.SaveXom(SaveDialog: TSaveDialog);
var
  VirtualBufer: TMemoryStream;
  p2: Pointer;

  i,j,n: Integer;
  VBufBegin,VBuf: Pointer;
  LStrings:TStringList;
begin
 // OldXom := Buf;
  if SaveDialog.Execute and (SaveDialog.FileName <> '') then
  begin
    VirtualBufer := TMemoryStream.Create;
    n := CntrArr.Count;//Length(Containers);

  VBufBegin := AllocMem(1024*1024); // берем память для строк и шапок
  VBuf := VBufBegin;
  p2:=VBuf;

  SaveXomHandle(p2);
  SaveStringTable(p2,XomHandle.StringTable);

    VBuf:=p2;
    VirtualBufer.Write(VBufBegin^, Longword(VBuf)-Longword(VBufBegin));
    FreeMem(VBufBegin);

    for i := 1 to n - 1 do
      CntrArr[i].WriteCNTR(VirtualBufer);

    if ExtractFileExt(SaveDialog.FileName)='' then SaveDialog.FileName:=SaveDialog.FileName+'.xom';
    VirtualBufer.SaveToFile(SaveDialog.FileName);
    VirtualBufer.Free;
  end;
end;

function ToTime(milisec: Longword): Single;
begin
  Result := (milisec div 60000) + ((milisec mod 60000) div 1000) / 100;
end;


procedure TXom.SelectClassTree(XCntr: TContainer; var Mesh: TMesh);
var
  x, k, k3, inx: Integer;
  p2: Pointer;
  Matrix: TMatrix;
  f: Single;
  Pos, Size, RotOrient, Rot, JointOrient: Tver;
  TempMesh: TMesh;
begin
if XCntr<>nil then
  case XCntr.Xtype of
    XGraphSet:
    begin
      if Length(XCntr.Childs)=0 then exit;
      SelectClassTree(XCntr.Childs[0], Mesh);
      if Length(XCntr.Childs) > 1 then
      begin
        if UpdateAnimFlag and (XCntr.Childs[1].Xtype = XAnimClipLibrary) and (But.AnimBox<>nil) then
        begin
        AnimClips:=nil;
        CurAnimClip:=nil;
        AnimClips:=TAnimClips.Create;
        But.AnimBox.Clear;
        AnimReady := (AnimClips.BuildAnim(XCntr.Childs[1]) > 0);

        But.AnimBox.Items.Assign(AnimClips.FStrings);
        If AnimReady then
        CurAnimClip:=AnimClips.GetItemID(0);
        But.AnimBox.ItemIndex := 0;
        end;
      end;
    end;
    XMeshDescriptor:
    begin
      SelectClassTree(XCntr.Childs[0], Mesh);
    end;
    XSpriteSetDescriptor:
    begin
      SelectClassTree(XCntr.Childs[0], Mesh);
    end;
    XDataBank:
    begin
       k:=Length(XCntr.Childs);
       for x:=0 to k-1 do
                SelectClassTree(XCntr.Childs[x], Mesh);
    end;
    XContainerResourceDetails:
    begin
      SelectClassTree(XCntr.Childs[0], Mesh);
    end;
    XBitmapDescriptor:
    begin
      SelectClassTree(XCntr.Childs[0], Mesh);
    end;
    XPsTextureReference,XPsProxyTexture:
    begin

      if (XCntr.Name = 'Diffuse') or
      (XCntr.Name = 'Texture0')or
      (XCntr.Name = 'Texture1') or
      (XCntr.Name = 'Texture2') or
      (XCntr.Name = 'Skygrad') or
      (XCntr.Name = 'Animatedtexture') or
      (XCntr.Name = 'SpriteTexture')
       then
      begin
      if Mesh<>nil then
      Mesh.Attribute.ZBuffer:=true;
   //   :=  XCntr.Name<>'Texture0';   // not work
      if ((Mesh<>nil)and(Mesh.Attribute.TextureId<>0)) then
      else
      SelectClassTree(XCntr.Childs[0], Mesh);
      end;
    end;
    XTexFont,XPsTexFont:
    begin
       p2 := XCntr.GetPoint;
       k := TestByte128(p2);
       LastUV.Length:=k;
       Move(p2^,LastUV.UVCoord0[0][0],8*k);
       Inc(Longword(p2), 8*k);
       k := TestByte128(p2);
       Move(p2^,LastUV.UVCoord1[0][0],8*k);
       Inc(Longword(p2), 8*k);
       k:=Length(XCntr.Childs);
       for x:=0 to k-1 do
                SelectClassTree(XCntr.Childs[x], Mesh);
       if ViewUV then LastUV.DrawUV(But.XImage.Picture.Bitmap);
    end;
    XImage:
    begin
      if But.ClassTree<>nil then begin
      if Xom.IsContainer(But.ClassTree.Selected.Data) = XCntr then
      begin
        ImageReady := true;
        //     FormXom.Button3.Enabled:=true;
      end;
      LastXImage := XCntr;
      if But.XImage<>nil then
      XCntr.ViewTga(But.XImage, true, But.XImageLab);
      end;
    end;
    XBlendModeGL:
    begin
      p2 := XCntr.GetPoint;
      if Mesh <> nil then
      begin
        Mesh.Attribute.Blend := true;
        Mesh.Attribute.ZBuffer:= false;
        Mesh.Attribute.BlendVal1 := Longword(p2^);
        Mesh.Attribute.BlendVal2 := Longword(Pointer(Longword(p2) + 4)^);
      end;
    end;
    XAlphaTest:
    begin
      p2 := XCntr.GetPoint;
      if Mesh <> nil then
      begin
        Mesh.Attribute.AlphaTest := Boolean(Byte(p2^));
        Inc(Longword(p2), 5);
        Mesh.Attribute.AlphaTestVal := Single(Pointer(p2)^);
        if Mesh.Attribute.AlphaTestVal=0 then Mesh.Attribute.AlphaTestVal:=1
      end;
    end;
    XCullFace:
    begin
      p2 := XCntr.GetPoint;
      if Mesh <> nil then
        Mesh.Attribute.CullFace := Boolean(Longword(p2^));
    end;
    XDepthTest:
    begin
      p2 := XCntr.GetPoint;
      if Mesh <> nil then 
        Mesh.Attribute.ZBufferFuncVal := Longword(p2^);
    end;
    XZBufferWriteEnable:
    begin
      p2 := XCntr.GetPoint;
      if Mesh <> nil then 
        Mesh.Attribute.ZBuffer := Boolean(Byte(p2^));
    end;
    XMaterial:
    begin
      p2 := XCntr.GetPoint;
      if Mesh <> nil then
        with Mesh.Attribute do
        begin
          Material.use := true;
          Move(p2^, Material.Abi[0], 4 * 4);
          Inc(Longword(p2), 4 * 4);
          Move(p2^, Material.Dif[0], 4 * 4);
          Inc(Longword(p2), 4 * 4);
          Move(p2^, Material.Spe[0], 4 * 4);
          Inc(Longword(p2), 4 * 4);
          Move(p2^, Material.Emi[0], 4 * 4);
          Inc(Longword(p2), 4 * 4);
          Move(p2^, Material.Shi, 4);
          //      Material.use:=false;
        end;
    end;
    XMatrix:
    begin
      p2 := XCntr.GetPoint;
      Move(p2^, Matrix[1][1], 4 * 3); 
      Inc(Longword(p2), 4 * 3); 
      Matrix[1][4] := 0;
      Move(p2^, Matrix[2][1], 4 * 3); 
      Inc(Longword(p2), 4 * 3); 
      Matrix[2][4] := 0;
      Move(p2^, Matrix[3][1], 4 * 3); 
      Inc(Longword(p2), 4 * 3); 
      Matrix[3][4] := 0;
      Move(p2^, Matrix[4][1], 4 * 3); 
      Inc(Longword(p2), 4 * 3); 
      Matrix[4][4] := 1;
      if Mesh <> nil then
      begin
        Mesh.Transform.TransType := TTMatrix;
        Mesh.Transform.TrMatrix := Matrix;
      end;
    end;
    XTexturePlacement2D:
    begin
      p2 := XCntr.GetPoint;
      Move(p2^, Matrix[1][1], 4 * 4);
      Inc(Longword(p2), 4 * 4);
      Move(p2^, Matrix[2][1], 4 * 4);
      Inc(Longword(p2), 4 * 4);
      Move(p2^, Matrix[3][1], 4 * 4);
      Inc(Longword(p2), 4 * 4);
      Move(p2^, Matrix[4][1], 4 * 4);
      Inc(Longword(p2), 4 * 4);
      if Mesh <> nil then
      begin
        Mesh.Attribute.Texture2D:=true;
        Mesh.Attribute.T2DMatrix:= Matrix;
      end;
    end;
    XJointTransform:
    begin
      p2 := XCntr.GetPoint;
      Move(p2^, RotOrient[0], 4 * 3);
      Inc(Longword(p2), 4 * 3);
      Move(p2^, Rot[0], 4 * 3);
      Inc(Longword(p2), 4 * 3);
      Move(p2^, Pos[0], 4 * 3); 
      Inc(Longword(p2), 4 * 3);
      Move(p2^, JointOrient[0], 4 * 3);    
      Inc(Longword(p2), 4 * 3);
      Move(p2^, Size[0], 4 * 3);
      Inc(Longword(p2), 4 * 3);
      Inc(Longword(p2), 4);
      Move(p2^, Matrix[1][1], 4 * 3);
      Inc(Longword(p2), 4 * 3);
      Matrix[1][4] := 0;
      Move(p2^, Matrix[2][1], 4 * 3);
      Inc(Longword(p2), 4 * 3); 
      Matrix[2][4] := 0;
      Move(p2^, Matrix[3][1], 4 * 3); 
      Inc(Longword(p2), 4 * 3); 
      Matrix[3][4] := 0;
      Move(p2^, Matrix[4][1], 4 * 3); 
      Inc(Longword(p2), 4 * 3); 
      Matrix[4][4] := 1;

      if Mesh <> nil then
      begin
        Mesh.xtype := 'BG';
        Mesh.Transform.Pos := Pos;
        Mesh.Transform.Rot := Rot;
        Mesh.Transform.JointOrient := JointOrient;
        Mesh.Transform.RotOrient := RotOrient;
     {   if System.Pos('root',Mesh.Name)<>-1
        then begin
        Size[0]:=1.0;
        Size[1]:=1.0;
        Size[2]:=1.0;
        end; }
        Mesh.Transform.Size := Size;

        //   MatrixDecompose(Matrix,Mesh.Transform.Pos,Mesh.Transform.Rot,Mesh.Transform.Size);
        Mesh.Transform.TransType := TTJoint;
        Mesh.BoneMatrix := Matrix;
        Mesh.Transform.TrMatrix := GetMatrix2(Pos, Rot,
          JointOrient, RotOrient, Size);
       //      Mesh.Transform.TrMatrix:=Matrix;
        f := 10;
        Mesh.SizeBox.Xmin := -Pos[0] / 2;
        Mesh.SizeBox.Ymin := -Pos[1] / 2;
        Mesh.SizeBox.Zmin := -Pos[2] / 2;
        Mesh.SizeBox.Xmax := Pos[0] / 2;
        Mesh.SizeBox.Ymax := Pos[1] / 2;
        Mesh.SizeBox.Xmax := Pos[2] / 2;
      end;
    end;
    XBone:
    begin
      //    Matrix:= Mesh.Transform.TrMatrix;

      Mesh := TMesh.Create(CntrArr);
      Mesh.xtype := 'BO';
      p2 := XCntr.GetPoint;
      //   Mesh.InvBoneMatrix:=MatrixInvert(LastMatrix);
      Move(p2^, Matrix[1][1], 16 * 4); 
      Inc(Longword(p2), 16 * 4);
      k:=Length(XCntr.Childs);
      SetLength(Mesh.Childs, k);
      for x := 0 to k - 1 do
      begin
        SelectClassTree(XCntr.Childs[x], Mesh.Childs[x]);
      end;
      //       Mesh.Transform.TransType:=TTMatrix;
      //       Mesh.Transform.TrMatrix:=Matrix;
      Mesh.InvBoneMatrix := Matrix;
      Mesh.Name := XCntr.Name;
      Mesh.Indx := XCntr.Index;
    end;
    XTransform:
    begin
      p2 := XCntr.GetPoint;
      Move(p2^, Pos[0], 4 * 3); 
      Inc(Longword(p2), 4 * 3);
      Move(p2^, Rot[0], 4 * 3); 
      Inc(Longword(p2), 4 * 3);
      Move(p2^, Size[0], 4 * 3);
      Inc(Longword(p2), 4 * 3);
      Inc(Longword(p2), 4);
      Move(p2^, Matrix[1][1], 4 * 3);
      Inc(Longword(p2), 4 * 3);
      Matrix[1][4] := 0;
      Move(p2^, Matrix[2][1], 4 * 3); 
      Inc(Longword(p2), 4 * 3); 
      Matrix[2][4] := 0;
      Move(p2^, Matrix[3][1], 4 * 3); 
      Inc(Longword(p2), 4 * 3); 
      Matrix[3][4] := 0;
      Move(p2^, Matrix[4][1], 4 * 3); 
      Inc(Longword(p2), 4 * 3); 
      Matrix[4][4] := 1;
      //  CurMatrix:=Matrix;
      if Mesh <> nil then 
      begin
        //       if (Pos[0]<>Matrix[4][1])or (Pos[1]<>Matrix[4][2])or(Pos[2]<>Matrix[4][3])then
        //       begin
        Mesh.Transform.Pos := Pos;
        Mesh.Transform.Rot := Rot;
        Mesh.Transform.Size := Size;
        //        end;
        Mesh.Transform.TrMatrix := GetMatrix(Pos, Rot, Size);
        Mesh.Transform.TransType := TTVector;
      end;
    end;
    XEnvironmentMapShader:
    begin
      SelectClassTree(XCntr.Childs[0], Mesh);
      SelectClassTree(XCntr.Childs[1], Mesh);
      SelectClassTree(XCntr.Childs[2], Mesh);
    end;
    XOglTextureMap:
    begin
      p2 := XCntr.GetPoint;
      Inc(Longword(p2), 4);
      Inc(Longword(p2), 4 * 4);
      k3 := TestByte128(p2);
      SelectClassTree(XCntr.Childs[0], Mesh); // XImage

      //Inc(NTexture);
      if Mesh <> nil then
      begin
        Mesh.Attribute.Material.use := true;
        glBindTexture(GL_TEXTURE_2D, XCntr.Index+TEXTUREBASE);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER,
          GL_LINEAR_MIPMAP_LINEAR);
        if WR then
               Mesh3D.GetTextureGL(XCntr.Childs[0])
        else Mesh.Attribute.ZBuffer := Mesh3D.GetTextureGL(XCntr.Childs[0]);
        Mesh.Attribute.TextureId := XCntr.Childs[0].Index;
        Mesh.Attribute.Texture := XCntr.Index+TEXTUREBASE;
      end;

      Inc(Longword(p2), 4);
      Inc(Longword(p2), 2); Inx:=Word(p2^);
      If Mesh<>nil then   begin Mesh.Attribute.TextureClamp:=(Inx=3);
       if  Mesh.Attribute.TextureClamp then begin
                glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_WRAP_S,GL_CLAMP);   // wf
                glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_WRAP_T,GL_CLAMP);  // wf
       end
       else
       begin
                glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_WRAP_S,GL_REPEAT);
                glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_WRAP_T,GL_REPEAT);
       end;
      end;
      if Length(XCntr.Childs)>1 then
      SelectClassTree(XCntr.Childs[1], Mesh); // XTexturePlacement2D
    end;
    XInteriorNode:
    begin
      k := Length(XCntr.Childs);
      Mesh := TMesh.Create(CntrArr);
      Mesh.Indx := XCntr.Index;
      Mesh.xtype := 'IN';
      if But.ClassTree<>nil then
      if IsContainer(But.ClassTree.Selected.Data) = XCntr then
      begin
        Xom3DReady := true;
      end;
      SetLength(Mesh.Childs, k);
      for x := 0 to k - 1 do
      begin
        SelectClassTree(XCntr.Childs[x], Mesh.Childs[x]);
      end;
      Mesh.Name := XCntr.Name;
    end;
    XMultiTexShader:
    begin
      if (Mesh <> nil) then Mesh.Attribute.Multi:=true;
      // color
      k:=Length(XCntr.Childs);
      for x:=0 to k-2 do
                SelectClassTree(XCntr.Childs[x], Mesh);
      // 1 texture
      SelectClassTree(XCntr.Childs[k-2], Mesh);
      if (Mesh <> nil) then Mesh.Attribute.MultiT1:=Mesh.Attribute.Texture;
      // 2 texture
      SelectClassTree(XCntr.Childs[k-1], Mesh);
      if (Mesh <> nil) then Mesh.Attribute.MultiT2:=Mesh.Attribute.Texture;

      if (Mesh <> nil) and Mesh.Attribute.Material.use then
        Mesh.Attribute.Material.Name := XCntr.Name;
    end;
    XPfxEmitterGeom:
    begin
       k:=Length(XCntr.Childs);
       for x:=0 to k-1 do
                SelectClassTree(XCntr.Childs[x], Mesh);
    end;
    XPsShaderInstance:
    begin
       k:=Length(XCntr.Childs);
       for x:=0 to k-1 do
                SelectClassTree(XCntr.Childs[x], Mesh);
    end;
    XSimpleShader,XCustomShader:
    begin
      k:=Length(XCntr.Childs);
      for x:=0 to k-1 do
                SelectClassTree(XCntr.Childs[x], Mesh);
        if (Mesh <> nil) and Mesh.Attribute.Material.use then
        Mesh.Attribute.Material.Name := XCntr.Name;
    end;
    XAnimClipLibrary:
        begin

      //  SelectClassTree(k3, Mesh);
    //    AnimReady:=true;
        end;
    //XBone:
    XBrickGeometry:
    begin
    SelectClassTree(XCntr.Childs[0], Mesh); // координаты без смещения
    SelectClassTree(XCntr.Childs[1], Mesh); // со смещением
    end;
    XBrickIndexSet:
    begin
    if (Mesh<>nil) and (Length(Mesh.Vert)>0) and(Length(Mesh.DPos)>0) then
    begin
      p2:=XCntr.GetPoint;
      k:=TestByte128(p2);
      Mesh.InitSizeBox;
      for x:=0 to k-1 do with Mesh do begin
        inx:=TestByte128(p2);
        Vert[x][0]:=Vert[x][0]+DPos[inx][0];
        Vert[x][1]:=Vert[x][1]+DPos[inx][1];
        Vert[x][2]:=Vert[x][2]+DPos[inx][2];
        CalcSizeBox(Vert[x]);
      end;
    end;

    end;
    XBuildingShape:
    begin
      Mesh := TMesh.Create(CntrArr);
      Mesh.Indx := XCntr.Index;
      Mesh.xtype := 'BH';
      SelectClassTree(XCntr.Childs[0], Mesh); // смещение
      SelectClassTree(XCntr.Childs[1], Mesh); // координаты
      SelectClassTree(XCntr.Childs[2], Mesh); // текстура
      Mesh.Name := XCntr.Name;
       //BuildingDetails
       //BrickGeometry
       //ShaderType  ?
    end;
    XBrickDetails:
    begin
       if Mesh<>nil then begin
       p2:=XCntr.GetPoint;
       Inc(Longword(p2), 4);
       k := TestByte128(p2);
       SetLength(Mesh.DPos, k);
       Move(p2^, Mesh.DPos[0], k * 12);
       end;
    end;
    XPsShape,
    XShape:
    begin
      if WR and //(Mesh<>nil) and
      (system.Pos('(Shadow)',XCntr.Name)>0) then
       Exit;
      Mesh := TMesh.Create(CntrArr);
      Mesh.Indx := XCntr.Index;
      Mesh.xtype := 'SH';
      SelectClassTree(XCntr.Childs[0], Mesh);
      SelectClassTree(XCntr.Childs[1], Mesh);
      Mesh.Name := XCntr.Name;
    end;  
    XSkinShape,XPsSkinShape:
    begin
      if WR and //(Mesh<>nil) and
      (system.Pos('(Shadow)',XCntr.Name)>0) then
       Exit;
      Mesh := TMesh.Create(CntrArr);
      Mesh.Indx := XCntr.Index;
      Mesh.xtype := 'SS';
      k := Length(XCntr.Childs)-1;
      if WUM then k:=k-2;
      SetLength(Mesh.Bones, k-2);
      for x := 0 to k - 3 do
        Mesh.Bones[x] := Mesh3D.GetMeshOfID(XCntr.Childs[x].Index);  //Bones;
      SelectClassTree(XCntr.Childs[k-2], Mesh); //XSimpleShader
      SelectClassTree(XCntr.Childs[k-1], Mesh);//XIndexedTriangleSet
      Mesh.Name := XCntr.Name;
    end;
    BrickBuildingCtr:
    begin
    Mesh := TMesh.Create(CntrArr);
      p2:=XCntr.GetPoint;
      Mesh.Indx := XCntr.Index;
      Mesh.xtype := 'BC';
      x:=TestByte128(p2);
     for inx:=1 to x do    // BrickLinkage  BrickLinkage
       TestByte128(p2);
      p2 := Pointer(Longword(p2) + 4 * 4);   // BoundingSphere

      k:=TestByte128(p2);
     for inx:=1 to k do  // CollisionGeometry XCollisionGeometry
       TestByte128(p2);

      k3:=TestByte128(p2);
      SetLength(Mesh.Childs, k3);
     for inx:=0 to k3-1 do      begin   // BrickShapes     XBuildingShape
       SelectClassTree(XCntr.Childs[x+k+inx], Mesh.Childs[inx]);
       TestByte128(p2);
       end;
  {    Mesh.InitSizeBox;
      Move(p2^, Pos[0], 4 * 2);
      Inc(Longword(p2), 4 * 2);
      Pos[2]:=0;
      Move(p2^, Size[0], 4 * 2);
      Inc(Longword(p2), 4 * 2);
      Move(p2^, Size[2], 4 );
      Mesh.CalcSizeBox(Pos);
      Mesh.CalcSizeBox(Size);   }
    end;
    XGroup,XSkeletonRoot:
    begin
      Mesh := TMesh.Create(CntrArr);
      TempMesh := Mesh3D.GetMeshOfID(XCntr.Index);
      Mesh.Indx := XCntr.Index;
      Mesh.xtype := 'GR';
      if TempMesh<>nil then begin
        Mesh.Name:=TempMesh.Name;
        Mesh.IsLink:=true;
      end else begin

        if (XCntr.Childs[0] <> nil) then
                SelectClassTree(XCntr.Childs[0], Mesh)
        else // Matrix
                Mesh.xtype := 'GS';

      if (XCntr.Childs[0] <> nil) and
      (XCntr.Childs[0].Xtype=XDetailSwitch) and
      (Length(XCntr.Childs)>2) then
      k := 1
      else
      k := Length(XCntr.Childs)-1;
      SetLength(Mesh.Childs, k);
      //  IsDummy:=true;
      for x := 0 to k - 1 do
      begin
        SelectClassTree(XCntr.Childs[x+1], Mesh.Childs[x]);
        if (x = 0) and (Mesh.Childs[x] <> nil) and (Mesh.Childs[x].XType = 'GS') then
          Mesh.xtype := 'GO';

        if (x>0) and (Mesh.Childs[x]<>nil) and (Mesh.Childs[x].XType='BM')  then
                Mesh.Childs[x-1].Attribute.ZBuffer:=false;
                
        if (x=0) and WR and (Mesh.Childs[x]<>nil) and (system.Pos('_BASE',Mesh.Childs[x].Name)>0)
        then break;

        //    if Mesh.Childs[x].XType='SH' then
        //           IsDummy:=false;
      end;
      //   if IsDummy then Mesh.xtype:='DM';
      Mesh.Name := XCntr.Name;
      end;
    end;
    XChildSelector:
    begin
      if Mesh <> nil then
        Mesh.XType := 'CS';
    end;
    XBinSelector:
    begin
      Mesh := TMesh.Create(CntrArr);
      Mesh.Indx := XCntr.Index;
      Mesh.xtype := 'BN';
     SelectClassTree(XCntr.Childs[0], Mesh);
     Mesh.Transform.TransType:=TTMatrix;
     Mesh.Transform.TrMatrix[2][2]:=0.5;
    end;
    XBinModifier:
    begin
      Mesh := TMesh.Create(CntrArr);
      Mesh.Indx := XCntr.Index;
      Mesh.xtype := 'BM';
      SelectClassTree(XCntr.Childs[0], Mesh);  //matrix
      k := Length(XCntr.Childs)-1;
      SetLength(Mesh.Childs, k);
      for x := 0 to k - 1 do
      begin
        SelectClassTree(XCntr.Childs[x+1], Mesh.Childs[x]);
       //Mesh.Childs[x].Attribute.ZBuffer:=false;
      end;
      Mesh.Name := XCntr.Name;
    end;
    XSkin:
    begin
      Mesh := TMesh.Create(CntrArr);
      Mesh.Indx := XCntr.Index;
      Mesh.xtype := 'SK';
      SetLength(Mesh.Childs, 1);
      SelectClassTree(XCntr.Childs[0], Mesh.Childs[0]);
      k := Length(XCntr.Childs);
      SetLength(Mesh.Childs, k);
      for x := 1 to k-1 do
      begin
        SelectClassTree(XCntr.Childs[x], Mesh.Childs[x]);
      end;
      Mesh.Name := XCntr.Name;
    end;
    XCollisionData:
    begin
      Mesh := TMesh.Create(CntrArr);
      Mesh.Indx := XCntr.Index;
      Mesh.xtype := 'CD';
      k := Length(XCntr.Childs);
      SetLength(Mesh.Childs, k);
      for x := 1 to k-1 do
        SelectClassTree(XCntr.Childs[x], Mesh.Childs[x]);
      Mesh.Name := XCntr.Name;
    end;
    XCollisionGeometry:
    begin
      if Mesh = nil then
        Mesh := TMesh.Create(CntrArr);
      Mesh.Indx := XCntr.Index;
      Mesh.XType := 'CG';
      Mesh.glBuildCollGeo(XCntr);
      Mesh.Name := XCntr.Name;
    end;
    XPsGeoSet,
    XIndexedTriangleSet,
    XIndexedCustomTriangleSet,
    XIndexedCustomTriangleStripSet,
    XIndexedTriangleStripSet:
    begin
      if Mesh = nil then 
      begin
        Mesh := TMesh.Create(CntrArr);
        Mesh.Indx := XCntr.Index;
        Mesh.XType := 'OB';
        Mesh.Name := Format('XomMesh#%d', [Mesh.Indx]);
        //      FormXom.Button4.Enabled:=true;
      end;
      Mesh.glBuildTriangleGeo(XCntr);
      if Mesh.XType = 'SS' then
        Mesh.RVert := Copy(Mesh.Vert);
    end;
  end;
end;

Function TXom.ReadXContainer(p:pointer;NType:XTypes; var s:string; var IsCtnr:Boolean):pointer;
var
p2:Pointer;
k,x,x1,x2,k3,k2,inx, inx1,inx2:integer;
px:Longword;
ExpAnim: Boolean;
s1,s2:string;
begin

          if (Longword(p^) = Ctnr) then
            p2 := Pointer(Longword(p) + 7)
          else
            p2 := Pointer(Longword(p) + 3);
          k := TestByte128(p2);

          if k >= XomHandle.StringTable.Count then
          begin
            s := '[OUT]';
            s2 := '0';
          end
          else
          begin
            s := XomHandle.StringTable[k];
            s2 := Format('%.2x', [byte128(k)]);
          end;

          case NType of
            XGraphSet:
            begin
              p2 := p;
              s := '';
              k := TestByte128(p2);
              for x := 1 to k do
              begin
                Inc(Longword(p2), 16);
                k3 := TestByte128(p2);
                s := s + GetStr128(p2) + '; ';
              end;
              s := Format('(%d) Graph [%s]', [k, s]);
              IsCtnr := false;
            end;
            XOglTextureMap:
            begin
              p2 := Pointer(Longword(p) + 7);
              Inc(Longword(p2), 4);
              Inc(Longword(p2), 4 * 4);
              k3 := TestByte128(p2);
              Inc(Longword(p2), 4);
              k2 := Word(p2^);
              Inc(Longword(p2), 2);
              Inc(Longword(p2), 4 * 5);
              k := TestByte128(p2);
              //  dec(Longword(p2),4);
              // funit, float4,index,float,unit,funit5
              s := Format('OglMap [%d; %d]', [k3, k]);
              if k2 <> 1 then
                Inc(Longword(p2), 68);
              if not WR then
              IsCtnr := false;
            end;
            XBinormal3fSet:
            begin
               p2 := Pointer(Longword(p) + 7);
               k2 := TestByte128(p2);
               Inc(Longword(p2), k2*12);
               IsCtnr := false;
            end;
            XDetailSwitch:
            begin
               p2 := Pointer(Longword(p) + 7);
               Inc(Longword(p2), 4*3);
               k2 := TestByte128(p2);
               Inc(Longword(p2), k2*4);
               Inc(Longword(p2), 4*2);
               IsCtnr := false;
            end;
            XBitmapDescriptor:
            begin
              p2 := p;
              s := GetStr128(p2);
              if WUM then  Inc(Longword(p2));
              Inc(Longword(p2));
              k2 := TestByte128(p2);
              s := Format('"%s" [%d] [%dx%d]',
                [s, k2, Word(p2^), Word(Pointer(Longword(p2) + 2)^)]);
              Inc(Longword(p2), 4);
             // if WUM then  Inc(Longword(p2));
             if WR then  Inc(Longword(p2),13); //?
              IsCtnr := false;
            end;
            XXomInfoNode:
            begin
              for x := 1 to k do
                TestByte128(p2);
              s := format('InfoData[%d]',[k]);
            end;
            W3DTemplateSet:
            begin
              for x := 1 to k do
                TestByte128(p2);
              Inc(Longword(p2), 12);
              Inc(Longword(p2), 8);
              s := GetStr128(p2);
              IsCtnr := false;
            end;
            XCustomDescriptor:
            begin
              p2 := p;
              s := GetStr128(p2);
              if WUM then  Inc(Longword(p2));
              Inc(Longword(p2), 3);
              if WR then  Inc(Longword(p2),13); //?
              IsCtnr := false;
            end;
            XMeshDescriptor:
            begin
              p2 := p;
              s := GetStr128(p2);
              if WUM then Inc(Longword(p2));
              k3 := byte(p2^);//14
              Inc(Longword(p2));
              x := TestByte128(p2);
              Inc(Longword(p2), 2);// 80 00
              if WR then  begin
              Inc(Longword(p2),6);
               TestByte128(p2);
               TestByte128(p2);
              end;
              IsCtnr := false;
              s := Format('"%s" #%d (%d)', [s, x, k3]);
            end;
            XEnvironmentMapShader:
            begin
              p2 := Pointer(Longword(p) + 7);
              k2 := TestByte128(p2);
              k3 := TestByte128(p2);
              Inc(Longword(p2), 1);
              x := TestByte128(p2);
              x := TestByte128(p2);
              Inc(Longword(p2), 7);
              s := GetStr128(p2);
              s := Format('"%s" #%d [%d;%d]', [s, x, k2,k3]);
            end;
            XMultiTexShader:
            begin
              p2 := Pointer(Longword(p) + 7);
                k:=TestByte128(p2);
                for x:=1 to k do
                        k3:=TestByte128(p2);
                k:=TestByte128(p2);
                k:=TestByte128(p2);
             //   k:=TestByte128(p2);
                inc(Longword(p2),4);
                s:=GetStr128(p2);
            end;
            XTextDescriptor:
            begin
              p2 := p;
              s := GetStr128(p2);
              if WUM then  Inc(Longword(p2));
              k := TestByte128(p2); //1  number
              k := TestByte128(p2); //2  link
              if WR then begin
              Inc(Longword(p2), 2);
              end;
              k := Word(p2^);       // size
              if WR then begin
              Inc(Longword(p2), 23);
              end else
              Inc(Longword(p2), 4); // 1
              for x := 1 to k do
                Inc(Longword(p2), 6); // num, wchar, wchar
              //     k3:=TestByte128(p2);
              s := Format('"%s" #%d', [s, k]);
              IsCtnr := false;
            end;
            XDirectMusicDescriptor:
             begin
              p2 := p;
              s := GetStr128(p2);
              s2 := GetStr128(p2);
              Inc(Longword(p2),4);
              s := Format('"%s" (%s)', [s, s2]);
              IsCtnr := false;
            end;
            XNullDescriptor:
            begin
              p2 := p;
              s := GetStr128(p2);
              if WUM then  Inc(Longword(p2));
              k := TestByte128(p2);
              s := Format('"%s" (%d)', [s, k]);
              IsCtnr := false;
            end;
            XSpriteSet:
            begin
             p2 := Pointer(Longword(p) + 4);
             if WR then
             begin
             Inc(Longword(p2));
             Inc(Longword(p2),36);
             IsCtnr := false;
             end;
             s:='Data';
            end;
            XSpriteSetDescriptor:
            begin
              p2 := p;
              s := GetStr128(p2);
              if WUM then  Inc(Longword(p2));
              Inc(Longword(p2), 1);// 0
              k3 := TestByte128(p2);
              if WR then TestByte128(p2);
              s := Format('"%s" #%d', [s, k3]);
              if WR then Inc(Longword(p2),13);
              IsCtnr := false;
            end;
            XCollisionData:
            begin
              p2 := Pointer(Longword(p) + 9);
              k := TestByte128(p2); 
              k3 := 0;
              if k <> 0 then 
                k3 := TestByte128(p2);
              s := Format('[%d]', [k3]);
            end;
            XImage:
            begin
              //s := GetString(k);
              //                k2:=TestByte128(p2);
              s := Format('"%s" [%dx%d]',
                [s, Word(p2^), Word(Pointer(Longword(p2) + 2)^)]);
            end;
            XInteriorNode:
            begin
              for x := 1 to k do
                k3 := TestByte128(p2);
              px := Longword(p2); //4*4+4*3*2+4
              p2 := Pointer(Longword(p2) + 4 * 5);
              if WR then Inc(Longword(p2),4*3*2);
              s := GetStr128(p2);
              s := Format('%s [%.2f; %.2f; %.2f; %.2f]',
                [s, Single(Pointer(px)^), Single(Pointer(px + 4)^),
                Single(Pointer(px + 8)^), Single(Pointer(px + 12)^)]);
              IsCtnr := false;
            end;
            XGroup, XSkin:
            begin
              k := TestByte128(p2);
              for x := 1 to k do
                k3 := TestByte128(p2);
              px := Longword(p2);
              p2 := Pointer(Longword(p2) + 4 * 5);
              s := GetStr128(p2);
              s := Format('%s [%.2f; %.2f; %.2f; %.2f]',
                [s, Single(Pointer(px)^), Single(Pointer(px + 4)^),
                Single(Pointer(px + 8)^), Single(Pointer(px + 12)^)]);
            end;
            XChildSelector:
            begin
              s := 'Childs';
            end;
            XBinModifier:
            begin
              k := TestByte128(p2);
              //               for x:=1 to k do
              k3 := TestByte128(p2);
              k := TestByte128(p2);
              for x := 1 to k do
                k3 := TestByte128(p2);
              px := Longword(p2);
              p2 := Pointer(Longword(p2) + 4 * 5);
              s := GetStr128(p2);
              s := Format('%s [%.2f; %.2f; %.2f; %.2f]',
                [s, Single(Pointer(px)^), Single(Pointer(px + 4)^),
                Single(Pointer(px + 8)^), Single(Pointer(px + 12)^)]);
            end;
            XBone:
            begin
              p2 := Pointer(Longword(p) + 7);
              Inc(Longword(p2), 4*4*4);
              Inc(Longword(p2), 4*4*4);
              TestByte128(p2);
              k := TestByte128(p2);
              for x := 1 to k do
                k3 := TestByte128(p2);
              Inc(Longword(p2), 4*4+4);
              s := GetStr128(p2);
            end;
            XAnimChannel:
            begin
              p2 := Pointer(Longword(p) + 7);
              Inc(Longword(p2), 4+4*2);
               k := TestByte128(p2);
              //MustContribute XBool
              // IsWeighted XBool
              // IsStatic   XBool
              // IsLinear  XBool
              // PreInfinity XEnumByte
              // PostInfinity  XEnumByte
              // KeyArray XSet

               Inc(Longword(p2), k*4);
                IsCtnr := false;
            end;
            XAnimClipLibrary:
            begin
              p2 := p;
              s1 := GetStr128(p2);  // Name
              inx1 := Integer(p2^); // NumKeys
              //    if inx>16000 then break;
              Inc(Longword(p2), 4);
              for x := 1 to inx1 do
              begin   // Keys
                Inc(Longword(p2), 4);   //AnimType
                s1 := GetStr128(p2); //Object
              end;
              inx2 := Integer(p2^);  // NumClips
              Inc(Longword(p2), 4);
              s := Format('Clips[%d]', [inx2]);
              for x := 1 to inx2 do 
              begin
                Inc(Longword(p2), 4); // time
                s1 := GetStr128(p2); // name
                inx := Word(p2^);     // NumAnimKeys
                ExpAnim := not WR and ((inx = 256) or (inx=257));
                // 00 01   - zero Frame
                // 01 01   - frame no Index
                // 24 00   - index frame
                //  ExpAnim:= inx <> integer($0101);
                if ExpAnim then
                  inx := inx1
                else
                  Inc(Longword(p2), 4);
                for x1 := 1 to inx do
                begin // AnimKeys
                  x2 := Word(p2^);
                  if x2 = 256 then
                  begin
                    Inc(Longword(p2), 16);
                    Continue;
                  end;
                  Inc(Longword(p2), 4); // 1 1 0 0
                  if not ExpAnim then
                  begin
                    k2 := Word(p2^); 
                    Inc(Longword(p2), 2);
                  end;
                  k3 := Word(p2^);
                  Inc(Longword(p2), 2);
                  Inc(Longword(p2), 6);
                  k := Integer(p2^); 
                  Inc(Longword(p2), 4);
                  for x2 := 1 to k do
                    Inc(Longword(p2), 6 * 4);
                end;
              end;
              IsCtnr := false;
            end;
            XSkinShape:
            begin
              for x := 1 to k do
                k3 := TestByte128(p2);
              Inc(Longword(p2), 4);
              k3 := TestByte128(p2);
              k3 := TestByte128(p2);
              Inc(Longword(p2), 5);
              px := Longword(p2);
              p2 := Pointer(Longword(p2) + 4 * 5);
              s := GetStr128(p2);
              s := Format('%s [%.2f; %.2f; %.2f; %.2f]',
                [s, Single(Pointer(px)^), Single(Pointer(px + 4)^),
                Single(Pointer(px + 8)^), Single(Pointer(px + 12)^)]);
            end;
            XShape:
            begin
              Inc(Longword(p2), 3);
              k3 := TestByte128(p2);
              k3 := TestByte128(p2);
              if not WB then
              Inc(Longword(p2), 5);
              if WUM then Inc(Longword(p2), 2);
              px := Longword(p2);
              p2 := Pointer(Longword(p2) + 4 * 5);
              s := GetStr128(p2);
              s := Format('%s [%.2f; %.2f; %.2f; %.2f]',
                [s, Single(Pointer(px)^), Single(Pointer(px + 4)^),
                Single(Pointer(px + 8)^), Single(Pointer(px + 12)^)]);
            end;
            XBuildingShape:
            begin
            //  Inc(Longword(p2), 3);
              k3 := TestByte128(p2);
              k3 := TestByte128(p2);
              Inc(Longword(p2), 9);
              k3 := TestByte128(p2);
              Inc(Longword(p2), 6);
              px := Longword(p2);
              p2 := Pointer(Longword(p2) + 4 * 5);
              s := GetStr128(p2);
              s := Format('%s [%.2f; %.2f; %.2f; %.2f]',
                [s, Single(Pointer(px)^), Single(Pointer(px + 4)^),
                Single(Pointer(px + 8)^), Single(Pointer(px + 12)^)]);
            end;
            XTransform:
            begin
              px := Longword(p) + 7;
              s := Format('Pos <%.2f; %.2f; %.2f>',
                [Single(Pointer(px)^), Single(Pointer(px + 4)^), Single(Pointer(px + 8)^)]);
            end;
            XJointTransform:
            begin
              px := Longword(p) + 7;
              s := Format('<%.2f; %.2f; %.2f>',
                [Single(Pointer(px)^), Single(Pointer(px + 4)^), Single(Pointer(px + 8)^)]);
            end;
            XMatrix:
            begin
              px := Longword(p) + 7 + 36;
              s := Format('Pos <%.2f; %.2f; %.2f>',
                [Single(Pointer(px)^), Single(Pointer(px + 4)^), Single(Pointer(px + 8)^)]);
              p2:= Pointer(Longword(p) + 3+7*8);
              if WR then IsCtnr:=false;
            end;
            XTexturePlacement2D:
            begin
              //px:=Longword(p)+7;
              s := 'Matrix';
            end;
            XCustomShader:
            begin
              p2 := Pointer(Longword(p) + 7 );
              k := TestByte128(p2);
              for x := 1 to k do
                k3 := TestByte128(p2);
              Inc(Longword(p2), 4*2);
              k := TestByte128(p2);
              for x := 1 to k do
                k3 := TestByte128(p2);
              k := TestByte128(p2);
              for x := 1 to k do
                k3 := TestByte128(p2);
              k := TestByte128(p2);
              for x := 1 to k do
                k3 := TestByte128(p2);
              k := TestByte128(p2);
              for x := 1 to k do
                k3 := TestByte128(p2);
              k := TestByte128(p2);
              Inc(Longword(p2), k*4);
              k := TestByte128(p2);
              Inc(Longword(p2), k*4);
              Inc(Longword(p2), 4);
              s := GetStr128(p2);
              s := Format('%s', [s]);
            //  IsCtnr := false;
            end;
            XSimpleShader:
            begin
              for x := 1 to k do
                k3 := TestByte128(p2);
              k := TestByte128(p2);
              for x := 1 to k do
                k3 := TestByte128(p2);
              Inc(Longword(p2), 4);
              s := GetStr128(p2);
              s := Format('%s', [s]);
              if WUM then  Inc(Longword(p2));
              IsCtnr := false;
            end;
            XTexFont:
            begin
              for x := 1 to k do 
                Inc(Longword(p2), 8);
              k := TestByte128(p2);
              for x := 1 to k do 
                Inc(Longword(p2), 8);
              k := TestByte128(p2);
              for x := 1 to k do
                k3 := TestByte128(p2);
              k := TestByte128(p2);
              for x := 1 to k do
                k3 := TestByte128(p2);
              Inc(Longword(p2), 4);
              s := GetStr128(p2);
              s := Format('%s', [s]);
              if WUM then  Inc(Longword(p2));
               IsCtnr := false;
            end;
            XContainerResourceDetails:
            begin
              s := GetStr128(p2);
              k3 := TestByte128(p2);
              s := Format('%s [%d]', [s,k3]);
              //       sTemp:= sTemp+s+nVn;
            end;
            XFloatResourceDetails: 
            begin
              p2 := Pointer(Longword(p) + 7 + 4);
              s := GetStr128(p2);
              s := Format('%s = %f', [s, Single(Pointer(Longword(p) + 7)^)]);
              //         sTemp:= sTemp+s+nVn;
            end;
            XIntResourceDetails, XUintResourceDetails: 
            begin
              p2 := Pointer(Longword(p) + 7 + 4);
              s := GetStr128(p2);
              s := Format('%s = %d', [s, Word(Pointer(Longword(p) + 7)^)]);
              //        sTemp:= sTemp+s+nVn;
            end;
            XStringResourceDetails, GSProfile,XExportAttributeString:
            begin
              k3 := TestByte128(p2);
              if k = 0 then 
                s2 := '' 
              else
                s2 := XomHandle.StringTable[k];//But.GlValueList.Cells[1, k];
              s := XomHandle.StringTable[k3];//But.GlValueList.Cells[1, k3];
              if (NType = GSProfile) then
                s := Format('Nick:%s / E-mail:%s', [s2, s]) 
              else
                s := Format('%s = %s', [s, s2]);
              //         sTemp:= sTemp+s+nVn;
            end;
            LockedContainer:
            begin
              p2 := Pointer(Longword(p) + 7 + 1);
              s := GetStr128(p2);
            end;
            BaseWeaponContainer:
            begin
             s:='BaseWeapon';
            end;
            MeleeWeaponPropertiesContainer:
            begin
             s:='MeleeWeapon';
            end;
            MenuDescription:
            begin
             p2 := Pointer(Longword(p) + 7 + 4*6);
             TestByte128(p2);
             TestByte128(p2);
             TestByte128(p2);
             TestByte128(p2);
             s := GetStr128(p2);
            end;
            GunWeaponPropertiesContainer:
            begin
             s:='GunWeapon';
            end;
            SentryGunWeaponPropertiesContainer:
            begin
            begin
             s:='SentryGunWeapon';
            end;
            end;
            FlyingPayloadWeaponPropertiesContainer:
            begin
             s:='FlyingPayloadWeapon';
            end;
            JumpingPayloadWeaponPropertiesContainer:
            begin
             s:='JumpingPayloadWeapon';
            end;
            HomingPayloadWeaponPropertiesContainer:
            begin
             s:='HommingPayloadWeapon';
            end;
            PayloadWeaponPropertiesContainer:
            begin
             s:='PayloadWeapon';
            end;
            MineFactoryContainer:
            begin
             s:='MineFactory';
            end;
            ParticleEmitterContainer:
            begin
             s:='EmitterData';
            end;
            EffectDetailsContainer:
            begin
            s:=format('EffectNames [%d]',[k]);
            end;
            HighScoreData:
            begin
              s1 := '';
              s1 := s1 + Format('%s - %.2f ', [s, ToTime(Longword(p2^))]);
              if not WUM then begin
              p2 := Pointer(Longword(p2) + 4);
              s := GetStr128(p2);
              s1 := s1 + Format('%s - %.2f ', [s, ToTime(Longword(p2^))]);
              p2 := Pointer(Longword(p2) + 4);
              s := GetStr128(p2);
              s1 := s1 + Format('%s - %.2f ', [s, ToTime(Longword(p2^))]);
              end;
              s := s1;                                            //         sTemp:= sTemp+s+nVn;
            end;
            StoredTeamData:
            begin
              s := Format('Team [%s]', [s]);
            end;
            BrickLinkage:
            begin
             p2 := Pointer(Longword(p) + 7 + 2);
             s := GetStr128(p2);
            end;
            Campaign:
            begin
              s := 'Data';
            end;
            ChatMessagesWindowDetails:
            begin
              s:= 'Data';
            end;
            LevelLock:
            begin
             p2 := Pointer(Longword(p) + 7 + 4+4);
             s := GetStr128(p2);
            end;
            MovieLock:
            begin
             p2 := Pointer(Longword(p) + 7 + 4);
             s := GetStr128(p2);
            end;
            CampaignData:
            begin
              s := Format('Compaign [%d]', [k]);
            end;
            XZBufferWriteEnable:
            begin
              s := BoolToStr(Boolean(k), true);
            end;
            XAlphaTest:
            begin
              s := Format('Alpha [%d; %.2f]',
                [Longword(Pointer(p2)^), Single(Pointer(Longword(p2) + 4)^)]);
                Inc(Longword(p2), 8);
              IsCtnr := false;
            end;
            XLightingEnable:
            begin
              px := Longword(p) + 14;
              s := Format('Light %s %d [%.2f; %.2f; %.2f; %.2f]',
                [BoolToStr(Boolean(k), true), Longword(Pointer(Longword(p) + 10)^),
                Single(Pointer(px)^), Single(Pointer(px + 4)^), Single(Pointer(px + 8)^),
                Single(Pointer(px + 12)^)]);
              p2 := Pointer(Longword(p) + 14 + 16);
              IsCtnr := false;
            end;
            XBlendModeGL:
            begin
              s := Format('Blend [%d; %d]',
                [Longword(Pointer(Longword(p) + 7)^), Longword(Pointer(Longword(p) + 7 + 4)^)]);
              p2 := Pointer(Longword(p) + 11);
              //    IsCtnr:=false;
            end;
            XDepthTest:
            begin
              s := Format('Depth [%d; %d; %f]',
                [Longword(Pointer(Longword(p) + 7)^), Longword(Pointer(Longword(p) + 7 + 4)^),
                Single(Pointer(Longword(p) + 7 + 9)^)]);
              if WR then begin
              p2 := Pointer(Longword(p) + 7 + 9+4);
              IsCtnr:=false;
              end;
            end;
            XCullFace:
            begin
              s := BoolToStr(Boolean(k), true);
              p2:= Pointer(Longword(p) + 7 + 4);
              IsCtnr := false;
            end;
            XPointLight:
            begin
             p2 := Pointer(Longword(p) + 7 + 86);
             s2 := GetStr128(p2);
            s := Format('%s = <x:%f y:%f z:%f>',
                [s2, Single(Pointer(Longword(p) + 7)^), Single(Pointer(Longword(p) + 7 + 4)^),
                Single(Pointer(Longword(p) + 7 + 8)^)]);
            end;
            XMaterial:
            begin
              s := Format('Ambiend = [%.2f; %.2f; %.2f; %.2f]',
                [Single(Pointer(Longword(p) + 7)^), Single(Pointer(Longword(p) + 7 + 4)^),
                Single(Pointer(Longword(p) + 7 + 8)^), Single(Pointer(Longword(p) + 7 + 12)^)]);
            end;
            XVectorResourceDetails:
            begin
              p2 := Pointer(Longword(p) + 7 + 12);
              s2 := GetStr128(p2);
              s := Format('%s = <x:%f y:%f z:%f>',
                [s2, Single(Pointer(Longword(p) + 7)^), Single(Pointer(Longword(p) + 7 + 4)^),
                Single(Pointer(Longword(p) + 7 + 8)^)]);
              //         sTemp:= sTemp+s+nVn;
            end;
            XColorResourceDetails:
            begin
              p2 := Pointer(Longword(p) + 7 + 4);
              s2 := GetStr128(p2);
              s := Format('%s = <r:%d g:%d b:%d a:%d>',
                [s2, Byte(Pointer(Longword(p) + 7)^), Byte(Pointer(Longword(p) + 7 + 1)^),
                Byte(Pointer(Longword(p) + 7 + 2)^), Byte(Pointer(Longword(p) + 7 + 3)^)]);
              //            sTemp:= sTemp+s+nVn;
            end;
            XCoord3fSet, XNormal3fSet: 
            begin
              px := Longword(p2);
              s := Format('[%d] ', [k]);
              for x := 0 to k - 1 do 
              begin
                s := s + Format('<%f; %f; %f> ',
                  [Single(Pointer(px + x * 12)^), Single(Pointer(px + x * 12 + 4)^),
                  Single(Pointer(px + x * 12 + 8)^)]);
                if Length(s) > 100 then 
                begin 
                  s := s + '...'; 
                  Break; 
                end;
              end;
            end;
            XCoord3sSet_1uScale, XNormal3sSet_1uScale:
            begin
              px := Longword(p2);
              s := Format('[%d] ', [k]);
              for x := 0 to k - 1 do 
              begin
                s := s + Format('<%d; %d; %d> ',
                  [ShortInt(Pointer(px + x * 6)^), ShortInt(Pointer(px + x * 6 + 2)^),
                  ShortInt(Pointer(px + x * 6 + 4)^)]);
                if Length(s) > 100 then 
                begin 
                  s := s + '...'; 
                  Break; 
                end;
              end;
            end;
            XTexCoord2fSet: 
            begin
              px := Longword(p2);
              s := Format('[%d] ', [k]);
              for x := 0 to k - 1 do 
              begin
                s := s + Format('<%f; %f> ',
                  [Single(Pointer(px + x * 12)^), Single(Pointer(px + x * 8 + 4)^)]);
                if Length(s) > 100 then 
                begin 
                  s := s + '...'; 
                  Break; 
                end;
              end;
            end;
            XMultiTexCoordSet:
            begin
              p2 := Pointer(Longword(p) + 7);
              k := TestByte128(p2);
              k2:= TestByte128(p2);
              k3:= TestByte128(p2);
              s := Format('%d:[%d][%d]', [k,k2,k3]);
            end;
            XPsTextureReference:
            begin
              p2:= Pointer(Longword(p) + 7);
              k := TestByte128(p2);
              k := TestByte128(p2);
              Inc(Longword(p2));
              IsCtnr := false;
              s:='Data';
            end;
            XPaletteWeightSet:
            begin
              p2 := Pointer(Longword(p) + 7);
              k := TestByte128(p2);
              s := Format('[%d bones index]', [k]);
            end;
            XWeightSet:
            begin
              p2 := Pointer(Longword(p) + 7);
              k2 := Word(p2^);
              Inc(Longword(p2), 2);
              k := TestByte128(p2);
              px := Longword(p2);
              s := Format('[%d bones] [%d vertex] <', [k2, k]);
              for x := 0 to k - 1 do 
              begin
                s := s + Format('%.2f; ', [Single(Pointer(px + x * 4)^)]);
                if Length(s) > 100 then 
                begin 
                  s := s + '...'; 
                  Break; 
                end;
              end;
            end;
            XColor4ubSet: 
            begin
              px := Longword(p2);
              s := Format('[%d] ', [k]);
              for x := 0 to k - 1 do 
              begin
                s := s + Format('<%d; %d; %d; %d> ',
                  [Byte(Pointer(px + x * 4)^), Byte(Pointer(px + x * 4 + 1)^),
                  Byte(Pointer(px + x * 4 + 2)^), Byte(Pointer(px + x * 4 + 3)^)]);
                if Length(s) > 100 then 
                begin 
                  s := s + '...'; 
                  Break; 
                end;
              end;
            end;
            XIndexedTriangleSet://,XIndexedCustomTriangleSet:
            begin
              Inc(Longword(p2), 4);
              k2 := Word(p2^);
              Inc(Longword(p2), 4);
              k3 := TestByte128(p2);
              k3 := TestByte128(p2);
              k3 := TestByte128(p2);
              k3 := TestByte128(p2);
              Inc(Longword(p2));
              px := Longword(p2);
              s := Format('%d faces [%.2f; %.2f; %.2f][%.2f; %.2f; %.2f]',
                [k2, Single(Pointer(px)^), Single(Pointer(px + 4)^),
                Single(Pointer(px + 8)^), Single(Pointer(px + 12)^),
                Single(Pointer(px + 16)^), Single(Pointer(px + 20)^)]);
            end;
            XIndexedTriangleStripSet:
            begin
            WF:=true;
              p2 := Pointer(Longword(p) + 8);
              k2 := Word(p2^);
              Inc(Longword(p2), 2);
              k3 := TestByte128(p2);
              Inc(Longword(p2), 8);
              k3 := TestByte128(p2);
              k3 := TestByte128(p2);
              k3 := TestByte128(p2);
              k3 := TestByte128(p2);
              Inc(Longword(p2));
              px := Longword(p2);
              s := Format('%d faces [%.2f; %.2f; %.2f][%.2f; %.2f; %.2f]',
                [k2, Single(Pointer(px)^), Single(Pointer(px + 4)^),
                Single(Pointer(px + 8)^), Single(Pointer(px + 12)^),
                Single(Pointer(px + 16)^), Single(Pointer(px + 20)^)]);
            end;
            XConstColorSet: 
            begin
              px := Longword(p) + 7;
              s := Format('[%.2f; %.2f; %.2f; %.2f]',
                [Single(Pointer(px)^), Single(Pointer(px + 4)^),
                Single(Pointer(px + 8)^), Single(Pointer(px + 12)^)]);
            end;
            XBrickIndexSet:
            begin
              s := Format('[%d] ', [k]);
            end;
            XMultiIndexSet:
            begin
              s := Format('[%d] ', [k]);
              k3 := TestByte128(p2);
              k3 := TestByte128(p2);
              k3 := TestByte128(p2);
              k3 := TestByte128(p2);
            end;
            XIndexSet:
            begin
              s := Format('[%d] ', [k]);
              Inc(Longword(p2),2*k);
              IsCtnr := false;
            end;
            XIndexSet8:
            begin
              s := Format('[%d] ', [k]);
              Inc(Longword(p2),k);
              IsCtnr := false;
            end;
            StringStack:
            begin
                s := Format('[%d] ', [k]);
            end;
            XBrickGeometry:
            begin
               s := 'Data';
            end;
            XCollisionGeometry:
            begin
              p2 := Pointer(Longword(p) + 4 + 7 + 8);
              s := Format('Faces = %d', [TestByte128(p2)]);
            end;
            XDataBank: 
            begin
              s := Format('Bank #%d', [k]);
            end;
            XExpandedAnimInfo:
            begin
              s := 'Data';
              if (Longword(p^) = Ctnr) then
                p2 := Pointer(Longword(p) + 7 + 4)
              else
                p2 := Pointer(Longword(p) + 7);
              IsCtnr := false;
            end;
            XPalette: 
            begin
              s := 'Palette';
            end;
            XAnimInfo:
            begin
              s := 'Data';
              if (Longword(p^) = Ctnr) then
                p2 := Pointer(Longword(p) + 5 + 4)
              else
                p2 := Pointer(Longword(p) + 5);
              IsCtnr := false;
            end;
            XSceneCamera:
            begin
             p2 := Pointer(Longword(p) + 7 + 3*3*4+4);
             s:=GetStr128(p2);
            end;
            XFortsExportedData:
            begin
              s := 'Data';
            end;
            BrickBuildingCtr:
            begin
              s:='Data';
            end;
            PC_LandChunk:
            begin
              p2 := Pointer(Longword(p) + 7 + 4);
              Inc(Longword(p2), 4 * 4);
              Inc(Longword(p2), 5);
              IsCtnr := false;
              s := 'Data';
            end;
            PC_LandFrame:
            begin
              p2 := Pointer(Longword(p) + 7);
              k3 := TestByte128(p2);
              Inc(Longword(p2), k3);
              k3 := TestByte128(p2);
              Inc(Longword(p2), k3);
              Inc(Longword(p2), 2);    //00 00
              Inc(Longword(p2), 4);    // 3d 00 6c 00
              Inc(Longword(p2), 368);  // pos?
              k3 := TestByte128(p2);   // layers 1
              Inc(Longword(p2), k3 * 2 * 4);
              k3 := TestByte128(p2); // layers 2
              Inc(Longword(p2), k3 * 2 * 4);
              k3 := TestByte128(p2); // ?
              Inc(Longword(p2), k3 * 4);
              Inc(Longword(p2), 4);
              k3 := TestByte128(p2); // ?
              Inc(Longword(p2), k3 * 4);
              k3 := TestByte128(p2); // ?
              Inc(Longword(p2), k3 * 4);
              // ?????
              k3 := TestByte128(p2); // ?
              Inc(Longword(p2), (k3 - 1) * 4);
              Inc(Longword(p2), 16); //???
              Inc(Longword(p2), 4);  // ff ff ff ff
              k3 := TestByte128(p2); // childs
              for x := 1 to k3 do
                TestByte128(p2);
              Inc(Longword(p2), 4 * 4); // coord4
              Inc(Longword(p2), 4);     // zero
              s := GetStr128(p2);
              IsCtnr := false;
            end;
            WeaponSettingsData:
            begin
              s:= 'Weapon';
            end;
            BrickBuildingList,
            CampaignCollective,
            GSProfileList,
            LockedBitmapArray,
            SchemeColective,
            SchemeCollective,
            SoundBankCollective,
            WormapediaCollective:
            begin
              s:= Format('[%d]', [k]);
            end;
            XSoundBank:
            begin
              p2 := p;
              k3 := TestByte128(p2); // childs
              for x := 1 to k3 do
                TestByte128(p2);
              s:=GetStr128(p2);
               IsCtnr := false;
            end;
            XInternalSampleData:
            begin
              p2 := p;
                k:= Longword(p2^); Inc(Longword(p2) , 4);
                Inc(Longword(p2),k);
              if not WB then begin   Inc(Longword(p2), 4); //0
                Inc(Longword(p2), 4);//1
                Inc(Longword(p2), 4);//2
              end;
                IsCtnr := false;
            end;
            XSampleData:
            begin
                p2 := p;
                TestByte128(p2); //01:Sound ID Key
                TestByte128(p2);//02:Sound Direct Key
                if WB then Inc(Longword(p2), 34)
                 else
                 Inc(Longword(p2), 47);
                IsCtnr := false;
            end;
            XStreamData:
            begin
              p2 := p;
                TestByte128(p2); //01:Sound ID Key
                TestByte128(p2);//02:Sound Direct Key
                Inc(Longword(p2),4);     //44 AC: Hz 44100
                Inc(Longword(p2), 4); //float
                inc(Longword(p2),4); //int
                inc(Longword(p2),1); // byte
                Inc(Longword(p2), 4); //00 00 7A 44 - 1000
                Inc(Longword(p2), 4); //00 40 9C 45- 5000
                Inc(Longword(p2), 4); //00 00 CB 42 -101,5   float
                Inc(Longword(p2), 4); //00 80 BB 44  float
                Inc(Longword(p2), 4); //00 80 BB 44  float
                Inc(Longword(p2), 4*3); //?
                k:= Longword(p2^);Inc(Longword(p2), 4);
                Inc(Longword(p2),k);
                Inc(Longword(p2), 4); //?
                Inc(Longword(p2), 4); //?

              IsCtnr := false;
            end;
            TeamDataColective,TeamDataCollective:
            begin
              s:= Format('Team[%d]', [k]);
            end;
            LandFrameStore:
            begin
              s := Format('(%s)', [s]);
            end;
            DetailEntityStore:
            begin
              p2 := Pointer(Longword(p) + 7);
              s:=GetStr128(p2);
              TestByte128(p2);
              Inc(Longword(p2), 4*3*4);//pos,rot,clip,size
              Inc(Longword(p2), 4*2+4*3+1);
              s := Format('(%s)', [s]);
               IsCtnr := false;
            end;
            XPathFinderData:
            begin
              s := 'Data';
            end;
            XPositionData:
            begin
              p2 := Pointer(Longword(p) + 12);
              s := 'Data';
              IsCtnr := false;
            end;
            XDetailObjectsData: 
            begin
              p2 := Pointer(Longword(p) + 7);
              k := TestByte128(p2);
              for x := 1 to k do
                k3 := TestByte128(p2);
              k := TestByte128(p2);
              for x := 1 to k do 
                k3 := TestByte128(p2);

              k := TestByte128(p2);
              for x := 1 to k do 
                Inc(Longword(p2), 3 * 4);
              k := TestByte128(p2);
              for x := 1 to k do
                Inc(Longword(p2), 3 * 4);
              k := TestByte128(p2);
              for x := 1 to k do
                Inc(Longword(p2), 3 * 4);

              s := 'Data';
              IsCtnr := false;
            end;
            XNone:
              s := Format('0x%x (%s)', [k, s]);
          end;
result:=p2;
end;

function TXom.AddClassTree(XCntr: TContainer; TreeView: TTreeView;
  TreeNode: TTreeNode): TTreeNode;
var
  x, k, k4, k3, k2, px, i, j, inx, inx1, inx2,
  w, h, Isize, Imap, Iformat, Bsize: Integer;
  val:single;
  p2,pt: Pointer;
  s, s1: string;
  Matrix: TMatrix;
  KeyFrame: TKeyFrame;
  Pos, Size, Rot: Tver;
  AnimV: Tpnt;
  AnimType: Cardinal;
  ftime: Single;
  ExpAnim: Boolean;
  StrList: TStringList;
  TempNode, TempNode0, TempNode2, TempNode3: TTreeNode;
  ArrTree,ArrTree2:array of TTreeNode;
  StrPar:array [1..4] of char;
  ArrStr:array of string;
  //ArrNode:array of TTreeNode;
  DelVal:Boolean;

      vi:Integer;
      vu:Smallint;
      vf:Single;
      vb:boolean;
      vs,vs0:string;
      vc:Cardinal;
      vby:Shortint;
      vl:PXEnumStrings;//array of string;//TStringList;
      vsize:integer;

    function GetXName(_cntr:TContainer):String;
    begin
      if _cntr.Name<>'' then
      result:=Format('%s [%d] "%s"', [PCharXTypes[_cntr.Xtype], _cntr.Index, _cntr.Name])
      else
      result:=Format('%s [%d]', [PCharXTypes[_cntr.Xtype],_cntr.Index]);
   //   if But.Status<>nil then
    //    But.Status.Text := result;
    end;

  procedure AddNode(Name: string;icon:integer=0);
  begin
    TreeNode := TreeView.Items.AddChild(TreeNode, Name);
    TreeNode.Data := XCntr;
    TreeNode.ImageIndex := icon;
    TreeNode.SelectedIndex := icon;
  end;

  function AddIdxNode:TTreeNode;
  begin
      Result:=AddClassTree(XCntr.AddChild(GetIdx128(p2,XCntr)), TreeView, TreeNode);
  end;

  procedure AddSetNode(Name: string;icon:integer=0);
  var i:integer;
  begin
    k := GetSize128(p2,XCntr);
    if k>0 then begin
    TempNode := TreeView.Items.AddChild(TreeNode,
          Format('%s [%d]', [Name,k]));
    TempNode.Data:=XCntr.CntrSet;
    TempNode.ImageIndex := icon;
    TempNode.SelectedIndex := icon;
    for i := 1 to k do
        AddClassTree(XCntr.AddChild(GetIdx128(p2,XCntr)), TreeView, TempNode);
    end;
  end;



     function AddChildF(TN:TTreeNode;StrVal:String;XT:XValTypes;StrGet:Boolean=false):TTreeNode;
      var
      CntrVal:TCntrVal;
      TmpNode:TTreeNode;
      DelFromP,DelToP:Pointer;
        procedure AddValNode(str:string);
        begin
        if StrGet then begin
                StrVal:=GetStr128(p2,XCntr);
                vs0:=StrVal; end;
        TmpNode:=TreeView.Items.AddChild(TN,Format('%s = %s',[StrVal,str]));
        end;
      begin
      CntrVal:=TCntrVal.Create;
      if DelVal then DelFromP:=p2;
      CntrVal.Point:=p2;
      CntrVal.XType:=XT;
      CntrVal.Cntr:=XCntr;
      case XT of
      XBool:    begin
                vb:=Boolean(byte(p2^));  Inc(Longword(p2));
                AddValNode(BoolToStr(vb, true));
                end;
      XByte:    begin
                vby:=byte(p2^);  Inc(Longword(p2));
                AddValNode(Format('%d', [vby]));
                end;
      XString:  begin
                vs:=GetStr128(p2,XCntr);
                AddValNode(vs);
                end;
      XText:    begin
                vs:=GetStr128(p2,XCntr);
                if length(vs)>20 then begin
                        SetLength(vs,20);
                        vs:=format('"%s..."',[vs]);
                end;
                AddValNode(vs);
                end;
      XIndex:   begin
                vu:=TestByte128(p2);
                AddValNode(Format('#%d', [vu]));
                end;
      X4Char:   begin
                Move(p2^,StrPar[1],4);
                vs:=StrPar[4]+StrPar[3]+StrPar[2]+StrPar[1]; Inc(Longword(p2), 4);
                AddValNode(vs);
                end;
      XFloat:   begin
                vf:=single(p2^);  Inc(Longword(p2), 4);
                AddValNode(Format('%f', [vf]));
                end;
      XFFloat:   begin
                vf:=single(p2^);  Inc(Longword(p2), 4);
                AddValNode(Format('%.6f', [vf]));
                end;
      XEnum:    begin
                vi:=integer(p2^);  Inc(Longword(p2), 4);
                CntrVal.XList:=vl;
                CntrVal.XListSize:=vsize;
                if (vi<0) or (vi>vsize) then
                AddValNode(format('[OUT]%d',[vi]))//
                else AddValNode(vl^[vi]);
                end;
      XEnumByte:    begin
                vby:=byte(p2^);  Inc(Longword(p2));
                CntrVal.XList:=vl;
                CntrVal.XListSize:=vsize;
                if vby =-1 then
                        AddValNode('NONE')
                else
                        AddValNode(vl^[vby]);
                end;
      XInt:    begin
                vi:=integer(p2^);  Inc(Longword(p2), 4);
                AddValNode(Format('%d', [vi]));
                end;
      XCode:    begin
                vc:=integer(p2^);  Inc(Longword(p2), 4);
                AddValNode(Format('0x%x', [vc]));
                end;
      XVectorR: Begin
                vc:=Longword(p2);  Inc(Longword(p2), 4*3);
                AddValNode(Format('<%f; %f; %f>',
                [RadToDeg(Single(Pointer(vc)^)), RadToDeg(Single(Pointer(vc + 4)^)), RadToDeg(Single(Pointer(vc + 8)^))]));
                end;
      XVector:  begin
                vc:=Longword(p2);  Inc(Longword(p2), 4*3);
                AddValNode(Format('<%f; %f; %f>',
                [Single(Pointer(vc)^), Single(Pointer(vc + 4)^), Single(Pointer(vc + 8)^)]));
                end;
      XSBound:  begin
                vc:=Longword(p2);  Inc(Longword(p2), 4*4);
                AddValNode(Format('[%f; %f; %f; %f]',
                [Single(Pointer(vc)^), Single(Pointer(vc + 4)^), Single(Pointer(vc + 8)^),
                Single(Pointer(vc + 12)^)]));
                end;
      XVector4: begin
                vc:=Longword(p2);  Inc(Longword(p2), 4*4);
                AddValNode(Format('<%f; %f; %f; %f>',
                [Single(Pointer(vc)^), Single(Pointer(vc + 4)^), Single(Pointer(vc + 8)^),
                Single(Pointer(vc + 12)^)]));
                end;
      XMatrix4: begin
                vc:=Longword(p2);  Inc(Longword(p2), 4*4*4);
                inc(vc,4*4*3);
                AddValNode(Format('[%f; %f; %f; %f]',
                [Single(Pointer(vc)^), Single(Pointer(vc + 4)^), Single(Pointer(vc + 8)^),
                Single(Pointer(vc + 12)^)]));
                end;
      XMatrix3: begin
                vc:=Longword(p2);  Inc(Longword(p2), 4*3*4);
                inc(vc,4*3*3);
                AddValNode(Format('[%f; %f; %f; %f]',
                [Single(Pointer(vc)^), Single(Pointer(vc + 4)^), Single(Pointer(vc + 8)^),
                1.0]));
                end;
      XUInt:    begin
                vu:=SmallInt(p2^);  Inc(Longword(p2), 2);
                AddValNode(Format('%d', [vu]));
                end;
      XPoint:   begin
                vc:=Longword(p2);  Inc(Longword(p2), 4*2);
                AddValNode(Format('<%f; %f>',
                [Single(Pointer(vc)^), Single(Pointer(vc + 4)^)]));
                end;
      XFColor:   begin
                vc:=Longword(p2);  Inc(Longword(p2), 4*3);
                AddValNode(Format('<r:%f g:%f b:%f>',
                [Single(Pointer(vc)^), Single(Pointer(vc + 4)^), Single(Pointer(vc + 8)^)]));
                TmpNode.ImageIndex:=$01000000+ RGB(Round(Single(Pointer(vc)^)*255),
                        Round(Single(Pointer(vc + 4)^)*255), Round(Single(Pointer(vc + 8)^)*255));
                end;
      XBColor:  begin
                vc:=Longword(p2);  Inc(Longword(p2), 3);
                AddValNode(Format('<r:%d g:%d b:%d>',
                [byte(Pointer(vc)^), byte(Pointer(vc + 1)^), byte(Pointer(vc + 2)^)]));
                TmpNode.ImageIndex:=$01000000+ RGB(byte(Pointer(vc)^), byte(Pointer(vc+1)^), byte(Pointer(vc+2)^));
                end;
      XColor:   begin
                vc:=Longword(p2);  Inc(Longword(p2), 1*4);
                AddValNode(Format('<r:%d g:%d b:%d a:%d>',
                [byte(Pointer(vc)^), byte(Pointer(vc + 1)^), byte(Pointer(vc + 2)^), byte(Pointer(vc + 3)^)]));
                TmpNode.ImageIndex:=$01000000+ RGB(byte(Pointer(vc)^), byte(Pointer(vc + 1)^), byte(Pointer(vc + 2)^));
                end;
      end;
      CntrVal.IdName:=StrVal;
      TmpNode.Data:= CntrVal;
      result:=TmpNode;
      if DelVal then begin
        DelToP:=p2;
        p2:=DelFromTo(DelFromP,DelToP,XCntr);
      end;
      end;

     function AddVal(StrVal:String;XT:XValTypes;StrGet:Boolean=false):TTreeNode;
     begin
       Result:=AddChildF(TreeNode,StrVal,XT,StrGet);
     end;

     procedure LoadEnum(const EnumType: array of string);
     begin
        vl:=@EnumType;
        vsize:=High(EnumType);//StringListFromStrings(EnumType);
     end;

  procedure AddSetVal(Name: string;VType:XValTypes);
  var i:integer;
  SetCntr:TSetCntr;
  point:Pointer;
  begin
    point:=p2;
    k := TestByte128(p2);
    if k>0 then begin

      SetCntr:=TSetCntr.Create;
      SetCntr.Point:=point;
      SetCntr.XType:=VType;
      SetCntr.Cntr:=XCntr;
      SetCntr.Size:=k;

      TempNode := TreeView.Items.AddChild(TreeNode,
          Format('%s [%d]', [Name,k]));
    if k>1000 then
    for i := 1 to k do
        IncXValType(p2,VType)
    else
    for i := 1 to k do
        Result:=AddChildF(TempNode,Name,VType,false);

      TempNode.Data:=SetCntr;
    end;
  end;

    procedure AddFlag;
    var v: integer;
    begin
      AddVal('Name',XString);
      XCntr.Name := vs;
      TreeNode.Text:=GetXName(XCntr);
      AddVal('Flag',XInt);
    end;

    procedure AddSizeBox;
    begin
      TempNode := TreeView.Items.AddChild(TreeNode, 'BoundBox');
      px := Longword(p2); Inc(Longword(p2), 4*3*2);
      TreeView.Items.AddChild(TempNode,
        Format('MinVertex = <%.2f; %.2f; %.2f>',
        [Single(Pointer(px)^), Single(Pointer(px + 4)^), Single(Pointer(px + 8)^)]));
      Inc(px, 12);
      TreeView.Items.AddChild(TempNode,
        Format('MaxVertex = <%.2f; %.2f; %.2f>',
        [Single(Pointer(px)^), Single(Pointer(px + 4)^), Single(Pointer(px + 8)^)]));
      //if Integer(p2)<>0 then
     // inc(px);
      LoadEnum(UpdateMode);
      AddVal('BoundMode',XEnum);
    end;

    procedure AddDataName;
    begin
     if WR then begin  //4*4+4*3*2+4
      vc:=Longword(p2);
      s:=Format(' [%f; %f; %f; %f]',
                [Single(Pointer(vc)^), Single(Pointer(vc + 4)^), Single(Pointer(vc + 8)^),
                Single(Pointer(vc + 12)^)]);
      Inc(Longword(p2), 16);
      AddSizeBox;
      Inc(Longword(p2), 4);
      AddVal('Name',XString);
      XCntr.Name:=vs;
      TreeNode.Text:=GetXName(XCntr)+s;
     end else begin
     { vc:=Longword(p2);  Inc(Longword(p2), 4*4);
      //Bounds
      //BoundMode
      //Name
      s:=Format(' [%f; %f; %f; %f]',
                [Single(Pointer(vc)^), Single(Pointer(vc + 4)^), Single(Pointer(vc + 8)^),
                Single(Pointer(vc + 12)^)]);  }
      AddVal('Bounds',XSBound);
      LoadEnum(UpdateMode);
      AddVal('BoundMode',XEnum);
      AddVal('Name',XString);
      XCntr.Name:=vs;
      TreeNode.Text:=GetXName(XCntr);
     end;
    end;

    procedure WXFE_BaseItemDesc;
    begin
        //WXFE_BaseItemDesc
      AddVal('ItemName',XString);
      XCntr.Name:=vs;
      TreeNode.Text:=GetXName(XCntr);
      AddVal('EnableId',XString);
      AddVal('ControllerId',XString);
      AddSetNode('ChildrenItems');
    end;

    procedure WXFE_BaseGfxItemDesc;
    begin
//WXFE_BaseGfxItemDesc
      AddVal('Position',XVector);
      AddVal('Scale',XVector);
      AddVal('Orientation',XVector);
      LoadEnum(WXFE_ControlAnimsEnum);
      AddVal('Anim_Incoming',XEnum);
      AddVal('Anim_Outgoing',XEnum);
// WXFE_ControlAnimsEnum
//	WXFE_ControlAnimsEnum: array [0..29] of String = ('kANIM_None','kANIM_Click','kANIM_Click_Error','kANIM_Highlight','kANIM_In_BigBounce','kANIM_In_Flipy','kANIM_In_Next','kANIM_In_Prev','kANIM_In_ScaleHitXY','kANIM_In_ScaleY','kANIM_In_SlideX','kANIM_In_Speech','kANIM_In_SpringX','kANIM_In_SpringXY','kANIM_In_TitleUnderline','kANIM_In_ToolTip','kANIM_Out_Next','kANIM_Out_Prev','kANIM_Out_ScaleX','kANIM_Out_ScaleXY','kANIM_Out_ScaleY','kANIM_Out_Speech','kANIM_Out_TitleUnderline','kANIM_Out_ToolTip','kANIM_Reset','kANIM_Title_Scroll','kANIM_Wide_Highlight','kANIM_In_Chat','kANIM_Out_Chat','kANIM_LAST')
      AddVal('Anim_Spot',XString);
      LoadEnum(WXFE_ControlAudioEnum);
      AddVal('Audio_Incoming',XEnum);
      AddVal('Audio_Outgoing',XEnum);
// WXFE_ControlAudioEnum
//	WXFE_ControlAudioEnum: array [0..41] of String = ('kAUDIO_None','kAUDIO_Cancel','kAUDIO_Click','kAUDIO_Click2','kAUDIO_Click3','kAUDIO_Error','kAUDIO_Grenade','kAUDIO_Highlight','kAUDIO_In_BigBounce','kAUDIO_In_Book','kAUDIO_In_Controller','kAUDIO_In_CrateDice','kAUDIO_In_Custom','kAUDIO_In_Net','kAUDIO_In_Next','kAUDIO_In_Prev','kAUDIO_In_ScaleHitXY','kAUDIO_In_ScaleY','kAUDIO_In_SlideX','kAUDIO_In_SoundVid','kAUDIO_In_Speech','kAUDIO_In_SpringX','kAUDIO_In_WeaponFactory','kAUDIO_In_WormPot','kAUDIO_Out_Book','kAUDIO_Out_Next','kAUDIO_Out_Prev','kAUDIO_Out_Scale','kAUDIO_Out_ScaleXY','kAUDIO_Out_ScaleY','kAUDIO_Typewriter','kAUDIO_WormPot_Button','kAUDIO_WormPot_HandlePull','kAUDIO_WormPot_Intro','kAUDIO_WormPot_Nudge','kAUDIO_WormPot_Outro','kAUDIO_WormPot_Spin_Loop','kAUDIO_WormPot_Spin_Start','kAUDIO_WormPot_Spin_Stop','kAUDIO_Page_Turn','kAUDIO_Typewriter_Delete','kAUDIO_LAST')
      AddVal('Audio_Spot',XString);
      AddVal('Delay_Incoming',XInt);
      AddVal('Delay_Outgoing',XInt);
      AddVal('FontSizeOverride',XFloat);
      AddVal('LayerOffset',XInt);
      AddVal('LOCKED',XBool);
      WXFE_BaseItemDesc;
    end;

    procedure WXFE_BaseInputItemDesc;
    begin
      AddVal('ToolTipId',XString);
      AddVal('Navigate_Left',XString);
      AddVal('Navigate_Right',XString);
      AddVal('Navigate_Up',XString);
      AddVal('Navigate_Down',XString);
      LoadEnum(WXFE_ControlAnimsEnum);
      AddVal('Anim_Activated',XEnum);
      AddVal('Anim_Highlighted',XEnum);
      LoadEnum(WXFE_ControlAudioEnum);
      AddVal('Audio_Activated',XEnum);
      AddVal('Audio_Highlighted',XEnum);
      WXFE_BaseGfxItemDesc;
    end;

    procedure MeshObjectDesc;
    begin
      AddVal('MeshName',XString);
      AddVal('Anim_In_Mesh',XString);
      AddVal('Audio_In_Mesh',XString);
      AddVal('Delay_In_Mesh',XInt);
      AddVal('Anim_Spot_Mesh',XString);
      AddVal('Audio_Spot_Mesh',XString);
      AddVal('Anim_Out_Mesh',XString);
      AddVal('Audio_Out_Mesh',XString);
      AddVal('Delay_Out_Mesh',XInt);
      AddVal('Anim_Looping_Mesh',XString);
      AddVal('Audio_Looping_Mesh',XString);
      AddVal('Lighting',XBool);
      AddVal('ScaleResourceID',XString);
      AddVal('PositionResourceID',XString);
      AddVal('OrientationResourceID',XString);
      AddVal('WaitingGfxResource',XString);
      AddVal('WaitingScale',XVector);
      AddVal('WaitingPosition',XVector);
      AddVal('WaitTime',XInt);
      WXFE_BaseGfxItemDesc;
    end;

    procedure IconColumns;
    begin
      AddVal('IconName',XString);
      XCntr.Name:=vs;
      TreeNode.Text:=GetXName(XCntr);      
      AddVal('ScaleX',XFloat);
      AddVal('ScaleY',XFloat);
      AddVal('AutoScale',XBool);
      AddVal('WidthAdjust',XFloat);
      AddVal('InvisibleToBorder',XBool);
      AddVal('Colour_Normal',XColor);
      AddVal('Colour_Highlight',XColor);
      AddVal('Colour_Disabled',XColor);
      AddSetVal('Messages',XString);
    end;

    procedure StringColumns;
    begin
      AddVal('Text',XString);
      XCntr.Name:=vs;
      TreeNode.Text:=GetXName(XCntr);
      AddVal('Font',XString);
      AddVal('FontSize',XFloat);
      AddVal('Width',XFloat);
      AddVal('WidthIsInPercent',XBool);
      AddVal('ScaleTextToFit',XBool);
      AddVal('KeepWhiteSpace',XBool);
      LoadEnum(EdgeJustificationEnum);
      AddVal('Justification',XEnum);
      LoadEnum(WXFE_GradientColours);
      AddVal('ColourFRONT_Normal',XEnum);
      AddVal('ColourFRONT_Highlight',XEnum);
      AddVal('ColourFRONT_Disabled',XEnum);
      LoadEnum(WXFE_BackgroundColours);
      AddVal('ColourBACK_Normal',XEnum);
      AddVal('ColourBACK_Highlight',XEnum);
      AddVal('ColourBACK_Disabled',XEnum);
      LoadEnum(WXFE_TextAnimationEnum);
      AddVal('TextAnim',XEnum);
      AddVal('TextAnimSeed',XInt);
      AddVal('KeepJustification',XBool);
    end;    

    procedure WormDesc();
    begin
      AddVal('Hat',XString);
      AddVal('Glasses',XString);
      AddVal('Tash',XString);
      AddVal('Gloves',XString);
      AddVal('Interest',XString);
      AddVal('Mood',XString);
      AddVal('Anim',XString);
      AddVal('Coyness',XFloat);
      AddVal('EyeZone',XFloat);
      AddVal('BlendRate',XFloat);
      AddSetVal('RandomAnims',XString);
      AddVal('MinElapsTimeSecs',XInt);
      AddVal('MaxElapsTimeSecs',XInt);
      WXFE_BaseGfxItemDesc;
    end;

    procedure ParticleEmitter();
    begin
      AddSetNode('ParticleSet');  // XParticleSet
      //      AddIdxNode;//('Mesh',XCntr);

      AddVal('Name',XString);
      AddVal('Active',XBool);
      AddVal('MaxParticles',XInt); // dword_73C920
      AddVal('LifeSpan',XFloat);
      AddVal('EmitterStaysAliveWhenExpired',XBool);
      AddVal('GraphicalResource',XString);
      LoadEnum(BlendMode);
      AddVal('BlendMode',XEnum);
      AddVal('EmitterUsesWorldSpace',XBool);
      AddVal('EmitterXForm',XMatrix3);// unk_7471E4
      AddVal('GravityMatrix',XVector);//unk_7471CC
      AddVal('GravityMatrix',XVector);//unk_7471CC
      AddVal('GravityMatrix',XVector);//unk_7471CC
      AddVal('CameraMatrix',XMatrix3);//
      AddVal('MinSpreadAngle',XFloat);
      AddVal('MaxSpreadAngle',XFloat);
      AddVal('Gravity',XFloat);
      AddVal('Rate',XFloat);
      AddVal('RateDeviation',XFloat);
      LoadEnum(FadeMode);
      AddVal('FadeMode',XEnum);
      LoadEnum(ColourChange);
      AddVal('ColourChange',XEnum);
      LoadEnum(SizeChange);
      AddVal('SizeChange',XEnum);
      LoadEnum(EmitterShape);
      AddVal('EmitterShape',XEnum);
      AddVal('MaxEmitterRadius',XFloat);
      AddVal('MinEmitterRadius',XFloat);
      AddVal('BoundsSphereRadius',XFloat);
      AddVal('CylinderEmitterMinHeight',XFloat);
      AddVal('CylinderEmitterMaxHeight',XFloat);
      AddVal('InitialSpeed',XFloat);
      AddVal('InitialSpeedDeviation',XFloat);
      AddVal('InitialEnergy',XFloat);
      AddVal('EnergyDeviation',XFloat);
      AddVal('InitialSize',XFloat);
      AddVal('InitialSizeDeviation',XFloat);
      AddVal('FinalSizeFactor',XFloat);
      AddVal('InitialAlpha',XFloat);
      AddVal('TargetAlpha',XFloat);
      AddVal('FinalAlpha',XFloat);
      AddVal('FadeInEnergy',XFloat);
      AddVal('FadeOutEnergy',XFloat);
      AddVal('LinearVelocity',XVector);//  unk_74710C
      AddVal('RecurringLinearVelocityUpdate',XBool);
      AddVal('WindVector',XVector);
      AddVal('SecondaryEmitterContainerName',XString);
      AddVal('ParticleDeathEmitterContainerName',XString);
      AddSizeBox;
    end;

    procedure BaseWeapon(HasName:boolean=false);
    begin
      AddVal('DisplayName',XString);//
      if not WUM then begin
      AddVal('AnimDraw',Xstring);//
      AddVal('AnimAim',Xstring);//
      AddVal('AnimFire',Xstring);//
      AddVal('AnimHolding',Xstring);//
      AddVal('AnimEndFire',Xstring );//
      end;
      AddVal('WeaponGraphicsResourceID',Xstring);//
      if not HasName then begin
      XCntr.Name:=vs;
      TreeNode.Text:=GetXName(XCntr);
      end;
      LoadEnum(WeaponTypeEnum);
      AddVal('WeaponType',XEnum);//
      AddVal('DefaultPreference',XFloat);//
      AddVal('CurrentPreference',XFloat);//
      AddVal('LaunchDelay',XInt);//
      AddVal('PostLaunchDelay',XInt);//
      AddVal('FirstPersonOffset',XVector);//
      AddVal('FirstPersonScale',XVector);//
      if not WUM then begin
      AddVal('FirstPersonFiringParticleEffect',Xstring);//
      AddVal('FirstPersonDrawAnim',Xstring);//
      AddVal('FirstPersonWindUpAnim',Xstring);//
      AddVal('FirstPersonFireAnim',Xstring);//
      AddVal('FirstPersonWindDownAnim',Xstring);//
      AddVal('FirstPersonReloadAnim',Xstring);//
      AddVal('FirstPersonHideAnim',Xstring);//
      AddVal('FirstPersonIdleAnim',Xstring);//
      AddVal('FirstPersonHandDrawAnim',Xstring);//
      AddVal('FirstPersonHandWindUpAnim',Xstring);//
      AddVal('FirstPersonHandFireAnim',Xstring);//
      AddVal('FirstPersonHandWindDownAnim',Xstring);//
      AddVal('FirstPersonHandReloadAnim',Xstring);//
      AddVal('FirstPersonHandHideAnim',Xstring);//
      AddVal('FirstPersonHandIdleAnim',Xstring);//
      AddVal('DisplayInFirstPerson',Xbool);//
      AddVal('CanBeFiredWhenWormMoving',Xbool);//
      AddVal('RumbleLight',XByte);//
      AddVal('RumbleHeavy',XByte);//
      end;
      if WUM then begin
      AddVal('FirstPersonFiringParticleEffect',Xstring);//
      AddVal('HoldParticleFX',Xstring);//
      AddVal('DisplayInFirstPerson',Xbool);//
      AddVal('CanBeFiredWhenWormMoving',Xbool);//
      AddVal('RumbleLight',XByte);//
      AddVal('RumbleHeavy',XByte);//
      AddVal('CanBeUsedWhenTailNailed',Xbool);//

      AddVal('RetreatTimeOverride',Xint);//

      AddVal('WXAnimDraw',Xstring);//
      AddVal('WXAnimAim',Xstring);//
      AddVal('WXAnimFire',Xstring);//
      AddVal('WXAnimHolding',Xstring);//
      AddVal('WXAnimEndFire',Xstring );//
      AddVal('WXAnimTaunt',Xstring );//
      AddVal('WXAnimTargetSelected',Xstring );//
      AddVal('HoldLoopSfx',Xstring );//
      AddVal('EquipSfx',Xstring );//
      end;
    end;

    procedure PayloadWeapon(HasName:boolean=false);
    begin
      AddVal('IsAimedWeapon',XBool);
      AddVal('IsPoweredWeapon',XBool);
      AddVal('IsTargetingWeapon',XBool);
      if WUM then begin
      AddVal('IsControlledBomber',XBool);
      end;
      AddVal('IsBomberWeapon',XBool);
      AddVal('IsDirectionalWeapon',XBool);
      AddVal('IsHoming',XBool);
      AddVal('IsLowGravity',XBool);
      AddVal('IsLaunchedFromWorm',XBool);
      AddVal('HasAdjustableFuse',XBool);
      AddVal('HasAdjustableBounce',XBool);
      AddVal('HasAdjustableHerd',XBool);
      AddVal('IsAffectedByGravity',XBool);
      AddVal('IsAffectedByWind',XBool);
      if WUM then begin
      AddVal('EndTurnImmediate',XBool);
      AddVal('UseParabolicRetical',XBool);
      end;
      AddVal('ColliderFlags',XInt);
      AddSetVal('CameraID',XString);
      AddVal('PayloadGraphicsResourceID',XString);
      if not HasName then begin
      XCntr.Name:=vs;
      TreeNode.Text:=GetXName(XCntr);
      end;
      if WUM then begin
      AddVal('Payload2ndGraphicsResourceID',XString);
      end;
      AddVal('Scale',XFloat);
      AddVal('Radius',XFloat);

      AddVal('AnimTravel',XString);
      AddVal('AnimSmallJump',XString);
      AddVal('AnimBigJump',XString);
      AddVal('AnimArm',XString);
      AddVal('AnimSplashdown',XString);
      AddVal('AnimSink',XString);
      if WUM then begin
      AddVal('AnimIntermediate',XString);
      AddVal('AnimImpact',XString);
      end;
      AddVal('DirectionBlend',XFloat);
      if WUM then begin
      AddVal('FuseTimerGraphicOffset',XFloat);
      AddVal('FuseTimerScale',XFloat);
      end;
      AddVal('BasePower',XFloat);
      AddVal('MaxPower',XFloat);
      AddVal('MinTerminalVelocity',XFloat);
      AddVal('MaxTerminalVelocity',XFloat);
      AddVal('LogicalLaunchZOffset',XFloat);
      if WUM then begin
      AddVal('LogicalLaunchYOffset',XFloat);
      end;
      AddVal('OrientationOption',XInt);
      AddVal('SpinSpeed',XFloat);
      AddVal('InterPayloadDelay',XInt);
      if WUM then begin
      AddVal('MinAimAngle',XFloat);
      AddVal('MaxAimAngle',XFloat);
      end;
      AddVal('DetonatesOnLandImpact',XBool);
      AddVal('DetonatesOnExpiry',XBool);
      AddVal('DetonatesOnObjectImpact',XBool);
      AddVal('DetonatesOnWormImpact',XBool);
      AddVal('DetonatesAtRest',XBool);
      AddVal('DetonatesOnFirePress',XBool);
      AddVal('DetonatesWhenCantJump',XBool);
      if WUM then begin
      AddVal('DetonateMultiEffect',XInt);
      AddVal('WormCollideResponse',XFloat);
      end;
      AddVal('WormDamageMagnitude',XFloat);
      AddVal('ImpulseMagnitude',XFloat);
      AddVal('WormDamageRadius',XFloat);
      AddVal('LandDamageRadius',XFloat);
      AddVal('ImpulseRadius',XFloat);
      AddVal('ImpulseOffset',XFloat);
      AddVal('Mass',XFloat);
      if WUM then begin
      AddVal('WormImpactDamage',XFloat);
      end;
      AddVal('MaxPowerUp',XInt);
      AddVal('TangentialMinBounceDamping',XFloat);
      AddVal('ParallelMinBounceDamping',XFloat);
      AddVal('TangentialMaxBounceDamping',XFloat);
      AddVal('ParallelMaxBounceDamping',XFloat);
      AddVal('SkimsOnWater',XBool);
      AddVal('MinSpeedForSkim',XFloat);
      AddVal('MaxAngleForSkim',XFloat);
      AddVal('SkimDamping',XVector);
      AddVal('SinkDepth',XFloat); ///////
      if WUM then
      AddVal('NumStrikeBombs',XInt);
      AddVal('NumBomblets',XInt);
      AddVal('BombletMaxConeAngle',XFloat);
      AddVal('BombletMaxSpeed',XFloat);
      AddVal('BombletMinSpeed',XFloat);
      AddVal('BombletWeaponName',XString);
      AddVal('FxLocator',XString);
      AddVal('ArielFx',XString);
      AddVal('DetonationFx',XString);
      AddVal('DetonationSfx',XString);
      AddVal('ExpiryFx',XString);
      AddVal('SplashFx',XString);
      AddVal('SplishFx',XString);
      AddVal('SinkingFx',XString);
      AddVal('BounceFx',XString);
      AddVal('StopFxAtRest',XBool);  
      AddVal('BounceSfx',XString );
      AddVal('PreDetonationSfx',XString);
      AddVal('ArmSfx1Shot',XString);
      AddVal('ArmSfxLoop',XString);
      AddVal('LaunchSfx',XString );
      AddVal('LoopSfx',XString);
      AddVal('BigJumpSfx',XString);
      AddVal('WalkSfx',XString);
      AddVal('TrailBitmap',XString);
      AddVal('TrailLocator1',XString);
      AddVal('TrailLocator2',XString);
      AddVal('TrailLength',XInt);
      AddVal('AttachedMesh',XString);
      AddVal('AttachedMeshScale',XFloat);
      AddVal('StartsArmed',Xbool);
      if WUM then begin
      AddVal('ArmOnImpact',Xbool);
      end;
      if not WUM then begin
      AddVal('RetreatTimeOverride',XInt);//?
      end;
      AddVal('ArmingCourtesyTime',XInt);//
      AddVal('PreDetonationTime',XInt);//
      AddVal('ArmingRadius',XFloat);//
      AddVal('LifeTime',XInt);//
      AddVal('IsFuseDisplayed',Xbool);//
      BaseWeapon(true);
    end;

    procedure JumpingPayloadWeapon;
    begin
      AddVal('SmallJumpHorizontalSpeed',XFloat);
      AddVal('SmallJumpMinVerticalSpeed',XFloat);
      AddVal('SmallJumpMaxVerticalSpeed',XFloat);
      AddVal('BigJumpHorizontalSpeed',XFloat);
      AddVal('BigJumpMinVerticalSpeed',XFloat);
      AddVal('BigJumpMaxVerticalSpeed',XFloat);
      AddVal('MaxDrop',XFloat);
      AddVal('ReturnProbability',XFloat);
      AddVal('MinTimeForSafeJump',XInt);
      PayloadWeapon;
    end;


    procedure AddTagTimeCritical;
    begin
      AddVal('Tag',XString);
      AddVal('Time',XInt);
      AddVal('Critical',XBool);
    end;

    procedure TextBoxRead;
    begin
    if WUM then begin
//WXFE_TextBoxDesc
      AddVal('FontName',XString);
      AddVal('TextGameDataId',XString);
      LoadEnum(WXFE_BorderTypeEnum);
      AddVal('Border_Normal',XEnum);
      AddVal('Border_Disabled',XEnum);
      AddVal('Border_Highlight',XEnum);
      AddVal('Border_Active',XEnum);
      LoadEnum(EdgeJustificationEnum);
      AddVal('Justification',XEnum);
      AddVal('BorderSize',XFloat);
      AddVal('AutoScrollSpeed',XFloat);
      AddVal('AutoScrollDelay',XInt);
      AddVal('AutoScale',XBool);
      LoadEnum(WXFE_GradientColours);
      AddVal('Colour_Front',XEnum);
      AddVal('Colour_Front_Edit',XEnum);
      AddVal('Colour_Front_Highlight',XEnum);
      AddVal('Colour_Front_Disabled',XEnum);
      LoadEnum(WXFE_BackgroundColours);
      AddVal('Colour_Back_Highlight',XEnum);
      AddVal('Colour_Back_Disabled',XEnum);
      AddVal('Colour_Back_Edit',XEnum);
      AddVal('Colour_Back',XEnum);
      LoadEnum(WXFE_TextAnimationEnum);
      AddVal('TextAnim',XEnum);
      AddVal('TextAnimSeed',XInt);
      AddVal('VisibilityId',XString); //	2
    end else begin
      AddVal('ResourceName',XString);
      AddVal('TextGameDataId',XString);
      AddVal('TextColourResource',XString);
      LoadEnum(ButtonColourEnum);
      AddVal('BorderColour',XEnum);
      LoadEnum(EdgeJustificationEnum);
      AddVal('Justification',XEnum);
      AddVal('BorderSize',XFloat);
      AddVal('AutoScroll',XBool);
      AddVal('AutoScale',XBool);
      AddVal('Colour',XInt);
      AddVal('Animate',XString);
    end;
    end;

    procedure ListBoxColumnRead;
    begin
      AddVal('ColumnName',XString);
      XCntr.Name:=vs;
      TreeNode.Text:=GetXName(XCntr);
      AddVal('WidthPercent',XFloat);
      AddVal('Ratio',XFloat);
      LoadEnum(EdgeJustificationEnum);
      AddVal('Justification',XEnum);
      AddVal('UnevenColumns',XBool);
      AddSetVal('Values',XString);
      AddSetVal('Data',XString);
    end;

    procedure ListControlRead;
    begin
      AddVal('TextColourResource',XString);
      AddVal('GameDataId',XString);
      AddVal('HighlightedMessage',XString);
      AddVal('SelectedMessage',XString);
      LoadEnum(ButtonColourEnum);
      AddVal('BorderColour',XEnum);
      AddVal('SliderAlwaysOn',XBool);
      AddVal('SliderTabExpand',XBool);
      LoadEnum(RowBackgroundType);
      AddVal('BackGroundType',XEnum);
      AddVal('ItemHeight',XFloat);
      AddVal('BorderSize',XFloat);
      AddVal('AlwaysActive',XBool);
      AddVal('AutoScroll',XBool);
    end;
    
    procedure MenuButoonRead;
    begin
      AddVal('ResourceName',XString);
      AddVal('HighlightedMessage',XString);
      AddVal('SelectedMessage',XString);
      AddVal('BorderResource',XString);
      LoadEnum(ButtonColourEnum);
      AddVal('BorderColour',XEnum);
      AddVal('SquareButton',XBool);
      AddVal('BorderBehind',XBool);
      AddVal('HighlightSize',XFloat);
      AddVal('OnRelease',XBool);
    end;

   procedure DescRead;
   begin
      AddVal('StartDelay',XInt);
      AddVal('EndDelay',XInt);
      AddVal('Position',XVector);
      AddVal('Scale',XVector);
      AddVal('IncomingAnimation',XString);
      AddVal('OutgoingAnimation',XString);
      AddVal('HighlightedAnimation',XString);
      AddVal('ActivatedAnimation',XString);
      AddVal('ItemName',XString);
      XCntr.Name:=vs;
      TreeNode.Text:=GetXName(XCntr);
      AddVal('LeftItem',XString);
      AddVal('RightItem',XString);
      AddVal('UpItem',XString);
      AddVal('DownItem',XString);
      AddVal('ToolTipId',XString);
      AddVal('FontSizeOverride',XFloat);
      AddVal('EnableSwitch',XString);
      AddVal('IncomingAudio',XString);
      AddVal('OutgoingAudio',XString);
      AddVal('HighlightedAudio',XString);
      AddVal('ActivatedAudio',XString);
   end;

   procedure CameraPropRead;
   begin
      AddVal('AntiGimScale',XFloat);
      AddVal('DblHitThres',XInt);
      AddVal('DefaultHeight',XFloat);
      AddVal('DistFromObject',XFloat);
      AddVal('HeightSpeed',XFloat);
      AddVal('LkAboveSpdScale',XFloat);
      AddVal('LookAboveObject',XFloat);
      AddVal('LookAheadScale',XFloat);
      AddVal('LookAheadSpeed',XFloat);
      AddVal('LookUpdateSpeed',XFloat);
      AddVal('MaxHeight',XFloat);
      AddVal('MaxLkAheadDist',XFloat);
      AddVal('MaxLookAboveObj',XFloat);
      AddVal('MinHeight',XFloat);
      AddVal('MinLookAt',XFloat);
      AddVal('MinPosition',XFloat);
      AddVal('MinZoomDist',XFloat);
	AddVal('MouseXSpeed',XFloat);
	AddVal('MouseYSpeed',XFloat);
	AddVal('OccDestSize',XFloat);
	AddVal('OccHeightSpeed',XFloat);
	AddVal('OcclusionSize',XFloat);
	AddVal('OccYawSpeed',XFloat);
	AddVal('OccZoomInSpeed',XFloat);
	AddVal('OccZoomOutSpeed',XFloat);
	AddVal('TimeBeforeZoomOut',XInt);
	AddVal('PosUpdateSpeed',XFloat);
	AddVal('StartYaw',XFloat);
	AddVal('UpUpdateSpeed',XFloat);
	AddVal('YawSpeed',XFloat);
	AddVal('ZoomOffsetDist',XFloat);
	AddVal('TailOffset',XVector);
        AddVal('HeadOffset',XVector);
   end;

   procedure XPfxEmitterGeomRead;
   begin
      AddVal('Enabled',XBool);
      Inc(Longword(p2), 4*6+4);
     // BoundBox
     // BoundMode
      AddVal('EmitterPosition',XVector);
      AddVal('EmitterRotation',XVector);
      AddVal('EmitterRotationQuat',XFloat);
      AddVal('InheritPositionalVelocity',XFloat);
      AddVal('InheritRotationalVelocity',XFloat);
      AddVal('Visible',XBool);
      AddVal('CastShadows',XBool);
      AddVal('DrawAsMesh',XBool);
      AddVal('StartEmitterOnBirth',XBool);
      AddVal('MaxParticles',XInt);
      AddVal('StartTimeDelay',XFloat);
      AddSetNode('EmissionModules');
      AddSetNode('Modules');
      AddIdxNode;//MeshGeoSet
      AddVal('RenderAsFlags',XInt);
      AddVal('PromoteToSmokeAge',XFloat);
      AddVal('ParticlesLoop',XBool);
      AddVal('ParticlesLoopStartAge',XFloat);
      AddVal('ParticlesLoopEndAge',XFloat);
      AddVal('ParticlesLoopQuickEnd',XBool);
      AddVal('EmitterLifeSpan',XFloat);
      AddSetNode('trackingEmitters');
    {  AddVal('EmitterFirstEmit',XFloat);
      AddVal('IsInitialized',XBool);
      AddSetVal('Positions',XVector);
      AddSetVal('Scales',XVector);
      AddSetVal('Rotations',XVector);
       AddSetVal('Indexs',XInt);
      AddSetVal('UserData',XInt);
      AddSetVal('ParticleIDs',XInt);
      AddVal('TrackParticleIDx',XInt);
      AddSetVal('TrackingEmitters',XString);
      AddSetVal('PositionalVelocitys',XVector);
      AddSetVal('RotationalVelocitys',XVector);
      AddSetVal('ScaleVelocitys',XVector);
      AddVal('LastEmittedParticleID',XInt);
      AddVal('PrevLastActiveParticle',XInt);
      AddVal('Active',XBool);
      AddVal('CameraPositionUniform',XInt);
      AddVal('CameraUpUniform',XInt);
      AddVal('CameraLookAtUniform',XInt);
      AddVal('cgPositions',XInt);
      AddVal('cgScales',XInt);
      AddVal('cgRotations',XInt);
      AddVal('cgUserData',XInt);   }
   end;

    procedure LockVals;
    begin
      AddVal('Name',XString);
      XCntr.Name:=vs;
      TreeNode.Text:=GetXName(XCntr);
      AddVal('Icon',XInt);
      AddVal('Locked',XBool);
      AddVal('DisplayInList',XBool);
    end;

begin
if (XCntr <> nil) then begin

  if (Length(TreeArray)>0) and (not TreeArray[XCntr.Index]) and (XCntr.Xtype<>XNone)
  then
  begin
    Inc(TreeCount);
    TreeArray[XCntr.Index]   := true;
    But.TreeProgress.Position:= TreeCount;
  end;

  if ReBuild and XCntr.ReBuild then exit;
  XCntr.ClearChilds;  // проблема первая, иногда индексы повторяются
  DelVal:=false;
try

  case XCntr.Xtype of
    XGraphSet:
    begin
      AddNode(GetXName(XCntr),4);

      p2 := XCntr.point;
      k := GetSize128(p2,XCntr);
      for x := 1 to k do
      begin
        Inc(Longword(p2), 16);
        k3 := GetIdx128(p2,XCntr);
        TempNode := TreeView.Items.AddChild(TreeNode,
          Format('<%s>', [GetStr128(p2,XCntr)]));
        AddClassTree(XCntr.AddChild(k3), TreeView, TempNode);
        if TreeNode.Level>6 then break;
      end;
    end;
    XXomInfoNode:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      k := GetSize128(p2,XCntr);
      for x := 1 to k do
        AddIdxNode;
    end;
    WXTemplateSet,W3DTemplateSet:
    begin
      AddNode('');
      p2 := XCntr.GetPoint;
      AddSetNode('Templates');
      AddDataName;
    end;
    XStreamSet:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddSetNode('SystemStreams');
      AddSetNode('VertexStreams');
      AddIdxNode; //WeightSet
    end;
    XSpriteSet,
    XBillboardSpriteSet,
    XPlaneAlignedSpriteSet:
    begin
      AddNode(GetXName(XCntr));
      {
04 00 00 00 00 00 00 00
00 B7 43 3A D1 B7 43 3A
D1 B7 43 3A D1 B7 43 3A
51 B7 43 3A 51 B7 43 3A
51 00 00 00 00
}
     { FrameNumber
      Position
      Rotation
      Size
      Color
      Enable
      CurrentVBStride
      IndexAPIHandle
      CurrentMaxSpriteCount
      RenderHints  }
    end;
    XSpriteSetDescriptor:
    begin
      if TreeNode <> nil then
      begin
        TreeNode.ImageIndex := 1;
        TreeNode.SelectedIndex := 1;
      end;
      p2 := XCntr.point;
      XCntr.Name := GetStr128(p2,XCntr);
      if WUM then Inc(Longword(p2));
      AddNode('XBaseResourceDescriptor::'+GetXName(XCntr),20);
      Inc(Longword(p2), 1);
      AddIdxNode;
     // AddIdxNode;
    end;
    XDirectMusicDescriptor:
    begin
      p2 := XCntr.point;
      XCntr.Name := GetStr128(p2,XCntr);
      AddNode(GetXName(XCntr),25);
      AddVal('str1',XString);
      AddVal('Int1',XInt);
    end;
    XNullDescriptor:
    begin
      p2 := XCntr.point;
      XCntr.Name := GetStr128(p2,XCntr);
      AddNode('XBaseResourceDescriptor::'+GetXName(XCntr),20);
      if WUM then  Inc(Longword(p2));
      k := TestByte128(p2);
    end;
    XTextDescriptor:
    begin
      p2 := XCntr.point;
      XCntr.Name := GetStr128(p2,XCntr);
      AddNode('XBaseResourceDescriptor::'+GetXName(XCntr),20);
      if WUM then  Inc(Longword(p2));
      k := TestByte128(p2); //1  number    // TextGroup
      // AddClassTree(k3,TreeView,TempNode);
      k3 := GetIdx128(p2,XCntr); //2  link
      AddClassTree(XCntr.AddChild(k3), TreeView, TreeNode);
      if WR then  Inc(Longword(p2), 2);
      k := Word(p2^);       // size   // NumChars
      if WR then begin
              Inc(Longword(p2), 23);
      end else
      Inc(Longword(p2), 4); // 1        

      TempNode := TreeView.Items.AddChild(TreeNode,
        Format('NumChars [%d]', [k]));
      for x := 1 to k do
      begin
        s1 := Format('Index [%d] MappedVal [%d] Unicode [%x] ',
          [Word(p2^), Word(Pointer(Longword(p2) + 2)^), Word(Pointer(Longword(p2) + 4)^)]);
        Inc(Longword(p2), 6);  //Index // MappedVal //Unicode
        TreeView.Items.AddChild(TempNode, s1);
      end;
    end;
    XMeshDescriptor:
    begin
      if TreeNode <> nil then
      begin
        TreeNode.ImageIndex := 2;
        TreeNode.SelectedIndex := 2;
      end;
      p2 := XCntr.point;
      XCntr.Name := GetStr128(p2,XCntr);
      AddNode('XBaseResourceDescriptor::'+GetXName(XCntr),20);
      if WUM then Inc(Longword(p2));
      k := Byte(p2^);
      Inc(Longword(p2));
      AddIdxNode;
      Inc(Longword(p2), 2);// 80 00
    end;
    XCustomDescriptor:
    begin
      p2 := XCntr.point;
      XCntr.Name := GetStr128(p2,XCntr);
      AddNode('XBaseResourceDescriptor::'+GetXName(XCntr),20);
      if WUM then  Inc(Longword(p2));
      Inc(Longword(p2), 3);
    end;
    XBitmapDescriptor:
    begin
      if TreeNode <> nil then
      begin
        TreeNode.ImageIndex := 3;
        TreeNode.SelectedIndex := 3;
      end;
      p2 := XCntr.point;
      XCntr.Name := GetStr128(p2,XCntr);
      AddNode('XBaseResourceDescriptor::'+GetXName(XCntr),20);
      if WUM then  Inc(Longword(p2));
      Inc(Longword(p2));
      k3 := GetIdx128(p2,XCntr);
      s := Format(' [%dx%d]',
        [Word(p2^), Word(Pointer(Longword(p2) + 2)^)]);
      TreeNode.Text := TreeNode.Text + s;
      AddClassTree(XCntr.AddChild(k3), TreeView, TreeNode);
    end;
    TeamDataColective,TeamDataCollective:
    begin
    AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddSetNode('Teams');
      AddSetNode('HighScores');
    end;
    SchemeDataContainer:
    begin
      p2 := XCntr.GetPoint;
      AddNode(GetXName(XCntr));
      AddVal('Name',XString);
      AddVal('Lock',XString);
      AddVal('ToolTip',XString);
      AddVal('Available',XBool);
      AddVal('OverrideInventory',XBool);
      AddVal('WormSelectMode',XBool);
      AddVal('HealthInCrates',XInt);
      AddVal('CrateProbability',XInt);
      AddVal('BoobyTrapProbability',XInt);
      AddVal('TurnTime',XInt);
      AddVal('SuddenDeathTime',XInt);
      AddVal('RetreatTime',XInt);
      AddVal('HotSeatTime',XInt);
      AddVal('SuddenDeathMode',XInt);
      AddVal('ResourceMax',XInt);
      AddVal('NumRandomMines',XInt);
      AddVal('NumRandomOilDrums',XInt);  
      AddVal('DoubleDamageCrate',XBool);
      AddVal('DoubleTimeCrate',XBool);
      AddVal('CrateShowerCrate',XBool);
      AddVal('CrateSpyCrate',Xbool);
      AddVal('WeaponProbability',Xbyte);
      AddVal('UtilityProbability',Xbyte);
      AddVal('BuildingProbability',Xbyte);
      AddVal('HealthProbability',Xbyte);
      AddVal('ArtilleryMode',XInt);
      AddVal('FallDamage',XInt);
      AddVal('Stockpiling',XInt);
      AddVal('Wins',XInt);
      AddVal('WormHealth',XInt);
      AddVal('MineFuseTime',XFloat);   //1 4
      AddVal('FortModeA',XInt);     //1  2
      AddVal('FortModeB',XInt);      //1 2
      AddVal('FortModeC',XInt);       //1  2
      k:=55;
      for x := 1 to k do begin
          TempNode:=AddIdxNode;
          TempNode.Text:=format('%s "%s"',[TempNode.Text,WFWeapon[x]])
          end;
    end;
    SchemeData:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('Name',XString);
      XCntr.Name:=vs;
      TreeNode.Text:=GetXName(XCntr);
      AddVal('Permanent',XBool);
      if W3D then AddVal('Available',XString) else
      AddVal('Lock',XString);
      k:=54;
      if WUM then k:=58;
      if W4 then k:=57;
      for x := 1 to k do begin
          TempNode:=AddIdxNode;
          if WUM then TempNode.Text:=format('%s "%s"',[TempNode.Text,WUMWeapon[x]])
          else if W4 then TempNode.Text:=format('%s "%s"',[TempNode.Text,W4Weapon[x]]) else
          TempNode.Text:=format('%s "%s"',[TempNode.Text,W3DWeapon[x]])
          end;
      if WUM then begin
    //  TempNode:=AddIdxNode;
     // TempNode.Text:='AssistedShotSettings';  // deleted v2
      AddVal('AssistedShotLevel',XString); // schema2
      end;
      AddVal('ArtileryMode',XInt);
      AddVal('TeleportIn',XInt);
      AddVal('Wins',XInt);
      AddVal('WormSelect',XInt);
      AddVal('WormHealth',XInt);
      AddVal('RoundTime',XInt);
      AddVal('TurnTime',XInt);
      AddVal('Objects',XInt);
      if WUM or W4  then begin
      AddVal('RandomCrateChancePerTurn',XInt);
      AddVal('MysteryChance',XInt);
      end;
      AddVal('WeaponChance',XInt);
      AddVal('UtilityChance',XInt);
      AddVal('HealthChance',XInt);
      AddVal('HealthInCrates',XInt);
      AddVal('Stockpiling',XInt);
      AddVal('SuddenDeath',XInt);
      AddVal('WaterSpeed',XInt);
      AddVal('DisplayTime',XInt);
      AddVal('LandTime',XInt);
      AddVal('RopeTime',XInt);
      AddVal('FallDamage',XInt);
      AddVal('HotSeat',XInt);
      AddVal('Special',XInt);

      AddVal('MineFuse',XInt);
      if WUM or W4 then begin
      AddVal('HelpPanelDelay',XInt);
      AddVal('MineFactoryOn',XBool);
      AddVal('TelepadsOn',XBool);
      AddVal('WindMaxStrength',XInt);
      end;
    end;
    LockedContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      if W3D then begin
      AddVal('Locked',XBool);
      AddVal('LockedTitle',XString);
      LoadEnum(LockedTypeEnum);
      AddVal('LockedIcon',XEnum);
      end else begin
      AddVal('Lock',XBool);
      AddVal('LockKey',XString);
      AddVal('Type',XInt);
      end;
    end;
    StatsContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddSetVal('Value',XInt);
    end;
    DamageStatsContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddSetVal('RecipientTasks',XInt);
      AddSetVal('SenderTasks',XInt);
      AddSetVal('WeaponNames',XInt);
    end;
    StoredStatsCollective:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      if W3D then
      AddSetNode('Shots'); // StatsContainer
      if WUM then begin
      AddSetNode('WormStats');  // StatsContainer
      AddSetNode('TeamStats');   // StatsContainer
      AddSetVal('TeamNames',XString);
      end;
    end;
    ProfileAchievementsContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddSetNode('ProfileProgress'); // AchievementsProgressContainer
    end;
    AchievementsProgressContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddSetVal('OnlineRankedMatchesWon',XInt);
      AddVal('TotalWormsKilled',XInt);
      AddVal('EasterEggsFound',XInt);
      AddVal('OnlineMatchesCompleted',XInt);
      AddVal('TotalWeaponFactoryDamage',XInt);
      AddVal('FourPlayerMatchesPlayed',XInt);  //	2
      AddVal('RankedUpProgress',XInt);//	2
      AddVal('WormicideProgress',XInt); //	2
      AddVal('GenghisWormProgress',XInt); //	2
      AddVal('LovesAChallengeProgress',XInt);  //	2
      AddVal('DaveyJonesProgress',XInt); //	2
      AddVal('DaveyJonesReturnsProgress',XInt); //	8
      AddVal('FingerOfDeathProgress',XInt);  //	2
      AddVal('EmbraceTheDarknessProgress',XInt); //	2
      AddVal('DoingItSoloProgress',XInt); //	2
      AddVal('NoChallengeAtAllProgress',XInt); //	2
      AddVal('TimeForAChallengeProgress',XInt); //	2
    //  AddVal('TimeAttackedProgress',XInt); //	Obsolete4
      AddVal('ClockWatchingProgress',XInt); //	2
      AddVal('ClockWatchingPS3Progress',XInt); //	Scheme4
      AddVal('AlexanderTheWormProgress',XInt); //	2
      AddSetVal('ILoveNewProgress',XInt);  //	2
      AddSetVal('DedicatedRankerProgress',XInt); //	2
  //    AddVal('EggHunterProgress',XInt);  //	2   8
      AddVal('FeelThePowerOfTheDarksideProgress',XInt); //	2
      AddVal('TutorialsDone',XInt); //	3
      AddVal('AllTutorialsDone',XBool); //	3
      AddVal('AllMissionsDone',XBool);  //	3
      AddVal('WelcomeMovieViewed',XBool); //	7
      AddSetVal('StoryMissionsCompleted',XInt);  //	3
      AddVal('StoryChapter',XInt); //	3
      AddVal('w3dMissionsComplete',XInt); //	3
      AddVal('w3dMissionsCompleteExtra',XInt); //	3
      AddSetNode('CachedLBData'); // CachedLeaderBoardWrite  //	5
    end;
    CachedLeaderBoardWrite:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('HavePosted',XBool);
      AddVal('AmCurrentlyPosting',XBool);
      AddVal('IsValid',XBool);
      AddVal('Value',XInt);
    end;
    TeamAwardsContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddSetVal('AwardsReceived',XInt);
    end;
    WormStatsContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('PositiveDamage',XInt);
      AddVal('PositiveKills',XInt);
      AddVal('ShotsFired',XInt);
      AddVal('ShotsMissed',XInt);
      AddVal('SurvivalTime',XInt);
      AddVal('StrategyPoints',XInt);
      AddVal('BoringPoints',XInt);
      AddVal('NegativeDamage',XInt);
      AddVal('CratesCollected',XInt);
      AddVal('RopesUsed',XInt);
      AddVal('BestShotDamage',XInt);
      AddVal('BestShotKills',XInt);
    end;
    WormDataContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('Name',XString);
      AddVal('Active',XBool);
      if WUM then AddVal('PlayedInGame',XBool);
      AddVal('Position',XVector);
      if WUM then begin
      AddVal('ForcedCameraOffset',XVector);
      AddVal('Velocity',XVector);
      AddVal('Aftertouch',XVector);
      AddVal('InputImpulse',XVector);
      AddVal('Acceleration',XVector);
      AddVal('SupportNormal',XVector);
      end;
      AddVal('Orientation',XVector);
      if WUM then begin
      AddVal('AngularVelocity',XVector);
      AddVal('ControlX',XFloat);
      AddVal('ControlY',XFloat);
      AddVal('LastLogicalUpdate',XInt);
      AddVal('SupportFrame',XUInt);
      AddVal('SupportVoxel',XUInt);
      AddVal('WeaponAngle',XFloat);
      AddVal('WeaponFuse',XInt);
      AddVal('WeaponIsBounceMax',XBool);
      AddVal('WeaponHerd',XInt);   //
      AddVal('TeamIndex',XByte);
      AddVal('PositionInTeam',XByte);
      AddVal('PhysicsOverride',XInt);
      AddVal('Flags',XInt);
      LoadEnum(WXWormPhysicsStateEnum);
      AddVal('PhysicsState',XEnum);
      LoadEnum(WUMWeaponNameEnum);
      AddVal('WeaponIndex',XEnum);
      AddVal('InitialEnergy',XInt);
      AddVal('Energy',XUint);   //    4    2
      AddVal('CPUFixedWeapon',XByte);  //2  1
      AddVal('CPUActionRadius',XUint);  //2  2
      AddVal('ArtilleryMode',XBool);   //1   1
      AddVal('PoisonRate',XInt);       //4  4
      AddVal('PendingPoison',XInt);     //4  4
      AddVal('PlaceWormAtPosition',XBool); // 1
      AddSetVal('PoolDamagePending',XInt);// ?
      AddVal('SfxBankName',XString);
      AddVal('Spawn',XString);
      AddVal('IsParachuteSpawn',XBool);
      AddVal('IsAllowedToTakeTurn',XBool);
      AddVal('GunWobblePitch',XFloat);
      AddVal('GunWobbleYaw',XFloat);
      AddVal('LipSynchBank',XByte);
      AddVal('ATT_Hat',XString);
      AddVal('ATT_Glasses',XString);  //
      AddVal('ATT_Gloves',XString);
      AddVal('ATT_Tash',XString);
      AddVal('MovedByImpulse',XBool);
      end;
      AddVal('GraphicalOrientation',XVector);
      AddVal('Scale',XVector);
      if W3D then AddVal('Velocity',XVector);
      AddVal('LastCollisionNormal',XVector);
      AddVal('LogicAnimState',XInt);
      AddVal('SlopeAngle',XFloat);
      if W3D then begin
      LoadEnum(WeaponNameEnum);
      AddVal('WeaponIndex',XEnum);
      AddVal('WeaponAngle',XFloat);
      AddVal('WeaponFuse',XInt);
      AddVal('WeaponIsBounceMax',XBool);
      AddVal('WeaponHerd',XInt);   //
      AddVal('TeamIndex',XByte);
      AddVal('Energy',XUint);
      AddVal('Vital',XBool);
      AddVal('CPUFixedWeapon',XByte);
      AddVal('CPUActionRadius',XUint);
      AddVal('ArtilleryMode',XBool);
      AddVal('PoisonRate',XInt);
      AddVal('PendingPoison',XInt);
      AddVal('PlaceWormAtPosition',XBool);
      end;
      AddVal('DamagePending',XInt);
      if W3D then
      AddVal('InitialEnegry',XInt);
      AddVal('CurrentEnergy',XInt);
      if W3D then begin
      AddVal('SfxBankName',XString);
      AddVal('Spawn',XString);
      end;
      AddVal('IsAfterTouching',XBool);
      AddVal('AfterTouchVector',XVector);
      if W3D then begin
      AddVal('IsParachuteSpawn',XBool);
      AddVal('IsAllowedToTakeTurn',XBool);
      end;
      AddVal('IsHatWearer',XBool);
      if W3D then begin
      AddVal('GunWobblePitch',XFloat);
      AddVal('GunWobbleYaw',XFloat);
      end;
      AddVal('IsQuickWalking',XBool);
      AddVal('AllowBazooka',XByte);
      AddVal('AllowGrenade',XByte);
      AddVal('AllowClusterGrenade',XByte);
      AddVal('AllowAirstrike',XByte);
      AddVal('AllowDynamite',XByte);
      AddVal('AllowHolyHandGrenade',XByte);
      AddVal('AllowBananaBomb',XByte);
      AddVal('AllowLandmine',XByte);
      AddVal('AllowShotgun',XByte);
      if W3D then
      AddVal('AllowUzi',XByte);
      AddVal('AllowBaseballBat',XByte);
      AddVal('AllowProd',XByte);
      if W3D then
      AddVal('AllowVikingAxe',XByte);
      AddVal('AllowFirePunch',XByte);
      AddVal('AllowHomingMissile',XByte);
      if W3D then begin
      AddVal('AllowMortar',XByte);
      AddVal('AllowHomingPidgeon',XByte);
      AddVal('AllowEarthquake',XByte);
      AddVal('AllowBlowpipe',XByte);
      end;
      if WUM then
      AddVal('AllowFlood',XByte);
      AddVal('AllowSheep',XByte);
      if W3D then  begin
      AddVal('AllowMineStrike',XByte);
      AddVal('AllowPetrolBomb',XByte);
      end;
      AddVal('AllowGasCanister',XByte);
      if W3D then begin
      AddVal('AllowSheepStrike',XByte);
      AddVal('AllowMadCow',XByte);
      end;
      AddVal('AllowOldWoman',XByte);
      AddVal('AllowConcreteDonkey',XByte);
      if W3D then  begin
      AddVal('AllowNuclearBomb',XByte);
      AddVal('AllowArmageddon',XByte);
      AddVal('AllowMagicBullet',XByte);
      end;
      AddVal('AllowSuperSheep',XByte);
      AddVal('AllowGirder',XByte);
      AddVal('AllowBridgeKit',XByte);
      AddVal('AllowNinjaRope',XByte);
      AddVal('AllowParachute',XByte);
      if W3D then
      AddVal('AllowScalesOfJustice',XByte);
      AddVal('AllowLowGravity',XByte);
      if W3D then begin
      AddVal('AllowQuickWalk',XByte);
      AddVal('AllowLaserSight',XByte);
      end;
      AddVal('AllowTeleport',XByte);
      AddVal('AllowJetpack',XByte);
      AddVal('AllowSkipGo',XByte);
      AddVal('AllowSurrender',XByte);
      AddVal('AllowChangeWorm',XByte);
      if W3D then begin
      AddVal('AllowFreeze',XByte);
      AddVal('AllowLotteryStrike',XByte);
      AddVal('AllowDoctorsStrike',XByte);
      AddVal('AllowMegaMine',XByte);
      AddVal('AllowStickyBomb',XByte);
      AddVal('AllowBinoculars',XByte);
      end;
      AddVal('AllowRedbull',XByte);
      if WUM then begin
      AddVal('AllowArmour',XByte);
      AddVal('AllowWeaponFactoryWeapon',XByte);
      AddVal('AllowStarburst',XByte);
      AddVal('AllowAlienAbduction',XByte);
      AddVal('AllowFatkins',XByte);
      AddVal('AllowScouser',XByte);
      AddVal('AllowNoMoreNails',XByte);
      AddVal('AllowPipe',XByte);
      AddVal('AllowPoisonArrow',XByte);
      AddVal('AllowSentryGun',XByte);
      AddVal('AllowSniperRifle',XByte);
      AddVal('AllowSuperAirstrike',XByte);
      AddVal('AllowBubbleTrouble',XByte);
      AddVal('AllowBinoculars',XByte);
      end;
      AddVal('TeleportIn',XBool);
      AddVal('IsEmotional',XBool);
      AddVal('HasDrunkRedbull',XBool);
      if WUM then
      AddVal('Armoured',XBool);
    end;
    TeamDataContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('Name',XString);
      if WUM then
      AddVal('Player',XString);
      AddVal('Active',XBool);
      AddVal('WormCountStart',XByte);
      AddVal('TeamColour',XByte);
      AddVal('TeamMustSurvive',XBool);
      AddVal('AlliedGroup',XByte);
      AddVal('DisableCPUAttack',XBool);
      AddVal('IsAIControlled',XBool);
      AddVal('RoundsWon',XByte);
      AddVal('GraveIndex',XByte);
      AddVal('WormsCountEnd',XByte);
      AddVal('Surrendered',XBool);
      AddVal('ScorePoints',XInt);
      AddVal('FlagGfxName',XString);
      AddVal('IsCrateSpyActive',XBool);
      AddVal('Skill',XByte);
      AddVal('IsLocal',XBool);
      if WUM then begin
      AddVal('ATT_Hat',XString);
      AddVal('ATT_Glasses',XString);  //
      AddVal('ATT_Gloves',XString);
      AddVal('ATT_Tash',XString);
      AddVal('SfxBankName',XString);
      LoadEnum(WUMWeaponNameEnum);
      AddVal('WormpotSuperWeapon',XEnum);
      LoadEnum(CameraDistanceEnum);
      AddVal('DefaultCameraDistance',XEnum);
      AddSetVal('RankedPoints',XInt);
      AddVal('PlayerPoints',XInt);
      AddVal('WeeklyPlayerPointsGained',XInt);
      AddVal('WeeklyInitialPlayerPoints',XInt);
      AddVal('NumKills',XInt);
      AddVal('NumDeaths',XInt);
      AddVal('DamageTaken',XInt);
      AddVal('DamageDealt',XInt);
      AddVal('GamesPlayed',XInt);
      AddVal('GamesWon',XInt);
      end;
    end;
    WeaponInventory,WeaponDelays:
    begin
    AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('Bazooka',XByte);
      AddVal('Grenade',XByte);
      AddVal('ClusterGrenade',XByte);
      AddVal('Airstrike',XByte);
      AddVal('Dynamite',XByte);
      AddVal('HolyHandGrenade',XByte);
      AddVal('BananaBomb',XByte);
      AddVal('Landmine',XByte);
      AddVal('Shotgun',XByte);
      if W3D then
      AddVal('Uzi',XByte);
      AddVal('BaseballBat',XByte);
      AddVal('Prod',XByte);
      if W3D then
      AddVal('VikingAxe',XByte);
      AddVal('FirePunch',XByte);
      AddVal('HomingMissile',XByte);
      if W3D then begin
      AddVal('Mortar',XByte);
      AddVal('HomingPidgeon',XByte);
      AddVal('Earthquake',XByte);      
      end;
      if WUM then
      AddVal('Flood',XByte);
      AddVal('Sheep',XByte);
      if W3D then  begin
      AddVal('MineStrike',XByte);
      AddVal('PetrolBomb',XByte);
      end;
      AddVal('GasCanister',XByte);
      if W3D then begin
      AddVal('SheepStrike',XByte);
      AddVal('MadCow',XByte);
      end;
      AddVal('OldWoman',XByte);
      AddVal('ConcreteDonkey',XByte);
      if W3D then  begin
      AddVal('NuclearBomb',XByte);
      AddVal('Armageddon',XByte);
      AddVal('MagicBullet',XByte);
      end;
      AddVal('SuperSheep',XByte);
      AddVal('Girder',XByte);
      AddVal('BridgeKit',XByte);
      AddVal('NinjaRope',XByte);
      AddVal('Parachute',XByte);
      if W3D then
      AddVal('ScalesOfJustice',XByte);
      if XCntr.Xtype=WeaponDelays then
      AddVal('LowGravity',XByte);
      if W3D then begin
      AddVal('QuickWalk',XByte);
      AddVal('LaserSight',XByte);
      end;
      AddVal('Teleport',XByte);
      AddVal('Jetpack',XByte);
      AddVal('SkipGo',XByte);
      AddVal('Surrender',XByte);
      AddVal('ChangeWorm',XByte);
      if W3D then begin
      AddVal('Freeze',XByte);
	  AddVal('Blowpipe',XByte);
      AddVal('LotteryStrike',XByte);
      AddVal('DoctorsStrike',XByte);
      AddVal('MegaMine',XByte);
      AddVal('StickyBomb',XByte);
      AddVal('Binoculars',XByte);
      end;
      AddVal('Redbull',XByte);
      if WUM then begin
      AddVal('WeaponFactoryWeapon',XByte);
      AddVal('Starburst',XByte);
      AddVal('AlienAbduction',XByte);
      AddVal('Fatkins',XByte);
      AddVal('Scouser',XByte);
      AddVal('NoMoreNails',XByte);
      AddVal('Pipe',XByte);
      AddVal('PoisonArrow',XByte);
      AddVal('SentryGun',XByte);
      AddVal('SniperRifle',XByte);
      AddVal('SuperAirstrike',XByte);
      AddVal('BubbleTrouble',XByte);
      AddVal('Binoculars',XByte);
      end;

    end;
    WeaponDataCtr:
    begin
    AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
	AddVal('Name',XString);
	AddVal('WeaponId',XInt);
	AddVal('WeaponResourceName',XString);
	AddVal('RoundResourceName',XString);
	AddVal('SubRoundResourceName',XString);
	AddVal('SecondRandomRoundResource',XString);
	AddVal('ThirdRandomRoundResource',XString);
	AddVal('FourthRandomRoundResource',XString);
	AddVal('FifthRandomRoundResource',XString);
	AddVal('SubRoundSecondRandomResource',XString);
	AddVal('SubRoundThirdRandomResource',XString);
	AddVal('SubRoundFourthRandomResource',XString);
	AddVal('SubRoundFifthRandomResource',XString);
	AddVal('MinShotPower',XFloat);
	AddVal('MaxShotPower',XFloat);
	AddVal('TimeToReachMaxShotPower',XFloat); // 00 00 C0 3F

  	AddVal('ShotPowerIsFixed',XBool);  //1 //01
	AddVal('ResourcePointsRequired',XInt);// 4 // 01 00  00 00
	AddVal('FiringPlatformRequired',XInt);// 4 //00 00  00 00
	AddVal('DamagesBuildings',XBool); // 1    //01
	AddVal('CanBeFiredFromAnywhere',XBool);//1  //01
	AddVal('WeaponFiresAutomatically',XBool); //1 // 00
	AddVal('UserSelectableFuseTime',XFloat); // 4   // 00 00 00 00
	AddVal('UserSelectableBounceSetting',XFloat); //4  //00 00  00 00
	AddVal('GlobalWeaponDamage',XBool); // 1         00
	AddVal('WeaponCanBeMovedWhileFiring',XBool);// 1   00
	AddVal('MovementResistanceWhenFiring',XBool);//1   00

	AddVal('NumberOfShotsPerTurn',XInt); // 01 00 00 00
	AddVal('UsesWeaponCameraWhenFired',XBool); //01
	AddVal('RandomAimModifierHorizontal',XFloat);//00 00 00 00
	AddVal('RandomAimModifierVertical',XFloat); //00 00 00 00
	AddVal('ImpactDamageRepeatDelay',XFloat);//CD CC CC 3D
	AddVal('AnimFrameForVerticalLaunch',XInt);
	AddVal('AnimFrameForHorizontalLaunch',XInt);
	AddVal('IsStrikeWeapon',XBool); //00
	AddVal('IsGodWeapon',XBool);  //01
	AddVal('UsesBlimpViewToAim',XBool);  //00
	AddVal('StrikeWeaponBomberResourceName',XString);//00
	AddVal('GodWormStartAnimationName',XString); // 37
	AddVal('GodWormEndAnimationName',XString);  //38   !!!!!!

   	AddVal('RoamingWeaponAvoidsSteepSlopes',Xbool);
	AddVal('RoamingWeaponAvoidsObstructions',Xbool);
	AddVal('RoamingWeaponAcceleration',XFloat);
	AddVal('RoamingWeaponTopSpeed',XFloat);
	AddVal('RoamingWeaponTurnRate',XFloat);
	AddVal('RoamingWeaponImpactRebound',XFloat);
	AddVal('RoamingWeaponHeightAboveGround',XFloat);
	AddVal('RoamingWeaponRandomlyChangesDirection',XBool);
	AddVal('RoamingWeaponRandomDirectionChangeDelay',XFloat);
	AddVal('RoamingWeaponJumpSpeed',XFloat);
	AddVal('RoamingWeaponSteeringRate',XFloat);
	AddVal('RoamingWeaponDustTrailEmitterName',XString);  //!!!
        
     	AddVal('FlyingWeaponMaxSpeed',XFloat);
	AddVal('FlyingWeaponTimeToReachMaxSpeed',XFloat);
	AddVal('FlyingWeaponSpeedReductionWhenTurning',XFloat);
	AddVal('FlyingWeaponMaxYawRate',XFloat);
	AddVal('FlyingWeaponMaxPitchRate',XFloat);
	AddVal('FlyingWeaponMaxRollRate',XFloat);
	AddVal('FlyingWeaponYawResponseTime',XFloat);
	AddVal('FlyingWeaponPitchResponseTime',XFloat);
	AddVal('FlyingWeaponRollResponseTime',XFloat);
	AddVal('FlyingWeaponAIMinHeightAboveGround',XFloat);
	AddVal('FlyingWeaponAIMaxHeightAboveGround',XFloat);
	AddVal('FlyingWeaponYawAnimName',XString);
	AddVal('FlyingWeaponPitchAnimName',XString);
	AddVal('FlyingWeaponRollAnimName',XString);
	AddVal('FlyingWeaponActivationDelay',XFloat);   //!!!

    	AddVal('MaxHorizontalAimAngle',XFloat);
	AddVal('MinVerticalAimAngle',XFloat);
	AddVal('MaxVerticalAimAngle',XFloat);
	AddVal('MaxHorizontalAimSpeed',XFloat);
	AddVal('MaxVerticalAimSpeed',XFloat);
	AddVal('InitialVerticalAimAngle',XFloat);
	AddVal('WindFactor',XFloat);
	AddVal('GravityFactor',XFloat);  //!!!
	AddVal('AirResistance',XFloat);  //?

     	AddVal('CamFirstPersonCameraDistance',XFloat);
	AddVal('CamThirdPersonCameraDistance',XFloat);
	AddVal('CamDefaultThirdPersonCameraPitch',XFloat);
	AddVal('CamMinThirdPersonCameraPitch',XFloat);
	AddVal('CamMaxThirdPersonCameraPitch',XFloat);
	AddVal('CamMaxThirdPersonHorizontalSpeed',XFloat);
	AddVal('CamMaxThirdPersonVerticalSpeed',XFloat);
	AddVal('CamFirstPersonOffset',XVector);
	AddVal('CamThirdPersonOffset',XVector);
	AddVal('CamVisableRadius',XFloat);
	AddVal('CamMinFireDistance',XFloat);

    	AddVal('ActionCamDist',XFloat);
	AddVal('ActionCamAngle',XFloat);
	AddVal('HideSiegeWeaponInFirstPersonView',XBool);
	AddVal('GunWobbleMaxAmp',XFloat);
	AddVal('GunWobblePeriod',XFloat);
	AddVal('GunWobbleSpeed',XFloat);
	AddVal('GunWobbleKickSize',XFloat);
	AddVal('GunWobbleKickDelay',XFloat);
	AddVal('IsHandHeldWeapon',XBool);

     	AddVal('HandHeldWeaponEndFireAnimationName',XString);
	AddVal('HandHeldWeaponResourceName',XString);
	AddVal('HandHeldWeaponAttachLocatorName',XString);
	AddVal('HandHeldWeaponFireAnimLaunchFrame',XInt);
	AddVal('MeleeWeaponRange',XFloat);
	AddVal('MeleeWeaponAngle',XFloat);
	AddVal('MeleeWeaponPushForce',XFloat);
	AddVal('RateOfFire',XInt);

   	AddVal('RepeatingWeaponFiringDuration',XFloat);
	AddVal('RepeatingWeaponSpinUpAnimName',XString);
	AddVal('RepeatingWeaponSpinDownAnimName',XString);
	AddVal('RepeatingWeaponSpinUpDelay',XFloat);
	AddVal('RepeatingWeaponSpinDownDelay',XFloat);
     
	AddVal('AudioWeaponFire',XString);
	AddVal('AudioWeaponPowerUp',XString);
	AddVal('AudioWeaponPowerDown',XString);
	AddVal('AudioRoundImpact',XString);
	AddVal('AudioRoundExplode',XString);
	AddVal('AudioRoundActive',XString);
	AddVal('AudioBomberActive',XString);
	AddVal('AudioWeaponPitch',XString);
	AddVal('AudioWeaponRotate',XString);
	AddVal('AudioWormIdle',XString);
	AddVal('AudioWeaponAppear',XString);
	AddVal('AudioWeaponVanish',XString);

     	AddVal('WeaponEmitter1Name',XString);
	AddVal('WeaponEmitter1Trigger',XInt);
	AddVal('WeaponEmitter1LocatorName',XString);
	AddVal('WeaponEmitter1Timer',XFloat);
	AddVal('WeaponEmitter2Name',XString);
	AddVal('WeaponEmitter2Trigger',XInt);
	AddVal('WeaponEmitter2LocatorName',XString);
	AddVal('WeaponEmitter2Timer',XFloat);
	AddVal('WeaponEmitter3Name',XString);
	AddVal('WeaponEmitter3Trigger',XInt);
	AddVal('WeaponEmitter3LocatorName',XString);
	AddVal('WeaponEmitter3Timer',XFloat);
	AddVal('WeaponEmitter4Name',XString);
	AddVal('WeaponEmitter4Trigger',XInt);
	AddVal('WeaponEmitter4LocatorName',XString);
	AddVal('WeaponEmitter4Timer',XFloat);

      	AddVal('WormIdleAnimationName',XString);
	AddVal('WormHoldAnimationName',XString);
	AddVal('WormDrawWeaponAnimationName',XString);
	AddVal('WormAimWeaponAnimationName',XString);
	AddVal('WormFireWeaponAnimationName',XString);
	AddVal('WormSnapDrawAnimationName',XString);  //!!!!
	AddVal('WormHatName',XString);

       	AddVal('RoundType',XInt);
	AddVal('NumRounds',XInt);
	AddVal('RoundUsesParabolicTrajectory',XBool);
	AddVal('RoundImpactBehaviour',XFloat);
	AddVal('RoundFuseTime',XFloat);
	AddVal('RoundExplodesWhenFuseExpires',XBool);
	AddVal('RoundMass',XFloat);
	AddVal('RoundRestitution',XFloat);
	AddVal('RoundFriction',XFloat);
	AddVal('RoundImpactFriction',XFloat);
	AddVal('RoundCollisionSphereRadius',XFloat);
	AddVal('RoundExplosionType',XInt);   // !!!
	AddVal('RoundExplosionRadius',XFloat);
	AddVal('RoundExplosionInnerRadius',XFloat);
	AddVal('RoundMaxExplosionDamage',XFloat);
	AddVal('RoundMaxExplosionWormDamage',XFloat);
	AddVal('RoundMaxExplosionForce',XFloat);
	AddVal('RoundExplosionForceFactorAddUp',XFloat);
	AddVal('RoundImpactAnimationName',XString);
	AddVal('RoundImpactDamage',XFloat);
	AddVal('RoundImpactWormDamage',XFloat);
	AddVal('RoundImpactForce',XFloat);
	AddVal('RoundRespondsToFireButton',XBool);
	AddVal('RoundIdleAnimationName',XString);
	AddVal('RoundFiringAnimationName',XString);
	AddVal('RoundFallingAnimationName',XString);// !!!
	AddVal('RoundActiveAnimationName',XString);
	AddVal('RoundRandomRotation',XFloat);
	AddVal('RoundGraphicFacesDirectionOfTravel',XBool);
	AddVal('RoundGraphicRotationY',XFloat);
	AddVal('RoundGraphicRotationX',XFloat);

        AddVal('RoundEmitter1Name',XString);
	AddVal('RoundEmitter1Trigger',XInt);
	AddVal('RoundEmitter1LocatorNum',XInt);
	AddVal('RoundEmitter1Timer',XFloat);
	AddVal('RoundEmitter1LinearVelocityScale',XFloat);
	AddVal('RoundEmitter2Name',XString);
	AddVal('RoundEmitter2Trigger',XInt);
	AddVal('RoundEmitter2LocatorNum',XInt);
	AddVal('RoundEmitter2Timer',XFloat);
	AddVal('RoundEmitter2LinearVelocityScale',XFloat);
	AddVal('RoundEmitter3Name',XString);
	AddVal('RoundEmitter3Trigger',XInt);
	AddVal('RoundEmitter3LocatorNum',XInt);
	AddVal('RoundEmitter3Timer',XFloat);      /// !!!
	AddVal('RoundEmitter3LinearVelocityScale',XFloat);

	AddVal('RoundDelayBetweenRounds',XFloat);  //00 00  00 00

    	AddVal('MethodOfAttachingRoundMeshToWeapon',XInt); //01 00 00 00
   	AddVal('ProximityRoundDetectionRadius',XFloat); //00 00 80 3F
	AddVal('ProximityRoundActivationFuse',XFloat);  //00 00 00 40
	AddVal('ProximityRoundActivationEffect',XFloat);  //00 00 00 00
	AddVal('ProximityRoundGameTurnsToBeActive',XInt); // 02 00 00 00
	AddVal('ProximityRoundDetectionYOffset',XFloat); //00 00 00 00

   	AddVal('SubRoundType',XInt); /// !!! 00 00 00 00
	AddVal('NumSubRounds',XInt);  //00 00  00 00

   	AddVal('SubRoundImpactBehaviour',XFloat); //00 00 00 00
	AddVal('SubRoundInitialSpeedY',XFloat);   //00 00 80 3F
	AddVal('SubRoundInitialSpeedXZ',XFloat);  //00 00 80 3F
	AddVal('SubRoundVelocityFactorOfMainRound',XFloat); //33 33 B3 3E
	AddVal('SubRoundInitialPositionOffset',XFloat); //00 00 C0 3F
	AddVal('SubRoundFuseTime',XFloat); // 00 00  40 40
	AddVal('SubRoundExplodesWhenFuseExpires',XBool); //01
	AddVal('SubRoundMass',XFloat);  // 00 00 80 3F
	AddVal('SubRoundRestitution',XFloat);  //00 00 80 3F
	AddVal('SubRoundFriction',XFloat);     //0A D7 23 3B
	AddVal('SubRoundImpactFriction',XFloat); //  CD CC CC 3C
	AddVal('SubRoundCollisionSphereRadius',XFloat); //00 00 80 3E
	AddVal('SubRoundExplosionType',XInt); //00 00 00 00
	AddVal('SubRoundExplosionRadius',XFloat);//00 00 00 40
	AddVal('SubRoundExplosionInnerRadius',XFloat);//00 00 00 00
	AddVal('SubRoundMaxExplosionDamage',XFloat);  //00 00 AF 43
	AddVal('SubRoundMaxExplosionWormDamage',XFloat);// 00 00 00 00
	AddVal('SubRoundMaxExplosionForce',XFloat); // 00 00 A0 40
	AddVal('SubRoundExplosionForceFactorAddUp',XFloat);// CD CC 4C 3E
	AddVal('SubRoundImpactDamage',XFloat); //00 00 00 00
	AddVal('SubRoundImpactWormDamage',XFloat); //00 00 00 00
	AddVal('SubRoundImpactForce',XFloat);  //00 00 00 00
	AddVal('SubRoundRespondsToFireButton',XBool); //01
	AddVal('SubRoundRandomRotation',XFloat);// 00 00 00 00
	AddVal('SubRoundGraphicFacesDirectionOfTravel',XBool);//00
	AddVal('SubRoundGraphicRotationY',XFloat);// 00 00 00 00
	AddVal('SubRoundGraphicRotationX',XFloat); //00 00 00 00

    	AddVal('SubRoundEmitter1Name',XString);
	AddVal('SubRoundEmitter1Trigger',XInt);
	AddVal('SubRoundEmitter1LocatorNum',XInt);
	AddVal('SubRoundEmitter1Timer',XFloat);
	AddVal('SubRoundEmitter1LinearVelocityScale',XFloat);
	AddVal('SubRoundEmitter2Name',XString);
	AddVal('SubRoundEmitter2Trigger',XInt);
	AddVal('SubRoundEmitter2LocatorNum',XInt);
	AddVal('SubRoundEmitter2Timer',XFloat);
	AddVal('SubRoundEmitter2LinearVelocityScale',XFloat);
	AddVal('SubRoundEmitter3Name',XString);
	AddVal('SubRoundEmitter3Trigger',XInt);
	AddVal('SubRoundEmitter3LocatorNum',XInt);
	AddVal('SubRoundEmitter3Timer',XFloat);
	AddVal('SubRoundEmitter3LinearVelocityScale',XFloat);

    end;
    WeaponSettingsData:
    begin
    AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      if W3D then begin
      AddVal('Ammo',XInt);
      AddVal('Crate',XInt);
      AddVal('Power',XInt);
      AddVal('Delay',XInt);
      end else
      if WF then begin
      AddVal('Weapon',XByte);
      AddVal('Crates',XByte);
      AddVal('Delay',XByte);
      end else
      begin
      AddVal('Ammo',XInt);
      AddVal('Crate',XInt);
      AddVal('Delay',XInt);
      end;
    end;
    WormapediaDetails,WormpaediaDetails:
    begin
    AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('TitleID',XString);
      AddVal('DescID',XString);
      XCntr.Name:=vs;
      TreeNode.Text:=GetXName(XCntr);
      AddVal('ImageID',XString);
      AddVal('MovieID',XString);
      AddVal('Lock',XString);
      AddVal('ItemNumber',XInt);
    end;
    LevelLock:
    begin
      AddNode('');
      p2 := XCntr.GetPoint;
      AddVal('Medal',XInt);
      AddVal('Retries',XInt);
      LockVals;
    end;
    Lock:
    begin
      AddNode('');
      p2 := XCntr.GetPoint;
      LockVals;
    end;
    MovieLock:
    begin
      AddNode('');
      p2 := XCntr.GetPoint;
      AddVal('PlayCount',XInt);
      LockVals;
    end;
   FlyCameraPropertiesContainer:
   begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
	    AddVal('LagBehind',XFloat);
	    AddVal('LookAhead',XFloat);
      AddVal('LookSpeed',XFloat);
      AddVal('MinLookAt',XFloat);
      AddVal('MinPosition',XFloat);
	    AddVal('PosSpeed',XFloat);
      AddVal('UpSpeed',XFloat);
      if W3D then
	    AddVal('CameraStartsInLand',XBool);
      if WUM then begin
      AddVal('Cut',XBool);
      AddVal('PosRate',XFloat);
      AddVal('PauseDuration',XInt);
      AddVal('FinalDistance',XFloat);
      end;
   end;
   OccludingCameraPropertiesContainer:
   begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      CameraPropRead;
      if WUM then begin
      AddVal('ResetYaw',XBool);
      AddVal('OccInnerTestPoints',XInt);
      AddVal('OccZoomPctge',XFloat);
      AddVal('ShowDebugDots',XBool);
      end;
   end;
   ChaseCameraPropertiesContainer:
   begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('CutOnRetreat',XBool);
      CameraPropRead;
   end;
   SimpleCameraContainer:
   begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('PosUpdateSpeed',XFloat);
      AddVal('LookUpdateSpeed',XFloat);
   end;
   TrackCameraContainer:
   begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('Camera2ObjectDistance',XFloat);
      AddVal('LookSpeed',XFloat);
      AddVal('UpSpeed',XFloat);
      AddVal('ZoomSpeed',XFloat);
      AddVal('MinPreferredDistance',XFloat);
      AddVal('MinPosition',XFloat);
      AddVal('MinTimeBetweenCuts',XInt);
      AddSetVal('ViewPoint',XVector);
      AddVal('CutWhenStartOffScreen',XBool);
   end;
   WormCareerStats:
   begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('LongestSurvivalTime',XFloat);
      AddVal('MostDamageInARound',XFloat);
      AddVal('MostEnemyWormsKilledInARound',XInt);
      AddVal('MostFriendlyWormsKilledInARound',XInt);
      AddVal('MostBuildingsDestroyedInARound',XInt);
      AddVal('MostBuildingsCreatedInARound',XInt);
      AddVal('MostCratesCollected',XInt);
      AddVal('MostDeathsInARound',XInt);
      AddVal('MostShotsFired',XInt);
   end;
   TeamCareerStats:
   begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('GamesPlayed',XInt);
      AddVal('GamesWon',XInt);
      AddVal('GamesDrawn',XInt);
      AddVal('GamesLost',XInt);
      AddVal('MostDamageCaused',XFloat);
      AddVal('MostDamageRecieved',XFloat);
      AddVal('MostEnemyWormsKilled',XInt);
      AddVal('MostFriendlyWormsKilled',XInt);
      AddVal('MostBuildingsDestroyed',XInt);
      AddVal('MostBuildingsCreated',XInt);
      AddVal('MostBuildingsLost',XInt);
      AddVal('MaxVictoryPointsHeld',XInt);
      AddVal('MaxCratesCollected',XInt);
   end;
   GameInitData:
   begin
    AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
	AddVal('NumberOfTeams',Xint);
	AddVal('AllyToStart',Xint);
	AddVal('AllyTeam0',Xint);
	AddVal('AllyTeam1',Xint);
	AddVal('AllyTeam2',Xint);
	AddVal('AllyTeam3',Xint);
	AddVal('T1_Name',XString);
	AddVal('T1_Player',XString);
	AddVal('T1_NumOfWorms',Xint);
	AddVal('T1_W1_Name',XString);
	AddVal('T1_W2_Name',XString);
	AddVal('T1_W3_Name',XString);
	AddVal('T1_W4_Name',XString);
	AddVal('T1_W5_Name',XString);
	AddVal('T1_W6_Name',XString);
	AddVal('T1_Skill',Xint);
	AddVal('T1_Grave',Xint);
	AddVal('T1_SWeapon',Xint);
	AddVal('T1_Flag',XString);
	AddVal('T1_Speech',XString);
	AddVal('T1_IsLocal',XBool);
	AddVal('T1_AlliedGroup',XInt);
	AddVal('T1_FirstWorm',XInt);
  if WUM then  begin
      AddVal('T1_Handicap',XInt);
      AddVal('T1_HatAttachment',XString);
      AddVal('T1_GlovesAttachment',XString);
      AddVal('T1_GlassesAttachment',XString);
      AddVal('T1_TashAttachment',XString);
      AddIdxNode; //'T1_CustomWeapon' // StoreWeaponFactory
 //     AddVal('T1_InvertY',XBool);   //	2
 //    AddVal('T1_InvertX',XBool);   //	2
 //     AddVal('T1_InvertYFP',XBool); //	2
  end;
	AddVal('T2_Name',XString);
	AddVal('T2_Player',XString);
	AddVal('T2_NumOfWorms',Xint);
	AddVal('T2_W1_Name',XString);
	AddVal('T2_W2_Name',XString);
	AddVal('T2_W3_Name',XString);
	AddVal('T2_W4_Name',XString);
	AddVal('T2_W5_Name',XString);
	AddVal('T2_W6_Name',XString);
	AddVal('T2_Skill',Xint);
	AddVal('T2_Grave',Xint);
	AddVal('T2_SWeapon',Xint);
	AddVal('T2_Flag',XString);
	AddVal('T2_Speech',XString);
	AddVal('T2_IsLocal',XBool);
	AddVal('T2_AlliedGroup',XInt);
	AddVal('T2_FirstWorm',XInt);
  if WUM then  begin
      AddVal('T2_Handicap',XInt);
      AddVal('T2_HatAttachment',XString);
      AddVal('T2_GlovesAttachment',XString);
      AddVal('T2_GlassesAttachment',XString);
      AddVal('T2_TashAttachment',XString);
      AddIdxNode; //'T2_CustomWeapon' // StoreWeaponFactory
  end;
 	AddVal('T3_Name',XString);
	AddVal('T3_Player',XString);
	AddVal('T3_NumOfWorms',Xint);
	AddVal('T3_W1_Name',XString);
	AddVal('T3_W2_Name',XString);
	AddVal('T3_W3_Name',XString);
	AddVal('T3_W4_Name',XString);
	AddVal('T3_W5_Name',XString);
	AddVal('T3_W6_Name',XString);
	AddVal('T3_Skill',Xint);
	AddVal('T3_Grave',Xint);
	AddVal('T3_SWeapon',Xint);
	AddVal('T3_Flag',XString);
	AddVal('T3_Speech',XString);
	AddVal('T3_IsLocal',XBool);
	AddVal('T3_AlliedGroup',XInt);
	AddVal('T3_FirstWorm',XInt);
  if WUM then  begin
      AddVal('T3_Handicap',XInt);
      AddVal('T3_HatAttachment',XString);
      AddVal('T3_GlovesAttachment',XString);
      AddVal('T3_GlassesAttachment',XString);
      AddVal('T3_TashAttachment',XString);
      AddIdxNode; //'T3_CustomWeapon' // StoreWeaponFactory
  end;
	AddVal('T4_Name',XString);
	AddVal('T4_Player',XString);
	AddVal('T4_NumOfWorms',Xint);
	AddVal('T4_W1_Name',XString);
	AddVal('T4_W2_Name',XString);
	AddVal('T4_W3_Name',XString);
	AddVal('T4_W4_Name',XString);
	AddVal('T4_W5_Name',XString);
	AddVal('T4_W6_Name',XString);
	AddVal('T4_Skill',Xint);
	AddVal('T4_Grave',Xint);
	AddVal('T4_SWeapon',Xint);
	AddVal('T4_Flag',XString);
	AddVal('T4_Speech',XString);
	AddVal('T4_IsLocal',XBool);
	AddVal('T4_AlliedGroup',XInt);
	AddVal('T4_FirstWorm',XInt);
  if WUM then  begin
      AddVal('T4_Handicap',XInt);
      AddVal('T4_HatAttachment',XString);
      AddVal('T4_GlovesAttachment',XString);
      AddVal('T4_GlassesAttachment',XString);
      AddVal('T4_TashAttachment',XString);
      AddIdxNode; //'T4_CustomWeapon' // StoreWeaponFactory
  end;
   end;
   LensFlareElementContainer:
   begin
        AddNode(GetXName(XCntr));
        p2 := XCntr.GetPoint;
        AddVal('Scale',XFloat);
        AddVal('Size',XFloat);
        AddVal('FadeIn',XFloat);
        AddVal('Color',XColor);
        LoadEnum(LensElementType);
        AddVal('Type',XEnum);
   end;
   LensFlareContainer:
   begin
        AddNode(GetXName(XCntr));
        p2 := XCntr.GetPoint;
        AddVal('Active',XBool);
        AddVal('LensScale',XFloat);
        AddVal('FocalOffset',XFloat);
        AddSetNode('Elements');
   end;
   WormPotContainer:
   begin
        AddNode(GetXName(XCntr));
        p2 := XCntr.GetPoint;
        if W3D then begin
  AddVal('PowerScale',XFloat);
	AddVal('SuperScale',XFloat);
	AddVal('FallingScale',XFloat);
	AddVal('SlippyModeScale',XFloat);
	AddVal('StickyModeScale',XFloat);
	AddVal('SlippyMode',XBool);
	AddVal('StickyMode',XBool);
	AddVal('DavidAndGoliath',XBool);
	AddVal('OneShotOneKill',XBool);
	AddVal('CratesContaineSheep',XBool);
	AddVal('GodMode',XBool);
	AddVal('SpecialistWorms',XBool);
	AddVal('NoRetreatTime',XBool);
	AddVal('DoubleHealthCrates',XBool);
	AddVal('WindEffectMore',XBool);
	AddVal('EnergyOrEnemy',XBool);
	AddVal('EarthquakeEveryTurn',XBool);
	AddVal('FallingHurtsMore',XBool);
	AddVal('CratesOnly',XBool);
	AddVal('LotsOfCrates',XBool);
	AddVal('SuperHand',XBool);
	AddVal('SuperFirearms',XBool);
	AddVal('SuperAnimals',XBool);
	AddVal('SuperClusters',XBool);
	AddVal('SuperFire',XBool);
	AddVal('SuperExplosives',XBool);
	AddVal('PowerHand',XBool);
	AddVal('PowerFirearms',XBool);
	AddVal('PowerAnimals',XBool);
	AddVal('PowerClusters',XBool);
	AddVal('PowerFire',XBool);
	AddVal('PowerExplosives',XBool);
      end else if WUM then begin
      AddVal('PowerScale',XFloat);
      AddVal('SuperScale',XFloat);
      AddVal('FallingScale',XFloat);
      AddVal('SlippyModeScale',XFloat);
      AddVal('StickyModeScale',XFloat);
      AddVal('WindScale',XFloat);
      AddVal('SuperExplosives',XBool);
      AddVal('SuperClusters',XBool);
      AddVal('SuperFirearms',XBool);
      AddVal('SuperAnimals',XBool);
      AddVal('SuperHand',XBool);
      AddVal('DavidAndGoliath',XBool);
      AddVal('FallingHurtsMore',XBool);
      AddVal('DoubleDamage',XBool);
      AddVal('LotsOfCrates',XBool);
      AddVal('SpecialistWorms',XBool);
      AddVal('NoRetreatTime',XBool);
      AddVal('DoubleHealthCrates',XBool);
      AddVal('WindEffectMore',XBool);
      AddVal('OneShotOneKill',XBool);
      AddVal('EnergyOrEnemy',XBool);
      AddVal('CratesOnly',XBool);
      AddVal('SlippyMode',XBool);
      AddVal('StickyMode',XBool);
      AddVal('WormsOnlyDrown',XBool);
      AddVal('PermanentGravity',XBool);
      AddVal('DisableFlips',XBool);
      AddVal('RopingArtilleryWorms',XBool);
      AddVal('WindAffectsGuns',XBool);
      AddVal('PermanentQuickWalk',XBool);
      AddVal('DisableBlimp',XBool);
      AddVal('SpawnMineEveryTurn',XBool);
      AddVal('RandomDestrucibleTerrain',XBool);
      AddVal('HighPowerPetrolBombs',XBool);
      AddVal('JusticeMode',XBool);
      AddVal('JetpackEndsTurn',XBool);
      AddVal('GirdersDontEndTurn',XBool);
      AddVal('DeathTouch',XBool);
      AddVal('NoParachuteDrops',XBool);
      AddVal('MemeroyMode',XBool);
      AddVal('VampireMode',XBool);
      AddVal('VitalWorm',XBool);
      AddVal('SecretSuperWeapons',XBool);
      AddVal('DonorCard',XBool);
      AddVal('GirdersOnly',XBool);
      AddVal('WindAffectsWorms',XBool);
      AddVal('WormsJumpOnly',XBool);
      end;
   end;
   GSNetworkGameList,
   GSRoomList,
   GSTeamList,
   BrickBuildingList,
   CampaignCollective,
   GSProfileList,
   LockedBitmapArray,
   SchemeColective,
   SchemeCollective,
   SoundBankCollective,
   SoundBankColective,
   WormapediaCollective,
   WormpaediaColective :
    begin
    AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddSetNode('Collection');
    end;
    XSoundBank:
    begin
    AddNode('');
    p2 := XCntr.Point;
    AddSetNode('Sounds');
    AddVal('Name',XString);
    XCntr.Name:=vs;
    TreeNode.Text:=GetXName(XCntr);
    end;
    XSampleData:
    begin
      AddNode('',25);
      p2 := XCntr.Point;
      AddVal('Name',XString);
      XCntr.Name:=vs;
      TreeNode.Text:=GetXName(XCntr);
      AddIdxNode;
      AddVal('Loop',XBool);
      AddVal('byte1',Xbyte);
      if not WB then
      AddVal('byte2',Xbyte);

      AddVal('float1',XFloat);
      AddVal('float2',XFloat);
      AddVal('Frequency',XInt);
      AddVal('Priority',XInt);
      AddVal('float3',XFloat);
      AddVal('float4',XFloat);
      AddVal('float5',XFloat);
      AddVal('int3',XInt);
      if not WB then begin
      AddVal('int4',XInt);
      AddVal('int5',XInt);
      AddVal('int6',XInt);
      end;
    end;
    XInternalSampleData:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.Point;
      AddVal('StreamSize',XInt);
    end;
    XStreamData:
    begin
      AddNode('',25);
      p2 := XCntr.Point;
      AddVal('Name',XString);
      XCntr.Name:=vs;
      TreeNode.Text:=GetXName(XCntr);
      AddVal('Filename',XString);
      AddVal('Frequency',XInt);
      AddVal('Volume',XFloat);
      AddVal('Priority',XInt);
      AddVal('Loop',Xbool);
      AddVal('FadeIn',XFloat);
      AddVal('FadeOut',XFloat);
      AddVal('MinDistance',XFloat);
      AddVal('MaxDistance',XFloat);
      AddVal('percent',XFloat);
      AddVal('Channels',XInt);
      AddVal('int2',XInt);
      AddVal('int3',XInt);
      AddVal('LipSize',XInt);
      Inc(Longword(p2), vi);
      AddVal('int5',XInt);
      AddVal('SampleSize',XInt);


   {   typedef struct
    DWORD freq;
    float volume;
    float pan;
    DWORD flags;
    DWORD length;
    DWORD max;
    DWORD origres;
    DWORD chans;
    DWORD mingap;
    DWORD mode3d;
    float mindist;
    float maxdist;
    DWORD iangle;
    DWORD oangle;
    float outvol;
    DWORD vam;
    DWORD priority;
 BASS_SAMPLE;  }
    end;
    LockedBitmapDesc:
    begin
    AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('BitmapID',XString);
      AddVal('ToolTipID',XString);
      AddVal('Value',XFloat);
      AddVal('Lock',XString);
    end;
    SoundBankData:
    begin
    AddNode('');
      p2 := XCntr.GetPoint;
      AddVal('NameID',XString);
      XCntr.Name:=vs;
      TreeNode.Text:=GetXName(XCntr);
      AddVal('RealName',XString);
      AddVal('Lock',XString);
      AddVal('LanguageBank',XBool);
    end;
    LandFrameStore:
    begin
      p2 := XCntr.GetPoint;
      //Name
      //Position
      //Orientation
      //Scale

      //FloorTexXVec
      //FloorTexYVec
      //WallTexXVec
      //WallTexYVec
      //FloorTexOffset
      //WallTexOffset
      //CentreOffset

      //EdgeOffset1
      //EdgeOffset2

      //XSize
      //YSize
      //ZSize
      //HeightMap
      //EdgeCrinkle
      //EdgeFalloff
      //PeturbCliffs
      //Visible
      //SmoothShading
      //Tint
      //Voxels
      //Details
      XCntr.Name := GetStr128(p2,XCntr);
      AddNode(GetXName(XCntr));
      Inc(Longword(p2), 3 * 3 * 4);

      if (Byte(Pointer(Longword(p2) + $4c)^) <> 0) then
      begin
        Inc(Longword(p2), 16 * 4 + 12);
        Inc(Longword(p2), TestByte128(p2) * 8);
        Inc(Longword(p2), TestByte128(p2) * 8);
        Inc(Longword(p2), 3);
        Inc(Longword(p2), TestByte128(p2) * 4);

        Inc(Longword(p2), 12);
        Inc(Longword(p2), TestByte128(p2) * 4);

        k := GetSize128(p2,XCntr);
        for x := 1 to k do
          AddIdxNode;
      end
      else
        Inc(Longword(p2), $60);

      k := GetSize128(p2,XCntr);
      for x := 1 to k do
        AddIdxNode;
    end;
    DetailEntityStore:
    begin
     AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('Name',XString);
      AddVal('Lib',XString);
    end;
    WXTemplate,W3DTemplate:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddSetNode('Connectors');//W3DLumpConnector
      AddSetNode('Bounds');//W3DLumpBoundBox
      AddIdxNode;//Outline
      AddVal('PreviewPos',XVector);
      AddVal('PreviewOrientation',XVectorR);
      AddVal('PreviewScale',XVector);
      if XCntr.XType=WXTemplate then
      AddVal('PreviewType',XByte)
      else begin
      LoadEnum(PreviewTypeEnum);
      AddVal('PreviewType',XEnum);
      AddVal('RandomRoot',XBool);
      end;
      //RandomRoot   00  00
      AddVal('LandCost',XInt);
      //LandCost   01 00 00 00
      AddVal('Complexity',XUint);
      //Complexity  00  
      AddVal('EmitterCost',XUInt);
      //EmitterCost  01 0000 00
      LoadEnum(LumpTypeEnum);
      AddVal('LumpType',XEnum);
      //LumpType  06 00 00 00
      AddVal('YPlacement',XFloat);//FA 82 C4 3F
    end;
    WXLumpBoundBox,W3DLumpBoundBox:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('Position',XVector);
      AddVal('Size',XVector);
      AddVal('Orientation',XVectorR);
      AddVal('Type',XByte);
    end;
    WXLumpConnector,W3DLumpConnector:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('Flags[0]',XUint);
      AddVal('Flags[1]',XUint);
      AddVal('Position',XVector);
      AddVal('Size',XVector);
      AddVal('Orientation',XVectorR);
    end;
    PC_LandChunk:
      AddNode('LandChunk::'+GetXName(XCntr));
    PC_LandFrame:
    begin
      AddNode('LandFrame::'+GetXName(XCntr));
      p2 := XCntr.GetPoint;
      k3 := TestByte128(p2);
      Inc(Longword(p2), k3);
      k3 := TestByte128(p2);
      Inc(Longword(p2), k3);
      Inc(Longword(p2), 2);    //00 00
      Inc(Longword(p2), 4);    // 3d 00 6c 00
      Inc(Longword(p2), 368);  // pos?
      k3 := TestByte128(p2);   // layers 1
      Inc(Longword(p2), k3 * 2 * 4);
      k3 := TestByte128(p2); // layers 2
      Inc(Longword(p2), k3 * 2 * 4);
      k3 := TestByte128(p2); // ?
      Inc(Longword(p2), k3 * 4);
      Inc(Longword(p2), 4);
      k3 := TestByte128(p2); // ?
      Inc(Longword(p2), k3 * 4);
      k3 := TestByte128(p2); // ?
      Inc(Longword(p2), k3 * 4);
      // ?????
      k3 := TestByte128(p2); // ?
      Inc(Longword(p2), (k3 - 1) * 4);
      Inc(Longword(p2), 16); //???
      Inc(Longword(p2), 4);  // ff ff ff ff
      k3 := GetSize128(p2,XCntr); // childs
      for x := 1 to k3 do
        AddIdxNode;
      AddDataName;
    end;
    XDataBank:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('Section',XByte);
      for i:=0 to 7 do
        AddSetNode(XResourceDetails[i]);
    end;
    XContainerResourceDetails:
    begin
      AddNode('');
      p2 := XCntr.GetPoint;
      k3 := GetIdx128(p2,XCntr);   
      AddClassTree(XCntr.AddChild(k3), TreeView, TreeNode);
      AddFlag;
    end;
    EFMV_MovieContainer,EFMV_TrackContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('Tag',XString);
      k := GetSize128(p2,XCntr);
       for x := 1 to k do
          AddIdxNode;
    end;
    EFMV_PathCameraEventContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('PositionKnotList',XString);
      AddVal('LookAtKnotList',XString);
      AddVal('LoopPosition',XBool);
      AddVal('LoopLookAt',XBool);
      AddVal('PositionSteps',XInt);
      AddVal('LookAtSteps',XInt);
      AddVal('PositionTension',XInt);
      AddVal('LookAtTension',XInt);
      AddVal('DrawDebugDots',XBool);
      AddTagTimeCritical;
    end;
    EFMV_WormEmoteEventContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('Emote',XString);
      AddVal('PermittedEyeMovement',XInt);
      AddVal('BlendTime',XFloat);
      AddVal('Coyness',XInt);
      AddVal('AllowBlink',XBool);
      AddTagTimeCritical;
    end;
    EFMV_CastActorEventContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('ActorName',XString);
      AddTagTimeCritical;
    end;
    EFMV_TriggerSoundEffectEventContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('EffectName',XString);
      AddVal('Location',XString);
      AddVal('Looping',XBool);
      if WUM then AddVal('?',XInt);
      AddTagTimeCritical;
    end;
    EFMV_TriggerSpeechEventContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('Speech',XString);
      AddVal('FullVolume',XBool);
      AddVal('Duration',XInt);
      AddTagTimeCritical;
    end;
    EFMV_TimedPathCameraEventContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('PositionKnotList',XString);
      AddVal('LookAtKnotList',XString);
      AddVal('LoopPosition',XBool);
      AddVal('LoopLookAt',XBool);
      AddVal('PositionSteps',XString);
      AddVal('LookAtSteps',XString);
      AddVal('PositionTension',XFloat);
      AddVal('LookAtTension',XFloat);
      AddVal('DrawDebugDots',XBool);
      AddTagTimeCritical;
    end;
    EFMV_AnimateDetailEventContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('FourCC',XString);
      AddVal('AnimName',XString);
      AddTagTimeCritical;
    end;
    EFMV_SpawnAccessoryEventContainer,
    EFMV_SpawnParticleEventContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('ResourceId',XString);
      AddVal('AttachmentPoint',XString);
      AddTagTimeCritical;
    end;
    EFMV_AnimateCustomHudGraphicEventContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('AnimName',XString);
      AddVal('Loop',XBool);
      AddVal('QueueAtEnd',XBool);
      AddTagTimeCritical;
    end;
    EFMV_CreateWXBriefingBoxEventContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('Type',XString);
      AddVal('TextId',XString);
      AddVal('Image',XString); 
      AddTagTimeCritical;
    end;
    EFMV_CreateCustomHudGraphicEventContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('X',XFloat);
      AddVal('Y',XFloat);
      AddVal('GraphicName',XString);
      AddTagTimeCritical;
    end;
    EFMV_DeleteLandframeEventContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('Code',XString);
      AddTagTimeCritical;
    end;
    EFMV_ShakeCameraEventContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('Duration',XInt);
      AddVal('Magnitude',XFloat);
      AddTagTimeCritical;
    end;
    EFMV_FailureCommentEventContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('Duration',XInt);
      AddTagTimeCritical;
    end;
    EFMV_WormBaseEventContainer,
    EFMV_CreateBordersEventContainer,
    EFMV_DeleteBordersEventContainer,
    EFMV_DeleteCustomHudGraphicEventContainer,
    EFMV_ClearAccessoryEventContainer,
    EFMV_StopEventContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddTagTimeCritical;
    end;
    EFMV_StopAnimationEventContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('BlendTime',XFloat);
      AddTagTimeCritical;
    end;
    EFMV_SpawnWormEventContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('WormId',XInt);
      AddVal('DataId',XString);
      AddTagTimeCritical;
    end;
    EFMV_UnspawnWormEventContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('WormId',XInt);
      AddTagTimeCritical;
    end;
    EFMV_CommentEventContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('Comment',XString);
      AddVal('Duration',XInt);
      AddTagTimeCritical;
    end;
    EFMV_CutCameraEventContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('Position',XString);
      AddVal('LookAt',XString);
      AddTagTimeCritical;
    end;
    EFMV_PlayAnimationEventContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('Animation',XString);
      AddTagTimeCritical;
    end;
    EFMV_ThreatenWormEventContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('Threatened',XBool); //	Threat status true or false
      AddTagTimeCritical;
    end;
    EFMV_WormLookAtEventContainer,
    EFMV_WormGestureAtEventContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('TargetCastMember',XByte);
      AddTagTimeCritical;
    end;

    EFMV_CreateEmitterEventContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('EmitterName',XString);
      AddVal('Location',XString);
      AddVal('Locator',XString);
      AddVal('UserId',XInt);
      AddTagTimeCritical;
    end;
    EFMV_DeleteEmitterEventContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('UserId',XInt);
      AddTagTimeCritical;
    end;
    EFMV_CreateExplosionEventContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('Location',XString);
      AddVal('WormDamageMagnitude',XFloat);
      AddVal('ImpulseMagnitude',XFloat);
      AddVal('WormDamageRadius',XFloat);
      AddVal('LandDamageRadius',XFloat);
      AddVal('ImpulseRadius',XFloat);
      AddVal('ParticleEffect',XString);
      AddVal('ImpulseOffset',XFloat);
      AddTagTimeCritical;
    end;
    WXFE_LevelDetails:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('Frontend_Name',XString);
      XCntr.Name:=vs;
      AddVal('Frontend_Briefing',XString);
      AddVal('Frontend_Image',XString);
      AddVal('Level_ScriptName',XString);
      AddVal('Level_FileName',XString);
      AddVal('Objectives',XString);
      AddVal('Level_Number',XInt);
      LoadEnum(WXFE_LevelTypeEnum);
      AddVal('Level_Type',XEnum);
      AddVal('Lock',XString);
      LoadEnum(WXFE_LevelThemeTypeEnum);
      AddVal('Theme_Type',XEnum);
      LoadEnum(WXFE_LevelPreviewEnum);
      AddVal('Preview_Type',XEnum);
      AddVal('BonusTime',XInt);
      LoadEnum(WXFE_LevelSectionEnum);
      AddVal('LevelSection',XEnum);//	1

    end;
    LevelDetails:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('LevelName',XString);
      XCntr.Name:=vs;
      AddVal('ScriptName',XString);
      if WUM then AddVal('DataBank',XIndex);
      if not WF then begin
      AddVal('Theme',XString);
      AddVal('CustomTheme',XString);
      AddVal('LandFile',XString);
      AddVal('TimeOfDay',XString);
      AddVal('Particles',XString);
      end;
      LoadEnum(LevelTypeEnum);
      AddVal('LevelType',XEnum);
      AddVal('Brief',XString);
      AddVal('Image',XString);
      AddVal('LevelNumber',XInt);
      AddVal('Lock',XString);
      AddVal('LongestWins',XBool);
      AddVal('AIPathNodeStartYOffset',XFloat);
      AddVal('AIPathNodeCollisionStep',XFloat);
    end;
    Mission:
    begin
      AddNode('');
      p2 := XCntr.GetPoint;
      AddVal('LevelName',XString);
      XCntr.Name:=vs;
      TreeNode.Text:=GetXName(XCntr);
      AddVal('ScriptName',XString);
      AddVal('LevelType',XInt);
      AddVal('Brief',XString);
      AddVal('Image',XString);
      AddVal('LevelNumber',XInt);
      AddVal('Lock',XString);
      AddVal('Movie',XString);
      AddVal('AIPathNodeStartYOffset',XFloat);
      AddVal('AIPathNodeCollisionStep',XFloat);
    end;
    Movie:
    begin
     AddNode('');
      p2 := XCntr.GetPoint;
      AddVal('DescID',XString);
      XCntr.Name:=vs;
      TreeNode.Text:=GetXName(XCntr);
      AddVal('ImageID',XString);
      AddVal('MovieID',XString);
      AddVal('Lock',XString);
      AddVal('ItemNumber',XInt);
    end;
    FlagLockIdentifier:
    begin
     AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('Lock',XString);
      AddVal('FlagIndex',XInt);
    end;
    StringStack:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      k := TestByte128(p2);
       for x := 1 to k do
           AddVal(format('Stack[%d]',[x]),XString);
      AddVal('MaxSize',XInt);
    end;
    XVectorResourceDetails:
    begin
      AddNode('');
      p2:=XCntr.GetPoint;
      AddVal('Value',XVector);
      AddFlag;
    end;
    XDataMatrix4f:
    begin
      AddNode('');
      p2:=XCntr.GetPoint;
      AddVal('Value', XMatrix4);
      AddFlag;
    end;
    XDataVector4f:
    begin
      AddNode('');
      p2:=XCntr.GetPoint;
      AddVal(s,XVector4,true);
      XCntr.Name := vs0;
      TreeNode.Text:=GetXName(XCntr);
    end;
    XColorResourceDetails:
    begin
      AddNode('');
      p2:=XCntr.GetPoint;
      AddVal('Value',XColor);
      AddFlag;
    end;
    XFloatResourceDetails,XDataFloat:
    begin
      AddNode('');
      p2:=XCntr.GetPoint;
      AddVal('Value',XFloat);
      AddFlag;
    end;
    XIntResourceDetails:
    begin
      AddNode('');
      p2:=XCntr.GetPoint;
      AddVal('Value',XInt);
      AddFlag;
    end;
    XUintResourceDetails:
    begin
      AddNode('');
      p2:=XCntr.GetPoint;
      AddVal('Value',XInt);
      AddFlag;
    end;
    XExportAttributeString:
    begin
      AddNode('');
      p2:=XCntr.GetPoint;
      AddVal(s,XString,true);
      XCntr.Name := vs0;
      TreeNode.Text:='XExportAttribute::'+GetXName(XCntr);
    end;
    XStringResourceDetails:
    begin
      AddNode('');
      p2:=XCntr.GetPoint;
      AddVal('Value',XString);
      AddFlag;
    end;
    GSProfile:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('Nick',XString);
      AddVal('E-mail',XString);
    end;
    HighScoreData:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      if WUM then begin
      AddVal('WinnerName',XString);
      AddVal('WinnerTime',XInt);
      end else begin
      AddVal('Gold',XString);
      AddVal('GoldTime',XInt);
      AddVal('Silver',XString);
      AddVal('SilverTime',XInt);
      AddVal('Bronze',XString);
      AddVal('BronzeTime',XInt);
      end;
    end;
    FlyingPayloadWeaponPropertiesContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('MaxPitchSpeed',XFFloat);
      AddVal('PitchAcceleration',XFFloat);
      AddVal('Inertia',XFloat);
      AddVal('MaxYawSpeed',XFFloat);
      AddVal('YawAcceleration',XFFloat);
      AddVal('MaxRollSpeed',XFFloat);
      AddVal('RollAcceleration',XFFloat);
      AddVal('FlyingSpeed',XFloat);
      AddVal('MaxWorldYawSpeed',XFFloat);
      AddVal('BlendTowardsHorizontal',XFloat);
      AddVal('BlendTowardsVertical',XFFloat);
      AddVal('MaxAutoRollSpeed',XFFloat);
      AddVal('AutoRollAcceleration',XFFloat);
      AddVal('AutoRollDelay',XInt);
      AddVal('YawAnimSpeed',XFFloat);
      AddVal('RollAnimSpeed',XFFloat);
      AddVal('AnimYaw',XString);
      AddVal('AnimRoll',XString);
      AddVal('FlyingGraphicsResourceID',XString);
      XCntr.Name:=vs;
      TreeNode.Text:=GetXName(XCntr);
      AddVal('FlyingLaunchSfx',XString);
      AddVal('FlyingLoopSfx',XString);
      AddVal('AnimFly',XString);
      AddVal('AnimFall',XString);
      JumpingPayloadWeapon;
    end;
    JumpingPayloadWeaponPropertiesContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      JumpingPayloadWeapon;
    end;
    HomingPayloadWeaponPropertiesContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;

      AddVal('OrientationProportion',XFloat);
      AddVal('Stage1Duration',XInt);
      AddVal('Stage2Duration',XInt);
      AddVal('Stage3Duration',XInt);
      AddVal('MaxHomingSpeed',XFloat);
      AddVal('HomingAcceleration',XFFloat);
      AddVal('AvoidsLand',XBool);
      AddVal('VerticalLandAvoidanceDistance',XFloat);
      AddVal('ForwardLandAvoidanceDistance',XFloat);
      AddVal('VerticalLandAvoidanceForce',XFloat);
      AddVal('ForwardLandAvoidanceForce',XFloat);
      PayloadWeapon;
    end;
    PayloadWeaponPropertiesContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      PayloadWeapon;
    end;
    AIParametersContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
	AddVal('WeightingThisWormValue',XFloat);
	AddVal('WeightingWormVital',XFloat);
	AddVal('WeightingWormHealth',XFloat);
	AddVal('WeightingWormPoisoned',XFloat);
	AddVal('WeightingWormExchange',XFloat);
	AddVal('WeightingWormLastInTeam',XFloat);
	AddVal('WeightingWormNearbyWorms',XFloat);
	AddVal('WeightingWormMilesAway',XFloat);
	AddVal('WeightingAttack',XFloat);
	AddVal('WeightingExplosiveSecondaryDamage',XFloat);
	AddVal('WeightingExplosiveNearbyThreat',XFloat);
	AddVal('WeightingKillTarget',XFloat);
	AddVal('WeightingMultipleUse',XFloat);
	AddVal('WeightingPunchThroughLand',XFloat);
	AddVal('WeightingPreferNearbyTargets',XFloat);
	AddVal('WeightingBestMissShotMultipleUse',XFloat);
	AddVal('WeightingPreferVariety',XFloat);
	AddVal('ShotErrorProjectile',XFloat);
	AddVal('ShotErrorDirect',XFloat);
	AddVal('ShotErrorDirectNonStrafe',XFloat);
	AddVal('DelayAtStart',XFloat);
	AddVal('DelayBeforeFire',XFloat);
	AddVal('ProjectileSweetSpotDistance',XFloat);
	AddVal('StrikeSweetSpotDistance',XFloat);
	AddVal('ClusterDistanceAboveTarget',XFloat);
	AddVal('MaximumDistanceTargetConsidered',XFloat);
	AddVal('ForbidShotsWhenMightAffectAITrigger',XFloat);
	AddVal('WeightingPlanScoreRandomise',XFloat);
	AddVal('AddScoreMoveIfNotMoved',XFloat);
	AddVal('AddScoreMove',XFloat);
	AddVal('DelayBeforeFirstMove',XFloat);
	AddVal('DelayBeforeNonFirstMove',XFloat);
	AddVal('RandomSmallMoveRange',XFloat);
	AddVal('ReduceMoveScoreFurtherThan',XFloat);
	AddVal('AddScoreCollectSomething',XFloat);
	AddVal('WeightCollectWeapon',XFloat);
	AddVal('WeightCollectHealth',XFloat);
	AddVal('WeightCollectHealthWhenPoisoned',XFloat);
	AddVal('WeightCollectUtility',XFloat);
	AddVal('AllowCollectNormalCrate',XBool);

	AddVal('LikeToCollectHealthWhenHealthBelow',XFloat);
	AddVal('ReduceMoveScoreIfTimeLeftLessThan',XFloat);
	AddVal('ForbidMoveIfWouldLeaveTimeLessThan',XFloat);
	AddVal('WeightingPreferAttackHumans',XFloat);
	AddVal('MemoryImproveAccuracyMatchRadius',XFloat);
	AddVal('MemoryImproveAccuracyEffect',XFloat);

	AddVal('TargetDetailObject',XString);
	AddVal('AddScoreTeleport',XFloat);
	AddVal('WeightStrikeSecondaryTarget',XFloat);
	AddVal('ConsidersStrikeThrustDirection',XBool);
	AddVal('ShotErrorStrike',XFloat);
	AddVal('StrafeProgressiveErrorScale',XFloat);
	AddVal('MovementJumpForwardAllowed',XBool);
	AddVal('MovementJumpBackflipAllowed',XBool);
	AddVal('MovementJumpError',XFloat);
	AddVal('WeightTeleportDefensivePos',XFloat);
	AddVal('WeightTeleportOffensivePos',XFloat);
	AddVal('WeightRetreatDefensivePos',XFloat);
	AddVal('WeightRetreatOffensivePos',XFloat);
	AddVal('ImaginaryCrateDetailObject',XString);
	AddVal('AttractorDetailObject',XString);
	AddVal('AttractorZoneRadius',XFloat);
	AddVal('MortarMaximumAimAngleAllowed',XFloat);
	AddVal('JetpackAboutToCrossLineLookAhead',XFloat);
	AddVal('PrefBazooka',XFloat);
	AddVal('PrefGrenade',XFloat);
	AddVal('PrefClusterGrenade',XFloat);
	AddVal('PrefAirstrike',XFloat);
	AddVal('PrefDynamite',XFloat);
	AddVal('PrefHolyHandGrenade',XFloat);
	AddVal('PrefBananaBomb',XFloat);
	AddVal('PrefLandmine',XFloat);
	AddVal('PrefShotgun',XFloat);
  if W3D then
	AddVal('PrefUzi',XFloat);
	AddVal('PrefBaseballBat',XFloat);
	AddVal('PrefProd',XFloat);
  if W3D then
	AddVal('PrefVikingAxe',XFloat);
	AddVal('PrefFirePunch',XFloat);
	AddVal('PrefHomingMissile',XFloat);
  if W3D then begin
	AddVal('PrefMortar',XFloat);
	AddVal('PrefHomingPidgeon',XFloat);
	AddVal('PrefEarthquake',XFloat);
  end;
  if WUM then
  AddVal('PrefFlood',XFloat);
	AddVal('PrefSheep',XFloat);
  if W3D then begin
	AddVal('PrefMineStrike',XFloat);
	AddVal('PrefPetrolBomb',XFloat);
  end;
	AddVal('PrefGasCanister',XFloat);
  if W3D then begin
	AddVal('PrefSheepStrike',XFloat);
	AddVal('PrefMadCow',XFloat);
  end;
	AddVal('PrefOldWoman',XFloat);
	AddVal('PrefConcreteDonkey',XFloat);
  if W3D then begin
	AddVal('PrefNuclearBomb',XFloat);
	AddVal('PrefArmageddon',XFloat);
	AddVal('PrefMagicBullet',XFloat);
  end;
	AddVal('PrefSuperSheep',XFloat);
	AddVal('PrefGirder',XFloat);
	AddVal('PrefBridgeKit',XFloat);
	AddVal('PrefNinjaRope',XFloat);
	AddVal('PrefParachute',XFloat);
  if W3D then
	AddVal('PrefScalesOfJustice',XFloat);
	AddVal('PrefLowGravity',XFloat);
  if W3D then begin
	AddVal('PrefQuickWalk',XFloat);
	AddVal('PrefLaserSight',XFloat);
  end;
	AddVal('PrefTeleport',XFloat);
	AddVal('PrefJetpack',XFloat);
	AddVal('PrefSkipGo',XFloat);
	AddVal('PrefSurrender',XFloat);
	AddVal('PrefChangeWorm',XFloat);
  if W3D then begin
	AddVal('PrefFreeze',XFloat);
	AddVal('PrefBlowpipe',XFloat);
	AddVal('PrefLotteryStrike',XFloat);
	AddVal('PrefDoctorsStrike',XFloat);
	AddVal('PrefMegaMine',XFloat);
	AddVal('PrefStickyBomb',XFloat);
	AddVal('PrefBinoculars',XFloat);
  end;
	AddVal('PrefRedbull',XFloat);
  if WUM then begin
      AddVal('PrefWeaponFactoryWeapon',XFloat);
      AddVal('PrefStarburst',XFloat);
      AddVal('PrefAlienAbduction',XFloat);
      AddVal('PrefFatkins',XFloat);
      AddVal('PrefScouser',XFloat);
      AddVal('PrefNoMoreNails',XFloat);
      AddVal('PrefPipe',XFloat);
      AddVal('PrefPoisonArrow',XFloat);
      AddVal('PrefSentryGun',XFloat);
      AddVal('PrefSniperRifle',XFloat);
      AddVal('PrefSuperAirstrike',XFloat);
      AddVal('PrefBubbleTrouble',XFloat);
  end;
	AddVal('PrefWeaponProjectile',XFloat);
	AddVal('PrefWeaponDirect',XFloat);
	AddVal('PrefWeaponStrike',XFloat);
	AddVal('PrefWeaponMelee',XFloat);
	AddVal('PrefWeaponAnimal',XFloat);
    end;
    BaseWeaponContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      BaseWeapon;
    end;
    MineFactoryContainer:
    begin
      AddNode('XContainer::'+GetXName(XCntr));
      p2 := XCntr.GetPoint;

      AddVal('NumMineActivation',XByte);
      AddVal('NumTurnsInactive',XByte);
      AddVal('SafeRadiusPadding',XFloat);
      AddVal('DamageMagnitude',XFloat);
      AddVal('ImpulseMagnitude',XFloat);
      AddVal('WormDamageRadius',XFloat);
      AddVal('LandDamageRadius',XFloat);
      AddVal('ImpulseRadius',XFloat);
    end;
    MeleeWeaponPropertiesContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;

      AddVal('IsAimedWeapon',XBool);
      AddVal('DamageIsPercentage',XBool);
      AddVal('WormIsWeapon',XBool);
      if WUM then begin
      AddVal('InstantKill',XBool);
      AddVal('AccuracyMeter',XBool);
      LoadEnum(MeleeWeaponEnum);
      AddVal('MeleeType',XEnum);
      end;
      if not WUM then begin
      AddVal('RetreatTimeOverride',XInt);
      end;
      AddVal('Radius',XFloat);
      AddVal('MinAimAngle',XFloat);
      AddVal('MaxAimAngle',XFloat);
      AddVal('DischargeFX',XString);
      AddVal('DischargeSoundFX',XString);
      AddVal('WormCollisionFX',XString);
      AddVal('LandCollisionFX',XString);
      if WUM then begin
      AddVal('WXAnimWindup',XString);//
      end;
      AddVal('LogicalPositionOffset',XVector);
      AddVal('ImpulseDirection',XVector);
      AddVal('LogicalLaunchYOffset',XFloat);
      AddVal('WormDamageMagnitude',XFloat);
      AddVal('LandDamageMagnitude',XFloat);
      AddVal('ImpulseMagnitude',XFloat);
      AddVal('WormDamageRadius',XFloat);
      AddVal('LandDamageRadius',XFloat);
      AddVal('ImpulseRadius',XFloat);
      BaseWeapon;
    end;

    GunWeaponPropertiesContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;

      AddVal('IsAimedWeapon',XBool);
      AddVal('IsAffectedByGravity',XBool);
      AddVal('IsAffectedByWind',XBool);
      AddVal('bCanDamageLand',XBool);
      AddVal('bCanMoveBetweenShots',XBool);
      AddVal('ImpulseIsNormal',XBool);
      AddVal('DamageIsPercentage',XBool);
      AddVal('LaserEffect',XBool);
      if WUM then begin
      AddVal('Sniper',XBool);
      end;
      if not WUM then begin
        AddVal('RetreatTimeOverride',XInt);
      end;
      AddVal('NumberOfBullets',XInt);
      AddVal('DischargeTime',XInt);
      AddVal('Range',XInt);
      AddVal('WaitForSoundDelay',XInt);
      AddVal('Accuracy',XFloat);
      AddVal('WormDamageMagnitude',XFloat);
      AddVal('WormPoisonMagnitude',XFloat);
      AddVal('LandDamageMagnitude',XFloat);
      AddVal('ImpulseMagnitude',XFloat);
      AddVal('BulletRadius',XFloat);
      AddVal('MinAimAngle',XFloat);
      AddVal('MaxAimAngle',XFloat);
      AddVal('WormDamageRadius',XFloat);
      AddVal('LandDamageRadius',XFloat);
      AddVal('ImpulseRadius',XFloat);
      AddVal('LogicalLaunchYOffset',XFloat);
      AddVal('DischargeFX',XString);
      AddVal('DischargeEndFX',XString);
      AddVal('SecondaryDischargeFX',XString);
      AddVal('SecondaryDischargeFXLocator',XString);
      AddVal('DischargeSoundFX',XString);
      AddVal('DischargeEndSoundFX',XString);
      AddVal('WormCollisionFX',XString);
      AddVal('LandCollisionFX',XString);
      AddVal('WaterCollisionFX',XString);
      AddVal('LogicalPositionOffset',XVector);
      AddVal('ImpulseDirection',XVector);
      AddVal('DischargeFXZOffset',XFloat);
      AddVal('KickSize',XFloat);
      AddVal('KickFrequency',XInt);
      BaseWeapon;
    end;
    SentryGunWeaponPropertiesContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;

      AddVal('ActivatedFx',XString);
      AddVal('ReloadFx',XString);
      AddVal('PreExplosionFx',XString);
      AddVal('DamageFx',XString);
      AddVal('ExplosionFx',XString);
      AddVal('FireFx',XString);
      AddVal('SplishFx',XString);
      AddVal('SplashFx',XString);
      AddVal('SinkingFx',XString);
      AddVal('ReloadSfx',XString);
      AddVal('ExplosionSfx',XString);
      AddVal('FireSfx',XString);
      AddVal('SplashSfx',XString);
      AddVal('ShotImpulseMagnitude',XFloat);
      AddVal('ShotImpulseRadius',XFloat);
      AddVal('ShotLandDamageMagnitude',XFloat);
      AddVal('ShotLandDamageRadius',XFloat);
      AddVal('ShotWormDamageMagnitude',XFloat);
      AddVal('ShotWormDamageRadius',XFloat);
      AddVal('WeaponDamageRadius',XFloat);
      AddVal('WeaponDamageMagnitude',XFloat);
      AddVal('DeathWormDamageMagnitude',XFloat);
      AddVal('DeathWormDamageRadius',XFloat);
      AddVal('DeathLandDamageRadius',XFloat);
      AddVal('DeathImpulseMagnitude',XFloat);
      AddVal('DeathImpulseRadius',XFloat);
      AddVal('MaxWeaponTemp',XFloat);
      AddVal('TempDelta',XFloat);
      AddVal('WeaponReloadTime',XInt);
      AddVal('MinWeaponRange',XFloat);
      AddVal('MaxWeaponRange',XFloat);
      AddVal('LogicalLaunchZOffset',XFloat);
      AddVal('CollisionRadius',XFloat);
      AddVal('TurretRotationalVelocity',XFFloat);
      AddVal('WeaponHealth',XFloat);
      BaseWeapon;
    end;
    ParticleMeshNamesContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddSetVal('MeshNames',XString);
    end;
    XParticleEmitter:
    begin
      AddNode('XContainer::'+GetXName(XCntr));
      p2 := XCntr.GetPoint;
      ParticleEmitter;
    end;
    XMissileTrailEmitter:
    begin
      AddNode('XContainer::'+GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('MinRotationRate',XFloat);
      AddVal('MaxRotationRate',XFloat);
      LoadEnum(RotationDirection);
      AddVal('RotationDirection',XEnum);
      AddVal('InitialColour',XVector4);
      AddVal('TargetColour',XVector4);
      AddVal('FinalColour',XVector4);
      AddVal('NumFrames',XInt);
      AddVal('RandomStartFrame',XBool);
      AddVal('AnimationFrameRate',XFloat);
      AddVal('FirstColourChangeStart',XFloat);
      AddVal('FirstColourChangeEnd',XFloat);
      AddVal('SecondColourChangeStart',XFloat);
      AddVal('SecondColourChangeEnd',XFloat);
      AddVal('TargetSizeFactor',XFloat);
      AddVal('FirstSizeChangeStart',XFloat);
      AddVal('FirstSizeChangeEnd',XFloat);
      AddVal('SecondSizeChangeStart',XFloat);
      AddVal('SecondSizeChangeEnd',XFloat);
      AddVal('MaxParticleGap',XFloat);
      AddVal('RandomParticleOffset',XFloat);
      ParticleEmitter;
    end;
    XSnowEmitter:
    begin
      AddNode('XContainer::'+GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('MinDistanceFromCamera',XFloat);
      AddVal('HeightAboveCamera',XFloat);
      AddVal('MaxDisturbAmount',XFloat);
      AddVal('DisturbIntervalEnergy',XFloat);
      ParticleEmitter;
    end;
    XBasicEmitter:
    begin
       AddNode('XContainer::'+GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('MinRotationRate',XFloat);
      AddVal('MaxRotationRate',XFloat);
        LoadEnum(RotationDirection);
      AddVal('RotationDirection',XEnum);
      AddVal('FinalSpeedFactor',XFloat);
      AddVal('NumFrames',XInt);// dword_73C920
      AddVal('RandomStartFrame',XBool);
      AddVal('AnimationFrameRate',XFloat);
      AddVal('TargetSizeFactor',XFloat);
      AddVal('FirstSizeChangeStart',XFloat);
      AddVal('FirstSizeChangeEnd',XFloat);
      AddVal('SecondSizeChangeStart',XFloat);
      AddVal('SecondSizeChangeEnd',XFloat);
      AddVal('InitialColour',XVector4); // unk_746E54
      AddVal('TargetColour',XVector4);
      AddVal('FinalColour',XVector4);
      AddVal('FirstColourChangeStart',XFloat);
      AddVal('FirstColourChangeEnd',XFloat);
      AddVal('SecondColourChangeStart',XFloat);
      AddVal('SecondColourChangeEnd',XFloat);
      ParticleEmitter;
    end;
    ParticleEmitterContainer:
    begin
      AddNode('XContainer::'+GetXName(XCntr));
      p2 := XCntr.GetPoint;

      AddVal('Comment',XString);
      LoadEnum(ParticleTypeEnum);
      AddVal('EmitterType',XEnum);  // Enum
      AddVal('SpriteSet',XString);
      AddSetVal('MeshSet',XString);
      AddVal('MeshAnimNodeName',XString);
      AddVal('EmitterAcceleration',XVector);
      AddVal('EmitterAccelerationRandomise',XVector);
      AddVal('EmitterIsAttachedToLand',XBool);
      AddVal('EmitterIsOfInterest',XBool);
      AddVal('EmitterIsLaunchedFromWeapon',XBool);
      AddVal('EmitterLifeTime',XUInt);
      AddVal('EmitterLifeTimeRandomise',XUint);
      AddVal('EmitterMaxParticles',XUint);
      AddVal('EmitterNumCollide',XUint);
      AddVal('EmitterNumSpawn',XUint);
      AddVal('EmitterNumSpawnRadnomise',XUint);
      AddVal('EmitterOriginOffset',XVector);
      AddVal('EmitterOriginRandomise',XVector);
      AddVal('EmitterParticleExpireFX',XString);
      AddVal('EmitterParticleFX',XString);
      AddVal('EmitterSameDirectionAsWorm',XBool);
      AddVal('EmitterSoundFX',XString);
      if WUM then begin
      DelVal:=AsW3D and true;
      AddVal('EmitterSoundFXVolume',XFloat);        //--
      DelVal:=false;
      end;
      AddVal('EmitterSpawnFreq',XUint);
      AddVal('EmitterSpawnFreqRansomise',XUint);
      AddVal('EmitterSpawnSizeVelocity',XPoint);
      AddVal('EmitterStartDelay',XUint);
      AddVal('EmitterVelocity',XVector);
      AddVal('EmitterVelocityRandomise',XVector);
      AddVal('ParticleAcceleration',XVector);
      AddVal('ParticleAccelerationRandomise',XVector);
      AddVal('ParticleAlpha',XFloat);
      AddVal('ParticleAlphaFadeIn',XUint);
      AddVal('ParticleAlphaVelocity',XFloat);
      AddVal('ParticleAlphaVelocityDelay',XUint);
      AddVal('ParticleAlternateAccelerationN',XFloat);
      AddVal('ParticleAlternateAccelerationS',XFFloat);
      AddVal('ParticleAnimationFrame',XByte);
      AddVal('ParticleAnimationFrameRandomise',XByte);
      AddVal('ParticleAnimationSpeed',XUint);
      AddVal('ParticleAnimationSpeedRandomize',XUint);
      AddVal('ParticleAttractor',XVector);
      AddVal('ParticleAttractorRandomise',XVector);
      AddVal('ParticleAttractorIsActive',XBool);
      AddVal('ParticleCanEnterWater',XBool);
      AddVal('ParticleCollisionFreq',XUint);
      AddVal('ParticleCollisionImmuneTime',XUint);
      AddVal('ParticleCollisionMinAlpha',XFloat);
      AddVal('ParticleCollisonRadius',XFloat);
      AddVal('ParticleCollisonRadiusOffset',XVector);
      AddVal('ParticleCollisonRadiusVelocity',XFFloat);
      AddVal('ParticleCollisionShowDebug',XBool);
      AddVal('ParticleCollisionWormDamageMagnitude',XByte);
      AddVal('ParticleCollisionWormImpulseMagnitude',XFloat);
      AddVal('ParticleCollisionWormImpulseYMagnitude',XFloat);
      AddVal('ParticleCollisionWormPoisonMagnitude',XByte);
      LoadEnum(WormCollideEnum);
      AddVal('ParticleCollisionWormType',XEnum);
      AddSetVal('ParticleColor',XFColor);
      AddSetVal('ParticleColorBand',XFloat);
      AddVal('ParticleExpireShake',XBool);
      AddVal('ParticleExpireShakeLength',XFloat);
      AddVal('ParticleExpireShakeMagnitude',XUint);
      AddVal('ParticleIsAlternateAcceleration',XBool);
      AddVal('ParticleIsEffectedByWind',XBool);
      AddVal('ParticleIsSpiral',XBool);
      AddVal('ParticleIsUnderWaterEffect',XBool);
      LoadEnum(LandCollideEnum);
      if WUM then  LoadEnum(WUMLandCollideEnum);
      AddVal('ParticleLandCollideType',XEnum);
      AddVal('ParticleLife',XUint);
      AddVal('ParticleLifeRandomise',XUint);
      AddVal('ParticleMass',XFloat);
      AddVal('ParticleNumColors',XByte);
      AddVal('ParticleNumFrames',XByte);
      AddVal('ParticleOrientation',XVector);
      AddVal('ParticleOrientationRandomise',XVector);
      AddVal('ParticleOrientationVelocity',XVector);
      AddVal('ParticleOrientationVelocityRandomise',XVector);
      AddVal('ParticleSize',XPoint);
      AddVal('ParticleSizeOriginIsCenterPoint',XBool);
      AddVal('ParticleSizeRandomise',XFloat);
      AddVal('ParticleSizeVelocity',XPoint);
      AddVal('ParticleSizeVelocityRandomise',XPoint);
      AddVal('ParticleSizeVelocityDelay',XUint);
      if WUM then begin
      DelVal:=AsW3D and true;
      AddVal('ParticleSizeVelocityDelayRandomise',XUint);     //--
      DelVal:=false;
      end;
      AddVal('ParticleFinalSizeScale',XPoint);
      AddVal('ParticleFinalSizeScaleRandomise',XFloat);
      if WUM then begin
      DelVal:=AsW3D and true;
      AddVal('ParticleSizeFadeIn',XUint);               //--
      AddVal('ParticleSizeFadeInRandomize',XUint);     //--
      AddVal('ParticleSizeFadeInDelay',XUint);         //--
      AddVal('ParticleSizeFadeInDelayRandomize',XUint); //--
      DelVal:=false;
      end;
      LoadEnum(ParticleSceneEnum);
      AddVal('ParticleRenderScene',XEnum);
      AddVal('ParticleSpiralRadius',XFloat);
      AddVal('ParticleSpiralRadiusRandomise',XFloat);
      AddVal('ParticleSpiralRadiusVelocity',XFloat);
      AddVal('ParticleSpiralRadiusVelocityRandomise',XFloat);
      AddVal('ParticleSpiralRadiusSizeVelocity',XFloat);
      AddVal('ParticleVelocity',XVector);
      AddVal('ParticleVelocityRandomise',XVector);
      AddVal('ParticleVelocityIsNormalised',XBool);

    end;
    WaterPlaneTweaks:
    begin
      AddNode('XContainer::'+GetXName(XCntr));
      p2 := XCntr.GetPoint;
      if W3D then begin
      AddVal('GlintCentreColor',XColor);
      AddVal('GlintInnerColor',XColor);
      AddVal('GlintMiddleColor',XColor);
      AddVal('GlintOuterColor',XColor);
      AddVal('GlintRimColor',XColor);
      AddVal('ShadowCentreColor',XColor);
      AddVal('ShadowInnerColor',XColor);
      AddVal('ShadowMiddleColor',XColor);
      AddVal('ShadowOuterColor',XColor);
      AddVal('ShadowRimColor',XColor);
      AddVal('BlendCentreColor',XColor);
      AddVal('BlendInnerColor',XColor);
      AddVal('BlendMiddleColor',XColor);
      AddVal('BlendOuterColor',XColor);
      AddVal('BlendRimColor',XColor);
      AddVal('DetailCentreColor',XColor);
      AddVal('DetailInnerColor',XColor);
      AddVal('DetailMiddleColor',XColor);
      AddVal('DetailOuterColor',XColor);
      AddVal('DetailRimColor',XColor);
      AddVal('ExtraGlintCentreColor',XColor);
      AddVal('ExtraGlintInnerColor',XColor);
      AddVal('ExtraGlintMiddleColor',XColor);
      AddVal('ExtraGlintOuterColor',XColor);
      AddVal('ExtraGlintRimColor',XColor);
      AddVal('GlintResource',XString);
      AddVal('ShadowResource',XString);
      AddVal('SkyBlendResource',XString);
      AddVal('DetailResource',XString);
      AddVal('SkyBlendColor',XColor);
      AddVal('GlintTextureScaleA',XFloat);
      AddVal('GlintTextureScaleB',XFloat);
      AddVal('ShadowTextureScaleA',XFloat);
      AddVal('ShadowTextureScaleB',XFloat);
      AddVal('DetailTextureScaleA',XFloat);
      AddVal('DetailTextureScaleB',XFloat);
      end;
      if WUM then begin
      //	5
  {    AddVal('GlintCentreColor',XColor);
      AddVal('GlintInnerColor',XColor);
      AddVal('GlintMiddleColor',XColor);
      AddVal('GlintOuterColor',XColor);
      AddVal('GlintRimColor',XColor);
      AddVal('ShadowCentreColor',XColor);
      AddVal('ShadowInnerColor',XColor);
      AddVal('ShadowMiddleColor',XColor);
      AddVal('ShadowOuterColor',XColor);
      AddVal('ShadowRimColor',XColor);
      AddVal('BlendCentreColor',XColor);
      AddVal('BlendInnerColor',XColor);
      AddVal('BlendMiddleColor',XColor);
      AddVal('BlendOuterColor',XColor);
      AddVal('BlendRimColor',XColor);
      AddVal('DetailCentreColor',XColor);
      AddVal('DetailInnerColor',XColor);
      AddVal('DetailMiddleColor',XColor);
      AddVal('DetailOuterColor',XColor);
      AddVal('DetailRimColor',XColor);
      AddVal('ExtraGlintCentreColor',XColor);
      AddVal('ExtraGlintInnerColor',XColor);
      AddVal('ExtraGlintMiddleColor',XColor);
      AddVal('ExtraGlintOuterColor',XColor);
      AddVal('ExtraGlintRimColor',XColor);
      AddVal('GlintResource',XString);
      AddVal('ShadowResource',XString);
      AddVal('SkyBlendResource',XString);
      AddVal('DetailResource',XString);  }

      AddVal('SkyBlendColor',XColor);
      //	5
   {   AddVal('GlintTextureScaleA',XFloat);
      AddVal('GlintTextureScaleB',XFloat);
      AddVal('ShadowTextureScaleA',XFloat);
      AddVal('ShadowTextureScaleB',XFloat);
      AddVal('DetailTextureScaleA',XFloat);
      AddVal('DetailTextureScaleB',XFloat);   }
      //	25
   {   AddVal('_cgNearOpacity',XFloat);
      AddVal('_cgTextureScale',XFloat);
      AddVal('_cgSpecualerFaceScale',XFloat);
      AddVal('_cgDiffuseFaceScale',XFloat);
      AddVal('_cgReflectionStrength',XFloat);
      AddVal('_cgReflectionContrast',XFloat);
      AddVal('_cgReflectionContrast1',XFloat); 
      //	45
      AddVal('_cgSpecularContrast',XFloat);
      AddVal('_cgSpecularPower',XFloat);
      //	25
      AddVal('_cgNormalIntensity',XVector);
      AddVal('_cgNormalIntensity1',XVector);   
      //	35
      AddVal('_cgSubtractColourScale',XFloat);  }
      //	5
      AddVal('DiffuseTexture',XString);
      AddVal('NormalTexture',XString);
      AddVal('EnvironmentTexture',XString);
      AddVal('NearOpacity',XFloat);
      AddVal('TextureScale',XFloat);
      AddVal('SpecularFadeScale',XFloat);
     // AddVal('DiffuseFadeScale',XFloat);     // Schema56
      AddVal('ReflectionStrength',XFloat);
      AddVal('ReflectionContrast',XFloat);
      AddVal('SpecularContrast',XFloat);
      AddVal('SpecularPower',XFloat);
      AddVal('NormalIntensity',XVector);
      AddVal('NormalIntensity1',XVector);
      AddVal('SubtractColourScale',XFloat);
      AddVal('LightDirection',XVector);
      AddVal('LightAmbient',XBColor);
      AddVal('LightDiffuse',XBColor);
      AddVal('LightSpecular',XBColor);
      //	6
      AddVal('LightFresnel',XBColor);
      //	5
      AddVal('LandSpecularPower',XFloat);
      AddVal('LandFresnelColour',XBColor);
      AddVal('LandFresnelPower',XFloat);
      end;
    end;
    EffectDetailsContainer:
    begin
      AddNode('XContainer::'+GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddSetVal('EffectNames',XString);
    end;
    Campaign:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddSetNode('Missions');
      AddVal('LevelName',XString);
      XCntr.Name:=vs;
      AddVal('ScriptName',XString);
      AddVal('LevelType',XInt);
      AddVal('Brief',XString);
      AddVal('Image',XString);
      AddVal('LevelNumber',XInt);
      AddVal('Lock',XString);
      AddVal('LongestWins',XBool);
      AddVal('AIPathNodeStartYOffset',XFloat);
      AddVal('AIPathNodeCollisionStep',XFloat);
    end;
    SavedLevel:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('seed',XInt);
      AddVal('levelName',XString);
      AddVal('theme',XString);
    end;
    SavedLevelCollective:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddSetNode('SavedLevels');    
    end;
    AssistedShotTweaks:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('ChangeInPitch',XFloat);
//	The range of pitch values.  Checks from -ChangeInPitch to +ChangeInPitch
      AddVal('ChangeInYaw',XFloat);
//	The range of yaw values.  Checks from -ChangeInYaw to +ChangeInYaw
      AddVal('ChangeInPower',XFloat);
//	The range of power values.  Checks from -ChangeInPower to +ChangeInPower
      AddVal('NumPowerChecks',XInt);
//	The number of values to check either side of the original power value
      AddVal('NumPitchChecks',XInt);
//	The number of values to check either side of the original pitch value
      AddVal('NumYawChecks',XInt);
//	The number of values to check either side of the original yaw value
    end;
    WXFE_UnlockableItem:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      LoadEnum(WXFE_UnlockResourceTypeEnum);
      AddVal('Type',XEnum);
      LoadEnum(WXFE_UnlockableStateEnum);
      AddVal('State',XEnum);
      AddVal('DescriptionName',XString);
      AddVal('Value',XInt);
      AddSetVal('UnlockRequirements',XString);
      AddVal('UnlockRequirementsMet',XBool);
      AddVal('DLCPack',XInt);
//	2
      AddSetVal('UnlockedAttachments',XString);
//	3
    end;
    WXFE_UnlockableItemSet:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddSetVal('CharacterSetItems',XString);
    end;

// Desc types

    AcceptCancelButtonDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('AcceptMessage',XString);
      AddVal('CancelMessage',XString);
      DescRead;
    end;
    ListHeaderControlDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('HeaderDataId',XString);
      AddVal('HeaderHeight',XFloat);
      AddVal('HeaderFontSize',XFloat);
      ListControlRead;
      DescRead;
    end;
    ListControlDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      ListControlRead;
      DescRead;
    end;
    ComboControlDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('GameDataId',XString);
      AddVal('DataIndexId',XString);
      AddVal('HighlightedMessage',XString);
      AddVal('SelectedMessage',XString);
      AddVal('ControlHighlightMessage',XString);
      LoadEnum(ButtonColourEnum);
      AddVal('BorderColour',XEnum);
      AddVal('SliderAlwaysOn',XBool);
      AddVal('SliderTabExpand',XBool);
      LoadEnum(RowBackgroundType);
      AddVal('BackGroundType',XEnum);
      AddVal('DropDownSize',XFloat);
      AddVal('ItemHeight',XFloat);
      AddVal('ButtonArea',XFloat);
      AddVal('ControlFontSize',XFloat);
      AddVal('OpenAudio',XString);
      AddVal('CloseAudio',XString);
      AddVal('KeepComboOpen',XBool);
      AddVal('BorderSize',XFloat);
      DescRead;
    end;
    PercentButtonDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('DataResourceName',XString);
      AddVal('LimitResource',XString);
      AddVal('ExpandingImage',XBool);
      AddVal('IncreaseAudio',XString);
      AddVal('FontResourceName',XString);
      AddVal('BorderSize',XFloat); 
      MenuButoonRead;
      DescRead;
    end;
    CheckBoxDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('DataResourceID',XString);
      AddVal('ChangeValue',XBool);
      MenuButoonRead;
      DescRead;
    end;    
    MenuButtonDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      MenuButoonRead;
      DescRead;
    end;
    PictureViewDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('GfxResource',XString);
      AddVal('DisabledGfxResource',XString);
      AddVal('NewGfxInAnim',XString);
      AddVal('NewGfxOutAnim',XString);
      DescRead;
    end;
    ControlSetupDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
    end;
    GraphicEqualiserDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('ResourceName',XString);
      AddVal('HighlightedMessage',XString);
      AddVal('SelectedMessage',XString);
      AddVal('BorderResource',XString);
      LoadEnum(ButtonColourEnum);
      AddVal('BorderColour',XEnum);
      AddVal('SquareButton',XBool);
      AddVal('BorderBehind',XBool);
      AddVal('MinOffset',XFloat);
      AddVal('MaxOffset',XFloat);
      AddVal('VolumeId',XString);
      AddVal('AudioData',XString);
      DescRead;
    end;
    WXFE_BriefingDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('Briefing_Font',XString);
      AddVal('Briefing_DataId',XString);
      AddVal('Briefing_FontSize',XFloat);
      LoadEnum(WXFE_GradientColours);
      AddVal('Briefing_Colour_Front',XEnum);
      LoadEnum(WXFE_BackgroundColours);
      AddVal('Briefing_Colour_Back',XEnum);
      LoadEnum(WXFE_TextAnimationEnum);
      AddVal('Briefing_TextAnim',XEnum);
      AddVal('Continue_Font',XString);
      AddVal('Continue_DataId',XString);
      AddVal('Continue_FontSize',XFloat);
      LoadEnum(WXFE_GradientColours);
      AddVal('Continue_Colour_Front',XEnum);
      LoadEnum(WXFE_BackgroundColours);
      AddVal('Continue_Colour_Back',XEnum);
      LoadEnum(WXFE_TextAnimationEnum);
      AddVal('Continue_TextAnim',XEnum);
      LoadEnum(WXFE_BorderTypeEnum);
      AddVal('Border_Type',XEnum);
      AddVal('Border_Size',XFloat);
      AddSetVal('Messages_Selected',XString);
      AddVal('MaximumHeight',XFloat);
      AddVal('Icon_Id',XString);
      AddVal('Icon_OnTheLeft',XBool);
      AddVal('Icon_Scale_X',XFloat);
      AddVal('Icon_Scale_Y',XFloat);
      LoadEnum(WXFE_PositionalEnum);
      AddVal('ControlPositionAdjustment',XEnum);
      WXFE_BaseInputItemDesc;
    end;
    WXFE_InputDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddSetVal('Messages_Selected',XString);
      AddSetVal('Messages_Cancel',XString);
      AddSetVal('Messages_Left',XString);
      AddSetVal('Messages_Right',XString);
      AddSetVal('Messages_Up',XString);
      AddSetVal('Messages_Down',XString);
      WXFE_BaseInputItemDesc;
    end;
    WXFE_LandscapeBoxDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('ResourceId',XString);
      AddVal('SeedId',XString);
      AddSetVal('Messages_Highlighted',XString);
      AddSetVal('Messages_Selected',XString);
      AddSetVal('Messages_RightMouse',XString);
      AddVal('FinishedRenderingID',XString);
      LoadEnum(WXFE_BorderTypeEnum);
      AddVal('Border_Normal',XEnum);
      AddVal('Border_Highlight',XEnum);
      AddVal('Border_Disabled',XEnum);
      WXFE_BaseInputItemDesc;
    end;
    LandscapeBoxDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('LumpFileId',XString);
      AddVal('HighlightedMessage',XString);
      AddVal('SelectedMessage',XString);
      AddVal('ChangedRenderState',XString);
      LoadEnum(ButtonColourEnum);
      AddVal('BorderColour',XEnum);
      AddVal('TimerPosition',XVector);
      AddVal('TimerScale',XVector);
      DescRead;
    end;
    WormPotControlDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('HighlightedMessage',XString);
      AddVal('Reel_1_Resource',XString);
      AddVal('Reel_2_Resource',XString);
      AddVal('Reel_3_Resource',XString);
      AddVal('ToolTip_NudgeUp1',XString);
      AddVal('ToolTip_NudgeUp2',XString);
      AddVal('ToolTip_NudgeUp3',XString);
      AddVal('ToolTip_NudgeDown1',XString);
      AddVal('ToolTip_NudgeDown2',XString);
      AddVal('ToolTip_NudgeDown3',XString);
      AddVal('ToolTip_Arm',XString);
      DescRead;
    end;
   TitleTextDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('FontResource',XString);
      AddVal('TextResource',XString);
      AddVal('Colour',XInt);
      AddVal('Underline',XBool);
      AddVal('BorderOn',XBool);
      AddVal('BorderSize',XFloat);
      DescRead;
    end;
    WeaponControlDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('WeaponGrafixID',XString);
      AddVal('DataContainerID',XString);
      AddVal('LockedID',XString);
      AddVal('PageID',XString);
      AddVal('TypeID',XString);
      AddVal('ToolTipID',XString);
      AddVal('BorderResource',XString);
      LoadEnum(ButtonColourEnum);
      AddVal('BorderColour',XEnum);
      AddVal('HighlightedMessage',XString);
      AddVal('SelectedMessage',XString);
      DescRead;
    end;
    WXFE_TextEditBoxDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddSetVal('Messages_Highlighted',XString);
      AddSetVal('Messages_Selected',XString);
      AddSetVal('Messages_Edited',XString);
      AddSetVal('Messages_NewChar',XString);
      AddVal('MaxTextWidthChars',XInt);
      AddVal('MaxTextWidthPixels',XInt);
      AddVal('PassWord',XBool);
      AddVal('InvalidChars',XString);
      AddVal('AutoActive',XBool);
      AddVal('NumbersOnly',XBool);
      AddVal('SoftwareKeyboardTitleID',XString);
      TextBoxRead;
      WXFE_BaseInputItemDesc;
    end;
    TextEditBoxDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('HighlightedMessage',XString);
      AddVal('SelectedMessage',XString);
      AddVal('EditedMessage',XString);
      AddVal('NewCharMessage',XString);
      AddVal('MaxTextWidthChars',XInt);
      AddVal('MaxTextWidthPixels',XInt);
      AddVal('PassWord',XBool);
      AddVal('InvalidChars',XString);
      AddVal('AutoActive',XBool);
      TextBoxRead;
      DescRead;
    end;
    WXFE_ButtonHelpDesc,
    WXFE_TextBoxDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      TextBoxRead;
      WXFE_BaseInputItemDesc;
    //  AddSetNode('ChildrenItems');
    end;
    TextBoxDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      TextBoxRead;
      DescRead;
    end;
    FrameBoxDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('ResourceName',XString);
      AddVal('TextGameDataId',XString);
      AddVal('TextRed',XInt);
      AddVal('TextGreen',XInt);
      AddVal('TextBlue',XInt);
      AddVal('BorderWidth',XFloat);
      LoadEnum(FrameBoxTextPosition);
      AddVal('TextPlacement',XEnum);
      AddVal('FrameOffset',XInt);
      DescRead;
    end;
    MultiStateButtonDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('ResourceName',XString);
      AddVal('GameDataId',XString);
      AddVal('BorderResource',XString);
      AddVal('HighlightedMessage',XString);
      AddVal('SelectedMessage',XString);
      LoadEnum(ButtonColourEnum);
      AddVal('BorderColour',XEnum);
      AddVal('SquareButton',XBool);
      AddVal('BorderBehind',XBool);
      AddVal('LoopValues',XBool);
      DescRead;
    end;
    TextButtonDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      if WF then begin
      AddVal('HighlightedMessage',XString);
      AddVal('SelectedMessage',XString);
      AddVal('BorderScaleResource',XString);// !!!
      AddVal('BorderHighlight',XInt);
      AddVal('OnRelease',XCode);
      AddVal('WrapText',XString);
    {
      AddVal('StartDelay',XString);
      AddVal('EndDelay',XString);
      AddVal('Position',XString);
      AddVal('Scale',XString);
      AddVal('UnhighlightMessage',XString);
      AddVal('IncomingAnimation',XString);
      AddVal('OutgoingAnimation',XString);
      AddVal('HighlightedAnimation',XString);
      AddVal('ActivatedAnimation',XString);
      AddVal('ItemName',XString);
      AddVal('LeftItem',XString);
      AddVal('RightItem',XString);
      AddVal('UpItem',XString);
      AddVal('DownItem',XString);
      AddVal('ToolTipId',XString);
      AddVal('FontSizeOverride',XString);
      AddVal('EnableSwitch',XString);
      AddVal('HideSwitch',XString);
      AddVal('AvailableSwitch',XString);
      AddVal('IncomingAudio',XString);
      AddVal('OutgoingAudio',XString);
      AddVal('HighlightedAudio',XString);
      AddVal('ActivatedAudio',XString);
      AddVal('Hidden',XBool);
      AddVal('LinkedItems',XString);
      AddVal('HighlightLinked',XBool);
      AddVal('DisplayOnly',XBool);    }
      end;
    end;
    MultiStateTextButtonDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      if WF then begin
      AddVal('TableResourceId',XString);
      AddVal('IntResourceId',XString);
      AddVal('LeftPressedMessage',XString);
      AddVal('RightPressedMessage',XString);
     { AddVal('EnableLeft',XString);
      AddVal('EnableRight',XString);
      AddVal('ArrowIconName',XString);
      AddVal('LoopValues',XString);   }
      end;
    end;
    ListBoxIconColumn:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      ListBoxColumnRead;
    end;
    ListBoxStringColumn:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddSetVal('Colour',XColor);
      ListBoxColumnRead;
    end;
    WeaponFactoryCollective:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddSetNode('Weapons');   // StoreWeaponFactory
    end;
    WeaponFactoryAirstrikeCostContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('BombletCost',XFloat);
      AddVal('WindCost',XFloat);
      AddVal('DetonateImpactCost',XFloat);
      AddVal('DetonateAtRestCost',XFloat);
      AddVal('PoisonCost',XFloat);
      AddVal('LandDamageRadiusCost',XFloat);
      AddVal('PushCostCost',XFloat);
      AddVal('WormDamageCost',XFloat);
    end;
    WeaponFactoryThrownCostContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('MaxPowerCost',XFloat);
      AddVal('ClustersCost',XFloat);
      AddVal('ClusterSpreadCost',XFloat);
      AddVal('ClusterDetonateImpactCost',XFloat);
      AddVal('ClusterDetonateRest',XFloat);
      AddVal('ClusterLandDamageRadiusCost',XFloat);
      AddVal('ClusterPushCostCost',XFloat);
      AddVal('ClusterWormDamageCost',XFloat);
      AddVal('WindCost',XFloat);
      AddVal('DetonateImpactCost',XFloat);
      AddVal('DetonateUserCost',XFloat);
      AddVal('DetonateAtRestCost',XFloat);
      AddVal('FuseAdjustableCost',XFloat);
      AddVal('PoisonCost',XFloat);
      AddVal('LandDamageRadiusCost',XFloat);
      AddVal('PushCostCost',XFloat);
      AddVal('WormDamageCost',XFloat);
    end;
    WeaponFactoryLanchedCostContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('MaxPowerCost',XFloat);
      AddVal('PowersUpCost',XFloat);
      AddVal('HomingCost',XFloat);
      AddVal('HomingAvoidLandCost',XFloat);
      AddVal('FuseAdjustableCost',XFloat);
      AddVal('ClustersCost',XFloat);
      AddVal('ClusterSpreadCost',XFloat);
      AddVal('ClusterDetonateImpactCost',XFloat);
      AddVal('ClusterDetonateRest',XFloat);
      AddVal('ClusterLandDamageRadiusCost',XFloat);
      AddVal('ClusterPushCostCost',XFloat);
      AddVal('ClusterWormDamageCost',XFloat);
      AddVal('WindCost',XFloat);
      AddVal('PoisonCost',XFloat);
      AddVal('LandDamageRadiusCost',XFloat);
      AddVal('PushCostCost',XFloat);
      AddVal('WormDamageCost',XFloat);
    end;
    WeaponFactoryContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('Name',XString);
      LoadEnum(WeaponFactoryTypeEnum);
      AddVal('Type',XEnum);
      LoadEnum(WeaponFactoryDetonateEnum);
      AddVal('Detonate',XEnum);
      AddVal('Homing',XBool);
      AddVal('HomingAvoidLand',XBool);
      AddVal('EffectedByWind',XBool);
      AddVal('FireOnGround',XBool);
      AddVal('Poison',XBool);
      AddVal('RetreatTime',XInt);
      AddVal('WormDamageRadius',XFloat);
      AddVal('WormDamageMagnitude',XFloat);
      AddVal('LandDamageRadius',XFloat);
      AddVal('ProjectileCollisionRadius',XFloat);
      AddVal('Push',XFloat);
      AddVal('FuseTime',XInt);
      AddSetVal('GraphicalResourceID',XString);
      AddSetVal('GraphicalLocatorID',XString);
      AddVal('LaunchFX',XString);
      AddVal('ArielFX',XString);
      AddVal('DetonationFX',XString);
      LoadEnum(WeaponPayLoadEnum);
      AddVal('PayloadResourceId',XEnum);
      LoadEnum(WeaponFactoryLaunchEnum);
      AddVal('ProjectileLaunchType',XEnum);
      AddVal('ProjectilePowersUp',XBool);
      AddVal('ProjectileNumClusters',XInt);
      AddVal('ProjectileMaxPower',XFloat);
      AddVal('ClusterSpread',XFloat);
      AddVal('ClusterMaxSpeed',XFloat);
    end;
    StoreWeaponFactory:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('StockWeapon',XBool);
      TempNode:=AddIdxNode;//Weapon <XCntr> // WeaponFactoryContainer
      TempNode.Text:=format('%s "%s"',[TempNode.Text,'Weapon']);
      TempNode:=AddIdxNode;//StoreWeaponFactory.Cluster <XCntr> // WeaponFactoryContainer
      TempNode.Text:=format('%s "%s"',[TempNode.Text,'Cluster']);
    end;
    WXFE_PowerColumns:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('PowerNumber',XFloat);
      AddVal('PowerResource',XString);
      AddVal('ScaleY',XFloat);
      AddVal('ScaleX',XFloat);
      LoadEnum(PowerColumnStyleEnum);
      AddVal('Style',XEnum);
      AddSetVal('Messages',XString);
    end;
    WXFE_GapColumns:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('GapWidth',XFloat);
      AddVal('ExpandToFitAvailableSpace',XBool);
      LoadEnum(GapTypeEnum);
      AddVal('GapType',XEnum);
      AddVal('Colour_Normal',XColor);
      AddVal('Colour_Highlight',XColor);
      AddVal('Colour_Disabled',XColor);
    end;
    WXFE_HighlightIconColumns:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('TakeUpSpaceWhenNotHighlight',XBool);
      IconColumns;
    end;
    WXFE_IconColumns:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      IconColumns;
    end;
    WXFE_StringTableColumns:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('CallBack',XBool);
      StringColumns;
    end;
    WXFE_StringColumns:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      StringColumns;
    end;
    WXFE_ListBoxRows:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      LoadEnum(WXFE_BorderTypeEnum);
      AddVal('Border_Normal',XEnum);
      AddVal('Border_Highlight',XEnum);
      AddVal('Border_Disabled',XEnum);
      AddVal('BorderFitContents',XBool);
      LoadEnum(WXFE_ControlAnimsEnum);
      AddVal('Anim_Highlight',XEnum);
      AddVal('Anim_Clicked',XEnum);
      AddSetVal('Messages_Selected',XString);
      AddSetVal('Messages_RightClick',XString);
      AddSetVal('Messages_Highlighted',XString);
      AddSetVal('Messages_Left',XString);
      AddSetVal('Messages_Right',XString);
      AddVal('Orientation',XVector);
      AddVal('RowHeight',XFloat);
      AddVal('BorderHeightAdjust',XFloat);
      AddVal('BorderWidthAdjust',XFloat);
      AddVal('GapBetweenItems',XFloat);
      AddVal('Decorative',XBool);
      AddVal('Sort',XString);
      AddVal('Index',XString);
      AddVal('Enable',XString);
      AddSetNode('Columns'); // WXFE_Columns
    end;
    WXFE_ListBoxContents:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddSetNode('Rows'); // WXFE_ListBoxRows
      AddVal('TotalRows',XInt);  //	2
      AddVal('VirtualOffset',XInt);//	2
      AddVal('VirtualEnabled',XBool);//	2
      AddVal('CallBack',XInt); //	2
    end;
    ListBoxData:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddSetNode('Columns');
      AddSetVal('Messages',XString);
      AddVal('FontResource',XString);
      AddVal('FontSize',XFloat);
    end;
    InputEventMappingContainer:
     begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('Message',XString);
      AddVal('FEResourceID',XString);
      AddSetVal('AllowedDuplacates',XByte);
      AddSetNode('InputMappings');
      AddVal('Group',XByte);
    end;
    InputMappingDetails:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddSetNode('InputEventMappings');
    end;
    InputDetailsContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      LoadEnum(InputMappingTypeEnum);
      AddVal('InputDetailsContainer.Type',XEnum);
      AddVal('InputDetailsContainer.Key',XInt);
      AddVal('InputDetailsContainer.JoystickAxis',XInt);
    end;
    FlagDataContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('TextResource',XString);
      AddVal('TargaName',XString);
    end;
    IntegerArray:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddSetVal('Integers',XInt);
    end;
    WXFE_FlagObjectDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('FlagID',XString);
      AddVal('Lighting',XBool);
      AddVal('FlagScale',XVector);
      AddVal('FlagPosition',XVector);
      AddVal('FlagOrientation',XVector);
      AddSetVal('Messages_Highlighted',XString);
      AddSetVal('Messages_Selected',XString);
      LoadEnum(WXFE_BorderTypeEnum);
      AddVal('Border_Normal',XEnum);
      AddVal('Border_Disabled',XEnum);
      AddVal('Border_Highlight',XEnum);
      WXFE_BaseInputItemDesc;
    end;
    WXFE_MenuButtonDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('ResourceName',XString);
      AddSetVal('Messages_Highlighted',XString);
      AddSetVal('Messages_Selected',XString);
      LoadEnum(WXFE_BorderTypeEnum);
      AddVal('Border_Normal',XEnum);
      AddVal('Border_Disabled',XEnum);
      AddVal('Border_Highlight',XEnum);
      AddVal('SquareButton',XBool);
      AddVal('BorderBehind',XBool);
      AddVal('OnRelease',XBool);
      LoadEnum(WXFE_GradientColours);
      AddVal('ColourFRONT_Normal',XEnum);
      AddVal('ColourFRONT_Highlight',XEnum);
      AddVal('ColourFRONT_Disabled',XEnum);
      LoadEnum(WXFE_BackgroundColours);
      AddVal('ColourBACK_Normal',XEnum);
      AddVal('ColourBACK_Highlight',XEnum);
      AddVal('ColourBACK_Disabled',XEnum);
      WXFE_BaseInputItemDesc;
    end;
    WXFE_TitleControlDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('TextResourceID',XString);
      LoadEnum(WXFE_GradientColours);
      AddVal('FrontColour',XEnum);
      LoadEnum(WXFE_BackgroundColours);
      AddVal('BackColour',XEnum);
      LoadEnum(WXFE_TextAnimationEnum);
      AddVal('TextAnim',XEnum);
      AddVal('TextAnimSeed',XInt);
      WXFE_BaseGfxItemDesc;
    end;
    WXFE_PlayerRepresentationObjectDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('TeamIndex',XInt);
      AddVal('AvatarPosition',XVector);
      AddVal('AvatarScale',XVector);
      WXFE_BaseGfxItemDesc;
    end;
    WXFE_MeshObjectParticleDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddSetVal('EffectNames',XString);
      AddSetVal('LocatorNames',XString);
      AddSetVal('SpawnDelay',XInt);
      AddSetVal('SpawnLoopTime',XInt);
      AddVal('ParticleLayerOffset',XInt);
      MeshObjectDesc;
    end;
    WXFE_MeshObjectDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      MeshObjectDesc;
    end;
    WXFE_ListDetailDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('ListDataId',XString);
      AddSetVal('Messages_Highlighted',XString);
      AddVal('Index',XInt);
      WXFE_BaseInputItemDesc;
    end;
    WXFE_ListControlDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('GameDataId',XString);
      AddSetVal('Messages_Highlighted',XString);
      AddVal('BorderSize',XFloat);
      AddVal('AutoScroll',XBool);
      AddVal('LoopContents',XFloat);
      AddVal('SortContents',XBool);
      LoadEnum(WXFE_BorderTypeEnum);
      AddVal('Border_Normal',XEnum);
      AddVal('Border_Disabled',XEnum);
      AddVal('Border_Highlight',XEnum);
      AddVal('Arrow_ScaleX',XFloat);
      AddVal('Arrow_ScaleY',XFloat);
      AddVal('Arrow_Colour_Normal',XColor);
      AddVal('Arrow_Colour_Highlight',XColor);
      AddVal('Arrow_Colour_ShadowNormal',XColor);
      AddVal('Arrow_Colour_ShadowHighlight',XColor);
      AddVal('IndexID',XString);
      WXFE_BaseInputItemDesc;
    end;
    WXFE_HowToPlayTextBoxDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('FontName',XString);
      AddVal('TextGameDataId',XString);
      LoadEnum(WXFE_BorderTypeEnum);
      AddVal('Border_Normal',XEnum);
      AddVal('Border_Disabled',XEnum);
      AddVal('Border_Highlight',XEnum);
      AddVal('Border_Active',XEnum);
      LoadEnum(EdgeJustificationEnum);
      AddVal('Justification',XEnum);
      AddVal('BorderSize',XFloat);
      LoadEnum(WXFE_GradientColours);
      AddVal('Colour_Front',XEnum);
      LoadEnum(WXFE_BackgroundColours);
      AddVal('Colour_Back',XEnum);
      WXFE_BaseInputItemDesc;
    end;
    WXFE_GetControllerInputDesc,
    WXFE_WeaponFactoryMeshDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      WXFE_BaseGfxItemDesc;
    end;
    WXFE_WormPotControlDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddIdxNode;//('Mesh',XCntr);// WXFE_MeshObjectDesc
      WXFE_BaseInputItemDesc;
    end;
    WXFE_TrophyDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('AwardIndex',XInt);
      WXFE_BaseInputItemDesc;
    end;
    WXFE_TrophyCabinetDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddIdxNode;//('Mesh',XCntr);// WXFE_MeshObjectDesc
      AddSetNode('Trophies');// WXFE_TrophyDesc
      WXFE_BaseInputItemDesc;
      end;
    WXFE_WormDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      WormDesc;
    end;
    WXFE_ShopDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('ShopMeshName',XString);
      AddVal('DissapointingSale',XInt);
      AddVal('ExceptionalSale',XInt);
      AddVal('WormOffset',XVector);  //	2
      WormDesc;
    end;
    WXFE_GalleryThumbDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('GalleryId',XInt);
      AddSetVal('Messages_Highlighted',XString);
      AddSetVal('Messages_Selected',XString);
      AddSetVal('Messages_RightMouse',XString);
      LoadEnum(WXFE_BorderTypeEnum);
      AddVal('Border_Normal',XEnum);
      AddVal('Border_Highlight',XEnum);
      AddVal('Border_Disabled',XEnum);
      WXFE_BaseInputItemDesc;
    end;
    WXFE_GalleryImageDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      LoadEnum(WXFE_BorderTypeEnum);
      AddVal('Border',XEnum);
      AddVal('GalleryId',XInt);
      WXFE_BaseGfxItemDesc;
    end;
    WXFE_ImageViewDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      LoadEnum(WXFE_BorderTypeEnum);
      AddVal('Border',XEnum);
      AddVal('ImageId',XString);
      AddVal('DefaultImageId',XString);
      AddVal('Colour',XColor);
      AddVal('WaitTime',XInt);
      WXFE_BaseGfxItemDesc;
    end;
    WXFE_NewsFeedScrollingTextDesc,
    WXFE_ScrollingTextDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      LoadEnum(WXFE_BorderTypeEnum);
      AddVal('Border',XEnum);
      AddVal('TextResourceID',XString);
      AddVal('Font',XString);
      LoadEnum(WXFE_GradientColours);
      AddVal('Colour_Front',XEnum);
      LoadEnum(WXFE_BackgroundColours);
      AddVal('Colour_Back',XEnum);
      AddVal('Speed',XFloat);
      AddVal('Wrap',XBool);
      AddVal('ScrollForward',XBool);
      AddVal('AlwaysScroll',XBool);
      AddVal('DisplayInvites',XBool);
      AddVal('DisplayFriendRequest',XBool);
      WXFE_BaseGfxItemDesc;
    end;
    WXFE_MenuDescription:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      LoadEnum(WXFE_BorderTypeEnum);
      AddVal('BorderType',XEnum);
      AddVal('BorderAutoSize',XBool);
      AddVal('BorderEdgeSize',XFloat);
      AddSetVal('Messages_BeforeMenuDisplayed',XString);
      AddSetVal('Messages_AfterMenuDisplayed',XString);
      AddSetVal('Messages_MenuGoingAway',XString);
      AddSetVal('Messages_CancelPressed',XString);
      AddSetVal('Messages_AcceptPressed',XString);
      AddVal('DefaultSelectedItem',XString);
      AddVal('FullScreenColour',XColor);
      WXFE_BaseGfxItemDesc;
    end;
    WXFE_SoftwareKeyBoardDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('SoftwareKeyBoardDataID',XString);
      AddSetVal('Messages_FinishedUsing',XString);
      WXFE_BaseInputItemDesc;
    end;
    WXFE_SoftwareKeyBoardData:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('TextGameDataId',XString);
      AddSetVal('Messages_Edited',XString);
      AddSetVal('Messages_NewChar',XString);
      AddVal('MaxTextWidthChars',XInt);
      AddVal('MaxTextWidthPixels',XInt);
      AddVal('InvalidChars',XString);
      AddVal('NumbersOnly',XBool);
      AddVal('SoftwareKeyboardTitleID',XString);
      AddVal('FontSize',XFloat);
      AddVal('AutoClear',XBool);
    end;
    CreditsFMVs:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddSetVal('MovieName',XString);
    end;
    FMVTextLine:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('TextID',XString);
      AddVal('TimeOffset',XInt);
    end;
    FMVSubTiles:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      LoadEnum(FMVSubTiles_FMV);
      AddVal('FMV',XEnum);
      AddSetNode('TextLines');
    end;
    MenuDescription:
    begin
      AddNode('');
      p2 := XCntr.GetPoint;
      if WF then begin
      AddVal('PopUpPosition',XVector);
      AddVal('PopUpScale',XVector);
      end;
      AddVal('ActiveItem',XString);
      AddVal('DefaultCancelItem',XString);
      AddVal('DefaultAcceptItem',XString);
      if WF then
      AddVal('AcceptEnableSwitch',XString);
      AddVal('MenuName',XString);
      XCntr.Name:=vs;
      TreeNode.Text:=GetXName(XCntr);
      AddVal('InitMessages',XString);
      if WF then begin
      AddVal('InitAlwaysMessages',XString);
      AddVal('BackgroundImage',XString);
      AddVal('PreventActiveUpdate',XInt);
      AddVal('BackgroundShade',XByte);
      end;
      if W3D then
      AddVal('PreventActiveUpdate',XByte);
      AddSetNode('MenuItems');
    end;
    WXFE_AttachmentOffsets:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('PositionOffset',XVector);
      AddVal('OrientationOffset',XVector);
      AddVal('ScaleOffset',XVector);
    end;
    WXFE_WormAttachments:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('MeshID',XString);
      AddVal('FrontEndMeshID',XString);
      AddVal('MeshTextNameID',XString);
      AddVal('Glasses',XBool);
      AddVal('Tash',XBool);
      LoadEnum(AttachmentTypeEnum);
      AddVal('Type',XEnum);
      AddSetNode('Offsets');
      AddIdxNode; // FrontEndOffsets
      AddVal('Lock',XString);
      AddVal('Eyebrow',XBool);
    end;
    ShotStatsCollective:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddSetNode('Shots');
    end;
    ChatMessagesContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      if WUM then begin
      AddSetVal('Sender',XString);
      AddSetVal('Content',XString);
      AddSetVal('Colour',XInt);
      AddSetVal('Scope',XInt);
      end else begin
      AddSetVal('Sender',XUint);
      AddSetVal('Content',XUint);
      AddSetVal('SenderColour',XUint);
      AddSetVal('ContentColour',XUint);
      AddSetVal('Scope',XUint);
      end;
    end;
    ChatMessagesWindowDetails:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('NameWidthPercent',XFloat);
      AddVal('DefaultPos',XVector);
      AddVal('MainChatWindowSize',XVector);
      AddVal('PlayersWindowSize',XVector);
      AddVal('InputMsgWindowSize',XVector);
      AddVal('PlayersFontSize',XFloat);
      AddVal('InputMsgFontSize',XFloat);
      AddVal('MessageFontSize',XFloat);
      AddVal('MainChatWindowBorderSize',XFloat);
      AddVal('PlayersWindowBorderSize',XFloat);
      AddVal('InputMsgWindowBorderSize',XFloat);
      AddVal('SlideInOutSpeed',XFloat);
    end;
    CrateDataContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('Type',XString);
      AddVal('Contents',XString);
      AddVal('NumContents',XInt);
      AddVal('Index',XInt);
      AddVal('LifetimeSec',XFloat);
      AddVal('GroundSnap',XInt);
      AddVal('Parachute',XInt);
      AddVal('Spawn',XString);
      AddVal('FallSpeed',XInt);
      AddVal('Gravity',XInt);
      AddVal('TeamDestructible',XInt);
      AddVal('TeamCollectable',XInt);
      AddVal('UXB',XInt);
      AddVal('Hitpoints',XInt);
      AddVal('Pushable',XInt);
      AddVal('RandomSpawnPos',XInt);
      AddVal('CanDropFromChute',XInt);
      AddVal('WaitTillLanded',XInt);
      AddVal('TrackCam',XInt);
      AddVal('Scale',XFFloat);
      AddVal('Showered',XInt);
      AddVal('DelayMillisec',XInt);
      AddVal('LifetimeTurns',XInt);
      AddVal('AddToWormInventory',XInt);
      AddVal('CustomGraphic',XString);
    end;
    TriggerDataContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('Spawn',XString);
      AddVal('Radius',XFloat);
      AddVal('Index',XInt);
      AddVal('TeamCollect',XInt);
      AddVal('TeamDestroy',XInt);
      AddVal('HitPoints',XInt);
      AddVal('SheepCollect',XInt);
      AddVal('PayloadCollect',XInt);
      AddVal('GirderCollect',XInt);
      AddVal('WormCollect',XInt);
      AddVal('AffectsAI',XInt);
    end;
    StringQueue:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('Size',XInt);
      AddSetVal('Queue',XString);
      AddVal('Front',XInt);
      AddVal('Back',XInt);
      AddVal('Count',XInt);
    end;
    PlayerList:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddSetVal('Players',XString);
    end;
    TeamPersistDataContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('RoundsWon',XInt);
    end;
// Scheme part
    CampaignData:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      LoadEnum(MedalsEnum);
      AddVal('Medal',XEnum);
      AddVal('Retries',XInt);
    end;
    StoredTeamData:
    begin
      AddNode('');
      p2 := XCntr.GetPoint;
      AddVal('TeamName',XString);
      XCntr.Name:=vs;
      TreeNode.Text:=GetXName(XCntr);
      AddSetVal('Worm',XString);
      if WUM then begin

      //AddVal('TutorialsDone',XInt);//	 Obsolete4
      AddVal('NewTeam',XInt);
      AddVal('Skill',XInt);
      AddVal('Grave',XInt);
      AddVal('SWeapon',XInt);
      AddVal('Flag',XString);
      AddVal('Speech',XString);
      AddVal('InGame',XBool);
     // AddVal('AllTutorialsDone',XBool);//	Obsolete4
     // AddVal('AllMissionsDone',XBool);//	Obsolete4
      AddVal('Player',XString);
      AddIdxNode;//AddVal('SecretWeapon',XCntr);// WeaponFactoryContainer
      AddIdxNode;//AddVal('SecretWeaponCluster',XCntr);// WeaponFactoryContainer
      AddVal('CustomWeapon',XString);
      AddVal('Hat',XString);
      AddVal('Gloves',XString);
      AddVal('Glasses',XString);
      AddVal('Tash',XString);
      AddSetVal('ClothingChanged',XInt);//	Schema2
     // AddVal('StoryMissionsCompleted',XInt);//	Obsolete4
     // AddVal('StoryChapter',XInt);//	Obsolete4
     // AddVal('w3dMissionsComplete',XInt);//	Scheme3
    //  AddVal('w3dMissionsCompleteExtra',XInt);//	Scheme3

      end else begin

      if not WF then begin
      AddSetNode('Campaign');
      end;
      AddVal('TutorialsDone',XInt);
      AddVal('NewTeam',XInt);
      AddVal('Skill',XInt);
      AddVal('Grave',XInt);

      AddVal('SpecialWeapon',XInt);

      if WF then
      AddVal('Flag',XInt)
      else
      AddVal('Flag',XString);
      if WF then begin
      AddVal('Fanfare',XString);
      AddVal('Hat',XInt);
      AddVal('Speech',XString);
      end
      else
      AddVal('Speech',XString);
      if WF then begin
      AddVal('SpeechSet',XString);
      AddVal('Allegiance',XUInt);
      end;
      AddVal('InGame',XBool);
      if WF then begin
      AddVal('IsLocal',XBool);
      AddVal('WormsInGame',XBool);
      end;
      AddVal('Player',XString);
      if WF then begin
      AddSetNode('TeamCareer');
      AddSetNode('WormCareer');
      end;

      end;
    end;
    XImage:
    begin
      p2 := XCntr.GetPoint;
      XCntr.Name := GetStr128(p2,XCntr);  //Name
      AddNode(GetXName(XCntr),3);
      w := Word(p2^);           //Width
      Inc(Longword(p2), 2);
      h := Word(p2^);
      Inc(Longword(p2), 2);    //Height

      Imap := Byte(p2^);      //MipLevels
      Inc(Longword(p2), 2);
      Inc(Longword(p2), 2);   //Flags
      Bsize := Byte(p2^);     //Strides
      Inc(Longword(p2), 4 * Bsize + 1);
      Bsize := Byte(p2^);
      Inc(Longword(p2), 4 * Bsize + 1);
      IFormat:= Integer(p2^);

      if (IFormat>8)and(not W3D) then
      Inc(Longword(p2), 5);

      Inc(Longword(p2), 4);
      ISize := TestByte128(p2); //Offsets     //Format //Compression //Modifiable
      Inc(Longword(p2), ISize);   // Data
      k3 := GetIdx128(p2,XCntr); 
      s := Format(' [%dx%d maps:%d size:%d]', [w, h, Imap, ISize]);
      TreeNode.Text := TreeNode.Text + s;
      if k3 > 0 then
        AddClassTree(XCntr.AddChild(k3), TreeView, TreeNode); //Palette
    end;
    XAnimClipLibrary:
    begin
      if TreeNode <> nil then
      begin
        TreeNode.ImageIndex := 6;
        TreeNode.SelectedIndex := 6;
      end;
      AddNode(GetXName(XCntr));
      ////////////
      StrList := TStringList.Create;
      p2 := XCntr.point;
      XCntr.Name := GetStr128(p2,XCntr);   // Name
      inx1 := Integer(p2^);    
      Inc(Longword(p2), 4); // NumKeys
      s := Format('"%s" KeyTypes[%d]', [XCntr.Name, inx1]);
      TempNode := TreeView.Items.AddChild(TreeNode, s);
      StrList.Clear;
      //   SetLength(StrList,inx);
      for x := 0 to inx1 - 1 do 
      begin     // Keys
        AnimType := Cardinal(p2^);   
        Inc(Longword(p2), 4);   //AnimType
        s := GetStr128(p2,XCntr);   //Object
        s1 := AnimClips.GetNameAnimType(AnimType);
        s := Format('%s.%s', [s, s1]);
        StrList.Add(s);
        s1 := Format('#%d = %s', [x, s]);
        TempNode2 := TreeView.Items.AddChild(TempNode, s1);
          TempNode2.ImageIndex := 8;
          TempNode2.SelectedIndex := 8;
      end;
      inx2 := Integer(p2^);
      Inc(Longword(p2), 4);  // NumClips
      s1 := Format('Clips[%d]', [inx2]);
      TempNode := TreeView.Items.AddChild(TreeNode, s1);
      for j := 1 to inx2 do
      begin
        ftime := Single(p2^);
        Inc(Longword(p2), 4);  // time
        s1 := Format('"%s" (%.2fs)', [GetStr128(p2,XCntr), ftime]);
        // name
        TempNode0 := TreeView.Items.AddChild(TempNode, s1);
          TempNode0.ImageIndex := 9;
          TempNode0.SelectedIndex := 9;
        inx := Word(p2^); // NumAnimKeys
        ExpAnim := not WR and ( (inx = 256) or (inx=257));
        if ExpAnim then 
          inx := inx1 
        else
          Inc(Longword(p2), 4);

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

          k3 := Longword(p2^);
          Inc(Longword(p2), 4);
          k4 := Longword(p2^);
          Inc(Longword(p2), 4);
          k := Integer(p2^); 
          Inc(Longword(p2), 4);
       {   s1 := Format('%s.keys[%d] (%d;%d)', [StrList.Strings[k2], k, k3,k4]);
          TempNode2 := TreeView.Items.AddChild(TempNode0, s1);
         // TempNode2.Data:=XAnimKey;
          TempNode2.ImageIndex := 7;
          TempNode2.SelectedIndex := 7; }
          for i := 1 to k do
          begin
              {  Move(p2^, KeyFrame[0], 6*4);
                s:=format('%d. [%.2f; %.2f; %.2f; %.2f; %.2f; %.2f]',[i-1,KeyFrame[0],KeyFrame[1],
                KeyFrame[2],KeyFrame[3],KeyFrame[4],KeyFrame[5]]);
                TreeView.Items.AddChild(TempNode2,s);//  }
            Inc(Longword(p2), 6 * 4);
          end;
        end;
      end;
      StrList.Free;
      //////////
    end;
    XBone:
    begin
      AddNode('',10);
      p2 := XCntr.GetPoint;
      AddVal('PoseMatrix',XMatrix4);
      AddVal('Transform',XMatrix4);
      AddVal('Affine',XString);
      AddSetNode('BoneChilds',10);
      AddDataName;
    end;
    XMatrix:
    begin
      AddNode(GetXName(XCntr),17);
      p2 := XCntr.GetPoint;
      AddVal('Matrix',XMatrix3);
    end;
    XTextureStage:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      //ApiHandle',XInt);
      //MaxAnisotropy',XFloat);
      //FourCC',XInt);
      //Enable',XBool);
      //TexCoordIndex',XUint8);
      //MaxMipMapLevel',XUint8);
      //AddressMode
      //AddressModeS',XEnum);
      //AddressModeT',XEnum);
      //FilterMode
      //MagFilter',XEnum);
      //MinFilter',XEnum);
      //MipFilter',XEnum);
      //Matrix',XMatrix);
      //TextureGen',XCntr);
    end;
    XTexturePlacement2D:
    begin
      AddNode('XTextureGen::XTextureMatrix::'+GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('Matrix',XMatrix4);
    end;
    XJointTransform:
    begin
      AddNode('XMatrix::'+GetXName(XCntr),17);
      p2 := XCntr.GetPoint;
      //RotateAxis
      AddVal('RotOrient',XVectorR);
      //JointOrientation
      AddVal('Rot',XVectorR);
      AddVal('Pos',XVector);
      AddVal('Joint Orient',XVectorR);
      AddVal('Size',XVector);
      Inc(Longword(p2), 4);
      AddVal('Matrix',XMatrix3)
    end;

    XTransform:
    begin
      AddNode('XMatrix::'+GetXName(XCntr),17);

      p2 := XCntr.GetPoint;
      AddVal('Translate',XVector);
      AddVal('Rotate',XVectorR);
      AddVal('Scale',XVector);
      //RotateOrder
      LoadEnum(RotateOrder);
      AddVal('RotateOrder',XEnum);
      AddVal('Matrix',XMatrix3);
    end;
    XOglTextureStage:
    begin
      AddNode('XTextureStage::'+GetXName(XCntr),16);
      p2 := XCntr.GetPoint;
       //Blend XEnum //OglBlend
       //BlendColor XVector4
    end;
    XSlTextureMap:
    begin
      AddNode(GetXName(XCntr),16);
      p2 := XCntr.GetPoint;
      XCntr.Name :=GetStr128(p2,XCntr);
      TreeNode.Text := GetXName(XCntr);
      Inc(Longword(p2));
      //Blend
      //BlendColor
      Inc(Longword(p2), 4);
      Inc(Longword(p2), 4 * 4);
      AddIdxNode;
      Inc(Longword(p2), 4);
      Inc(Longword(p2), 2);
      Inc(Longword(p2), 4 * 5);
    end;
    XOglShadowSpotLight:
    begin
      AddNode(GetXName(XCntr),16);
      p2 := XCntr.GetPoint;
      AddIdxNode;
    end;
    XOglTextureMap:
    begin
      AddNode('XTextureMap::'+GetXName(XCntr),16);
      p2 := XCntr.GetPoint;
      LoadEnum(OglBlend);
      AddVal('Blend',XEnum); //OglBlend
      AddVal('BlendColor', XVector4);
      AddIdxNode;
      AddVal('MaxAnisotropy',XFloat);
      AddVal('Enable',XBool);
      if not WR then AddVal('TexCoordIndex',XByte);
     // AddVal('MaxMipMapLevel',XByte);
      LoadEnum(AddressMode);
      AddVal('AddressModeS',XEnum);
      AddVal('AddressModeT',XEnum);
      LoadEnum(FilterMode);
      AddVal('MagFilter',XEnum);
      AddVal('MinFilter',XEnum);
      AddVal('MipFilter',XEnum);
      if not WR then
      AddIdxNode;      //TextureGen',XCntr);
    end;
    XBlendModeGL:
    begin
      AddNode(GetXName(XCntr),18);
      p2 := XCntr.GetPoint;
      LoadEnum(BlendFactor);
      AddVal('SourceFactor',XEnum);
      AddVal('DestFactor',XEnum);
    end;
    XAlphaTest:
    begin
      AddNode(GetXName(XCntr),18);
      p2 := XCntr.GetPoint;
      AddVal('Enable',XBool);
      LoadEnum(CompareFunction);
      AddVal('CompareFunction',XEnum);
      AddVal('RefValue',XFloat);
    end;
    XDepthTest:
    begin
      AddNode(GetXName(XCntr),18);
      p2 := XCntr.GetPoint;
      LoadEnum(CompareFunction);
      AddVal('CompareFunction',XEnum);
      AddVal('Enable',XBool);
      AddVal('NearZ',XFloat);
      AddVal('FarZ',XFloat);
    end;
    XCullFace:
    begin
      AddNode(GetXName(XCntr),18);
      p2 := XCntr.GetPoint;
      LoadEnum(CullMode);
      AddVal('CullMode',XEnum);
    end;
    XLightingEnable:
    begin
      AddNode(GetXName(XCntr),18);
      p2 := XCntr.GetPoint;
      AddVal('Enable',XBool);
      AddVal('TwoSided',XBool);
      AddVal('LocalViewer',XBool);
      LoadEnum(NormalizeMode);
      AddVal('Normalize',XEnum);
      AddVal('AmbientColor',XVector4);
    end;
    XZBufferWriteEnable:
    begin
      AddNode(GetXName(XCntr),18);
      p2 := XCntr.GetPoint;
      AddVal('Enable',XBool);
    end;
    XPointLight:
    begin
      AddNode('XLight::');
      p2 := XCntr.GetPoint;
      AddVal('Pos',XVector);
      AddVal('Range',XFloat);

      AddVal('ConstantAttenuation',XFloat);
      AddVal('LinearAttenuation',XPoint);

      Inc(Longword(p2),2); //?
     //  QuadraticAttenuation
      AddVal('QuadraticAttenuation',XVector);
      AddVal('QuadraticAttenuation',XVector);
      AddVal('QuadraticAttenuation',XVector);

      AddDataName;
    end;
    XMaterial:
    begin
      AddNode(GetXName(XCntr),18);
      p2 := XCntr.GetPoint;
      AddVal('Diffuse',XVector4);
      AddVal('Ambient',XVector4);
      AddVal('Specular',XVector4);
      AddVal('Emissive',XVector4);
      if WUM then
      AddVal('Fresnel',XVector4);//	2
      LoadEnum(MaterialColorSource);
      AddVal('DiffuseSource',XEnum);
      AddVal('AmbientSource',XEnum);
      AddVal('SpecularSource',XEnum);
      AddVal('EmissiveSource',XEnum);
      AddVal('Power',XFloat);
      if WUM then
      AddVal('FresnelPower',XFloat); //	2
    end;
    XDataStreamDeclarator:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('FourCC',X4Char);//   c_Uint32Type
      AddVal('FVF',XInt);//     c_Uint32Type
      AddVal('Type',XInt);//    c_Uint32Type
      AddVal('Stride',XUInt);//  c_Uint16Type
      AddVal('ComponentRotationMask',XInt);//   c_Uint32Type
      AddVal('ComponentTranslationMask',XInt);//    c_Uint32Type
      AddVal('BoundsComponentOffset',XInt);//   c_Uint32Type
      AddVal('PureVirtual',XBool);//   c_BoolType
      AddSetVal('Method',XString);//      c_StringType
      AddSetVal('Source',XString);//      c_StringType
      AddSetVal('Format',XFloat);//     c_Uint32Type
      AddSetVal('ComponentFourCC',X4Char);// c_Uint32Type
      AddSetVal('ComponentOffset',XByte);//  c_Uint8Type
    end;
    XInteriorNode:
    begin
      if WB then
      if (TreeNode <> nil) and (TreeNode.Parent <> nil) and  (TreeNode.Parent.Parent <> nil) then
      begin
        TreeNode.Parent.Parent.ImageIndex := 2;
        TreeNode.Parent.Parent.SelectedIndex := 2;
      end;
      if TreeNode <> nil then
      begin
        TreeNode.ImageIndex := 2;
        TreeNode.SelectedIndex := 2;
      end;
      AddNode('XNode::',19);
      p2 := XCntr.GetPoint;
      AddSetNode('Children');
      AddDataName;
    end;
    XSlShaderInstance:
    begin
      AddNode(GetXName(XCntr),11);
      p2 := XCntr.GetPoint;
      AddSetNode('ShaderAttributes',18);
      AddIdxNode;// SlShader
      AddSetNode('Textures',16);
      AddSetNode('Attributes');
      AddIdxNode;//ShadowPassShader
      AddIdxNode; //FallbackShader
      AddVal('LibraryName',XString); // LibraryName str
      Inc(Longword(p2), 4);
      XCntr.Name:=GetStr128(p2,XCntr);
      TreeNode.Text := GetXName(XCntr);
    end;
    XPsShaderInstance:
    begin
      AddNode(GetXName(XCntr),11);
      p2 := XCntr.GetPoint;
      AddSetNode('ShaderAttributes',18);
      AddIdxNode;// Prototype
      AddSetNode('Textures',16);
      AddSetNode('Uniforms',17);
      AddVal('LibraryName',XString); // LibraryName str
      AddVal('Version',XFloat);// Version
      Inc(Longword(p2), 4);
      XCntr.Name:=GetStr128(p2,XCntr);
      TreeNode.Text := GetXName(XCntr);
    end;
    XPsProgReference:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('Name',XString);
      XCntr.Name:=vs;
      TreeNode.Text:=GetXName(XCntr);
      //Prog
     // AddVal('Type',XInt);
    end;
    XPsShaderPrototype:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddSetNode('Programs');
    end;
    XPsTextureReference:
    begin
      AddNode(GetXName(XCntr),16);
      p2 := XCntr.GetPoint;
      XCntr.Name :=GetStr128(p2,XCntr);
      TreeNode.Text:=GetXName(XCntr);
      AddIdxNode; //TextureMap
      //DataModified
     // AddVal('Name',XString);
    end;
    XUniformInstance:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddIdxNode;
    end;
    XUniformMatrixArray:
    begin
      AddNode(GetXName(XCntr),17);
      p2 := XCntr.GetPoint;
      Inc(Longword(p2));
      XCntr.Name:=GetStr128(p2,XCntr);
      TreeNode.Text:=GetXName(XCntr);
    end;
    XUniformShadowMatrix:
    begin
      AddNode(GetXName(XCntr),17);
      p2 := XCntr.GetPoint;
      AddVal(s,XMatrix4,true);
      XCntr.Name:=vs0;
      TreeNode.Text:=GetXName(XCntr);
    end;
    XSlShadowMap:
    begin
      AddNode(GetXName(XCntr),16);
      p2 := XCntr.GetPoint;
      AddIdxNode;
      XCntr.Name :=GetStr128(p2,XCntr);
      TreeNode.Text:=GetXName(XCntr);
    end;
    XSlProxyTexture:
    begin
      AddNode(GetXName(XCntr),16);
      p2 := XCntr.GetPoint;
      AddVal(s,XString,true);
      XCntr.Name:=vs0;
      TreeNode.Text:=GetXName(XCntr);
    end;
    XPsProxyTexture:
    begin
      AddNode(GetXName(XCntr),16);
      p2 := XCntr.GetPoint;
      AddVal(s,XString,true);
      XCntr.Name:=vs0;
      TreeNode.Text:=GetXName(XCntr);
      AddIdxNode;
      if WC then AddIdxNode;
    end;
    XUniformProxy:
    begin
      AddNode(GetXName(XCntr),17);
      p2 := XCntr.GetPoint;
      XCntr.Name:=GetStr128(p2,XCntr);
      TreeNode.Text:=GetXName(XCntr);
      AddIdxNode;
    end;
    XUniformTextureSize,
    XUniformTime,
    XUniformViewMatrix,
    XUniformViewMatrixInverse,
    XUniformWorldViewProjectionMatrix,
    XUniformWorldViewMatrix:
    begin
      AddNode(GetXName(XCntr),17);
      p2 := XCntr.GetPoint;
      XCntr.Name:=GetStr128(p2,XCntr);
      TreeNode.Text:=GetXName(XCntr);
    end;
    XUniformFloat:
    begin
      AddNode(GetXName(XCntr),17);
      p2 := XCntr.GetPoint;
      AddVal(s,XFloat,true);
      XCntr.Name:=vs0;
      TreeNode.Text:=GetXName(XCntr);
    end;
    XUniformVector4f:
    begin
      AddNode(GetXName(XCntr),17);
      p2 := XCntr.GetPoint;
      AddVal(s,XVector4,true);
      XCntr.Name:=vs0;
      TreeNode.Text:=GetXName(XCntr);
    end;
    XNamedAttribute:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      XCntr.Name:=GetStr128(p2,XCntr);
      TreeNode.Text:=GetXName(XCntr);
      AddIdxNode;
    end;
    XPsVertexDataSet:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      XCntr.Name:=GetStr128(p2,XCntr);
      TreeNode.Text:=GetXName(XCntr);
    //  AddVal('PsParameterName',XString);
      // Data  XInt
      // Format XByte
      // Dimensions  XByte
      // ElementCount XByte
      // VbHandle XByte
      // LittleEndian XBool
      // UsageType XEnumByte
      // Dynamic XBool
    end;
    XPsTexFont:
    begin
      AddNode('');
      p2 := XCntr.GetPoint;
      AddSetVal('CharCoords',XPoint);
      AddSetVal('CharSizes',XPoint);
      AddSetNode('Attributes',18);
      AddIdxNode;
      AddSetNode('TextureStage',16);
      Inc(Longword(p2), 6);
      Inc(Longword(p2), 4);
      XCntr.Name:=GetStr128(p2,XCntr);
      TreeNode.Text := GetXName(XCntr);
    end;
    XTexFont:
    begin
      if WB then
      if (TreeNode <> nil) and (TreeNode.Parent <> nil)then
      begin
        TreeNode.Parent.ImageIndex := 3;
        TreeNode.Parent.SelectedIndex := 3;
      end;
      AddNode('XShader::');
      p2 := XCntr.GetPoint;
     // XTexFont
      AddSetVal('CharCoords',XPoint);
      AddSetVal('CharSizes',XPoint);
      AddSetNode('TextureStage',16);
      AddSetNode('Attributes',18);
      Inc(Longword(p2), 4);
      XCntr.Name:=GetStr128(p2,XCntr);
      TreeNode.Text := TreeNode.Text + GetXName(XCntr);
    end;
    XEnvironmentMapShader:
    begin
      AddNode('XShader::');
      p2 := XCntr.GetPoint;
        AddIdxNode;
        AddIdxNode;
              Inc(Longword(p2), 1);
        AddIdxNode;
       s := Format('Unknown = [%d]',[Integer(p2^)]);
      TreeView.Items.AddChild(TreeNode, s);
              Inc(Longword(p2), 8);
      XCntr.Name:=GetStr128(p2,XCntr);
       TreeNode.Text := TreeNode.Text + GetXName(XCntr);
            end;
    XMultiTexFont:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddSetNode('Attributes',18); // XAttribute
      AddSetNode('FontPages');   // XMultiTexFontPage

      AddSetVal('AsciiMap',XUint);
      AddSetVal('CharacterMap',XUint);
      if WUM then begin
      AddVal('DesignScale',XPoint);    //	2
      AddVal('Ascent',XFloat);  //	2
      AddVal('Descent',XFloat); //	2
      AddSetVal('Kerning',XUint);  //	2
      end;
    end;
    XMultiTexFontPage:
    begin
     AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddIdxNode;           //Texture     // XTextureStage
      AddSetVal('CharacterMap',XUint);

      if WUM then begin
      AddSetVal('GlyphCoords',XPoint); //	2
      AddSetVal('GlyphSizes',XPoint);  //	2
      AddSetVal('Bearings',XPoint);   //	2
      AddSetVal('Advances',XFloat);  //	2
      end else
      begin
      AddSetVal('CharCoords',XPoint); //	2
      AddSetVal('CharSizes',XPoint); //	2
      AddSetVal('CharKernLeft',XByte); //	2
      AddSetVal('CharKernRight',XByte);//	2
      end;
    end;
    XMultiTexShader:
    begin
      AddNode('XShader::');
      p2 := XCntr.GetPoint;
      AddSetNode('Attributes',18);
      AddIdxNode;
      AddIdxNode;
      Inc(Longword(p2), 4);
      XCntr.Name:=GetStr128(p2,XCntr);
      TreeNode.Text := TreeNode.Text + GetXName(XCntr);
    end;
    XAttrPass:
    begin
      AddNode(GetXName(XCntr),11);
      p2 := XCntr.GetPoint;
      AddSetNode('TextureStages',16);  //c_CtrType
      AddSetNode('Attributes',18);   //c_CtrType
      AddVal('VertexShaderFourCC',X4Char); //c_Uint32Type
      AddVal('FourCC',X4Char); //c_Uint32Type
      AddSetVal('SetParameterFourCCs',X4Char); //c_Uint32Type
      AddSetVal('SetParameterValues',X4Char); //c_Uint32Type
    end;
    XCustomShader:
    begin
      AddNode('XShader::',11);
      p2 := XCntr.GetPoint;
      AddSetNode('Techniques');     //XTechnique //c_CtrType
      AddVal('ActiveTechnique',XInt);             //c_Uint32Type
      AddVal('LODSwitchFourCC',X4Char);             //c_Uint32Type
      AddSetNode('VertexShaders');  //c_CtrType
      AddSetNode('TextureStages',16);  //c_CtrType
      AddSetNode('Attributes',18);   //c_CtrType
      AddSetNode('DataStreamDecl');  //c_CtrType
      AddSetVal('ParameterNames',X4Char); //c_Uint32Type
      AddSetVal('ParameterValues',XInt); //c_Uint32Type
      Inc(Longword(p2), 4);
      XCntr.Name :=GetStr128(p2,XCntr);
      TreeNode.Text := TreeNode.Text +GetXName(XCntr);
    end;
    XSimpleShader:
    begin
      AddNode('XShader::',11);
      p2 := XCntr.GetPoint;
    //  if XCntr.Xtype=XCustomShader then  Inc(Longword(p2), 10);
      AddSetNode('TextureStages',16);
      AddSetNode('Attributes',18);
      Inc(Longword(p2), 4);
      XCntr.Name :=GetStr128(p2,XCntr);
      TreeNode.Text := TreeNode.Text +GetXName(XCntr);
    end;
    XPsSkinShape:
    begin
      AddNode('',13);
      p2 := XCntr.GetPoint;
      AddSetNode('Bones',10);
      Inc(Longword(p2), 4);
      Inc(Longword(p2), 5);
      AddIdxNode;
      AddIdxNode;
      Inc(Longword(p2), 5);
      AddDataName;
    end;
    XSkinShape:
    begin
      AddNode('',13);
      p2 := XCntr.GetPoint;
      AddSetNode('Bones',10);
      AddVal('Flags',XInt);
      AddIdxNode; // XShader
      AddIdxNode; // XGeometry
      AddVal('SortKey',XInt); //	2
      if not W3DGC then AddIdxNode; // AddVal('Parameters',XCntr); // XParameterChunk //	3
      if WUM then begin
           AddIdxNode; // AddVal('PreRenderFunc',XCntr);// XSceneFunc  //	4
           AddIdxNode; // AddVal('PostRenderFunc',XCntr);// XSceneFunc //	4
      end;
      AddDataName;
    end;
    XPsShape:
    begin
      AddNode(GetXName(XCntr),15);
      p2 := XCntr.GetPoint;
      Inc(Longword(p2), 8+1);
      AddIdxNode;
      AddIdxNode;
      Inc(Longword(p2), 5);
      AddDataName;
    end;
    XShape:
    begin
      AddNode('XCore::',15);
      p2 := XCntr.GetPoint;
      x := Byte(p2^);
      Inc(Longword(p2), 4);
      AddIdxNode;
      AddIdxNode;
      if not WB then
      Inc(Longword(p2), 5);
      if W3DGC then  dec(Longword(p2), 1);
      if WUM then Inc(Longword(p2), 2);
      AddDataName;
    end;
    XBuildingShape:
    begin
      AddNode('XCore::',15);
      p2 := XCntr.GetPoint;
      AddIdxNode;  //BuildingDetails
      AddIdxNode;  //BrickGeometry
      Inc(Longword(p2), 9);  //ShaderType  ?
      AddIdxNode;
      Inc(Longword(p2), 6);     //bShapeChanged  ?
      AddDataName;
    end;
    XSkin:
    begin
      AddNode('',14);
      p2 := XCntr.GetPoint;
      AddIdxNode;
      if WR then  Inc(Longword(p2));
      AddSetNode('shape');
      AddDataName;
    end;
    XChildSelector:
    begin
      AddNode(GetXName(XCntr));
    end;
    XBinModifier:
    begin
      AddNode('');
      p2 := XCntr.GetPoint;
      AddVal('OpaqueModifier',XByte);
      AddVal('TransparentModifier',XByte);
      AddIdxNode; // Matrix
      AddSetNode('childs');
      AddDataName;
    end;
    XDetailSwitch:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      Inc(Longword(p2), 4*3);  //Center
      k := TestByte128(p2);
      Inc(Longword(p2), k*4); //Range
      Inc(Longword(p2), 4*2);
    end;
    XBinSelector:
    begin
      if WB then
      if (TreeNode <> nil) then
      begin
        TreeNode.ImageIndex := 2;
        TreeNode.SelectedIndex := 2;
      end;
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('OpaqueBin',XByte);   //c_Uint8Type
      AddVal('TransparentBin',XByte);   //c_Uint8Type
      AddIdxNode; //Chain //c_CtrType
    end;
    XGroup,XSkeletonRoot:
    begin
      AddNode('',5);
      p2 := XCntr.GetPoint;
      AddIdxNode; // Matrix
      if WR then Inc(Longword(p2));
      AddSetNode('childs');
      AddDataName;
    end;
    XPalette:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      //ApiHandle XInt
      //IndexSize XUint8
      // Flags XUint8 /
      // LoadEnum(PaletteFormat);
      // Format  XEnum
      // Data
    end;
    XMultiIndexSet:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddIdxNode;
      AddIdxNode;
      AddIdxNode;
      AddIdxNode; 
    end;
    XIndexSet:
      AddNode('XIndexArray::'+GetXName(XCntr));
    XIndexSet8:
      AddNode('XIndexArray::'+GetXName(XCntr));
    XCoord3fSet:
      AddNode('XVertexDataSet::XCoordSet::'+GetXName(XCntr));
    XNormal3fSet:
      AddNode('XVertexDataSet::XNormalSet::'+GetXName(XCntr));
    XCoord3sSet_1uScale:
      AddNode('XVertexDataSet::XCoordSet::'+GetXName(XCntr));
    XNormal3sSet_1uScale:
      AddNode('XVertexDataSet::XNormalSet::'+GetXName(XCntr));
    XColor4ubSet:
      AddNode('XVertexDataSet::XColorSet::'+GetXName(XCntr));
    XConstColorSet:
      AddNode('XVertexDataSet::XColorSet::'+GetXName(XCntr));
    XTexCoord2fSet:
      AddNode('XVertexDataSet::XTexCoordSet::'+GetXName(XCntr));
    XBinormal3fSet:
      AddNode('XVertexDataSet::XBinormalSet::'+GetXName(XCntr));
    XTangent3fSet:
      AddNode('XVertexDataSet::XTangentSet::'+GetXName(XCntr));
    XMultiTexCoordSet:
    begin
    AddNode('XVertexDataSet::XTexCoordSet::'+GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddSetNode('TexCoordSets');
    end;
    XTechnique:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('FourCC',X4Char);//   c_Uint32Type
      AddVal('LODValid',XInt);//  c_Uint16Type
      AddSetNode('Passes');//     c_Uint32Type
      AddSetVal('RequiredStreamFourCCs',X4Char);//     c_Uint32Type
      AddSetVal('InvalidateOther',XInt);//     c_Uint32Type
    end;
    XSystemStream:
    begin
       AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('FourCC',X4Char);//   c_Uint32Type
      AddVal('Stride',XUInt);//  c_Uint16Type
      AddVal('FVF',XInt);//     c_Uint32Type
      AddVal('VertexCount',XInt);//     c_Uint32Type
      AddSetVal('ComponentFourCC',X4Char);//     c_Uint32Type
      AddSetVal('ComponentOffset',XByte);//     c_Uint8Type
      AddVal('BoundsComponentOffset',XInt);//     c_Uint32Type
    //  AddSetVal('ComponentProc',XInt);//     c_InterfaceType
    //  AddSetVal('ComponentProcOffset',XByte);//     c_Uint8Type
      AddVal('ComponentRotationMask',XInt);//     c_Uint32Type
      AddVal('ComponentTranslationMask',XInt);//     c_Uint32Type
      AddVal('Data',XIndex);//     c_Uint8Type
   //   AddVal('ResolvedDeclarator',XInt);//     c_CtrType
    end;
    XSlShader:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddSetNode('SlPrograms');
    end;
    XSlVertProg:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('ShaderProg',XText);//
    end;
    XSlFragProg:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('ShaderProg',XText);//
    end;
    XVertexShader:
    begin
       AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('FourCC',X4Char);//   c_Uint32Type
      AddVal('Flags',XInt);//  c_Uint32Type
      AddSetVal('APIHandle',X4Char);//  c_Uint32Type
      AddSetVal('StreamFourCCs',X4Char);//  c_Uint32Type
      AddSetVal('StreamCompFourCCs',XInt);//  c_Uint32Type
      AddSetVal('StreamTargets',XInt);//  c_Uint32Type
     // AddVal('Declaration',XInt);//  c_Uint32Type
     // AddVal('Function',XInt);//  c_Uint32Type
    end;
    XVertexStream:
    begin
       AddNode(GetXName(XCntr));
    end;
    XWeightSet:
      AddNode('XVertexDataSet::'+GetXName(XCntr));
    XPaletteWeightSet:
      AddNode('XVertexDataSet::XWeightSet::'+GetXName(XCntr));
    XCollisionData:
    begin
      if TreeNode <> nil then
      begin
        TreeNode.ImageIndex := 5;
        TreeNode.SelectedIndex := 5;
      end;
      AddNode(GetXName(XCntr));
      p2:=XCntr.GetPoint;
      AddIdxNode;      // SphereCentres ?
      AddIdxNode;  // SphereRadii  ?
      AddSetNode('Geom');    // Geom  XCollisionGeometry
    end;
    XPfxEmissionEmitterGeom:
    begin
      AddNode(GetXName(XCntr));
      p2:=XCntr.GetPoint;
      AddIdxNode;// EmittedEmissionType
      AddIdxNode;// EmittedEmissionShader
      AddVal('MaxNumEmitters',XInt);
      AddVal('EmittedEmissionPassTag',X4Char);
      XPfxEmitterGeomRead;
    end;
    XPfxEmitterGeom:
    begin
      AddNode(GetXName(XCntr),12);
      p2:=XCntr.GetPoint;
      XPfxEmitterGeomRead;
    end;
    XPfxBasicEmission:
    begin
      AddNode(GetXName(XCntr));
      p2:=XCntr.GetPoint;
	AddVal('MinScaleVelocity',XVector);
	AddVal('MaxScaleVelocity',XVector);
	AddVal('MinRotVelocity',XVector);
	AddVal('MaxRotVelocity',XVector);
	AddVal('MinLifeSpan',XFloat);
	AddVal('MaxLifeSpan',XFloat);
	AddVal('MinInitialPosition',Xvector);
	AddVal('MaxInitialPosition',Xvector);
	AddVal('MinInitialRotation',Xvector);
	AddVal('MaxInitialRotation',Xvector);
	AddVal('MinInitialScale',Xvector);
	AddVal('MaxInitialScale',Xvector);
	AddVal('ScaleProportionally',XBool);
	AddVal('MinSpread',XFloat);
	AddVal('MaxSpread',XFloat);
	AddVal('SpreadAdjust',Xvector);
	AddVal('EmissionRateMult',XFloat);
	AddVal('ParentAgeSizeMult',XFloat);
	AddVal('ParentAgeVelocityMult',XFloat);
	AddVal('ParentVelocitySizeMult',XFloat);
	AddVal('ParentVelocityRateMult',XFloat);
	AddVal('MinRand1',XFloat);
	AddVal('MaxRand1',XFloat);

      AddIdxNode;  //EmissionRateCurve
      AddIdxNode;  //MinVelocityCurve
      AddIdxNode;  //MaxVelocityCurve
    end;

    XPfxSizeLifeModule:
    begin
      AddNode(GetXName(XCntr));
      p2:=XCntr.GetPoint;
      AddVal('Effect',XVector);
      AddVal('bUseCache',XBool);
      AddVal('bCacheValid',XBool);
      AddIdxNode;  //SizeLifeCurve
    end;
    XAnimChannel:
    begin
      AddNode(GetXName(XCntr));
      p2:=XCntr.GetPoint;
      AddVal('MustContribute',XBool);
      AddVal('IsWeighted',XBool);
      AddVal('IsStatic',XBool);
      AddVal('IsLinear',XBool);
      LoadEnum(InfinityType);
      AddVal('PreInfinity',XEnum);
      AddVal('PostInfinity',XEnum);
    end;
    XPfxCubeEmission,
    XPfxDragModule,
    XPfxFollowEmitterModule,
    XPfxGravityModule,
    XPfxRingEmission,
    XPfxSphereEmission,
    XPfxVelocityAlignModule,
    XPfxWindModule:
    begin
      AddNode(GetXName(XCntr));
    end;
    XPfxParticleEffect:
    begin
      AddNode(GetXName(XCntr));
      p2:=XCntr.GetPoint;
     // AddVal('BoundBox'
     //AddVal('BoundMode'
      Inc(Longword(p2), 4*6+4);
      AddSetNode('Emitters');
      AddVal('CastShadows',XBool);
      AddVal('StartTime',XFloat);
      AddVal('MaxDuration',XFloat);
      AddVal('LayerNames',XString);
      AddVal('Initialized',XBool);
      AddVal('IsPaused',XBool);
      AddVal('StartNow',XBool);
      AddVal('CurrentEffectTime',XFloat);
      AddVal('TotalPausedTime',XFloat);
      AddVal('TimePaused',XFloat);
      AddVal('PauseCount',XUint);
      AddVal('Active',XBool);
      AddVal('AutoDisable',XBool);
      Inc(Longword(p2), 5); //??
      AddSetNode('shapes');
    end;
    XPathFinderData:
      AddNode(GetXName(XCntr));
    XPositionData:
      AddNode(GetXName(XCntr));
    XAnimInfo:
      AddNode(GetXName(XCntr));
    XExpandedAnimInfo:
      AddNode(GetXName(XCntr));
    XDetailObjectsData:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;

      k := TestByte128(p2);
      SetLength(ArrTree,k);
      for x := 1 to k do
        ArrTree[x-1]:=AddVal('DetailObjectFilePath',XString);

      k := TestByte128(p2);
      for x := 1 to k do
        AddChildF(ArrTree[x-1],'DetailObjectScriptName',XString);

      k:=TestByte128(p2);
     for x:=1 to k do
        AddChildF(ArrTree[x-1],'DetailObjectPosition',XVector);
     k:=TestByte128(p2);
     for x:=1 to k do
        AddChildF(ArrTree[x-1],'DetailObjectOrientation',XVectorR);
     k:=TestByte128(p2);
     for x:=1 to k do
        AddChildF(ArrTree[x-1],'DetailObjectScale',XVector);
    end;
    XSceneryEffectData:
    begin
      AddNode(GetXName(XCntr));
      p2:=XCntr.GetPoint;
      AddVal('ScriptName',XString);
      XCntr.Name := vs;
      AddSetVal('EmitterNames',XString);
      AddSetVal('EmitterRotation',XVector);
      AddVal('Position',XVector);
    //  AddVal('Orientation',XVector);
      AddVal('RotationSpeed',XVector);
      AddVal('MinActiveTime',XFloat);
      AddVal('MaxActiveTime',XFloat);
      AddVal('MinInactiveTime',XFloat);
      AddVal('MaxInactiveTime',XFloat);
      AddVal('TimerActivated',XBool);
      AddVal('SoundEffectName',XString);
      AddVal('WindFactor',XFloat);
    end;
    XSceneCamera:
    begin
    AddNode('');
      p2:=XCntr.GetPoint;
      AddVal('FocalLength',XFloat);
      AddVal('NearClip',XFloat);
      AddVal('FarClip',XFloat);
      AddVal('Aperture',XPoint);
      AddDataName;
    end;
    BuildingGlobalContainer:
    begin
     AddNode(GetXName(XCntr));
      p2:=XCntr.GetPoint;
      AddVal('LinkHeightDifference',XFloat);
      AddVal('DistanceFromBuildingToDropCrates',XFloat);
      AddVal('AdditionalStrongholdHealthPerVictoryPoint',XUint);
      AddVal('BuildDistance',XByte);
      AddVal('NumTurnsEarthRemainsScortched',XByte);
      AddVal('NumTurnsToHoldWonder',XByte);
      AddVal('MaxCratesToHoldAtRefinery',XByte);
      AddVal('NumCratesToSpawnAtRefineryPerTurn',XByte);
      AddVal('NumTurnsSuperScorchedMode',XByte);
    end;
    BuildingSpecificContainer:
    begin
     AddNode(GetXName(XCntr));
      p2:=XCntr.GetPoint;
      AddVal('ProjectileSizeScale',XFloat);
      AddVal('DamageIncrease',XFloat);
      AddVal('DamageRadiusIncrease',XFloat);
      AddVal('DeathExplosionDamage',XFloat);
      AddVal('DeathExplosionRadius',XFloat);
      AddVal('BuildingNum',XByte);
      AddVal('FiringPlatformSize',XByte);
      AddVal('ResourceCost',XByte);
      AddVal('AttachedToBuilding',XByte);
      AddVal('BuildingRequired',XByte);
      AddVal('MinPercentageBlocksRemainingBeforeDeath',XByte);
      AddVal('BuildingHealth',XUint);
      AddVal('Indestructible',XBool);
      AddVal('fBlockHealthVariance',XFloat);
      AddVal('ResourceName',XString);
      AddVal('BrickifiedFileName',XString);
    end;
    BrickLinkage:
    begin
     AddNode(GetXName(XCntr));
      p2:=XCntr.GetPoint;
      AddVal('AttachedType',XByte);
      AddVal('BrickNum',XByte);
      AddVal('LinkName',XString);
      AddVal('pos',XVector);
      XCntr.Name := vs;
      TreeNode.Text:=GetXName(XCntr);
      //AttachedType
      // BrickNum
      // LinkName
    end;
    BrickBuildingCtr:
    begin
     AddNode(GetXName(XCntr));
      p2:=XCntr.GetPoint;

      AddSetNode('BrickLinkage');   //  BrickLinkage
     AddVal('BoundingSphere',XVector4);
     AddSetNode('CollisionGeometry');  //  XCollisionGeometry
     AddSetNode('BrickShapes');   // XBuildingShape
      AddVal('BBMin',XPoint);
      AddVal('BBMax',XPoint);
      AddVal('Height',XFloat);

      LoadEnum(ListWFBuild);
      AddVal('BuildingType',XEnumByte);
      AddVal('NumFiringPlatformBricks',XByte);
    end;
    XFortsExportedData:
    begin
      AddNode(GetXName(XCntr));
        p2:=XCntr.GetPoint;
        if WF then begin
        LoadEnum(ListEpochs);
        AddVal('Epoch',XEnumByte); //1
        AddVal('FogNear',XFloat);
        AddVal('FogFar',XFloat);
        AddVal('FogType',XByte);

        LoadEnum(ListWFSky);
        AddVal('SkyBoxType',XEnumByte); // 1
        AddVal('SkyBoxPosition',XVector);
        LoadEnum(ListWFWater);
        AddVal('WaterType',XEnumByte);
        AddVal('WaterHeight',XFloat);
        LoadEnum(ListWFBuild);
                TempNode:=TreeView.Items.AddChild(TreeNode, 'wfRef');

                k:=TestByte128(p2);
                SetLength(ArrTree,k);
                 for x:=1 to k do
                    ArrTree[x-1]:=AddChildF(TempNode,format('RefPointName [%d]',[x]),XString);
                k:=TestByte128(p2);
                for x:=1 to k do
                    AddChildF(ArrTree[x-1],'RefPointPosition',XVector);
                k:=TestByte128(p2);
                 for x:=1 to k do
                    AddChildF(ArrTree[x-1],'RefPointOrientation',XVector);

                Pt:=p2;
                 k:=TestByte128(p2);
                SetLength(ArrTree,k);
                if k>0 then begin
                        WFBuilds.Cntr:=XCntr;
                        WFBuilds.Node:=TreeNode;
                        WFBuilds.Count:=k;
                        WFBuilds.Pnt1:=Pt;
                        SetLength(WFBuilds.Items,k);
                end;
                TempNode:=TreeView.Items.AddChild(TreeNode, 'buildHere');
                 for x:=1 to k do
                 begin
                    ArrTree[x-1]:=AddChildF(TempNode,format('BPName [%d]',[x]),XString);
                    ArrTree[x-1].ImageIndex:=21;
                    ArrTree[x-1].SelectedIndex:=21;
                    WFBuilds.Items[x-1].Name:=vs;
                    Delete(vs, 1, 9);
                    WFBuilds.Items[x-1].StrIndex:=vs;
                 end;
                k:=TestByte128(p2);
                 for x:=1 to k do begin
                    AddChildF(ArrTree[x-1],'BPPosition',XVector);
                    WFBuilds.Items[x-1].Pos.X:=Single(Pointer(vc)^);
                    WFBuilds.Items[x-1].Pos.Y:=Single(Pointer(vc + 4)^);
                    WFBuilds.Items[x-1].Pos.Z:=Single(Pointer(vc + 8)^);
                    end;
                k:=TestByte128(p2);
                for x:=1 to k do
                    begin
                    TempNode:=AddChildF(ArrTree[x-1],'BPVictoryLocation',XBool);
                    if vb then begin
                    ArrTree[x-1].ImageIndex:=22;
                    ArrTree[x-1].SelectedIndex:=22;
                    end;
                    WFBuilds.Items[x-1].Star:=vb;
                    end;
                k:=TestByte128(p2);
                for x:=1 to k do begin
                    AddChildF(ArrTree[x-1],'BPBuildingType',XEnumByte);
                    if vby=14 then begin
                    ArrTree[x-1].ImageIndex:=24;
                    ArrTree[x-1].SelectedIndex:=24;
                    end;
                    if vby=15 then begin
                    ArrTree[x-1].ImageIndex:=23;
                    ArrTree[x-1].SelectedIndex:=23;
                    end;
                    WFBuilds.Items[x-1].BuildType:=vby;
                    end;
                k:=TestByte128(p2);
                for x:=1 to k do begin
                    AddChildF(ArrTree[x-1],'BPBonusType',XByte);
                    WFBuilds.Items[x-1].BonusType:=vby;
                    end;
                k:=TestByte128(p2);
                 for x:=1 to k do begin
                    AddChildF(ArrTree[x-1],'BPBuildingName',XString);
                    WFBuilds.Items[x-1].BuildingName:=vs;
                    end;
                k:=TestByte128(p2);
                 for x:=1 to k do begin
                    AddChildF(ArrTree[x-1],'BPBuildingPlayerId',XInt);
                    WFBuilds.Items[x-1].PlayerId:=vi;
                    end;
                k:=TestByte128(p2);
                 for x:=1 to k do begin
                    AddChildF(ArrTree[x-1],'BPBuildingOrientation',XFloat);
                    WFBuilds.Items[x-1].Orientation:=vf;
                    end;
                k:=TestByte128(p2);
                 for x:=1 to k do begin
                    AddChildF(ArrTree[x-1],'BPBuildingConnections',XByte);
                    WFBuilds.Items[x-1].Connections:=vby;
                    end;
                if WFBuilds.Count>0 then WFBuilds.Pnt2:=p2;

                k:=TestByte128(p2);
                SetLength(ArrTree,k);
                TempNode:=TreeView.Items.AddChild(TreeNode, 'pSphere');
                 for x:=1 to k do
                    ArrTree[x-1]:=AddChildF(TempNode,format('PhantomSphereName [%d]',[x]),XString);

                k:=TestByte128(p2);
                SetLength(ArrTree2,k);
                TempNode:=TreeView.Items.AddChild(TreeNode, 'pCube');
                 for x:=1 to k do
                    ArrTree2[x-1]:=AddChildF(TempNode,format('PhantomBoxName [%d]',[x]),XString);
                k:=TestByte128(p2);
                for x:=1 to k do
                    AddChildF(ArrTree[x-1],'PhantomSpherePosition',XVector);
                k:=TestByte128(p2);
                 for x:=1 to k do
                    AddChildF(ArrTree2[x-1],'PhantomBoxPosition',XVector);
                k:=TestByte128(p2);
                 for x:=1 to k do
                    AddChildF(ArrTree[x-1],'PhantomSphereRadius',XFloat);
                k:=TestByte128(p2);
                for x:=1 to k do
                    AddChildF(ArrTree2[x-1],'PhantomBoxExtents',XVector);
                k:=GetSize128(p2,XCntr);
                TempNode:=TreeView.Items.AddChild(TreeNode, 'SceneryEffects');
                 for x:=1 to k do
                    AddClassTree(XCntr.AddChild(GetIdx128(p2,XCntr)), TreeView, TempNode);
        end;
      end;
    XBrickIndexSet:
    begin
      AddNode(GetXName(XCntr));
      p2:=XCntr.GetPoint;
      k:=TestByte128(p2);
      TreeView.Items.AddChild(TreeNode, Format('BrickIndex = %d', [k]));
    end;
    XBrickGeometry:
    begin
     AddNode(GetXName(XCntr));
       p2:=XCntr.GetPoint;
       AddIdxNode;  //Geometry
       AddIdxNode;  //BrickIndexSet
       AddSizeBox;
    end;
    XBrickDetails:
    begin
     AddNode(GetXName(XCntr));
       p2:=XCntr.GetPoint;
       AddVal('TeamColour',XInt);
      k := TestByte128(p2);
      SetLength(ArrTree,k);
      TempNode:= TreeView.Items.AddChild(TreeNode, format('Details[%d]',[k]));
  {    for x := 1 to k do  begin
        ArrTree[x-1]:= TreeView.Items.AddChild(TempNode, format('Detail[%d]',[x-1]));
        AddChildF(ArrTree[x-1],p2,'Translation',XVector);
      end;  }
      Inc(Longword(p2), 4*3*k);
      k := TestByte128(p2);
    {  for x := 1 to k do
        AddChildF(ArrTree[x-1],p2,'Health',XFloat); }
      Inc(Longword(p2), 4*k);
      k := TestByte128(p2);
 {     for x := 1 to k do
        AddChildF(ArrTree[x-1],p2,'DrawBrick',XBool);    }
      Inc(Longword(p2), 1*k);
     AddVal('bHasChanged',XBool);
    end;
    XCollisionGeometry:
    begin
      AddNode('');
      p2 :=XCntr.GetPoint;
      AddVal('Restitution',XFloat);
      AddVal('Friction',XFloat);
      AddVal('Mass',XFloat);
      // Indices
      k:=TestByte128(p2);
      s := Format('Indices = %d', [k]);
      TreeView.Items.AddChild(TreeNode, s);
      Inc(Longword(p2), 2*k);
      // Vertices
      k:=TestByte128(p2);
      s := Format('Vertices = %d', [k]);
      TreeView.Items.AddChild(TreeNode, s);
      Inc(Longword(p2), 4*k);
      AddDataName;
    end;
    XIndexedCustomTriangleSet:
    begin
      AddNode('XGeometry::'+GetXName(XCntr),12);
      p2 := XCntr.GetPoint;
      AddIdxNode; // IndexSet
      AddVal('PrimitiveCount',XInt);
      AddIdxNode; // StreamSet
      AddSizeBox;
    end;
    XIndexedCustomTriangleStripSet:
    begin
      AddNode('XGeometry::'+GetXName(XCntr),12);
      p2 := XCntr.GetPoint;
      AddSetVal('StripLength',XUInt);
      AddIdxNode;  // IndexSet
      AddVal('PrimitiveCount',XInt);
      AddIdxNode; // StreamSet
      AddSizeBox;
    end;
    XPsGeoSet:
    begin
      AddNode(GetXName(XCntr),12);
      p2 := XCntr.GetPoint;
      AddVal('PrimitiveCount',XInt);
      AddSetNode('VertexData');
      AddIdxNode;// IndexSet XCntr
      AddVal('Type',XInt);  // Type Enum
      AddSizeBox;// sizebox
    end;
    XSlGeoSet:
    begin
      AddNode(GetXName(XCntr),12);
      p2 := XCntr.GetPoint;//Flags
      AddVal('Flags',XInt);
      AddVal('PrimitiveCount',XInt);
      AddSetNode('VertexData');
      AddIdxNode;  // IndexSet
      AddSetNode('Attributes');
      AddSetVal('StripLength',XUint);
      AddVal('Type',XInt);
      AddSizeBox;
    end;
    XIndexedTriangleSet:
    begin
      AddNode('XGeometry::'+GetXName(XCntr),12);
      p2 := XCntr.GetPoint;
      // get Faces
      AddIdxNode;    //IndexSet
      AddVal('Flags',XInt);
      AddVal('PrimitiveCount',XInt);
      AddIdxNode; // CoordSet
      AddIdxNode; // NormalSet
      AddIdxNode; // ColorSet
      AddIdxNode; // TexCoordSet
      AddIdxNode; // WeightSet
      AddSizeBox;
    end;
    XIndexedTriangleStripSet:
    begin
      AddNode('XGeometry::'+GetXName(XCntr),12);
      p2 := XCntr.GetPoint;
      AddSetVal('StripLength',XUint);
      AddIdxNode;  //IndexSet
      AddVal('Flags',XInt);
      AddVal('PrimitiveCount',XInt);
      AddIdxNode;  // CoordSet
      AddIdxNode;  // NormalSet
      AddIdxNode;  // ColorSet
      AddIdxNode;  // TexCoordSet
      AddIdxNode;  // WeightSet
      AddSizeBox;
    end;
    else
      if XCntr.Index <> 0 then
        AddNode(Format('XNone [%d]', [XCntr.Index]));
  end;
  Except
      on E : Exception do
      ShowMessage(Format('Error "%s" in AddClassTree() on %s ', [E.ClassName,GetXName(XCntr)]));
  end;
end;
  if ReBuild and (XCntr<>nil) then XCntr.ReBuild:=true;
  Result := TreeNode;
end;


destructor TXom.Destroy;
begin
  Mesh3D.Free;
  SetLength(TreeArray,0);
  CntrArr.Free;
  SetLength(XomHandle.TypesInfo,0);
  XomHandle.StringTable.Free;
  LastUV.Free;
  inherited Destroy;
end;

procedure TXom.ReSizeTypes;
var
i,size:integer;
XType:XTypes;
begin
// очищаем котейнеры
 CntrArr.FreeDel;
 ClearSizeType;
 XType:=CntrArr[1].Xtype;
 Size:=0;
 for i:=1 to CntrArr.Count-1 do begin
        if (CntrArr[i].Xtype=XType) then inc(Size);
        if (CntrArr[i].Xtype<>XType) or (i=CntrArr.Count-1) then
                begin
                SetSizeType(XType,Size);
                if XType<> CntrArr[i].Xtype then begin
                        XType:=CntrArr[i].Xtype;
                        size:=1;
                        SetSizeType(XType,Size);
                end;
                end;
 end;
 XomHandle.NumTypes:=Length(XomHandle.TypesInfo);
end;

procedure TXom.ClearSizeType;
var i:integer;
begin
for i:=0 to Length(XomHandle.TypesInfo)-1 do
   XomHandle.TypesInfo[i].Size:=0;
end;

procedure TXom.FortsBuildUpdate;
var
OldPnt,Pnt,NewPnt:Pointer;
VirtualBufer: TMemoryStream;
_Size,offset:Integer;
k,i:Integer;
begin

 VirtualBufer := TMemoryStream.Create;
 // точка на значение
 WFBuilds.Cntr.CopyBufTo(VirtualBufer,WFBuilds.Pnt1);
 // тут пишем данные
// SetLength(WFBuilds.Items,33);
 WFBuilds.Count:=Length(WFBuilds.Items);
 k:=WFBuilds.Count;
 WriteXByte(VirtualBufer,k);
   for i:=0 to k-1 do
        with WFBuilds.Items[i] do
                WriteXName(VirtualBufer, Name);
 WriteXByte(VirtualBufer,k);
   for i:=0 to k-1 do
        with WFBuilds.Items[i] do begin
                VirtualBufer.Write(Pos.X,4);
                VirtualBufer.Write(Pos.Y,4);
                VirtualBufer.Write(Pos.Z,4);
        end;
 WriteXByte(VirtualBufer,k);
   for i:=0 to k-1 do
        with WFBuilds.Items[i] do
                VirtualBufer.Write(Star,1);
 WriteXByte(VirtualBufer,k);
   for i:=0 to k-1 do
        with WFBuilds.Items[i] do
                VirtualBufer.Write(BuildType,1);
 WriteXByte(VirtualBufer,k);
   for i:=0 to k-1 do
        with WFBuilds.Items[i] do
                VirtualBufer.Write(BonusType,1);
 WriteXByte(VirtualBufer,k);
   for i:=0 to k-1 do
        with WFBuilds.Items[i] do
                WriteXName(VirtualBufer, BuildingName);
 WriteXByte(VirtualBufer,k);
   for i:=0 to k-1 do
        with WFBuilds.Items[i] do
                VirtualBufer.Write(PlayerID,4);
 WriteXByte(VirtualBufer,k);
   for i:=0 to k-1 do
        with WFBuilds.Items[i] do
                VirtualBufer.Write(Orientation,4);
 WriteXByte(VirtualBufer,k);
   for i:=0 to k-1 do
        with WFBuilds.Items[i] do
                VirtualBufer.Write(Connections,1);
 //  ---
  WFBuilds.Cntr.CopyBufFrom(VirtualBufer,WFBuilds.Pnt2);

  WFBuilds.Cntr.WriteBuf(VirtualBufer);
  VirtualBufer.Free;
end;

function TXom.MakeBuildCopy(Index: integer): Integer;
var
i,j:integer;
NewName:string;
NameExist:boolean;
begin
// делаем копию объекта с созданием свободного индекса
with WFBuilds do begin// генерируем новое имя

for j:=1 to 200 do begin
        NewName:=format('buildHere00%d',[j]);
        NameExist:=false;

 for i:=0 to Count-1 do
        if CompareStr(Items[i].Name,NewName)=0 then
        begin
        NameExist:=true;
        break;
        end;

 if not NameExist then break;
end;

SetLength(Items,Count+1);
Items[Count]:= Items[Index];
Items[Count].Name:=NewName;
Delete(NewName, 1, 9);
Items[Count].StrIndex:=NewName;
Count:=Length(Items);
NewString:=true;
Result:=Count-1;
end;
end;

procedure TXom.BuildTestGrid(var pos: TXYZ);
begin
Pos.x := round(Pos.x / 600) * 600;
Pos.z := round(Pos.z / 600) * 600;
end;

procedure TXom.DrawBuild(Build: TBuildData;select:boolean=false);
begin
With Build do begin
 if select then glDisable(GL_LIGHTING) else
 begin

        glPushAttrib(GL_COLOR_MATERIAL);
        case PlayerID of
                4:
                glColor3f(0.48627451062,0.54509806633,0.54117649794);//glColor4_256($8A8B7C);
                0:
                glColor3f(0.73333334923,0.72941178083,0.16078431904);//glColor4_256($29BABB);
                1:
                glColor3f(0.18039216101,0.65098041296,0.18431372941);//glColor4_256($2FA62E);
                2:
                glColor3f(0.70980393887,0.14509804547,0.14509804547);//glColor4_256($2525B5);
                3:
                glColor3f(0.14509804547,0.40000000596,0.70980393887);//glColor4_256($B56625);
        end;
       // if not select then glColor3f(1,1,1);
 end;

  if Build.BuildType=14 then begin
        // draw pyramid
        oglPyramid(100,GL_QUADS);
  end
  else if Build.BuildType=15 then begin
        // draw light
        oglLumpLight;
        if not select then glColor3f(1,1,1);
        oglLumpCyl;
  end
  else begin
        // draw build
        oglBox(100,GL_QUADS);
  end;

  if Star then begin
        // draw star
        if not select then glColor3f(1,1,0);
        oglStar();
  end;

  if not select then begin
  glPopAttrib;
  glPushAttrib(GL_ENABLE_BIT);
  glDisable(GL_LIGHTING);
  glDisable(GL_DEPTH_TEST);
  glBegin(GL_LINES);
  if (Build.Connections and (1 shl 0))>0 then begin glVertex3f(0, 0, 300);  glVertex3f(0, 0, 0); end;
  if (Build.Connections and (1 shl 1))>0 then begin glVertex3f(-300, 0, 0);  glVertex3f(0, 0, 0); end;
  if (Build.Connections and (1 shl 2))>0 then begin glVertex3f(0, 0, -300);  glVertex3f(0, 0, 0); end;
  if (Build.Connections and (1 shl 3))>0 then begin glVertex3f(300, 0, 0);  glVertex3f(0, 0, 0); end;
  if (Build.Connections and (1 shl 4))>0 then begin glVertex3f(-300, 0, 300);  glVertex3f(0, 0, 0); end;
  if (Build.Connections and (1 shl 5))>0 then begin glVertex3f(300, 0, 300);  glVertex3f(0, 0, 0); end;
  if (Build.Connections and (1 shl 6))>0 then begin glVertex3f(-300, 0, -300);  glVertex3f(0, 0, 0); end;
  if (Build.Connections and (1 shl 7))>0 then begin glVertex3f(300, 0, -300);  glVertex3f(0, 0, 0); end;
  glEnd;
  glxDrawText(But.Canvas, 0, 0, 0, StrIndex);
  glPopAttrib;
  end;
end;
end;

function TXom.IsCntrSet(Data: Pointer): TCntrSet;
begin
Result:=nil;
if (Integer(Data)>10000) and (TObject(Data) is TCntrSet) then
        Result:=TCntrSet(Data);
end;

procedure TXom.SetType(Index: Integer; NewGUID: TGUID; XType: XTypes);
var s:string;
begin
  with XomHandle.TypesInfo[Index]do begin
        GUID:=NewGUID;
        FillChar(Name[0], SizeOf(Name),#0);
        StrLCopy(@Name[0],PCharXTypes[XType],31);
  end;
end;

function TXom.GetXType(XName: PChar; var XType: XTypes): Boolean;
var
Xi:XTypes;
begin
Result:=false;
      for Xi:=Low(XTypes) to High(XTypes) do
         if StrLComp(XName,PCharXTypes[Xi],31)=0 then
                begin XType:=Xi; Result:=true; break; end;
end;

function StringListFromStrings(const Strings: array of string;Size:integer): TStringList;
var
  i: Integer;
begin
  Result := TStringList.Create;
  for i := 0 to Size do
    Result.Add(Strings[i]);
end;

procedure TXom.AddToXDataBank(XCntr:TContainer;ResIndex:Integer;Name:String);
var
CurType:XTypes;
i,j,indx,size,NewIndex,offset,InsIndx,Num:integer;
p2,oldP,Pnt:Pointer;
VirtualBufer: TMemoryStream;
AddNew:boolean;
NewCntr:TContainer;
CurNode: TTreeNode;
begin
// add new XStringResource container to XDataBank
// 1. Т.к. мы ничего не удаляем переиндексовывать не нужно
// 2. Мы добавляем только новый тип 
CurType:=XResourceXTypes[ResIndex];
AddNew:=true;
if SearchType(CurType,i) then
begin
  if XomHandle.TypesInfo[i].Size = 0 then
  begin
   TestClearType(CurType);
   XomHandle.NumTypes:=Length(XomHandle.TypesInfo);
  end
  else begin
     // если же он присутствует и имеет размер
     //тут проблема, т.к. нужен пересчет и вставка
     AddNew:=false;
  end;
end;
if AddNew then  begin
      i:=XomHandle.NumTypes;

      Inc(XomHandle.NumTypes);
      SetLength(XomHandle.TypesInfo,XomHandle.NumTypes);
      SetType(i,XResourceGUID[ResIndex],CurType);
      StrLCopy(@XomHandle.TypesInfo[i].aType[0],PChar('TYPE'),4);
end;
      Inc(XomHandle.TypesInfo[i].Size);
      Num:=XomHandle.TypesInfo[i].Size;
//  и новый конейнер
NewCntr:=CreateNewCntr(CurType,Name);
if AddNew then
CntrArr.Add(NewCntr)
else
begin
InsIndx:=CntrArr.FoundXType(CurType);
if InsIndx=CntrArr.Count-1 then Inc(InsIndx);
CntrArr.Insert(InsIndx,NewCntr);
end;

 NewIndex:=NewCntr.Index;
 XomHandle.MaxCount:=CntrArr.Count-1;
// 3. в XDataBank мы добавляем новый Set
// Для этого нужно найти в XCntr.XType=XDataBank место под новый тип и вставить
// 1,index
      p2 := XCntr.GetPoint;
      TestByte128(p2); // номер версии
      for i:=0 to 7 do begin
        if ResIndex=i then break;
        size := TestByte128(p2);
        for indx:=1 to size do
           TestByte128(p2);
      end;
 Pnt:=p2;   // точка на значение
 VirtualBufer := TMemoryStream.Create;
 offset:=XCntr.CopyBufTo(VirtualBufer,Pnt);

 WriteXByte(VirtualBufer,Num);
 size := TestByte128(Pnt);
 for indx:=1 to size do
           begin
           WriteXByte(VirtualBufer,TestByte128(Pnt));
           end;
 WriteXByte(VirtualBufer,NewIndex);

 XCntr.CopyBufFrom(VirtualBufer,Pnt);
 XCntr.WriteBuf(VirtualBufer);
 VirtualBufer.Free;

 if not AddNew then
 begin
  ReBuild:=true;
  // пересчет конейтейнеров;
  ReCalcCntr;
  OldStringTable:=TStringList.Create;
  OldStringTable.CaseSensitive:=true;
  OldStringTable.Assign(XomHandle.StringTable);
  CurNode:=AddClassTree(BaseCntr, But.ClassTree, nil); // заменить ReplaceIndex!!!
  CurNode.Delete;
  OldStringTable.Clear;
  BaseNode.Data:=BaseCntr;
  CntrArr.OffReBuild;
  ReBuild:=false;
 end;

 LastCounter:=NewCntr.Index;


end;

procedure TXom.FixXDataBank(XCntr:TContainer);
var
CurType:XTypes;
i,j,indx,size,NewIndex,offset,InsIndx,Num,ColorIndex,StringIndex:integer;
p2,OldPnt,Pnt,NewPnt:Pointer;
VirtualBufer: TMemoryStream;
AddNew:boolean;
NewCntr:TContainer;
CurNode: TTreeNode;
begin
      ColorIndex:=7;
      p2 := XCntr.GetPoint;
      TestByte128(p2); // номер версии
      for i:=0 to 7 do begin
        if ColorIndex=i then break;
        size := TestByte128(p2);
        for indx:=1 to size do
           TestByte128(p2);
      end;
 OldPnt:=p2;   // точка на значение  XColor
       StringIndex:=2;
      p2 := XCntr.GetPoint;
      TestByte128(p2); // номер версии
      for i:=0 to 7 do begin
        if StringIndex=i then break;
        size := TestByte128(p2);
        for indx:=1 to size do
           TestByte128(p2);
      end;
 Pnt:=p2;   // точка на значение  XString

 VirtualBufer := TMemoryStream.Create;
 offset:=XCntr.CopyBufTo(VirtualBufer,Pnt);
  size := TestByte128(OldPnt);
 WriteXByte(VirtualBufer,size);
 for indx:=1 to size do
           begin
           WriteXByte(VirtualBufer,TestByte128(OldPnt));
           end;
 TestByte128(Pnt);
 for i:=StringIndex+1 to ColorIndex-1 do begin
 size := TestByte128(Pnt);
 WriteXByte(VirtualBufer,size);
 for indx:=1 to size do
           begin
           WriteXByte(VirtualBufer,TestByte128(Pnt));
           end;
 end;
 WriteXByte(VirtualBufer,0);
 XCntr.WriteBuf(VirtualBufer);
 VirtualBufer.Free;

end;

procedure TXom.InsertXom(NewXom: TXom; XCntr:TContainer; InsertMode: Boolean; CntrSet:TCntrSet);
var
CurNode: TTreeNode;
begin
if InsertMode then begin
//  NewXom.BaseCntr.BaseIndex:=XCntr.Index;  // вставляемое место
  BaseNew:=NewXom.XomHandle.RootCount;
  InsertIndex:=XCntr.Index;
// нужно сместить все индексы после этого места...
// заранее увеличив размер массива родителя!!!
end else
begin
// удаляем контейнеры выделеной ветви, помня о возможных клонах
  NewXom.BaseCntr.BaseIndex:=XCntr.DelNoClone(BaseCntr);
// меняем индексы ?
end;
// сверяем текущий Xom с новым, по типам контейнеров
// добавляем недостающие контейнеры в старый xom
  ReBuildXomHandle(NewXom,NewXom.CntrArr);
  // строки не освобождаем, т.к. они могут использоваться в других местах
  // копируем строки с добавлением новых
  OldStringTable:=TStringList.Create;
  OldStringTable.CaseSensitive:=true;
  OldStringTable.Assign(XomHandle.StringTable);
  NewStringTable:=NewXom.XomHandle.StringTable;
// добавляем недостающие строки
// переиндексовываем индексы и новые строки.
  ReBuild:=true;
  // нужно организовать поиск новых контейнеров
if InsertMode then begin
  //1 увеличить размер массива в контейнере
  CntrSet.IncSize;
  //2 вставить новый в то место где был старый, и добавить старый после него
end else begin
  LastCounter:=CntrArr.FindNewIndex(NewXom.BaseCntr.BaseIndex,false);
end;

  CurNode:=AddClassTree(BaseCntr, But.ClassTree, nil); // заменить ReplaceIndex!!!
  CurNode.Delete;
  BaseNode.Data:=BaseCntr;
  OldStringTable.Clear;
  // вырубить ребуилд для всех контейнеров!!!
  CntrArr.OffReBuild;
  ReBuild:=false;
end;

procedure TXom.InsertXGraphSetXom(NewXom: TXom; XCntr:TContainer; InsertMode: Boolean; CntrSet:TCntrSet);
var
CurNode: TTreeNode;
i,NameID:integer;
GUID:TGUID;
begin
  BaseNew:=NewXom.XomHandle.RootCount;
 // XCntr.Index:=666;
  //XCntr.Index;

// сверяем текущий Xom с новым, по типам контейнеров
// добавляем недостающие контейнеры в старый xom
  ReBuildXomHandle(NewXom,NewXom.CntrArr);
  // строки не освобождаем, т.к. они могут использоваться в других местах
  // копируем строки с добавлением новых
  OldStringTable:=TStringList.Create;
  OldStringTable.CaseSensitive:=true;
  OldStringTable.Assign(XomHandle.StringTable);
  NewStringTable:=NewXom.XomHandle.StringTable;
// добавляем недостающие строки
// переиндексовываем индексы и новые строки.
  ReBuild:=true;
  // нужно организовать поиск новых контейнеров

  if SearchType(NewXom.BaseCntr.Xtype,i) then
    GUID:=XomHandle.TypesInfo[i].GUID;
  NameID:=OldStringTable.Add('xgraphset data');
  InsertIndex:=CntrArr.Count;
  CntrSet.InsertXGraph(XCntr.OldIndex,InsertIndex,GUID,NameID);
  CntrSet.IncSize;
  XGraphMode:=True;
  CurNode:=AddClassTree(BaseCntr, But.ClassTree, nil); // заменить ReplaceIndex!!!
  XGraphMode:=False;
  CurNode.Delete;
  BaseNode.Data:=BaseCntr;
  OldStringTable.Clear;
  // вырубить ребуилд для всех контейнеров!!!
  CntrArr.OffReBuild;
  ReBuild:=false;
end;

function TXom.CreateNewCntr(XType: XTypes;NewName:String): TContainer;
var
XCntr:TContainer;
isCtnr:boolean;
p2,Pnt:pointer;
VirtualBufer:TMemoryStream;
zero,NewIndex:integer;

      vi:Integer;
      vu:Smallint;
      vf:Single;
      vb:boolean;
      vs,vs0:string;
      vc:Cardinal;
      vby:Shortint;
      vsize:integer;
begin
  NewIndex:=0;
  isCtnr:=true;
  zero:=0;

    VirtualBufer := TMemoryStream.Create;
    VirtualBufer.Write(zero, 3);
  case XType of
  XIntResourceDetails,XUintResourceDetails:
  begin
        vi:=0;
        VirtualBufer.Write(vi,4);
        WriteXName(VirtualBufer,NewName);
  end;
  XStringResourceDetails:
  begin
        WriteXName(VirtualBufer,'');
        WriteXName(VirtualBufer,NewName);
  end;
  XFloatResourceDetails:
  begin
        vf:=0.0;
        VirtualBufer.Write(vf,4);
        WriteXName(VirtualBufer,NewName);
  end;
  XVectorResourceDetails:
  begin
        vf:=0.0;
        VirtualBufer.Write(vf,4);
        VirtualBufer.Write(vf,4);
        VirtualBufer.Write(vf,4);
        WriteXName(VirtualBufer,NewName);
  end;
  XContainerResourceDetails:
  begin
        WriteXByte(VirtualBufer,NewIndex);
        WriteXName(VirtualBufer,NewName);
  end;
  XColorResourceDetails:
  begin
       vc:=0;
       VirtualBufer.Write(vc,4);
       WriteXName(VirtualBufer,NewName);
  end;
end;
          saidx := CntrArr.Count;
          XCntr := TContainer.Create(saidx, CntrArr,nil);
          XCntr.WriteBuf(VirtualBufer);
          VirtualBufer.Free;
          XCntr.XType := XType;
          XCntr.CTNR := isCtnr;
          XCntr.Name := NewName;
   result:=XCntr;
end;

{ TUVData }

constructor TUVData.Create;
begin
  Length:=1;
  UVCoord0[0][0]:=0.0;
  UVCoord0[0][1]:=0.0;
  UVCoord1[0][0]:=1.0;
  UVCoord1[0][1]:=1.0;
end;

destructor TUVData.Destroy;
begin
  Length:=0;
  inherited;
end;

procedure TUVData.DrawUV(Bitmap: TBitmap);
var
 i,w,h:integer;
 fw,fh:Single;
 rect:TRect;
begin
 Bitmap.Canvas.Brush.Color:=clYellow;
 //Bitmap.Canvas.Pen.Width:=2;
 w:= Bitmap.Width;
 h:= Bitmap.Height;
 if (w>0) and (h>0) then
 begin
  fw:=w*1.0;
  fh:=h*(1.0);
 for i:=0 to FLength-1 do
        begin    // проверить координаты!!!
        rect.Left:= Round(UVCoord0[i][0]*fw);
        rect.Right:= rect.Left+Round(UVCoord1[i][0]*fw);
        rect.Bottom:= h-Round(UVCoord0[i][1]*fh);
        rect.Top:= rect.Bottom-Round(UVCoord1[i][1]*fh);
        Bitmap.Canvas.FrameRect(rect);
        Bitmap.Canvas.TextOut(
        (rect.Left),//+Round(UVCoord1[i][1]*fw) div 2),
        (rect.Top),//+Round(UVCoord1[i][1]*fh) div 2),
        format('%d',[i])
        );
        end;
 end;
end;

function TUVData.GetLength: Integer;
begin
  Result:=System.Length(UVCoord0);
end;

procedure TUVData.SetLength(const Value: Integer);
begin
  System.SetLength(UVCoord0,Value);
  System.SetLength(UVCoord1,Value);
  FLength:=Value;
end;

end.



