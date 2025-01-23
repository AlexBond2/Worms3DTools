unit XomLib;

interface

uses OpenGLx, IdGlobal, SysUtils, Classes, Dialogs, Windows,Contnrs,
  ComCtrls, StdCtrls, ExtCtrls, Graphics, Buttons, Valedit, XTrackPanel, OpenGLLib,
  Math, Menus, CrystalDxt//, BitmapsUnit
  ;
{$DEFINE NOMULTI}
type
  Tver    = array[0..2] of GLfloat;
  Color4d = array[0..3] of GLfloat;

  AVer    = array of TVer;
  Aval    = array of GLfloat;
  AAval   = array of Aval;
  TFace   = array[0..3] of Word;
  IFace   = array of Word;
  AFace   = array of TFace;
  TFace3  = array[0..2] of Word;
  AFace3  = array of TFace3;
  Tpnt    = array[0..1] of GLfloat;
  ATCoord = array of Tpnt;
  TUColor = array[0..3] of Byte;
  AUColor = array of TUColor;
  TFColor = array[0..3] of Color4d;
  AFColor = array of TFColor;
  ATexures  = array of Integer;
  Tvector = record
    X, Y, Z: GLfloat;
  end;

  TBox = record
    Xmin, Ymin, Zmin: GLfloat;
    Xmax, Ymax, Zmax: GLfloat;
  end;


  TMatrix = array[1..4, 1..4] of GLfloat;

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

  TAnimInfo = record
    True:Boolean;
    Tm:TMatrix;
    TCoord: Tver;
    Child:Integer;
  end;

  XValTypes = (XString,XFloat,XFFloat,XVector,XVectorR,XVector4,
        XMatrix3,XMatrix4,XInt,XListInt,XBool,XUint,
        XFColor,XColor,XCode,XPoint,XByte,XListByte,XIndex,X4Char,XText);
  XTypes = (XNone,
    AIParametersContainer,
    BaseWeaponContainer,
    BrickBuildingCtr,
    BrickBuildingList,
    BrickLinkage,
    BuildingGlobalContainer,
    BuildingSpecificContainer,
    Campaign,
    CampaignCollective,
    CampaignData,
    ChaseCameraPropertiesContainer,
    ChatMessagesContainer,
    ChatMessagesWindowDetails,
    DetailEntityStore,
    EffectDetailsContainer,
    EFMV_CastActorEventContainer,
    EFMV_CommentEventContainer,
    EFMV_CreateBordersEventContainer,
    EFMV_CutCameraEventContainer,
    EFMV_DeleteBordersEventContainer,
    EFMV_MovieContainer,
    EFMV_PathCameraEventContainer,
    EFMV_PlayAnimationEventContainer,
    EFMV_TrackContainer,
    EFMV_TriggerSoundEffectEventContainer,
    EFMV_WormEmoteEventContainer,
    EFMV_WormGestureAtEventContainer,
    EFMV_WormLookAtEventContainer,
    FlagLockIdentifier,
    FlyCameraPropertiesContainer,
    FlyingPayloadWeaponPropertiesCo,
    GameInitData,
    GSProfile,
    GSProfileList,
    GSNetworkGameList,
    GSRoomList,
    GSTeamList,
    GunWeaponPropertiesContainer,
    HighScoreData,
    HomingPayloadWeaponPropertiesCo,
    JumpingPayloadWeaponPropertiesC,
    LandFrameStore,
    LensFlareElementContainer,
    LensFlareContainer,
    LevelDetails,
    LevelLock,
    ListBoxData,
    ListBoxIconColumn,
    ListBoxStringColumn,
    Lock,
    LockedBitmapArray,
    LockedBitmapDesc,
    LockedContainer,
    MeleeWeaponPropertiesContainer,
    MenuDescription,
        MenuButtonDesc,
        AcceptCancelButtonDesc,
        CheckBoxDesc,
        ComboControlDesc,
        ControlSetupDesc,
        FrameBoxDesc,
        GraphicEqualiserDesc,
        LandscapeBoxDesc,
        ListControlDesc,
        ListHeaderControlDesc,
        MultiStateButtonDesc,
        PercentButtonDesc,
        PictureViewDesc,
        TextBoxDesc,
        TextButtonDesc,
        MultiStateTextButtonDesc,
        TextEditBoxDesc,
        TitleTextDesc,
        WormPotControlDesc,
        WeaponControlDesc,
    StringQueue,
    PlayerList,
    TeamPersistDataContainer,
    MineFactoryContainer,
    Mission,
    Movie,
    MovieLock,
    OccludingCameraPropertiesContai,
    ParticleEmitterContainer,
    ParticleMeshNamesContainer,
    PayloadWeaponPropertiesContaine,
    PC_LandChunk,
    PC_LandFrame,
    SchemeColective,
    SchemeCollective,
    SchemeData,
    SchemeDataContainer,
    SentryGunWeaponPropertiesContai,
    SoundBankCollective,
    SoundBankColective,
    SoundBankData,
    StoredTeamData,
    StringStack,
    TeamDataColective,
    TeamDataCollective,
    TeamDataContainer,
    TeamCareerStats,
    TrackCameraContainer,
    W3DLumpBoundBox,
    W3DLumpConnector,
    W3DTemplate,
    W3DTemplateSet,
    WaterPlaneTweaks,
    WeaponDataCtr,
    WeaponDelays,
    WeaponInventory,
    WeaponSettingsData,
    WormDataContainer,
    WormStatsContainer,
    WormpaediaDetails,
    WormapediaDetails,
    WormpaediaColective,
    WormapediaCollective,
    WormPotContainer,
    WormCareerStats,
    WXLumpBoundBox,
    WXLumpConnector,
    WXTemplate,
    WXTemplateSet,
    WXFE_LevelDetails,
    XAlphaTest,
    XAnimChannel,
    XAnimClipLibrary,
    XAnimInfo,
    XAttrPass,
    XBillboardSpriteSet,
    XBinormal3fSet,
    XBinModifier,
    XBinSelector,
    XBitmapDescriptor,
    XBlendModeGL,
    XBone,
    XBrickDetails,
    XBrickGeometry,
    XBrickIndexSet,
    XBuildingShape,    
    XChildSelector,
    XCollisionData,
    XCollisionGeometry,
    XColor4ubSet,
    XColorResourceDetails,
    XConstColorSet,
    XContainerResourceDetails,
    XCoord3fSet,
    XCullFace,
    XCustomDescriptor,
    XDataBank,
    XDataStreamDeclarator,
    XDataFloat,
    XDataVector4f,
    XDepthTest,
    XDetailObjectsData,
    XDetailSwitch,
    XEnvironmentMapShader,
    XExpandedAnimInfo,
    XExportAttributeString,
    XFloatResourceDetails,
    XFortsExportedData,
    XGraphSet,
    XGroup,
    XImage,
    XIndexedTriangleSet,
    XIndexedCustomTriangleSet,
    XIndexedCustomTriangleStripSet,
    XIndexedTriangleStripSet,
    XIndexSet,
    XInteriorNode,
    XInternalSampleData,
    XIntResourceDetails,
    XJointTransform,
    XLightingEnable,
    XMaterial,
    XMatrix,
    XMeshDescriptor,
    XMultiTexCoordSet,
    XMultiTexFont,
    XMultiTexFontPage,
    XMultiTexShader,
    XNamedAttribute,
    XNormal3fSet,
    XNullDescriptor,
    XOglTextureMap,
    XOglTextureStage,
    XPalette,
    XPaletteWeightSet,
    XPathFinderData,
    XPlaneAlignedSpriteSet,
    XPsGeoSet,
    XPsProgReference,
    XPsProxyTexture,
    XPsShaderInstance,
    XPsShaderPrototype,
    XPsShape,
    XPsSkinShape,
    XPsTexFont,
    XPsTextureReference,
    XPsVertexDataSet,
    XPointLight,
    XPositionData,
    XSampleData,
    XSceneCamera,
    XSceneryEffectData,
    XShape,
    XCustomShader,
    XSimpleShader,
    XSlFragProg,
    XSlGeoSet,
    XSlShader,
    XSlShaderInstance,
    XSlTextureMap,
    XSlVertProg,
    XSkin,
    XSkinShape,
    XSoundBank,
    XStreamData,
    XStreamSet,
    XSpriteSet,
    XSpriteSetDescriptor,
    XStringResourceDetails,
    XSystemStream,
    XTangent3fSet,
    XTechnique,
    XTexCoord2fSet,
    XTexFont,
    XTextDescriptor,
    XTexturePlacement2D,
    XTransform,
    XUintResourceDetails,
    XUniformFloat,
    XUniformInstance,
    XUniformMatrixArray,
    XUniformProxy,
    XUniformShadowMatrix,
    XUniformTextureSize,
    XUniformTime,
    XUniformVector4f,
    XUniformViewMatrix,
    XUniformViewMatrixInverse,
    XUniformWorldViewMatrix,
    XUniformWorldViewProjectionMatr,
    XVectorResourceDetails,
    XVertexShader,
    XVertexStream,
    XWeightSet,
    XXomInfoNode,
    XZBufferWriteEnable,
    XMax);

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

  TContainers = class;
  TContainer = class;
  
  TCntrSet = class
    constructor Create;
    destructor Destroy;override;
  public
    Point: Pointer;
    Size:Integer;
    Cntr:TContainer;
    procedure SetSize(NewSize:integer);
    procedure ClearIndex(DelIndex: integer);
    procedure IncSize;
    procedure DecSize;
  end;

  TCntrVal = class
    constructor Create;
    destructor Destroy;override;
  public
    IdName:String;
    Point: Pointer;
    XType: XValTypes;
    XList: TStringList;
    Cntr: TContainer;
  end;

  TContainer = class
    constructor Create(_index:integer; Arr:TContainers; _point:Pointer);
    destructor Destroy; override;  
    private
    Del: boolean;
    procedure ToDelete;
    procedure NoDelete(DelCntr:TContainer);
    public
    Index: integer;
    Point: Pointer; // ссылка на точку в памяти
    Size: Integer; // размер контейнера
    Update: Boolean; // обновлен
    CTNR: Boolean; // имеет заголовок
    Xtype: XTypes; // тип контейнера
    Name: String;
    CntrArr: TContainers;
    CntrSet: TCntrSet;
    Childs: array of TContainer;
    OldIndex: Integer; // старый индекс
    ReBuild: boolean; // флаг для перестройки
    isNew:Boolean; // флаг новых контейнеров;
    BaseIndex: Integer; //базовый индекс
    procedure GetXMem(_size: Integer);
    function NewCopy:Pointer;
    function AddChild(_index:integer):TContainer;
    function GetPoint:Pointer;
    procedure ClearChilds;
    procedure ClearAllChilds;
    function GetOffset(P:Pointer):Integer;
    function CopyBufTo(Buf:TMemoryStream;P:Pointer):Integer;
    procedure CopyBufFrom(Buf:TMemoryStream;P:Pointer);
    procedure WriteBuf(Buf:TMemoryStream);
    procedure WriteXArray(Arr: Pointer; Len, _Size: Integer);
    procedure WriteCNTR(Buf:TMemoryStream);
    procedure FreeXMem;
    procedure CutSize(P:Pointer);
    function BuildCntrArr(Cntrs: TContainers): TContainer;
    function  Copy(Cntrs:TContainers=nil):TContainer;
    function DelNoClone(BaseCntr:TContainer):Integer;
    procedure ViewTga(ImageT32: TImage; XGrid: Boolean; XLabel: TLabel);
    procedure SaveTGA(Name: string; Image32: TImage; XLabel: TLabel);
    function ImportXImage(Name: string): Boolean;
    procedure StripSetToTri;
    procedure TriToStripSet;
    procedure FillColor(Num:Integer;Color:Byte);
  end;

//  XContainers = array of TContainer;

  TContainers = class(TObjectList)
    private
        function GetItems(Index: Integer): TContainer;
        procedure SetItems(Index: Integer; const Value: TContainer);
    public
        function FindNewIndex(OldIndex:Integer;New:Boolean): Integer;
        function FoundXType(XType:XTypes):Integer;
        procedure FreeDel;
        procedure ClearChilds;
        procedure ClearNames;
        procedure OffReBuild;
    property Items[Index: Integer]: TContainer read GetItems write SetItems; default;
  end;

  TXCtrls = record
    DrawBoxes,
    AnimButton,
    EditAnimBut,
    RotateButton,
    Dummy,Move,Rotate,Scale
    : PBoolean;
 //   JointButton: TSpeedButton;
    GlValueList: TValueListEditor;
    AnimBox: TComboBox;
    TrackPanel: TTrackPanel;
    TreeProgress:TProgressBar;
 //   ValueList: TValueListEditor;
    Status, StatusM: TStatusPanel;
    ClassTree: TTreeView;
    XLabel, XImageLab: TLabel;
    XImage: TImage;
    Handle: THandle;
    Canvas: TCanvas;
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
    end;

  AAnimInfo = array of TAnimInfo;

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

    function GetTextureGL(Point: Pointer): Boolean;
    procedure ReadXNode(VirtualBufer: TMemoryStream;
      XTextureStr: TStringList; Tree: TTreeView; Node: TTreeNode);
    function GetMeshOfName(ObjName:String):TMesh;
    function GetMeshOfID(Id:Integer):TMesh;
    destructor Destroy;override;
  end;

  AMesh = array of TMesh;

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

  TgaHead = record
    zero: Word;
    typeTGA: Word;
    zero2: Longword;
    zero3: Longword;
    Width: Word;
    Height: Word;
    ColorBit: Word;
  end;

  TRGBA = record
    b, g, r, a: Byte;
  end;
  ARGBA  = array [0..1] of TRGBA;
  PARGBA = ^ARGBA;

  TRGB = record
    b, g, r: Byte;
  end;
  ARGB  = array [0..1] of TRGB;
  PARGB = ^ARGB;

  AB  = array [0..1] of Byte;
  PAB = ^AB;

type
  TXom = class
    constructor Create;
    destructor Destroy; override;
  public
    Mesh3D: TMesh;
//    AnimClips: TAnimClips;
    LastXImage: TContainer;
    LastCounter: Integer;
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
    Loading:boolean;
    WFBuilds:TWFBuilds;

    function GetXType(XName:PChar;var XType:XTypes):Boolean;
    procedure LoadXomFileName(FileName: string; var OutCaption: string; ShowProgress:boolean=true);
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
    procedure DrawBuild(Build:TBuildData);
  end;

    TAnimClips = class
    constructor Create;
    destructor Destroy; override;
  private
    FAnimClips:AAnimClip;
    FStrings:TStringList;
  //  FKeyList:TStringList;
  protected
    function GetItem(Index: String): TAnimClip;
    procedure SetItem(Index: String; Value: TAnimClip);
  public
    cIndx:integer;
    Name:String;

    procedure ClearClips;
    function AddClip(Clip:TAnimClip):Integer;
    function GetNameAnimType(AType: Cardinal): string;
    function BuildAnim(XCntr: TContainer;Xom:TXom):Integer;
    procedure SaveAnimToXom(Xom:TXom);
    function GetItemID(Index: Integer): TAnimClip;
    property Items[Index:String]:TAnimClip read GetItem write SetItem;
//    property KeyList:TStringList read FKeyList write FKeyList;
  end;

//function GetFullName(Name:String):String;
function ReadName(var Stream: TMemoryStream): string;
function Byte128(_byte: Integer): Integer;
function TestByte128(var _p: Pointer): Integer;
procedure WriteXByte(var Memory: TMemoryStream; Val: Integer);
procedure WriteXByteP(var p: Pointer; Val: Integer);

type
  TStringArray = array of string;

function StringListFromStrings(const Strings: array of string): TStringList;

function ToTime(milisec: Longword): Single;

procedure oglAxes;
procedure oglGrid(GridMax: Integer);
procedure Light(var Color: Color4D);

function GetMatrix2(Pos, Rot1, Rot2, Rot3, Size: Tver): TMatrix;
function GetMatrix(Pos, Rot, Size: Tver): TMatrix;
procedure MatrixDecompose(XMatrix: TMatrix; var XPos: Tver;
  var XRot: Tver; var XSize: Tver);
function MatrixInvert(const m: TMatrix): TMatrix;
function MatrXMatr(M1, M2: TMatrix): TMatrix;
function MatrXVert(Matrix: TMatrix; V0, V1, V2: Single): Tver;
function ValXVert(Val: Single; vect: TVer): TVer;
function VertAddVert(v1, v2: TVer): TVer;

Procedure UpdateAnimTree(TV:TTreeView);
procedure UpdateAnimTreeMenu(AddItem,DeleteItem:TMenuItem);
procedure glxDrawBitmapText(Canvas:TCanvas; wdx, wdy, wdz: GLdouble; bitPoint2: Pointer;
  Name: string; select: Boolean);
procedure GetProjectVert(X,Y:real;axis:TAxis;var p:TXYZ);  
{type
 XTypesValue = record
 Str: PChar;
 Values : Array of XValTypes;
 end;    }

const
 APPVER = 'XomView v.2.9 by AlexBond';

 XResourceDetails: array [0..7] of String = ('IntResources','UintResources','StringResources',
        'FloatResources','VectorResources','ContainerResources','StringTableResources','ColorResources');

ImageFormatWR: array [0..39] of String = ('R8G8B8','A8R8G8B8','X8R8G8B8','X1R5G5B5','A1R5G5B5','R5G6B5','A8','P8','P4','DXT1','DXT3','DXT5','NgcRGBA8','NgcRGB5A3','NgcR5G6B5',
'NgcIA8','NgcIA4','NgcI8','NgcI4','NgcCI12A4','NgcCI8','NgcCI4','NgcCMPR','NgcIndirect','P2P8','P2P4','Linear','F16RGB','F16RGBA','F32RGB','F32RGBA','F16RG','D16','D24','D32',
'FD32','D24S8','A8R8G8B8_SCE','X8R8G8B8_LE','Count');

ImageFormatW3D: array [0..26] of String = ('R8G8B8','A8R8G8B8','X8R8G8B8','X1R5G5B5','A1R5G5B5','R5G6B5','A8','P8','P4','DXT1','DXT3','NgcRGBA8','NgcRGB5A3','NgcR5G6B5',
'NgcIA8','NgcIA4','NgcI8','NgcI4','NgcCI12A4','NgcCI8','NgcCI4','NgcCMPR','NgcIndirect','P2P8','P2P4','Linear','Count');

WRComprOp: array [0..4] of string = ('None','UseBest','ForceDXT1','ForceDXT3','ForceDXT5');

 WUMWeapon: array [1..58] of String = ('Airstrike','BananaBomb','BaseballBat','Bazooka','ClusterGrenade','ConcreteDonkey','CrateShower','CrateSpy','DoubleDamage','Dynamite',
'FirePunch','GasCanister','Girder','Grenade','HolyHandGrenade','HomingMissile','Jetpack','Landmine','NinjaRope','OldWoman','Parachute',
'Prod','SelectWorm','Sheep','Shotgun','SkipGo','SuperSheep','Redbull','Flood','Armour','WeaponFactoryWeapon','AlienAbduction','Fatkins',
'Scouser','NoMoreNails','PoisonArrow','SentryGun','SniperRifle','SuperAirstrike','BubbleTrouble','Starburst','Surrender','?','MineLayerMystery',
'MineTripletMystery','BarrelTripletMystery','FloodMystery','DisarmMystery','TeleportMystery','QuickWalkMystery','LowGravityMystery',
'DoubleTurnTimeMystery','HealthMystery','DamageMystery','SuperHealthMystery','SpecialWeaponMystery','BadPoisonMystery','GoodPoisonMystery');

 W4Weapon: array [1..57] of String = ('Airstrike','BananaBomb','BaseballBat','Bazooka','ClusterGrenade','ConcreteDonkey','CrateShower','CrateSpy','DoubleDamage','Dynamite',
'FirePunch','GasCanister','Girder','Grenade','HolyHandGrenade','HomingMissile','Jetpack','Landmine','NinjaRope','OldWoman','Parachute',
'Prod','SelectWorm','Sheep','Shotgun','SkipGo','SuperSheep','Redbull','Flood','Armour','WeaponFactoryWeapon','AlienAbduction','Fatkins',
'Scouser','NoMoreNails','PoisonArrow','SentryGun','SniperRifle','SuperAirstrike','BubbleTrouble','Starburst','Surrender','MineLayerMystery',
'MineTripletMystery','BarrelTripletMystery','FloodMystery','DisarmMystery','TeleportMystery','QuickWalkMystery','LowGravityMystery',
'DoubleTurnTimeMystery','HealthMystery','DamageMystery','SuperHealthMystery','SpecialWeaponMystery','BadPoisonMystery','GoodPoisonMystery');


 W3DWeapon: array [1..54] of String = ('Airstrike','Armageddon','BananaBomb','BaseballBat','Bazooka','Binoculars','Blowpipe','BridgeKit','ClusterGrenade','ConcreteDonkey','CrateShower',
'CrateSpy','DoctorsStrike','DoubleDamage','DoubleTurnTime','Dynamite','Earthquake','FirePunch','Freeze','GasCanister','Girder','Grenade',
'HolyHandGrenade','HomingMissile','HomingPigeon','Jetpack','Landmine','LaserSight','LotteryStrike','LowGravity','MadCow','MagicBullet','MegaMine','MineStrike',
'Mortar','NinjaRope','NuclearBomb','OldWoman','Parachute','PetrolBomb','Prod','QuickWalk','ScalesOfJustice','SelectWorm',
'Sheep',
//'SheepStrike',
'SkipGo','Shotgun','Surrender','StickyBomb','SuperSheep','Teleport',
'Uzi','VikingAxe','Redbull');

 WFWeapon: array [1..55] of String = ('Bazooka','Mortar','FireWeapon','HomingPigeon','RocketLauncher','Grenade','ClusterLauncher','FireGrenadeLauncher',
'BananaBombLauncher','Trebuchet','Canary','OldLady','BatteringRam','SuperHippo','MonkeyHerd','AirStrike','NapalmStrike','MineStrike','AnimalStrike',
'TrojanDonkey','ElectricalStorm','Earthquake','Flood','NuclearStrike','Armageddon','FirePunch','Ballista','MiniGun','GiantCrossbow','GiantLaser',
'Tower','Keep','Castle','Citadel','Wall','Hospital','Refinery','ScienceLab','Wonder','Farm','SiegeWorkshop','Storehouse','MasonsGuild','Market','Stronghold',
'Jetpack','Freeze','WormSelect','Parachute','Girder','RepairBuilding','SpawnWorm','SkipGo','Suicide','Surrender');

 ListEpochs: array [0..3] of String = ('Medieval','Oriental','Egypt','Greek');

 ListWFSky: array [0..19] of String = ('Medieval(Day)','Medieval(Evening)','Medieval(Night)',
        'Greek(Evening)','Greek(Day)','Greek(Night)','Oriental(Day)','Oriental(Evening)',
        'Oriental(Night)','Egypt(Day)','Egypt(Evening)','Egypt(Night)',
        'Coliseum of Doom Sky(Day)','Unused Red Sky(Evening)',
        'Mordred And Morgana(Hell)','A Quest(Day)','Pharaoh enough!(Day)',
        'The Kingdom is Born(Night)','Tower of Power Sky (Evening)',
        'Chess Mate Sky (Evening)');
 ListWFWater: array [0..3] of String = ('WATER','LAVA','CLOUD','SAND');
 ListWFBuild: array [0..16] of string = ('TOWER','KEEP','CASTLE','CITADEL','WALL','HOSPITAL',
        'REFINERY','SCIENCELAB','WONDER','-','-','-','-','-','STRONGHOLD','LIGHT','NONE');

 PCharXTypes:array[XTypes] of PChar = ('XNone',
    'AIParametersContainer',
    'BaseWeaponContainer',
    'BrickBuildingCtr',
    'BrickBuildingList',
    'BrickLinkage',
    'BuildingGlobalContainer',
    'BuildingSpecificContainer',
    'Campaign',
    'CampaignCollective',
    'CampaignData',
    'ChaseCameraPropertiesContainer',
    'ChatMessagesContainer',
    'ChatMessagesWindowDetails',
    'DetailEntityStore',
    'EffectDetailsContainer',
    'EFMV_CastActorEventContainer',
    'EFMV_CommentEventContainer',
    'EFMV_CreateBordersEventContaine',
    'EFMV_CutCameraEventContainer',
    'EFMV_DeleteBordersEventContaine',
    'EFMV_MovieContainer',
    'EFMV_PathCameraEventContainer',
    'EFMV_PlayAnimationEventContaine',
    'EFMV_TrackContainer',
    'EFMV_TriggerSoundEffectEventCon',
    'EFMV_WormEmoteEventContainer',
    'EFMV_WormGestureAtEventContaine',
    'EFMV_WormLookAtEventContainer',
    'FlagLockIdentifier',
    'FlyCameraPropertiesContainer',
    'FlyingPayloadWeaponPropertiesCo',
    'GameInitData',
    'GSProfile',
    'GSProfileList',
    'GSNetworkGameList',
    'GSRoomList',
    'GSTeamList',
    'GunWeaponPropertiesContainer',
    'HighScoreData',
    'HomingPayloadWeaponPropertiesCo',
    'JumpingPayloadWeaponPropertiesC',
    'LandFrameStore',
    'LensFlareElementContainer',
    'LensFlareContainer',
    'LevelDetails',
    'LevelLock',
    'ListBoxData',
    'ListBoxIconColumn',
    'ListBoxStringColumn',
    'Lock',
    'LockedBitmapArray',
    'LockedBitmapDesc',
    'LockedContainer',
    'MeleeWeaponPropertiesContainer',
    'MenuDescription',
        'MenuButtonDesc',
        'AcceptCancelButtonDesc',
        'CheckBoxDesc',
        'ComboControlDesc',
        'ControlSetupDesc',
        'FrameBoxDesc',
        'GraphicEqualiserDesc',
        'LandscapeBoxDesc',
        'ListControlDesc',
        'ListHeaderControlDesc',
        'MultiStateButtonDesc',
        'PercentButtonDesc',
        'PictureViewDesc',
        'TextBoxDesc',
        'TextButtonDesc',
        'MultiStateTextButtonDesc',
        'TextEditBoxDesc',
        'TitleTextDesc',
        'WormPotControlDesc',
        'WeaponControlDesc',
    'StringQueue',
    'PlayerList',
    'TeamPersistDataContainer',
    'MineFactoryContainer',
    'Mission',
    'Movie',
    'MovieLock',
    'OccludingCameraPropertiesContai',
    'ParticleEmitterContainer',
    'ParticleMeshNamesContainer',
    'PayloadWeaponPropertiesContaine',
    'PC_LandChunk',
    'PC_LandFrame',
    'SchemeColective',
    'SchemeCollective',
    'SchemeData',
    'SchemeDataContainer',
    'SentryGunWeaponPropertiesContai',
    'SoundBankCollective',
    'SoundBankColective',
    'SoundBankData',
    'StoredTeamData',
    'StringStack',
    'TeamDataColective',
    'TeamDataCollective',
    'TeamDataContainer',
    'TeamCareerStats',
    'TrackCameraContainer',
    'W3DLumpBoundBox',
    'W3DLumpConnector',
    'W3DTemplate',
    'W3DTemplateSet',
    'WaterPlaneTweaks',
    'WeaponDataCtr',
    'WeaponDelays',
    'WeaponInventory',
    'WeaponSettingsData',
    'WormDataContainer',
    'WormStatsContainer',
    'WormpaediaDetails',
    'WormapediaDetails',
    'WormpaediaColective',
    'WormapediaCollective',
    'WormPotContainer',
    'WormCareerStats',
    'WXLumpBoundBox',
    'WXLumpConnector',
    'WXTemplate',
    'WXTemplateSet',
    'WXFE_LevelDetails',
    'XAlphaTest',
    'XAnimChannel',
    'XAnimClipLibrary',
    'XAnimInfo',
    'XAttrPass',
    'XBillboardSpriteSet',
    'XBinormal3fSet',
    'XBinModifier',
    'XBinSelector',
    'XBitmapDescriptor',
    'XBlendModeGL',
    'XBone',
    'XBrickDetails',
    'XBrickGeometry',
    'XBrickIndexSet',
    'XBuildingShape',    
    'XChildSelector',
    'XCollisionData',
    'XCollisionGeometry',
    'XColor4ubSet',
    'XColorResourceDetails',
    'XConstColorSet',
    'XContainerResourceDetails',
    'XCoord3fSet',
    'XCullFace',
    'XCustomDescriptor',
    'XDataBank',
    'XDataStreamDeclarator',
    'XDataFloat',
    'XDataVector4f',
    'XDepthTest',
    'XDetailObjectsData',
    'XDetailSwitch',
    'XEnvironmentMapShader',
    'XExpandedAnimInfo',
    'XExportAttributeString',
    'XFloatResourceDetails',
    'XFortsExportedData',
    'XGraphSet',
    'XGroup',
    'XImage',
    'XIndexedTriangleSet',
    'XIndexedCustomTriangleSet',
    'XIndexedCustomTriangleStripSet',
    'XIndexedTriangleStripSet',
    'XIndexSet',
    'XInteriorNode',
    'XInternalSampleData',
    'XIntResourceDetails',
    'XJointTransform',
    'XLightingEnable',
    'XMaterial',
    'XMatrix',
    'XMeshDescriptor',
    'XMultiTexCoordSet',
    'XMultiTexFont',
    'XMultiTexFontPage',
    'XMultiTexShader',
    'XNamedAttribute',
    'XNormal3fSet',
    'XNullDescriptor',
    'XOglTextureMap',
    'XOglTextureStage',
    'XPalette',
    'XPaletteWeightSet',
    'XPathFinderData',
    'XPlaneAlignedSpriteSet',
    'XPsGeoSet',
    'XPsProgReference',
    'XPsProxyTexture',
    'XPsShaderInstance',
    'XPsShaderPrototype',
    'XPsShape',
    'XPsSkinShape',
    'XPsTexFont',
    'XPsTextureReference',
    'XPsVertexDataSet',
    'XPointLight',
    'XPositionData',
    'XSampleData',
    'XSceneCamera',
    'XSceneryEffectData',
    'XShape',
    'XCustomShader',
    'XSimpleShader',
    'XSlFragProg',
    'XSlGeoSet',
    'XSlShader',
    'XSlShaderInstance',
    'XSlTextureMap',
    'XSlVertProg',
    'XSkin',
    'XSkinShape',
    'XSoundBank',
    'XStreamData',
    'XStreamSet',
    'XSpriteSet',
    'XSpriteSetDescriptor',
    'XStringResourceDetails',
    'XSystemStream',
    'XTangent3fSet',
    'XTechnique',
    'XTexCoord2fSet',
    'XTexFont',
    'XTextDescriptor',
    'XTexturePlacement2D',
    'XTransform',
    'XUintResourceDetails',
    'XUniformFloat',
    'XUniformInstance',
    'XUniformMatrixArray',
    'XUniformProxy',
    'XUniformShadowMatrix',
    'XUniformTextureSize',
    'XUniformTime',
    'XUniformVector4f',
    'XUniformViewMatrix',
    'XUniformViewMatrixInverse',
    'XUniformWorldViewMatrix',
    'XUniformWorldViewProjectionMatr',
    'XVectorResourceDetails',
    'XVertexShader',
    'XVertexStream',
    'XWeightSet',
    'XXomInfoNode',
    'XZBufferWriteEnable',
    'XMax');
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

  Ctnr  = $524e5443;//'CTNR';
  Ctnr2 = $53525453; //'STRS'

  TypeStr: PChar       = 'TYPE';
  FileHeadType: PChar  = 'MOIK';
  Schm: PChar          = 'SCHM';
  StrS: PChar          = 'STRS';
  CtnrS: PChar         = 'CTNR';
  Space: PChar         = '   ';

  STRIPGUID:TGUID       = '{F9EA3152-F471-4189-9AA5-3E374C0355CD}';
  TRIGUID:TGUID         = '{99504FA1-C2D2-4E88-972C-38194B782488}';
  
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
  But:TXCtrls;

  AnimTimer: THRTimer;
  AnimClips:TAnimClips;
  CurAnimClip:TAnimClip;
  BaseClip:TAnimClip;

  MaxAnimTime: Single;
  Xbit: Integer;
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
//  StrArray: XConteiners;
//      CntrArr:XContainers;
  ActiveMesh:TMesh;
  ObjMatrix:TMatrix;
  W3D: boolean = true;
  WUM: boolean = false;
  WF: boolean = false;
  W4: boolean = false;
  WB: boolean = false;
  WR: boolean = false;
  WC: boolean = false;
  TEXTUREBASE:Integer = 0;
var
  ActiveMatrix, TempMatrix: TMatrix;
  NKey:Tver;
  MovePoxPos,  ScalePoxPos,RotatePoxPos:Tver;
  p:TXYZ;
  theta,alpha,beta,gamma:single;
  
implementation

procedure glColorPointer(size: TGLint; _type: TGLenum;
  stride: TGLsizei; const _pointer: PGLvoid); stdcall; external opengl32;

procedure glTexCoordPointer(size: TGLint; _type: TGLenum;
  stride: TGLsizei; const _pointer: PGLvoid); stdcall; external opengl32;
//procedure glColorTable(target: TGLint; internalformat: TGLenum; width: TGLsizei;format:TGLenum;_type: TGLenum; const _pointer: PGLvoid);stdcall;external opengl32;

procedure glDisableClientState(_array: TGLenum); stdcall; external opengl32;

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
                Item2 := MakeItem(Item1,'Size');
                Item2d := MakeItem(Item1d,'Size');
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
          ATypeReScale,ATypeScale: begin
                Node2:=TV.Items.AddChild(Node,'Size');
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

procedure TAnimClips.SaveAnimToXom(Xom:TXom);
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

Function TAnimClips.BuildAnim(XCntr: TContainer;Xom:TXom):Integer;
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
    if (s1='Base') then BaseClip:=AnimClip;
    AnimClip.Name := s1;
    AddClip(AnimClip);
  {  AnimClip.FNamesObj:=TStringList.Create;
    AnimClip.FNamesObj.Assign(StrList); 
    SetLength(AnimClip.FAnimInfo,StrList.Count);   }
 //   AB.Items.Add(s1);
    inx     := Word(p2^);  // NumAnimKeys
    ExpAnim := (inx = 256) or (inx=257);
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
ATypeRotation:FVal:=ActiveMesh.Transform.Rot[inx];
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
                AddKey(RS[ATypeX],FrameTime,
                ActiveMesh.Transform.Size[ATypeX],NKey[ATypeX],
                ATypeReScale+(ATypeX shl 24));
      end;
      case MAxis of
                Axis_Y,Axis_XY,Axis_YZ,Axis_XYZ:
                AddKey(RS[ATypeY],FrameTime,
                ActiveMesh.Transform.Size[ATypeY],NKey[ATypeY],
                ATypeReScale+(ATypeY shl 24));
      end;
      case MAxis of
                Axis_Z,Axis_XZ,Axis_YZ,Axis_XYZ:
                AddKey(RS[ATypeZ],FrameTime,
                ActiveMesh.Transform.Size[ATypeZ],NKey[ATypeZ],
                ATypeReScale+(ATypeZ shl 24));
      end;
end;
SortKeys;
end;

constructor TXom.Create;
begin
  inherited Create;
  CntrArr := TContainers.Create(true);
  Mesh3D := TMesh.Create(CntrArr);

end;

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
var
  i, j, ActChild, NormalLen, FaceNum, VCount, BCount: Integer;
  Matrix: TMatrix;
  point31, point32, BVert: Tver;
  AnimInfo: TAnimInfo;
    PushMatrix: TMatrix;
label
  normal2;
begin     // кидаем в стек текущую матрицу
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

    if Length(Face) <> 0 then
    begin
      NormalLen := Length(Normal);
      FaceNum := Length(Face);

      if NormalLen = 0 then
        glDisable(GL_LIGHTING);

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

    end;

      if (Length(Color) <> 0) and
        (Cardinal(Pointer(@Color[0])^) <> $FF000000) then
      begin
        glEnableClientState(GL_COLOR_ARRAY);
        glColorPointer(4, GL_UNSIGNED_BYTE, 0, Color);
      end;
      if (Length(ColorF) <> 0) then
      begin
        glEnableClientState(GL_COLOR_ARRAY);
        glColorPointer(4, GL_FLOAT, 0, ColorF);
      end;

      if NormalLen <> 0 then
      begin
        glEnableClientState(GL_NORMAL_ARRAY);
        glNormalPointer(GL_FLOAT, 0, Normal);
      end;

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

      if (XType='CG') then
      glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);

      for j := 0 to FaceNum - 1 do
        glDrawElements(GL_TRIANGLES, 3, GL_UNSIGNED_SHORT, @Face[j]);

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


      glDisableClientState(GL_TEXTURE_COORD_ARRAY);
      glDisableClientState(GL_COLOR_ARRAY);
      glDisableClientState(GL_NORMAL_ARRAY);
      glDisableClientState(GL_VERTEX_ARRAY);

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

function Byte128(_byte: Integer): Integer;
begin
  asm
mov eax,_byte
mov ecx,128
cdq
div ecx
cmp eax,0
je @@no
add edx,128
@@no:
mov ecx,eax
imul ecx,256
add ecx,edx
mov result,ecx
end;
end;

function TestByte128(var _p: Pointer): Integer;
var
  Val, n: Integer;
begin
  n := 1;
  Val := Byte(_p^) and $7f;
  while ((Byte(_p^) shr 7) = 1) and (n < 4) do
  begin
    Inc(Longword(_p));
    Val := ((Byte(_p^) and $7F) shl (7 * n)) + Val;
    Inc(n);
  end;
  Inc(Longword(_p));
  Result := Val;
end;

procedure WriteXByte(var Memory: TMemoryStream; Val: Integer);
var 
  byte0: Byte;
  HByte: Boolean;
begin
  Hbyte := true;
  while Hbyte do
  begin
    byte0 := Byte(Val);
    //     Hbyte:=byte((val shr 7)and 1);
    Hbyte := (Val shr 7) > 0;
    if Hbyte then  
      byte0 := byte0 or $80;
    Memory.Write(byte0, 1);
    Val := Val shr 7;
  end;
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

procedure WriteXByteP(var p: Pointer; Val: Integer);
var 
  byte0: Byte;
  HByte: Boolean;
begin
  Hbyte := true;
  while Hbyte do
  begin
    byte0 := Byte(Val);
    Hbyte := (Val shr 7) > 0;
    if Hbyte then  
      byte0 := byte0 or $80;
    Byte(p^) := byte0; 
    Inc(Longword(p));
    Val := Val shr 7;
  end;
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
if ((NewIndex<>0) and (indx<>NewIndex))then begin
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

 if insertmode then
        InsertIndex:=0
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

function TMesh.GetTextureGL(Point: Pointer): Boolean;
var
  VBuf, VBuf2, palette: Pointer;
  w, h, CntrIndx: Integer;
  NumMaps, IName, ISize, Mapsize, IFormat, IComponents: Integer;
  Bsize: Byte;
  Is24Bit, IsXBOX: Boolean;
  Format:integer;
begin
  //////////////////////////////
  VBuf := Pointer(Longword(Point) + 3);
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
  if Format = 7 then
    IsXBOX := true;
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
 { if IsXbox then
  begin
    glEnable(GL_COLOR_TABLE);
    palette:= pointer(Longword(StrArray[CntrIndx].point)+11);
//    glColorTable(GL_COLOR_TABLE, GL_RGBA, 256, GL_RGBA, GL_UNSIGNED_BYTE, palette);
    IFormat:=GL_COLOR_INDEX;
    IComponents:=1;
  end;     }
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
var
  Strip: Boolean;
  p2, p3, p4, MaxSingle, FaceArrStrip, FaceArr: Pointer;
  IndFace:IFace;
  FaceStrip: TFace;
  i,j, k, FaceNum, Count3dsPoints, cPoints, Faces: Integer;
//  IDtest: Boolean;
  //SizeBox:TBox;
  //Colors:AUColor;
  //TempNote:TTreeNode;
  NormalComp, ColorComp, TextureComp:Boolean;
  FaceCntr, VertexCntr, NormalCntr, ColorCntr, TextureCntr, WeightCntr,
  StreamCntr,SystemCntr,VertCntr,DataSize: Integer;
  s:string;
begin
WeightCntr:=0;
p4:=nil;

if (XCntr.XType = XPsGeoSet) then begin
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
    Exit;
  p2 := XCntr.CntrArr[VertexCntr].GetPoint;
  Count3dsPoints := TestByte128(p2);
  SetLength(Vert, Count3dsPoints);
  Move(p2^, Vert[0], Count3dsPoints * 12);

  // Normal
  if NormalCntr <> 0 then 
  begin
    if XCntr.CntrArr[NormalCntr].Xtype <> XNormal3fSet then
      Exit;
    p2 := XCntr.CntrArr[NormalCntr].GetPoint;
    k := TestByte128(p2);
    SetLength(Normal, k);
    Move(p2^, Normal[0], k * 12);
  end;
  // Color
  if (ColorCntr <> 0) and (XCntr.CntrArr[ColorCntr].Xtype <> XConstColorSet) then
  begin
    if XCntr.CntrArr[ColorCntr].Xtype <> XColor4ubSet then
      Exit;
    p2 := XCntr.CntrArr[ColorCntr].GetPoint;
    k := TestByte128(p2);
    SetLength(Color, k);
    Move(p2^, Color[0], k * 4);
  end;
  // TextCoord
  if XCntr.CntrArr[TextureCntr].Xtype = XTexCoord2fSet then
  begin
  p2 := XCntr.CntrArr[TextureCntr].GetPoint;
  k := TestByte128(p2);
  SetLength(TextCoord, k);
  Move(p2^, TextCoord[0], k * 8);
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
            
  MaxSingle := Pointer($FFFF7F7F);
  if SizeBox.Xmin = Single(MaxSingle) then
    for j := 0 to Count3dsPoints - 1 do
      CalcSizeBox(Vert[j]);
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


function ReadName(var Stream: TMemoryStream): string;
var
  p: Pointer;
begin
  p := Pointer(Longword(Stream.Memory) + Stream.Position);
  Result := PChar(p);
  Stream.Position := Stream.Position + Length(Result) + 1;
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
          VirtualBufer.Write(InvBoneMatrix[i], 3 * 4);
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

{       TCntrVal       }
constructor TCntrVal.Create;
begin
  inherited Create;
end;

destructor TCntrVal.Destroy;
begin
//  XList.Free;
  inherited;
end;
{}

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
  if ShowProgress then
  But.Status.Text := Format('Strings: (%d) - (%d)', [MaxInx, LenSTR]);
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
end;

{ TContainer }

constructor TContainer.Create(_index:Integer;Arr:TContainers;_point:Pointer);
begin
  inherited Create;
  CntrArr:=Arr;
  Index:=_index;
  Point:=_point;
end;

procedure TContainer.GetXMem(_size: Integer);
begin
    FreeXMem;
    Update := true;
    Point := AllocMem(_size);
    Size := _Size;
end;

function TContainer.NewCopy:Pointer;
var NewPoint:Pointer;
begin
      NewPoint := AllocMem(Size);
      Move(Point^, NewPoint^, Size);
      FreeXMem;
      Update := true;
      Point:=NewPoint;
      Result:=Point;
end;

procedure TContainer.FreeXMem;
begin
 if Update and (Point<>nil) then
      FreeMem(point);
end;

function TContainer.GetPoint:Pointer;
begin
  Result := Pointer(Longword(Point) + 3);
end;

function TContainer.AddChild(_index:integer):TContainer;
var
  Len: Integer;
begin
  Len := Length(Childs);
  SetLength(Childs, Len + 1);
  if _index<>0 then
        Childs[Len] := CntrArr[_index]
  else
        Childs[Len] := nil;
  Result:=Childs[Len];
end;

procedure TContainer.ClearChilds;
begin
  SetLength(Childs,0);
end;

function TContainer.Copy(Cntrs:TContainers=nil):TContainer;
var
NewPoint:Pointer;
begin
      NewPoint := AllocMem(Size);
      Move(Point^, NewPoint^, Size);
      Result:=TContainer.Create(Index,Cntrs,NewPoint);
      Result.Size:=Size;
      Result.CTNR:=CTNR;
      Result.Xtype:=Xtype;
      Result.Update:=true;
      Result.BaseIndex:=BaseIndex;
      if Cntrs<>nil then Result.isNew:=true;
end;

function TContainer.BuildCntrArr(Cntrs: TContainers):TContainer;
var
  i, Len, n: Integer;
  exist:boolean;
begin
  // проверка на уникальный класс
  Result:=nil;
  exist:=false;
  for i:=0 to Cntrs.Count-1 do
  begin
    if Cntrs[i].Index=Index then begin
    exist:=true;
    Result:= Cntrs[i];
    break end;
  end;
  // если он уникален, то добавляем его
  if not exist then begin
     n:=Cntrs.Add(Self.Copy);
     Cntrs[n].CntrArr:=Cntrs;
     Result:=Cntrs[n];
  // пробигаем по потомкам.
  Len := Length(Childs);
  SetLength(Result.Childs,Len);  // детей можно было не делать
  for i:=0 to Len-1 do
      if Childs[i]<>nil then begin
      Result.Childs[i]:=Childs[i].BuildCntrArr(Cntrs);
      end;
  end;
end;

procedure TContainer.ClearAllChilds;
var i:integer;
begin
  if Length(Childs) > 0 then begin
    for i := 0 to Length(Childs) - 1 do
      if Childs[i]<>nil then Childs[i].ClearAllChilds;
    ClearChilds;
  end;
end;

destructor TContainer.Destroy;
begin
    FreeXMem;
    ClearChilds;
    inherited Destroy;
end;

procedure TContainer.WriteCNTR(Buf:TMemoryStream);
var
p:pointer;
  begin
    if CTNR then
    begin
    //  p := PChar('CTNR');
      p := CtnrS;
      Buf.Write(p^, 4);
    end;

    Buf.Write(Point^, Size);
end;

function TContainer.GetOffset(P:Pointer):Integer;
begin
 Result:=Longword(P)-Longword(Point);
end;

function TContainer.CopyBufTo(Buf:TMemoryStream;P:Pointer):Integer;
var
 offset:Integer;
begin
 offset:=GetOffset(P);
 Buf.Write(Point^,offset);
 Result:=offset;
end;

procedure TContainer.CopyBufFrom(Buf:TMemoryStream;P:Pointer);
begin
 Buf.Write(P^,Size-GetOffset(P));
end;

procedure TContainer.WriteBuf(Buf:TMemoryStream);
var
  _Size:integer;
begin
  _Size := Buf.Position;
  GetXMem(_Size);
  Move(Buf.Memory^, Point^, _Size);
end;

procedure TContainer.CutSize(P: Pointer);
begin
   Size := GetOffset(P);
end;

procedure TContainer.WriteXArray(Arr: Pointer; Len, _size: Integer);
var
    NewPoint, p: Pointer;
begin
    GetXMem(Len * _size + 8);
    p := GetPoint;
    WriteXByteP(p, Len);
    Move(Arr^, p^, Len * _size);
    Inc(Longword(p), Len * _size);
    CutSize(p);
end;

var
globXGrid:boolean;
  // callback to fill image block from bgra block
procedure SetBitmap32bitBlock(const Handle: pointer; var BGRABlock: TBGRABlock; const X, Y: integer);
var
  Bitmap: TBitmap;
  Src, Dest: PBGRA;
  i, j, Width, Height: integer;
  Grid: Byte;
  Bgrid, Tgrid: Boolean;
  alfa, beta: Real;
begin
  Bitmap := TBitmap(Handle);
  Width := Bitmap.Width;
  Height := Bitmap.Height;


  Bgrid := false;
  Dest := nil;
  Src := @BGRABlock[0];


  Bgrid :=
        ((X - X mod 8) mod 16 = 0)
        xor
        ((Y - Y mod 8) mod 16 = 0);

  if not Bgrid then grid := 192 else grid := 255;

  for j := Y to Y+3 do
  begin
    if (j < Height) then Dest := pointer(integer(Bitmap.ScanLine[j]) + sizeof(TBGRA)*X);

    for i := X to X+3 do
    begin
     if (i < Width) and (j < Height) then begin
     if globXGrid then
          begin

          Dest.R := (Src.A * (Src.R - Grid) shr 8) + Grid;
          Dest.G := (Src.A * (Src.G - Grid) shr 8) + Grid;
          Dest.B := (Src.A * (Src.B - Grid) shr 8) + Grid;

          end else
       Dest^ := Src^
       end;

      inc(Dest);
      inc(Src);
    end;

  end;
end;

procedure TContainer.ViewTga(ImageT32: TImage; XGrid: Boolean;
  XLabel: TLabel);
label
  f24;
var
  VBuf, VBuf2: Pointer;
  w, h, i, j, IName, ISize, CntrIndx: Integer;
  b: TBitmap;
  p0, p1: PARGBA;
  p2, p4: PARGB;
  p3: PAB;
  Grid, Bsize: Byte;
  Bgrid, Is24Bit: Boolean;
  alfa, beta: Real;
  offsetbyte, Imap, itype: Integer;
  isXBOX: Boolean;
  Dxt1: boolean;
  Header: TDxtHeader;
  Buffer: TMemoryStream;
  DxtBlocks: pointer;


begin
  VBuf := GetPoint;
  IName := TestByte128(VBuf); // Name
  isXBOX:=false;
  // DeleteObject(ImageT32.Picture.Bitmap.Handle);
  //  ImageT32.Picture.Bitmap.Create;

  b := TBitmap.Create;//ImageT32.Picture.Bitmap;
  b.canvas.Brush.Style := bsSolid;
  b.canvas.Brush.Color := clBlack;
  w := Word(VBuf^);   // Width
  b.Width := w;
  Inc(Longword(VBuf), 2);
  h := Word(VBuf^);      // Height
  Inc(Longword(VBuf), 2);
  b.Height := h;

  Imap := Byte(VBuf^);    // MapLevels
  Inc(Longword(VBuf), 2);
  //  Is24Bit:=(byte(VBuf^)=0);  ????
  Inc(Longword(VBuf), 2);    // Flags
  if WC then Inc(Longword(VBuf), 4);
  Bsize := Byte(VBuf^);
  Inc(Longword(VBuf), 4 * Bsize + 1);  // Strides
  Bsize := Byte(VBuf^);
  Inc(Longword(VBuf), 4 * Bsize + 1);  // Offsets
  itype:=  Byte(VBuf^); // Format

  { 0 := GL_RGB8; kImageFormat_R8G8B8
    1,2 := GL_RGBA8; kImageFormat_A8R8G8B8
    3 :=  kImageFormat_X8R8G8B8
    4 := GL_RGBA //GL_UNSIGNED_SHORT_1_5_5_5_REV   kImageFormat_X1R5G5B5 ?
    5 := kImageFormat_A1R5G5B5 ? kImageFormat_R5G6B5
    6 := GL_ALPHA kImageFormat_A8
    7 := XBox // kImageFormat_P8
    8 :=  kImageFormat_P4
    9 := GL_COMPRESSED_RGBA_S3TC_DXT1_EXT  kImageFormat_DXT1
    10 := GL_COMPRESSED_RGBA_S3TC_DXT3_EXT kImageFormat_DXT3
    11 := GL_COMPRESSED_RGBA_S3TC_DXT5_EXT
    27 := GL_RGB16F kImageFormat_NgcRGBA8 ?
    28,31 := GL_RGBA16F
    33,36 := GL_DEPTH24_STENCIL8
  }
  { Worms 3D Image Format
   	0 = kImageFormat_R8G8B8
	1 = kImageFormat_A8R8G8B8
	2 = kImageFormat_X8R8G8B8
	3 = kImageFormat_X1R5G5B5
	4 = kImageFormat_A1R5G5B5
	5 = kImageFormat_R5G6B5
	6 = kImageFormat_A8
	7 = kImageFormat_P8
	8 = kImageFormat_P4
	9 = kImageFormat_DXT1
	10 = kImageFormat_DXT3
	11 = kImageFormat_NgcRGBA8
	12 = kImageFormat_NgcRGB5A3
	13 = kImageFormat_NgcR5G6B5
	14 = kImageFormat_NgcIA8
	15 = kImageFormat_NgcIA4
	16 = kImageFormat_NgcI8
	17 = kImageFormat_NgcI4
	18 = kImageFormat_NgcCI12A4
	19 = kImageFormat_NgcCI8
	20 = kImageFormat_NgcCI4
	21 = kImageFormat_NgcCMPR
	22 = kImageFormat_NgcIndirect
	23 = kImageFormat_P2P8
	24 = kImageFormat_P2P4
	25 = kImageFormat_Linear
	26 = kImageFormat_Count
  }
  {   Worms Revolution ImageFormat
  	0 = kImageFormat_R8G8B8
	1 = kImageFormat_A8R8G8B8
	2 = kImageFormat_X8R8G8B8
	3 = kImageFormat_X1R5G5B5
	4 = kImageFormat_A1R5G5B5
	5 = kImageFormat_R5G6B5
	6 = kImageFormat_A8
	7 = kImageFormat_P8
	8 = kImageFormat_P4
	9 = kImageFormat_DXT1
	10 = kImageFormat_DXT3
	11 = kImageFormat_DXT5
	12 = kImageFormat_NgcRGBA8
	13 = kImageFormat_NgcRGB5A3
	14 = kImageFormat_NgcR5G6B5
	15 = kImageFormat_NgcIA8
	16 = kImageFormat_NgcIA4
	17 = kImageFormat_NgcI8
	18 = kImageFormat_NgcI4
	19 = kImageFormat_NgcCI12A4
	20 = kImageFormat_NgcCI8
	21 = kImageFormat_NgcCI4
	22 = kImageFormat_NgcCMPR
	23 = kImageFormat_NgcIndirect
	24 = kImageFormat_P2P8
	25 = kImageFormat_P2P4
	26 = kImageFormat_Linear
	27 = kImageFormat_F16RGB
	28 = kImageFormat_F16RGBA
	29 = kImageFormat_F32RGB
	30 = kImageFormat_F32RGBA
	31 = kImageFormat_F16RG
	32 = kImageFormat_D16
	33 = kImageFormat_D24
	34 = kImageFormat_D32
	35 = kImageFormat_FD32
	36 = kImageFormat_D24S8
	37 = kImageFormat_A8R8G8B8_SCE
	38 = kImageFormat_X8R8G8B8_LE
	39 = kImageFormat_Count

        0 = kCompressionOpNone
	1 = kCompressionOpUseBest
	2 = kCompressionOpForceDXT1
	3 = kCompressionOpForceDXT3
	4 = kCompressionOpForceDXT5

}
  Dxt1 := false;                    
  case itype of
  7: begin
    isXBOX := true;
  end;
  9,10,11: begin
    if not W3D then Inc(Longword(VBuf), 5);    //Compression //Modifiable
    Dxt1:=true;
  end;
  end;
  Is24Bit := (itype = 0);
  Inc(Longword(VBuf), 4);
  //  ImageReady:=ImageReady and(typeimage=1);

  ISize := TestByte128(VBuf);  // Data
  VBuf2 := VBuf;
  Inc(Longword(VBuf2), ISize);
  CntrIndx := TestByte128(VBuf2); //Palette

  if Dxt1 then
  begin
    Buffer := TMemoryStream.Create;
    Dxt1 := itype=9; //(Header.dwFourCC = 'DXT1');
    Buffer.WriteBuffer(VBuf^,ISize);
    DxtBlocks := Buffer.Memory;
    DxtImageAlpha(DxtBlocks, Dxt1, w, h);

    // Flip
    CrystalDXT.DxtImageFlip(DxtBlocks, Dxt1, w, h);
    // Decompress
    try
      b.PixelFormat := pf32bit;
      globXGrid:=XGrid;
      DxtImageDecompress(DxtBlocks, Dxt1, w, h,
                         pointer(b), SetBitmap32bitBlock);
    except
      FreeAndNil(b);
    end;
    Buffer.Free;
    Xbit := 32;
  end
  else
  begin
 // if not isXBOX then
//  begin
    if not Is24Bit then
    begin
      b.PixelFormat := pf32bit;
      //  VBuf:=pointer(Longword(Buf)+offsetbyte);
      for j := 0 to h - 1 do 
      begin
        p0 := b.scanline[h - 1 - j];
        p1 := Pointer(Longword(VBuf) + j * w * 4);
        for i := 0 to w - 1 do
        begin
          p0[i] := p1[i];
          if XGrid then
          begin
          Bgrid:=
                ((i - i mod 8) mod 16 = 0)
                xor
                ((j - j mod 8) mod 16 = 0);
          if not Bgrid then grid := 192 else grid := 255;

          p0[i].B := (p1[i].A * (p1[i].R - Grid) shr 8) + Grid;
          p0[i].G := (p1[i].A * (p1[i].G - Grid) shr 8) + Grid;
          p0[i].R := (p1[i].A * (p1[i].B - Grid) shr 8) + Grid;

          end
          else
          begin
            p0[i].b := p1[i].r;
            p0[i].r := p1[i].b;
          end;
        end;
      end;
      Xbit := 32;
    end
    else

    begin
      b.PixelFormat := pf24bit;
      //   VBuf:=pointer(Longword(Buf)+offsetbyte);
      for j := 0 to h - 1 do
      begin
        Pointer(p2) := Pointer(b.scanline[h - 1 - j]);
        p4 := Pointer(Longword(VBuf) + j * w * 3);
        for i := 0 to w - 1 do 
        begin
          p2[i] := p4[i];
          p2[i].b := p4[i].r;
          p2[i].r := p4[i].b;
        end;
      end;
      Xbit := 24;
    end;
  end;
 { end
  else
  begin
    b.PixelFormat := pf32bit;
    p1    := Pointer(Longword(CntrArr[CntrIndx].point) + 11);
    Bgrid := false;
    for j := 0 to h - 1 do
    begin
      if (j mod 8 = 0) then 
        Bgrid := not Bgrid;
      Tgrid := Bgrid;
      p0 := b.scanline[h - 1 - j]; 
      p3 := Pointer(Longword(VBuf) + j * w * 1);
      for i := 0 to w - 1 do 
      begin
        p0[i] := p1[p3[i]];
        if XGrid then 
        begin
          alfa := (p1[p3[i]].a / 256);
          beta := 1 - alfa;
          if (i mod 8 = 0) then 
            Bgrid := not Bgrid;
          if Bgrid then
            grid := 192 
          else 
            grid := 255;
          p0[i].b := Round(p1[p3[i]].b * alfa + Grid * beta);
          p0[i].g := Round(p1[p3[i]].g * alfa + Grid * beta);
          p0[i].r := Round(p1[p3[i]].r * alfa + Grid * beta);
        end
        else 
        begin
          //  p0[i].b:=p1[p3[i]].r;
          //   p0[i].r:=p1[p3[i]].b;
        end;
      end;
      Bgrid := Tgrid;
    end;

    Xbit := 8;
  end; }
  ImageT32.Picture.Bitmap.Assign(b);
  B.Free;
  XLabel.Caption :=
    Format('XImage [%d] - %dx%dx%dbit%sMaps:%d Size:%d',
    [Index, w, h, Xbit, #13#10, Imap, ISize]);
end;

procedure TContainer.SaveTGA(Name: string; Image32: TImage; XLabel: TLabel);
var
  VirtualBufer: TMemoryStream;
  tga: TgaHead;
begin
  ViewTga(Image32, false, XLabel);
  VirtualBufer := TMemoryStream.Create;
  tga.zero := 0;
  tga.zero2 := 0;
  tga.zero3 := 0;
  tga.typeTGA := 2;
  tga.Width := Image32.Width;
  tga.Height := Image32.Height;
  tga.ColorBit := Xbit;
  VirtualBufer.Write(tga, SizeOf(tga) - 2);
  VirtualBufer.Write(Image32.Picture.Bitmap.scanline[tga.Height - 1]^,
    tga.Height * tga.Width * (tga.ColorBit div 8));
  VirtualBufer.SaveToFile(Name);
  VirtualBufer.Free;
end;



function TContainer.ImportXImage(Name: string): Boolean;
label
  ExitP;
var
  TGABuf, VBuf: Pointer;
  Iname, W, h, NumMaps: Integer;
  TgaH: TgaHead;

    p0: PARGB;
    p1: PARGBA;
    VirtualBufer: TMemoryStream;
    nbyte: Byte;
    MipXImage, RGBImage: Pointer;
    Maps, NMaps, Itype, i, j, wSize, Alpha, Compon, FullSize,
    Width, Height, offset: Integer;
  const
    zero: Integer = 0;

  function LoadTgaToMemeory(FileName: string): Pointer;
  var
    iFileHandle, iFileLength: Integer;
  begin
    Result:= nil;
    if FileExists(FileName) then
    begin
      iFileHandle := FileOpen(FileName, fmOpenRead);
      if iFileHandle > 0 then
      begin
        iFileLength := FileSeek(iFileHandle, 0, 2);
        FileSeek(iFileHandle, 0, 0);
        Result := AllocMem(iFileLength + 1);
        FileRead(iFileHandle, Result^, iFileLength);
        FileClose(iFileHandle);
      end;
    end
  end;

  procedure GetMipmap(var MipXImage: Pointer; RGBImage: Pointer;
    const TgaH: TgaHead; Width, Height, Compon: Integer);
  var 
    IFormat: Integer;
  begin
    IFormat := GL_RGBA;
    if Compon = 3 then
      IFormat := GL_RGB;
    if (TgaH.Width <> Width) and (TgaH.Height <> Height) then
      gluScaleImage(IFormat, TgaH.Width, TgaH.Height, GL_UNSIGNED_BYTE,
        RGBImage,
        Width, Height, GL_UNSIGNED_BYTE, MipXImage)
    else
      Move(RGBImage^, MipXImage^, TgaH.Width * TgaH.Height * Compon);
  end;


{00 00 00 01 80 00 80 00
01 00 00 00 01 80 01 00
00 01 00 00 00 00 00 00
00 00 80 80 03     }
  {}
begin
  Result := false;
  TGABuf := LoadTgaToMemeory(Name);
  if TGABuf = nil then
  begin
    MessageBox(But.Handle,
      PChar(Format('Can not open %s!!!', [Name])),
      PChar('Error'), MB_OK);
    goto ExitP;
  end;
  Move(TGABuf^, TgaH, SizeOf(tgaH) - 2);
  VBuf := GetPoint;
  IName := TestByte128(VBuf);
  w := Word(VBuf^);
  Inc(Longword(VBuf), 2);
  h := Word(VBuf^);
  Inc(Longword(VBuf), 2);
  NumMaps := Byte(VBuf^);
  Inc(Longword(VBuf), 2);
  if Word(VBuf^) > 0 then
    alpha := 32
  else 
    alpha := 24;

  if (TgaH.Width <> w) or (TgaH.Height <> h) or (tgaH.ColorBit <> alpha) then
    if MessageBox(But.Handle,
      PChar(Format('You sure replace Image %dx%dx%d to %dx%dx%d?',
      [w, h, alpha, TgaH.Width, TgaH.Height, tgaH.ColorBit])),
      PChar('Warning!!!'), MB_YESNO) = idNo then
      goto ExitP;

  if (Frac(log2(TgaH.Width)) <> 0) or (Frac(log2(TgaH.Height)) <> 0) then
  begin
    MessageBox(But.Handle,
      PChar(Format('Bad size %dx%d!!!', [TgaH.Width, TgaH.Height])),
      PChar('Error'), MB_OK);
    goto ExitP;
  end;

//  Result := MakeXImage(TGABuf, TgaH, Iname, NumMaps);

    VirtualBufer := TMemoryStream.Create;
    VirtualBufer.Write(zero, 3);
    WriteXByte(VirtualBufer, iName);//?
    VirtualBufer.Write(TgaH.Width, 2);
    VirtualBufer.Write(TgaH.Height, 2);
    if NumMaps = 1 then
      NMaps := 1
    else
    begin
      Maps  := Max(TgaH.Width, TgaH.Height);
      NMaps := Round(Log2(Maps)) + 1;
    end;
    VirtualBufer.Write(NMaps, 2);
    Itype := 0; 
    Compon := 3;
    Alpha := 0;
    if TgaH.ColorBit = 32 then
    begin
      Alpha  := 1;
      Itype  := 2;
      Compon := 4;
    end;

    //    ConvertRGBtoBGR
    RGBImage := Pointer(Longword(TGABuf) + 18);

    if Alpha = 0 then
      for j := 0 to TgaH.Height - 1 do
      begin
        p0 := Pointer(Longword(RGBImage) + j * TgaH.Width * Compon);
        for i := 0 to TgaH.Width - 1 do
        begin
          nbyte := p0[i].b;
          p0[i].b := p0[i].r;
          p0[i].r := nbyte;
        end;
      end
    else
      for j := 0 to TgaH.Height - 1 do
      begin
        p1 := Pointer(Longword(RGBImage) + j * TgaH.Width * Compon);
        for i := 0 to TgaH.Width - 1 do
        begin
          nbyte := p1[i].b;
          p1[i].b := p1[i].r;
          p1[i].r := nbyte;
        end;
      end;

    VirtualBufer.Write(Itype, 2);
    VirtualBufer.Write(NMaps, 1);
    Width := TgaH.Width;
    for i := 0 to NMaps - 1 do
    begin
      wSize := Compon * Width;
      VirtualBufer.Write(wSize, 4);
      Width := Width div 2;
      // if Width = 0 then Break;
    end;
    VirtualBufer.Write(NMaps, 1);
    offset := 0;
    Width := TgaH.Width;
    Height := TgaH.Height;
    for i := 0 to NMaps - 1 do
    begin
      VirtualBufer.Write(Offset, 4);
      Offset := offset + Compon * Width * Height;
      Width  := Width div 2;
      Height := Height div 2;
      if Height = 0 then
        Height := 1;
      //   If Width=0 then break;
    end;

    VirtualBufer.Write(Alpha, 4);
    FullSize := Offset;
    WriteXByte(VirtualBufer, FullSize);
    Width := TgaH.Width;
    Height := TgaH.Height;
    MipXImage := AllocMem(Width * Height * Compon);
    for i := 0 to NMaps - 1 do
    begin
      if (Width=0) then Width:=1;
      if (Height=0) then Height:=1;
      GetMipmap(MipXImage, RGBImage, TgaH, Width, Height, Compon);
      VirtualBufer.Write(MipXImage^, Width * Height * Compon);
      if ((Width = 1) and (Height = 1)) then
        Break;
      Width  := Width div 2;
      Height := Height div 2;
    end;
    VirtualBufer.Write(zero, 1);
    FreeMem(MipXImage);

    WriteBuf(VirtualBufer);
    VirtualBufer.Free;
    Result:=true;


  ExitP:
  FreeMem(TGABuf);
end;

function TContainer.DelNoClone(BaseCntr: TContainer):Integer;
var i:integer;
begin
 // помечаем все конейнеры и их детей на удаление
 ToDelete;
 // пробегаемся по дереву предка, находя всех клонов, кроме выделеного
 BaseCntr.NoDelete(self);
 // удаляем все уникальные контейнеры ?
 Result:=Index;
// Del:=false; //?
end;

procedure TContainer.ToDelete;
var i:integer;
begin
 for i:=0 to Length(Childs)-1 do
   if Childs[i]<>nil then Childs[i].ToDelete;
 Del:=true;
end;

procedure TContainer.NoDelete(DelCntr: TContainer);
var i:integer;
begin
if self=DelCntr then exit;
 for i:=0 to Length(Childs)-1 do
   if Childs[i]<>nil then Childs[i].NoDelete(DelCntr);
 Del:=false;
end;

procedure TContainer.StripSetToTri;
var
p2,p:Pointer;
SizeBox:TBox;
  IndFace:IFace;
  Face: AFace;
  i,j, FaceNum, Num: Integer;
FaceCntr, VertexCntr, NormalCntr, ColorCntr, TextureCntr, WeightCntr: Integer;
Val:integer;
begin

  p2 := GetPoint;
    // get Faces
  Inc(Longword(p2));
  Inc(Longword(p2),2);
  FaceCntr := TestByte128(p2);   //5  XIndexSet
  Inc(Longword(p2), 8);
  VertexCntr := TestByte128(p2);
  NormalCntr := TestByte128(p2);
  ColorCntr := TestByte128(p2);
  TextureCntr := TestByte128(p2);
  WeightCntr  := TestByte128(p2);
  Move(p2^, SizeBox, 2 * 12);

  p2 := CntrArr[FaceCntr].GetPoint;
  FaceNum      := TestByte128(p2);
  SetLength(IndFace,FaceNum);
  Move(p2^, IndFace[0], FaceNum*2);

  Face:=TMesh.FaceFromStrip(IndFace);  // Gen

  Num := Length(Face);
  CntrArr[FaceCntr].GetXMem(Num * 6 + 8);
  p := CntrArr[FaceCntr].GetPoint;
  WriteXByteP(p, Num * 3);
  for j := 0 to Num - 1 do
  begin
    Move(Face[j], p^, 6);
    Inc(Longword(p), 6);
  end;
  CntrArr[FaceCntr].CutSize(p);
// запись
  GetXMem(Size+8);
  val:=1;
  Move(val, Point^, 1);
  p2 := GetPoint;

  WriteXByteP(p2, FaceCntr); //5  XIndexSet
  Inc(Longword(p2), 4);
  Move(Num, p2^, 2);
  Inc(Longword(p2), 4);

  WriteXByteP(p2, VertexCntr);
  WriteXByteP(p2, NormalCntr);
  WriteXByteP(p2, ColorCntr);
  WriteXByteP(p2, TextureCntr);
  WriteXByteP(p2, WeightCntr);
  Move(SizeBox, p2^, 2 * 12);
  Inc(Longword(p2), 2*12);
  Inc(Longword(p2), 4);
  CutSize(p2);
  XType:=XIndexedTriangleSet;
end;

procedure TContainer.TriToStripSet;
var
p2,p:Pointer;
SizeBox:TBox;
  IndFace:IFace;
  Face: AFace;
  i,j, FaceNum, Num: Integer;
FaceCntr, VertexCntr, NormalCntr, ColorCntr, TextureCntr, WeightCntr: Integer;
Val:integer;
begin

  p2    := GetPoint;
  FaceCntr := TestByte128(p2);   //5
  Inc(Longword(p2), 4);
  Inc(Longword(p2), 4);
  VertexCntr := TestByte128(p2);
  NormalCntr := TestByte128(p2);
  ColorCntr := TestByte128(p2);
  TextureCntr := TestByte128(p2);
  WeightCntr  := TestByte128(p2);
  Move(p2^, SizeBox, 2 * 12);

  p2 := CntrArr[FaceCntr].GetPoint;
  FaceNum := TestByte128(p2) div 3;
  SetLength(Face, FaceNum);
  for j := 0 to FaceNum - 1 do
  begin
      Move(p2^, Face[j], 6);
      Inc(Longword(p2), 6);
  end;

  IndFace:=TMesh.FaceToStrip(Face);  // Gen

  Num := Length(IndFace);
  CntrArr[FaceCntr].GetXMem(Num * 2 + 8);
  p := CntrArr[FaceCntr].GetPoint;
  WriteXByteP(p, Num);
  Move(IndFace[0], p^, Num*2);
  Inc(Longword(p), Num*2);
  CntrArr[FaceCntr].CutSize(p);
 // запись
  GetXMem(Size+4);
  val:=1;
  Move(val, Point^, 1);
  p2 := GetPoint;
  Move(val, p2^, 1);   Inc(Longword(p2), 1);
  Move(Num, p2^, 2);   Inc(Longword(p2), 2);
  WriteXByteP(p2, FaceCntr); //5  XIndexSet
  Inc(Longword(p2), 4);
  val:=1;
  Move(val, p2^, 4);   Inc(Longword(p2), 4);

  WriteXByteP(p2, VertexCntr);
  WriteXByteP(p2, NormalCntr);
  WriteXByteP(p2, ColorCntr);
  WriteXByteP(p2, TextureCntr);
  WriteXByteP(p2, WeightCntr);
  Move(SizeBox, p2^, 2 * 12);
  Inc(Longword(p2), 2*12);
  Inc(Longword(p2), 4);
  CutSize(p2);

  XType:=XIndexedTriangleStripSet;  
end;

procedure TContainer.FillColor(Num: Integer; Color: Byte);
var
Color4u :AUColor;
FillColor4U:TUColor;
i:integer;
begin
      SetLength(Color4u,Num);
        FillColor4U[0]:=Color;
        FillColor4U[1]:=Color;
        FillColor4U[2]:=Color;
        FillColor4U[3]:=255;
      for i:=0 to Num-1 do
        Color4u[i]:=FillColor4U;
      WriteXArray(@Color4u[0], Num, 4);
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
 if  AnsiStrComp(XomHandle.TypesInfo[i].Name,PCharXTypes[XType])=0 then begin
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
    Smallint(Pointer((LStrings.IndexOf(s)-1) * 4 + Longword(p))^) := Smallint(Len);
 //   Smallint(Pointer(i * 4 + Longword(p))^) := Smallint(Len);  // заполняем длинны в индексы
    p3 := Pointer(Longword(p4) + Len);
    s2:= Utf8Encode(s);
   // s2:=s;
    p1  := PChar(s2);
    Move(p1^, p3^, Length(s2));// копируем текст в пямять
    Len := Len + Length(s2) + 1;
  end;
  SortStrings.Free;
  Smallint(Pointer(Longword(p) - 12)^) := Smallint(j + 1); // пишем количество слов
  Smallint(Pointer(Longword(p) - 8)^) := Smallint(Len);  // длинна слов
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
        if (XCntr.Childs[1].Xtype = XAnimClipLibrary) and (But.AnimBox<>nil) then
        begin
        AnimClips:=nil;
        CurAnimClip:=nil;
        AnimClips:=TAnimClips.Create;
        But.AnimBox.Clear;
        AnimReady := (AnimClips.BuildAnim(XCntr.Childs[1],self) > 0);

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

      if (XCntr.Name = 'Diffuse') or (XCntr.Name = 'Texture0')or
      (XCntr.Name = 'Texture1') or
       (XCntr.Name = 'Skygrad') or
      (XCntr.Name = 'SpriteTexture') then
      begin
      if Mesh<>nil then
      Mesh.Attribute.ZBuffer:=true;
   //   :=  XCntr.Name<>'Texture0';   // not work
      SelectClassTree(XCntr.Childs[0], Mesh);
      end;
    end;
    XTexFont,XPsTexFont:
    begin
       k:=Length(XCntr.Childs);
       for x:=0 to k-1 do
                SelectClassTree(XCntr.Childs[x], Mesh);
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
               Mesh3D.GetTextureGL(XCntr.Childs[0].point)
        else Mesh.Attribute.ZBuffer := Mesh3D.GetTextureGL(XCntr.Childs[0].point);
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
      k := Length(XCntr.Childs);
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
    XGroup:
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
              if WUM or WR then  Inc(Longword(p2));
              Inc(Longword(p2), 1);// 0
              k3 := TestByte128(p2);
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
              // PreInfinity XEnum
              // PostInfinity  XEnum
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
            SentryGunWeaponPropertiesContai:
            begin
            begin
             s:='SentryGunWeapon';
            end;
            end;
            FlyingPayloadWeaponPropertiesCo:
            begin
             s:='FlyingPayloadWeapon';
            end;
            JumpingPayloadWeaponPropertiesC:
            begin
             s:='JumpingPayloadWeapon';
            end;
            HomingPayloadWeaponPropertiesCo:
            begin
             s:='HommingPayloadWeapon';
            end;
            PayloadWeaponPropertiesContaine:
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
              p2 := Pointer(Longword(p2) + 4);
              s := GetStr128(p2);
              s1 := s1 + Format('%s - %.2f ', [s, ToTime(Longword(p2^))]);
              p2 := Pointer(Longword(p2) + 4);
              s := GetStr128(p2);
              s1 := s1 + Format('%s - %.2f ', [s, ToTime(Longword(p2^))]);
              s := s1;
              //         sTemp:= sTemp+s+nVn;
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
            XIndexSet:
            begin
              s := Format('[%d] ', [k]);
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
                k:= Longword(p2^);Inc(Longword(p2), 4);
                Inc(Longword(p2),k);
                Inc(Longword(p2), 4); //0
                Inc(Longword(p2), 4);//1
                Inc(Longword(p2), 4);//2
                IsCtnr := false;
            end;
            XSampleData:
            begin
                p2 := p;
                TestByte128(p2); //01:Sound ID Key
                TestByte128(p2);//02:Sound Direct Key
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

      vi:Integer;
      vu:Smallint;
      vf:Single;
      vb:boolean;
      vs,vs0:string;
      vc:Cardinal;
      vby:Shortint;
      vl:TStringList;

    function GetXName(_cntr:TContainer):String;
    begin
      if _cntr.Name<>'' then
      result:=Format('%s [%d] "%s"', [PCharXTypes[_cntr.Xtype], _cntr.Index, _cntr.Name])
      else
      result:=Format('%s [%d]', [PCharXTypes[_cntr.Xtype],_cntr.Index]);
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
        procedure AddValNode(str:string);
        begin
        if StrGet then begin
                StrVal:=GetStr128(p2,XCntr);
                vs0:=StrVal; end;
        TmpNode:=TreeView.Items.AddChild(TN,Format('%s = %s',[StrVal,str]));
        end;
      begin
      CntrVal:=TCntrVal.Create;

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
      XListByte:    begin
                vby:=byte(p2^);  Inc(Longword(p2));
                CntrVal.XList:=vl;
                if vby =-1 then
                        AddValNode('NONE')
                else
                        AddValNode(vl.Strings[vby]);
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
      end;

     function AddVal(StrVal:String;XT:XValTypes;StrGet:Boolean=false):TTreeNode;
     begin
       Result:=AddChildF(TreeNode,StrVal,XT,StrGet);
     end;

  procedure AddSetVal(Name: string;VType:XValTypes);
  var i:integer;
  begin
    k := TestByte128(p2);
    if k>0 then begin
    TempNode := TreeView.Items.AddChild(TreeNode,
          Format('%s [%d]', [Name,k]));
    for i := 1 to k do
        Result:=AddChildF(TempNode,Name,VType,false);
    end;
  end;



    procedure AddSizeBox;
    begin
      TempNode := TreeView.Items.AddChild(TreeNode, 'SizeBox');
      px := Longword(p2); Inc(Longword(p2), 4*3*2);
      TreeView.Items.AddChild(TempNode,
        Format('MinVertex = <%.2f; %.2f; %.2f>',
        [Single(Pointer(px)^), Single(Pointer(px + 4)^), Single(Pointer(px + 8)^)]));
      Inc(px, 12);
      TreeView.Items.AddChild(TempNode,
        Format('MaxVertex = <%.2f; %.2f; %.2f>',
        [Single(Pointer(px)^), Single(Pointer(px + 4)^), Single(Pointer(px + 8)^)]));
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
      vc:=Longword(p2);  Inc(Longword(p2), 4*4+4);
      //Bounds
      //BoundMode
      //Name
      s:=Format(' [%f; %f; %f; %f]',
                [Single(Pointer(vc)^), Single(Pointer(vc + 4)^), Single(Pointer(vc + 8)^),
                Single(Pointer(vc + 12)^)]);
      AddVal('Name',XString);
      XCntr.Name:=vs;
      TreeNode.Text:=GetXName(XCntr)+s;
     end;
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
      AddVal('WeaponType',XInt);//
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

    procedure AddTagTimeCritical;
    begin
      AddVal('Tag',XString);
      AddVal('Time',XInt);
      AddVal('Critical',XBool);
    end;

    procedure TextBoxRead;
    begin
      AddVal('ResourceName',XString);
      AddVal('TextGameDataId',XString);
      AddVal('TextColourResource',XString);
      AddVal('BorderColour',XInt);
      AddVal('Justification',XInt);
      AddVal('BorderSize',XFloat);
      AddVal('AutoScroll',XBool);
      AddVal('AutoScale',XBool);
      AddVal('Colour',XInt);
      AddVal('Animate',XString);
    end;

    procedure ListBoxColumnRead;
    begin
      AddVal('ColumnName',XString);
      XCntr.Name:=vs;
      TreeNode.Text:=GetXName(XCntr);
      AddVal('WidthPercent',XFloat);
      AddVal('Ratio',XFloat);
      AddVal('Justification',XInt);
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
      AddVal('BorderColour',XInt);
      AddVal('SliderAlwaysOn',XBool);
      AddVal('SliderTabExpand',XBool);
      AddVal('BackGroundType',XInt);
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
      AddVal('BorderColour',XInt);
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
      k := TestByte128(p2); //1  number
      // AddClassTree(k3,TreeView,TempNode);
      k3 := GetIdx128(p2,XCntr); //2  link
      AddClassTree(XCntr.AddChild(k3), TreeView, TreeNode);
      if WR then  Inc(Longword(p2), 2);
      k := Word(p2^);       // size
      if WR then begin
              Inc(Longword(p2), 23);
      end else
      Inc(Longword(p2), 4); // 1

      TempNode := TreeView.Items.AddChild(TreeNode,
        Format(' #%d', [k]));
      for x := 1 to k do
      begin
        s1 := Format('[%d %d %d] ',
          [Word(p2^), Word(Pointer(Longword(p2) + 2)^), Word(Pointer(Longword(p2) + 4)^)]);
        Inc(Longword(p2), 6); // num, wchar, wchar
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
      if WUM then AddVal('AssistedShotLevel',XString);
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
      AddVal('Lock',XBool);
      AddVal('LockKey',XString);
      AddVal('Type',XInt);
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
      AddVal('ControlX',XInt);
      AddVal('ControlY',XInt);
      AddVal('LastLogicalUpdate',XInt);
      AddVal('SupportFrame',XUInt);
      AddVal('SupportVoxel',XUInt);
      AddVal('WeaponAngle',XFloat);
      AddVal('WeaponFuse',XInt);
      AddVal('WeaponIsBounceMax',XBool);
      AddVal('WeaponHerd',XInt);   //
      AddVal('TeamIndex',XUInt);
      AddVal('PositionInTeam',XUInt);
      AddVal('PhysicsOverride',XUInt);
      AddVal('Flags',XInt);
      AddVal('PhysicsState',XInt);
      AddVal('WeaponIndex',XInt);
      AddVal('InitialEnergy',XInt);
      AddVal('Energy',XUint);   //    4    2
      AddVal('CPUFixedWeapon',XByte);  //2  1
      AddVal('CPUActionRadius',XUint);  //2  2
      AddVal('ArtilleryMode',XBool);   //1   1
      AddVal('PoisonRate',XByte);       //4  2
      AddVal('PendingPoison',XInt);     //4  2
      AddVal('PlaceWormAtPosition',XBool); // 1
      AddVal('PoolDamagePending', XInt);  //   4
      AddVal('SfxBankName',XString);
      AddVal('Spawn',XString);
      AddVal('IsParachuteSpawn',XBool);
      AddVal('IsAllowedToTakeTurn',XBool);
      AddVal('GunWobblePitch',XInt);
      AddVal('GunWobbleYaw',XInt);
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
      AddVal('WeaponIndex',XInt);
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
      if WUM then AddVal('?Player',XByte);
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
      AddVal('WormpotSuperWeapon',XInt);
      AddVal('DefaultCameraDistance',XInt);
      end;
    end;
    WeaponInventory,WeaponDelays:
    begin
    AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      if W3D then begin
	AddVal('Bazooka',XByte);
	AddVal('Grenade',XByte);
	AddVal('ClusterGrenade',XByte);
        AddVal('Airstrike',XByte);
        AddVal('Dynamite',XByte);
        AddVal('HolyHandGrenade',XByte);
        AddVal('BananaBomb',XByte);
        AddVal('Landmine',XByte);
        AddVal('Shotgun',XByte);
        AddVal('Uzi',XByte);
        AddVal('BaseballBat',XByte);
        AddVal('Prod',XByte);
        AddVal('VikingAxe',XByte);
        AddVal('FirePunch',XByte);
        AddVal('HomingMissile',XByte);
        AddVal('Mortar',XByte);
        AddVal('HomingPigeon',XByte);
        AddVal('Earthquake',XByte);
        AddVal('Sheep',XByte);
        AddVal('MineStrike',XByte);
        AddVal('PetrolBomb',XByte);
        AddVal('GasCanister',XByte);
        AddVal('SheepStrike',XByte);
        AddVal('MadCow',XByte);
     	AddVal('OldWoman',XByte);
        AddVal('ConcreteDonkey',XByte);
	AddVal('NuclearBomb',XByte);
        AddVal('Armageddon',XByte);
 	AddVal('MagicBullet',XByte);
   	AddVal('SuperSheep',XByte);
        AddVal('Girder',XByte);
        AddVal('BridgeKit',XByte);
        AddVal('NinjaRope',XByte);
        AddVal('Parachute',XByte);
        AddVal('ScalesOfJustice',XByte);
        AddVal('LowGravity',XByte);
        AddVal('QuickWalk',XByte);
        AddVal('LaserSight',XByte);
        AddVal('Teleport',XByte);
        AddVal('Jetpack',XByte);
        AddVal('SkipGo',XByte);
        AddVal('Surrender',XByte);
        AddVal('ChangeWorm',XByte);
        AddVal('Freeze',XByte);
        AddVal('Blowpipe',XByte);
        AddVal('LotteryStrike',XByte);
        AddVal('DoctorsStrike',XByte);
        AddVal('MegaMine',XByte);
        AddVal('StickyBomb',XByte);
	AddVal('Binoculars',XByte);
	AddVal('Redbull',XByte);
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
      AddVal('Weapon',XInt);
      AddVal('Crates',XInt);
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
	AddVal('CameraStartsInLand',XBool);
   end;
   OccludingCameraPropertiesContai:
   begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      CameraPropRead;
   end;
   ChaseCameraPropertiesContainer:
   begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('CutOnRetreat',XBool);
      CameraPropRead;
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
   end;
   LensFlareElementContainer:
   begin
        AddNode(GetXName(XCntr));
        p2 := XCntr.GetPoint;
        AddVal('Scale',XFloat);
        AddVal('Size',XFloat);
        AddVal('FadeIn',XFloat);
        AddVal('Color',XColor);
        AddVal('Type',XInt);
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
      AddVal('byte2',Xbyte);
      AddVal('float1',XFloat);
      AddVal('float2',XFloat);
      AddVal('Frequency',XInt);
      AddVal('Priority',XInt);
      AddVal('float3',XFloat);
      AddVal('float4',XFloat);
      AddVal('float5',XFloat);
      AddVal('int3',XInt);
      AddVal('int4',XInt);
      AddVal('int5',XInt);
      AddVal('int6',XInt);
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
      AddVal('LanguageBank',XByte);
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
      AddVal('PreviewType',XUint);
      //PreviewType 02  00
      AddVal('RandomRoot',XUint);
      end;
      //RandomRoot   00  00
      AddVal('LandCost',XInt);
      //LandCost   01 00 00 00
      AddVal('Complexity',XByte);
      //Complexity  00  
      AddVal('EmitterCost',XInt);
      //EmitterCost  01 0000 00
      AddVal('LumpType',XInt);
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
      px := TestByte128(p2); // номер версии
      s := Format(' Section #%d', [px]);
      TreeNode.Text := TreeNode.Text + s;
      for i:=0 to 7 do
        AddSetNode(XResourceDetails[i]);
    end;
    XContainerResourceDetails:
    begin
      AddNode('');
      p2 := XCntr.GetPoint;
      k3 := GetIdx128(p2,XCntr);
      AddVal('Name',XString);
      XCntr.Name:=vs;
      TreeNode.Text:=GetXName(XCntr);
      AddClassTree(XCntr.AddChild(k3), TreeView, TreeNode);
      k3 := TestByte128(p2);
      TreeView.Items.AddChild(TreeNode, Format('%d', [k3]));
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
    EFMV_WormLookAtEventContainer,
    EFMV_WormGestureAtEventContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('TargetCastMember',XByte);
      AddTagTimeCritical;
    end;
    EFMV_CreateBordersEventContainer,
    EFMV_DeleteBordersEventContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
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
      AddVal('Level_Type',XInt);
      AddVal('Lock',XString);
      AddVal('Theme_Type',XInt);
      AddVal('Preview_Type',XInt);
      AddVal('BonusTime',XInt);
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
      AddVal('LevelType',XInt);
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
      AddVal(s,XVector,true);
      XCntr.Name := vs0;
      TreeNode.Text:=GetXName(XCntr);
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
      AddVal(s,XColor,true);
      XCntr.Name := vs0;
      TreeNode.Text:=GetXName(XCntr);
    end;
    XFloatResourceDetails,XDataFloat:
    begin
      AddNode('');
      p2:=XCntr.GetPoint;
      AddVal(s,XFloat,true);
      XCntr.Name := vs0;
      TreeNode.Text:=GetXName(XCntr);
    end;
    XIntResourceDetails:
    begin
      AddNode('');
      p2:=XCntr.GetPoint;
      AddVal(s,XInt,true);
      XCntr.Name := vs0;
      TreeNode.Text:=GetXName(XCntr);
    end;
    XUintResourceDetails:
    begin
      AddNode('');
      p2:=XCntr.GetPoint;
      AddVal(s,XInt,true);
      XCntr.Name := vs0;
      TreeNode.Text:=GetXName(XCntr);
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
      AddVal(s,XString,true);
      XCntr.Name := vs0;
      TreeNode.Text:=GetXName(XCntr);
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
      AddVal('Gold',XString);
      AddVal('GoldTime',XInt);
      AddVal('Silver',XString);
      AddVal('SilverTime',XInt);
      AddVal('Bronze',XString);
      AddVal('BronzeTime',XInt);
    end;
    FlyingPayloadWeaponPropertiesCo:
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

      AddVal('SmallJumpHorizontalSpeed',XFloat);
      AddVal('SmallJumpMinVerticalSpeed',XFloat);
      AddVal('SmallJumpMaxVerticalSpeed',XFloat);
      AddVal('BigJumpHorizontalSpeed',XFloat);
      AddVal('BigJumpMinVerticalSpeed',XFloat);
      AddVal('BigJumpMaxVerticalSpeed',XFloat);
      AddVal('MaxDrop',XFloat);
      AddVal('ReturnProbability',XFloat);
      AddVal('MinTimeForSafeJump',XInt);
      PayloadWeapon(true);
    end;
    JumpingPayloadWeaponPropertiesC:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;

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
    HomingPayloadWeaponPropertiesCo:
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
    PayloadWeaponPropertiesContaine:
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
	AddVal('PrefUzi',XFloat);
	AddVal('PrefBaseballBat',XFloat);
	AddVal('PrefProd',XFloat);
	AddVal('PrefVikingAxe',XFloat);
	AddVal('PrefFirePunch',XFloat);
	AddVal('PrefHomingMissile',XFloat);
	AddVal('PrefMortar',XFloat);
	AddVal('PrefHomingPidgeon',XFloat);
	AddVal('PrefEarthquake',XFloat);
	AddVal('PrefSheep',XFloat);
	AddVal('PrefMineStrike',XFloat);
	AddVal('PrefPetrolBomb',XFloat);
	AddVal('PrefGasCanister',XFloat);
	AddVal('PrefSheepStrike',XFloat);
	AddVal('PrefMadCow',XFloat);
	AddVal('PrefOldWoman',XFloat);
	AddVal('PrefConcreteDonkey',XFloat);
	AddVal('PrefNuclearBomb',XFloat);
	AddVal('PrefArmageddon',XFloat);
	AddVal('PrefMagicBullet',XFloat);
	AddVal('PrefSuperSheep',XFloat);
	AddVal('PrefGirder',XFloat);
	AddVal('PrefBridgeKit',XFloat);
	AddVal('PrefNinjaRope',XFloat);
	AddVal('PrefParachute',XFloat);
	AddVal('PrefScalesOfJustice',XFloat);
	AddVal('PrefLowGravity',XFloat);
	AddVal('PrefQuickWalk',XFloat);
	AddVal('PrefLaserSight',XFloat);
	AddVal('PrefTeleport',XFloat);
	AddVal('PrefJetpack',XFloat);
	AddVal('PrefSkipGo',XFloat);
	AddVal('PrefSurrender',XFloat);
	AddVal('PrefChangeWorm',XFloat);
	AddVal('PrefFreeze',XFloat);
	AddVal('PrefBlowpipe',XFloat);
	AddVal('PrefLotteryStrike',XFloat);
	AddVal('PrefDoctorsStrike',XFloat);
	AddVal('PrefMegaMine',XFloat);
	AddVal('PrefStickyBomb',XFloat);
	AddVal('PrefBinoculars',XFloat);
	AddVal('PrefRedbull',XFloat);
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

      AddVal('SafeRadiusPadding?',XFloat);

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
      AddVal('MeleeType',XInt);
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
    SentryGunWeaponPropertiesContai:
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
    ParticleEmitterContainer:
    begin
      AddNode('XContainer::'+GetXName(XCntr));
      p2 := XCntr.GetPoint;

      AddVal('Comment',XString);
      AddVal('EmitterType',XInt);  // Enum
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
      AddVal('EmitterSoundFXVolume',XFloat);
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
      AddVal('ParticleCollisionWormType',XInt);
      AddSetVal('ParticleColor',XFColor);
      AddSetVal('ParticleColorBand',XFloat);
      AddVal('ParticleExpireShake',XBool);
      AddVal('ParticleExpireShakeLength',XFloat);
      AddVal('ParticleExpireShakeMagnitude',XUint);
      AddVal('ParticleIsAlternateAcceleration',XBool);
      AddVal('ParticleIsEffectedByWind',XBool);
      AddVal('ParticleIsSpiral',XBool);
      AddVal('ParticleIsUnderWaterEffect',XBool);
      AddVal('ParticleLandCollideType',XInt);
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
      AddVal('ParticleSizeVelocityDelayRandomise',XUint);
      end;
      AddVal('ParticleFinalSizeScale',XPoint);
      AddVal('ParticleFinalSizeScaleRandomise',XFloat);
      if WUM then begin
      AddVal('ParticleSizeFadeIn',XUint);
      AddVal('ParticleSizeFadeInRandomize',XUint);
      AddVal('ParticleSizeFadeInDelay',XUint);
      AddVal('ParticleSizeFadeInDelayRandomize',XUint);
      end;
      AddVal('ParticleRenderScene',XInt);
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
      AddVal('BorderColour',XInt);
      AddVal('SliderAlwaysOn',XBool);
      AddVal('SliderTabExpand',XBool);
      AddVal('BackGroundType',XInt);
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
      AddVal('BorderColour',XInt);
      AddVal('SquareButton',XBool);
      AddVal('BorderBehind',XBool);
      AddVal('MinOffset',XFloat);
      AddVal('MaxOffset',XFloat);
      AddVal('VolumeId',XString);
      AddVal('AudioData',XString);
      DescRead;
    end;
    LandscapeBoxDesc:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddVal('LumpFileId',XString);
      AddVal('HighlightedMessage',XString);
      AddVal('SelectedMessage',XString);
      AddVal('ChangedRenderState',XString);
      AddVal('BorderColour',XInt);
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
      AddVal('BorderColour',XInt);
      AddVal('HighlightedMessage',XString);
      AddVal('SelectedMessage',XString);
      DescRead;
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
      AddVal('TextPlacement',XInt);
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
      AddVal('BorderColour',XInt);
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
    ListBoxData:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddSetNode('Columns');
      AddSetVal('Messages',XString);
      AddVal('FontResource',XString);
      AddVal('FontSize',XFloat);
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
    ChatMessagesContainer:
    begin
      AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddSetVal('Sender',XUint);
      AddSetVal('Content',XUint);
      AddSetVal('SenderColour',XUint);
      AddSetVal('ContentColour',XUint);
      AddSetVal('Scope',XUint);
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
      AddVal('Medal',XInt);
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
          s1 := Format('%s.keys[%d] (%d;%d)', [StrList.Strings[k2], k, k3,k4]);
          TempNode2 := TreeView.Items.AddChild(TempNode0, s1);
         // TempNode2.Data:=XAnimKey;
          TempNode2.ImageIndex := 7;
          TempNode2.SelectedIndex := 7;
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
      Inc(Longword(p2), 4);
      AddVal('Matrix',XMatrix3);
    end;
    XOglTextureStage:
    begin
      AddNode('XTextureStage::'+GetXName(XCntr),16);
      p2 := XCntr.GetPoint;
       //Blend
       //BlendColor
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
    XOglTextureMap:
    begin
      AddNode('XTextureMap::'+GetXName(XCntr),16);
      p2 := XCntr.GetPoint;
      //Blend
      //BlendColor
      Inc(Longword(p2), 4);
      Inc(Longword(p2), 4 * 4);
      AddIdxNode;
      Inc(Longword(p2), 4);
      Inc(Longword(p2), 2);
      Inc(Longword(p2), 4 * 5);
      if not WR then
      AddIdxNode;
    end;
    XBlendModeGL:
    begin
      AddNode(GetXName(XCntr),18);
      p2 := XCntr.GetPoint;
      s := Format('Blend = [%d; %d]', [Longword(p2^),
        Longword(Pointer(Longword(p2) + 4)^)]);
      TreeView.Items.AddChild(TreeNode, s);
    end;
    XAlphaTest:
    begin
      AddNode(GetXName(XCntr),18);
      p2 := XCntr.GetPoint;
      AddVal('Enable',XBool);
      AddVal('CompareFunction',XInt);
      AddVal('RefValue',XFloat);
    end;
    XDepthTest:
    begin
      AddNode(GetXName(XCntr),18);
      p2 := XCntr.GetPoint;
      s := Format('Depth [%d; %d; %f]', [Longword(Pointer(Longword(p2))^),
        Longword(Pointer(Longword(p2) + 4)^), Single(Pointer(Longword(p2) + 9)^)]);
      TreeView.Items.AddChild(TreeNode, s);
    end;
    XCullFace:
    begin
      AddNode(GetXName(XCntr),18);
      p2 := XCntr.GetPoint;
      s := BoolToStr(Boolean(Longword(p2^)), true);
      TreeView.Items.AddChild(TreeNode, s);
    end;
    XLightingEnable:
    begin
      AddNode(GetXName(XCntr),18);
      p2 := XCntr.GetPoint;
      //Enable
      //TwoSided
      //LocalViewer
      //Normalize
      //AmbientColor
      k3 := TestByte128(p2);
      px := Longword(p2) + 6;
      s := Format('Light %s %d [%.2f; %.2f; %.2f; %.2f]',
        [BoolToStr(Boolean(k3), true), Longword(Pointer(Longword(p2) + 2)^),
        Single(Pointer(px)^), Single(Pointer(px + 4)^), Single(Pointer(px + 8)^),
        Single(Pointer(px + 12)^)]);
      TreeView.Items.AddChild(TreeNode, s);
    end;
    XZBufferWriteEnable:
    begin
      AddNode(GetXName(XCntr),18);
      p2 := XCntr.GetPoint;
      s := BoolToStr(Boolean(Byte(p2^)), true);
      TreeView.Items.AddChild(TreeNode, s);
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
      AddVal('DiffuseSource',XFloat);
      AddVal('AmbientSource',XFloat);
      AddVal('SpecularSource',XFloat);
      AddVal('EmissiveSource',XFloat);
      AddVal('Power',XFloat);
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
    XUniformWorldViewProjectionMatr,
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
      // UsageType XEnum
      // Dynamic XBool
    end;
    XPsTexFont:
    begin
      AddNode('');
      p2 := XCntr.GetPoint;
      k := TestByte128(p2);
      s := Format('UV0 = [%d]', [k]);
      for x := 1 to k do
      begin
        if Length(s) < 100 then
          s := s + Format(' <%.2f;%.2f>', [Single(p2^),
            Single(Pointer(Longword(p2) + 4)^)]);
        Inc(Longword(p2), 8);
      end;
      TreeView.Items.AddChild(TreeNode, s);
      k := TestByte128(p2);
      s := Format('UV1 = [%d]', [k]);
      for x := 1 to k do
      begin
        if Length(s) < 100 then
          s := s + Format(' <%.2f;%.2f>', [Single(p2^),
            Single(Pointer(Longword(p2) + 4)^)]);
        Inc(Longword(p2), 8);
      end;
      TreeView.Items.AddChild(TreeNode, s);
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
      k := TestByte128(p2);
      s := Format('UV0 = [%d]', [k]);
      for x := 1 to k do
      begin
        if Length(s) < 100 then
          s := s + Format(' <%.2f;%.2f>', [Single(p2^),
            Single(Pointer(Longword(p2) + 4)^)]);
        Inc(Longword(p2), 8);
      end;
      TreeView.Items.AddChild(TreeNode, s);
      k := TestByte128(p2);
      s := Format('UV1 = [%d]', [k]);
      for x := 1 to k do
      begin
        if Length(s) < 100 then
          s := s + Format(' <%.2f;%.2f>', [Single(p2^),
            Single(Pointer(Longword(p2) + 4)^)]);
        Inc(Longword(p2), 8);
      end;
      TreeView.Items.AddChild(TreeNode, s);
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
      AddSetNode('Attributes',18);
      AddSetNode('FontPages');
    //AsciiMap
    //CharacterMap
    end;
    XMultiTexFontPage:
    begin
     AddNode(GetXName(XCntr));
      p2 := XCntr.GetPoint;
      AddIdxNode;    //Texture
    //CharacterMap
    //CharCoords
    //CharSizes
    //CharKernLeft
    //CharKernRight
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
      Inc(Longword(p2), 4);
      AddIdxNode;
      AddIdxNode;
      Inc(Longword(p2), 5);
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
    XGroup:
    begin
      AddNode('',5);
      p2 := XCntr.GetPoint;
      AddIdxNode; // Matrix
      if WR then Inc(Longword(p2));
      AddSetNode('childs');
      AddDataName;
    end;
    XPalette:
      AddNode(GetXName(XCntr));
    XIndexSet:
      AddNode('XIndexArray::'+GetXName(XCntr));
    XCoord3fSet:
      AddNode('XVertexDataSet::XCoordSet::'+GetXName(XCntr));
    XNormal3fSet:
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
      p2:=XCntr.GetPoint;
      XCntr.Name := GetStr128(p2,XCntr);
      AddNode(GetXName(XCntr));
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
      vl:=StringListFromStrings(ListWFBuild);
      AddVal('BuildingType',XListByte);
      AddVal('NumFiringPlatformBricks',XByte);
    end;
    XFortsExportedData:
    begin
      AddNode(GetXName(XCntr));
        p2:=XCntr.GetPoint;
        if WF then begin
        vl:=StringListFromStrings(ListEpochs);
        AddVal('Epoch',XListByte); //1
        AddVal('FogNear',XFloat);
        AddVal('FogFar',XFloat);
        AddVal('FogType',XByte);

        vl:=StringListFromStrings(ListWFSky);
        AddVal('SkyBoxType',XListByte); // 1
        AddVal('SkyBoxPosition',XVector);
        vl:=StringListFromStrings(ListWFWater);
        AddVal('WaterType',XListByte);
        AddVal('WaterHeight',XFloat);
        vl:=StringListFromStrings(ListWFBuild);
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
                    AddChildF(ArrTree[x-1],'BPBuildingType',XListByte);
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
      AddSetVal('Attributes',XUint);
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
end;
  if ReBuild and (XCntr<>nil) then XCntr.ReBuild:=true;
  Result := TreeNode;
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

destructor TXom.Destroy;
begin
  Mesh3D.Free;
  SetLength(TreeArray,0);
  CntrArr.Free;
  SetLength(XomHandle.TypesInfo,0);
  XomHandle.StringTable.Free;
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

procedure TXom.DrawBuild(Build: TBuildData);
var
p:Pointer;
begin
With Build do begin
    {  glColor3f(1.0, 0.0, 0.0);
      glPointSize(8);
      glBegin(GL_POINTS);
      glVertex3f(0, 0, 0);
      glEnd;    }
        p:=BuildPoint;
        if Star then p:=StarPoint;
        if Build.BuildType=14 then  p:=PyramidPoint;
        if Build.BuildType=15 then  p:=LightPoint;
  glPushAttrib(GL_ENABLE_BIT);
  glDisable(GL_LIGHTING);
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
  glxDrawBitmapText(But.Canvas, 0, 0, 0, p, StrIndex, false);
  glPopAttrib;
end;
end;

function TXom.IsCntrSet(Data: Pointer): TCntrSet;
begin
Result:=nil;
if (Integer(Data)>10000) and (TObject(Data) is TCntrSet) then
        Result:=TCntrSet(Data);
end;

procedure TXom.SetType(Index: Integer; NewGUID: TGUID; XType: XTypes);
begin
  with XomHandle.TypesInfo[Index]do begin
        GUID:=NewGUID;
        FillChar(Name[0], SizeOf(Name),#0);
        StrCopy(@Name[0],PCharXTypes[XType]);
  end;
end;

function TXom.GetXType(XName: PChar; var XType: XTypes): Boolean;
var
Xi:XTypes;
begin
Result:=false;
      for Xi:=Low(XTypes) to High(XTypes) do
         if AnsiStrComp(XName,PCharXTypes[Xi])=0 then
                begin XType:=Xi; Result:=true; break; end;
end;

{ TContainers }

procedure TContainers.ClearChilds;
var i:integer;
begin
 for i:=1 to Count-1 do
   if (Items[i]<>nil) then Items[i].ClearChilds;
end;

procedure TContainers.ClearNames;
var i:integer;
begin
 for i:=1 to Count-1 do
   if (Items[i]<>nil) then Items[i].Name:='';
end;

function TContainers.FindNewIndex(OldIndex: Integer;New:Boolean): Integer;
var
i:integer;
begin
 Result:=0;
if OldIndex=0 then exit;
if New then begin    // если контейнер новый
 for i:=1 to Count-1 do // ищем среди новых индексов
        if (Items[i].isNew)and (Items[i].OldIndex=OldIndex) then
                begin
                Result:=Items[i].Index;
                break;
                end;
end else
begin
 for i:=1 to Count-1 do // ищем среди старых индексов
        if  (not Items[i].isNew)and (Items[i].OldIndex=OldIndex) then
                begin
                Result:=Items[i].Index;
                exit;
                end;
 // если не нашли, значит он удален, поэтому ищем тот который будет вместо него, среди новых.
 for i:=1 to Count-1 do // ищем среди новых базовый
       if (Items[i].isNew)and(Items[i].BaseIndex=OldIndex) then
                begin
                Result:=Items[i].Index;
                exit;
                end;
 // если и среди новых его нет, то исключительная ситуация.
 Result:=-1;
end;

end;


function TContainers.FoundXType(XType: XTypes): Integer;
var
i:integer;
found:boolean;
begin
 Result:=0;
 found:=false;
 for i:=1 to Count-1 do begin
        if (not found) and (Items[i].Xtype=XType) then found:=true;
        if (found) and ((Items[i].Xtype<>XType)or (i=Count-1)) then
                begin
                Result:=i;
                break;
                end;
        end;
end;

procedure TContainers.FreeDel;
var i:integer;
begin
 for i:=0 to Count-1 do
   if (Items[i]<>nil)and (Items[i].Del) then begin
   SetLength(Items[i].Childs,0);
   Items[i]:=nil;
   end;
 Pack;
end;

function TContainers.GetItems(Index: Integer): TContainer;
begin
 Result := TContainer(inherited GetItem(Index));
end;

procedure TContainers.OffReBuild;
var
i:integer;
begin
 for i:=0 to Count-1 do
                begin
                Items[i].ReBuild:=false;
                Items[i].isNew:=false;
                Items[i].BaseIndex:=0;
                end;
end;

procedure TContainers.SetItems(Index: Integer; const Value: TContainer);
begin
 inherited SetItem(Index, Value);
end;

function StringListFromStrings(const Strings: array of string): TStringList;
var
  i: Integer;
begin
  Result := TStringList.Create;
  for i := low(Strings) to high(Strings) do
    Result.Add(Strings[i]);
end;

{ TCntrSet }

constructor TCntrSet.Create;
begin
  inherited Create;
end;

procedure TCntrSet.DecSize;
begin
SetSize(Size-1);
end;

destructor TCntrSet.Destroy;
begin

  inherited;
end;

procedure TCntrSet.IncSize;
begin
SetSize(Size+1);
end;

procedure TCntrSet.SetSize(NewSize: integer);
var
indx, NewIndex: Integer;
oldP:Pointer;
OldPnt,Pnt,NewPnt:Pointer;
VirtualBufer: TMemoryStream;
_Size,offset:Integer;
begin
if Cntr<>nil then begin
  Size:=NewSize;
  VirtualBufer := TMemoryStream.Create;
  offset:=Cntr.GetOffset(Point);
  Pnt:=Point;   // точка на значение
  Cntr.CopyBufTo(VirtualBufer,Pnt);
  WriteXByte(VirtualBufer,Size);
  TestByte128(Pnt);
  Cntr.CopyBufFrom(VirtualBufer,Pnt);
  Cntr.WriteBuf(VirtualBufer);
  VirtualBufer.Free;
  Point:=Pointer(Longword(Cntr.Point)+offset);
end;

end;

procedure TCntrSet.ClearIndex(DelIndex: integer);
var
indx, Index: Integer;
oldP:Pointer;
OldPnt,Pnt,NewPnt:Pointer;
VirtualBufer: TMemoryStream;
_Size,offset:Integer;
begin
if Cntr<>nil then begin
  offset:=Cntr.GetOffset(Point);
  Pnt:=Point;
  TestByte128(Pnt);
  for indx:=0 to Size-1 do begin

  oldP:=Pnt;
  Index:=TestByte128(Pnt);

  if Index=DelIndex then begin
        VirtualBufer := TMemoryStream.Create;
        Cntr.CopyBufTo(VirtualBufer,oldP);
        TestByte128(oldP);
        Cntr.CopyBufFrom(VirtualBufer,oldP);
        Cntr.WriteBuf(VirtualBufer);
        VirtualBufer.Free;
        Point:=Pointer(Longword(Cntr.Point)+offset);
        break;
  end;

  end;
end;

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



