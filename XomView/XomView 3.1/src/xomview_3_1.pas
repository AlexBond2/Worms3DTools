unit xomview_3_1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ComCtrls, ExtCtrls, ValEdit, OpenGLx, OpenGL_Box,
  OpenGLLib,Clipbrd, ShellAPI,
  Buttons, Menus, IdGlobal, Math, ImgList, XomLib, XomCntrLib, XomMeshLib,
  XTrackPanel,GraphUtil,
  ToolWin, PanelX, Bass, fsblib, soblib, TntGrids, TntComCtrls, VistaAltFixUnit;

type
  TFormXom = class(TForm)
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    TypeTree: TTreeView;
    PanelView: TPanel;
    StringsTable: TValueListEditor;
    Panel2: TPanel;
    HexEdit: TMemo;
    StatusBar1: TStatusBar;
    SaveDialog1: TSaveDialog;
    ImageT32: TImage;
    ScrollBox1: TScrollBox;
    ExportImage: TButton;
    SaveDialog2: TSaveDialog;
    Panel3: TPanel;
    OpenGLBox: TOpenGLBox;
    Timer1: TTimer;
    RotateBut: TSpeedButton;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    Splitter4: TSplitter;
    ClassTree: TTreeView;
    XLabel: TLabel;
    Panel5: TPanel;
    TreeLabel: TLabel;
    ExportXom3D: TButton;
    SaveXom3D: TSaveDialog;
    ImportImage: TButton;
    ImportXom3D: TButton;
    OpenDialog2: TOpenDialog;
    SaveDialog3: TSaveDialog;
    ButSaveXom: TButton;
    OpenDialog3: TOpenDialog;
    PopupMenu1: TPopupMenu;
    Expand1: TMenuItem;
    Collupse1: TMenuItem;
    ExportAnim: TButton;
    SaveAnim: TSaveDialog;
    Panel6: TPanel;
    Panel7: TPanel;
    AnimBox: TComboBox;
    ImportAnim: TButton;
    LabelTime: TLabel;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    AnimButton: TSpeedButton;
    DrawBoxes: TSpeedButton;
    DrawBones: TSpeedButton;
    TreeImages: TImageList;
    Panel3D: TPanel;
    Panel12: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Panel1: TPanel;
    TrackPanel1: TTrackPanel;
    EditAnim: TSpeedButton;
    ImageList1: TImageList;
    Panel13: TPanel;
    ToolBar1: TToolBar;
    ZoomBut: TToolButton;
    PanBut: TToolButton;
    RotBut: TToolButton;
    PerspBut: TToolButton;
    DollyBut: TToolButton;
    CentrBut: TToolButton;
    SelBut: TToolButton;
    MoveBut: TToolButton;
    RotatBut: TToolButton;
    ScaleBut: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    Panel14: TPanel;
    ShowXTypes: TSpeedButton;
    StringsMenu: TPopupMenu;
    EditST: TMenuItem;
    AddNewST: TMenuItem;
    StringST: TMenuItem;
    N1: TMenuItem;
    ShowDummy: TSpeedButton;
    TreeView2: TTreeView;
    Splitter1: TSplitter;
    LoadAnim: TOpenDialog;
    AnimMenu: TPopupMenu;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    AnimTreeMenu: TPopupMenu;
    Add1: TMenuItem;
    Delete1: TMenuItem;
    AddElement1: TMenuItem;
    DelElement1: TMenuItem;
    Import3ds: TButton;
    Export3ds: TButton;
    Open3ds: TOpenDialog;
    Save3ds: TSaveDialog;
    Changevalue1: TMenuItem;
    ForceOn: TCheckBox;
    N2: TMenuItem;
    ExportXom: TMenuItem;
    ImportXom: TMenuItem;
    OpenDialog4: TOpenDialog;
    DeleteCntr: TMenuItem;
    HexMenu: TPopupMenu;
    SaveAsBin: TMenuItem;
    WriteHex1: TMenuItem;
    Panel4: TPanel;
    N3: TMenuItem;
    HexIndex: TMenuItem;
    HexStr: TMenuItem;
    N4: TMenuItem;
    StripSetConv: TMenuItem;
    rbWUM: TRadioButton;
    rbWF: TRadioButton;
    rbW4: TRadioButton;
    rbW3D: TRadioButton;
    ShowBuild: TSpeedButton;
    ChLink00: TCheckBox;
    BuildPanel: TPanel;
    Label7: TLabel;
    EdName: TEdit;
    ChStar: TCheckBox;
    ChLink02: TCheckBox;
    ChLink01: TCheckBox;
    ChLink03: TCheckBox;
    Chlink05: TCheckBox;
    ChLink06: TCheckBox;
    ChLink04: TCheckBox;
    ChLink07: TCheckBox;
    RadioButton5: TRadioButton;
    Panel31: TPanel;
    Panel32: TPanel;
    Panel33: TPanel;
    Panel34: TPanel;
    Panel35: TPanel;
    LinkBox: TGroupBox;
    UpdateBuild: TButton;
    Panel11: TPanel;
    BTeam: TEditX;
    TypeBox: TComboBox;
    Label8: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    PaintLines: TPaintBox;
    Panel15: TPanel;
    BuildDelete: TButton;
    HexFloat: TMenuItem;
    InsertCntr: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    TreeProgress: TProgressBar;
    TriStripConv: TMenuItem;
    XInde1: TMenuItem;
    XColor4ubSet1: TMenuItem;
    FilltoWhite1: TMenuItem;
    FillToBlack1: TMenuItem;
    ImportVertexColor1: TMenuItem;
    OpenVertexColor: TOpenDialog;
    TabSheet4: TTabSheet;
    Panel16: TPanel;
    Panel17: TPanel;
    Panel18: TPanel;
    OggLoop: TCheckBox;
    Panel19: TPanel;
    OggStop: TButton;
    Label4: TLabel;
    Label5: TLabel;
    OggFileName: TLabel;
    Label9: TLabel;
    OggStatus: TLabel;
    AudName: TLabel;
    Label12: TLabel;
    OggFileSize: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    OggTime: TLabel;
    OggPause: TSpeedButton;
    PB: TPaintBox;
    OggPlay: TButton;
    SaveWav: TSaveDialog;
    Panel20: TPanel;
    FSBOpen: TButton;
    SobOpen: TButton;
    FSBDialog: TOpenDialog;
    SaveMp3: TSaveDialog;
    Label6: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    oggbitrate: TLabel;
    oggchan: TLabel;
    oggrate: TLabel;
    oggformat: TLabel;
    OggSave: TButton;
    Mp3save: TButton;
    SobDialog: TOpenDialog;
    rbWB: TRadioButton;
    rbWR: TRadioButton;
    Panel21: TPanel;
    Label16: TLabel;
    limgWidth: TLabel;
    LabImgWidth: TLabel;
    LabImgName: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    LabImgHeight: TLabel;
    Label25: TLabel;
    LabImgMipLevels: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label30: TLabel;
    LabImgPalette: TLabel;
    LabImgCompr: TLabel;
    LabImgFlags: TLabel;
    LabImgFormat: TLabel;
    Label19: TLabel;
    LabImgSize: TLabel;
    Label18: TLabel;
    rbWC: TRadioButton;
    TabSheet5: TTabSheet;
    Panel22: TPanel;
    Panel23: TPanel;
    OpenLang: TButton;
    SaveLang: TButton;
    LangString: TTntRichEdit;
    LangStrings: TTntStringGrid;
    OpenLangDialog: TOpenDialog;
    ShowUV: TCheckBox;
    N7: TMenuItem;
    AddXValue1: TMenuItem;
    DeleteXValue1: TMenuItem;
    Panel24: TPanel;
    Panel25: TPanel;
    Label17: TLabel;
    Search: TEdit;
    FindText: TButton;
    DummyMenu: TPopupMenu;
    DummySelect: TMenuItem;
    XMesh11: TMenuItem;
    DeleteXMesh1: TMenuItem;
    AddXResource1: TMenuItem;
    IntResources1: TMenuItem;
    UintResources1: TMenuItem;
    StringResources1: TMenuItem;
    FloatResources1: TMenuItem;
    VectorResources1: TMenuItem;
    ContainerResources1: TMenuItem;
    ColorResources1: TMenuItem;
    FixXString1: TMenuItem;
    Exportxomas1: TMenuItem;
    W3D1: TMenuItem;
    N8: TMenuItem;
    InsertinXGraph: TMenuItem;
    DeletefromXGraph: TMenuItem;
    rbGC: TRadioButton;
    XWeightSet1: TMenuItem;
    toXPallette: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure TypeTreeChange(Sender: TObject; Node: TTreeNode);
    procedure FormCreate(Sender: TObject);
    procedure ExportImageClick(Sender: TObject);
    procedure OpenGLBoxResize(Sender: TObject);
    procedure OpenGLBoxPaint(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ClassTreeChange(Sender: TObject; Node: TTreeNode);
    procedure ExportXom3DClick(Sender: TObject);
    procedure ImportImageClick(Sender: TObject);
    procedure ButSaveXomClick(Sender: TObject);
    procedure ImportXom3DClick(Sender: TObject);
    procedure Expand1Click(Sender: TObject);
    procedure Collupse1Click(Sender: TObject);
    procedure ExportAnimClick(Sender: TObject);
    procedure ScrollBox1Resize(Sender: TObject);
    procedure AnimBoxChange(Sender: TObject);
    procedure ImportAnimClick(Sender: TObject);
    procedure OpenGLBoxMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure OpenGLBoxMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure OpenGLBoxMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure OpenGLBoxKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TrackPanel1DrawGraph(Canvas: TCanvas; Rect: TRect; XDiv,
      YDiv: Single);
    procedure EditAnimClick(Sender: TObject);
    procedure ToolButClick(Sender: TObject);
    procedure ToolButton13Click(Sender: TObject);
    procedure ToolButtonSMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);

    procedure OpenGLBoxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OpenGLBoxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OpenGLBoxClick(Sender: TObject);
    procedure CentrButClick(Sender: TObject);
    procedure ShowXTypesClick(Sender: TObject);
    procedure StringsMenuPopup(Sender: TObject);
    procedure StringSTClick(Sender: TObject);
    procedure EditSTClick(Sender: TObject);
    procedure AddNewSTClick(Sender: TObject);
    procedure StringsTableSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure StringsTableSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure SelButClick(Sender: TObject);
    procedure TrackPanel1Paint(Sender: TObject);
    procedure UpdateGraph;
    procedure TrackPanel1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure TrackPanel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TrackPanel1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ClassTreeCustomDrawItem(Sender: TCustomTreeView;
      Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure TreeView2Changing(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure TreeView2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TrackPanel1DblClick(Sender: TObject);
    procedure TreeView2DblClick(Sender: TObject);
    procedure DrawBonesClick(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure Paste1Click(Sender: TObject);
    procedure TrackPanel1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure AddElement1Click(Sender: TObject);
    procedure DelElement1Click(Sender: TObject);
    procedure Import3dsClick(Sender: TObject);
    procedure Export3dsClick(Sender: TObject);
    procedure Changevalue1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure ClassTreeAdvancedCustomDrawItem(Sender: TCustomTreeView;
      Node: TTreeNode; State: TCustomDrawState; Stage: TCustomDrawStage;
      var PaintImages, DefaultDraw: Boolean);
    procedure ExportXomClick(Sender: TObject);
    procedure ImportXomClick(Sender: TObject);
    procedure ForceOnClick(Sender: TObject);
    procedure DeleteCntrClick(Sender: TObject);
    procedure HexEditKeyPress(Sender: TObject; var Key: Char);
    procedure HexEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SaveAsBinClick(Sender: TObject);
    procedure WriteHex1Click(Sender: TObject);
    procedure HexEditContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure StripSetConvClick(Sender: TObject);
    procedure ShowBuildClick(Sender: TObject);
    procedure UpdateBuildClick(Sender: TObject);
    procedure PaintLinesPaint(Sender: TObject);
    procedure ChLink00Click(Sender: TObject);
    procedure BuildDeleteClick(Sender: TObject);
    procedure InsertCntrClick(Sender: TObject);
    procedure TabSheet3Show(Sender: TObject);
    procedure StringsTableDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringSTDrawItem(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; Selected: Boolean);
    procedure TriStripConvClick(Sender: TObject);
    procedure FilltoWhite1Click(Sender: TObject);
    procedure FillToBlack1Click(Sender: TObject);
    procedure ImportVertexColor1Click(Sender: TObject);
    procedure OggPauseClick(Sender: TObject);
    procedure OggStopClick(Sender: TObject);
    procedure PBPaint(Sender: TObject);
    procedure Panel18Resize(Sender: TObject);
    procedure OggPlayClick(Sender: TObject);
    procedure OggSaveClick(Sender: TObject);
    procedure FSBOpenClick(Sender: TObject);
    procedure Mp3saveClick(Sender: TObject);
    procedure SobOpenClick(Sender: TObject);
    procedure PBMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ClassTreeDblClick(Sender: TObject);
    procedure OpenLangClick(Sender: TObject);
    procedure LangStringsSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure ShowUVClick(Sender: TObject);
    procedure AddXValue1Click(Sender: TObject);
    procedure DeleteXValue1Click(Sender: TObject);
    procedure FindTextClick(Sender: TObject);
    procedure SearchKeyPress(Sender: TObject; var Key: Char);
    procedure ShowDummyClick(Sender: TObject);
    procedure XMesh11Click(Sender: TObject);
    procedure DeleteXMesh1Click(Sender: TObject);
    procedure DummyMenuPopup(Sender: TObject);
    procedure XResourcesClick(Sender: TObject);
    procedure FixXString1Click(Sender: TObject);
    procedure W3D1Click(Sender: TObject);
    procedure InsertinXGraphClick(Sender: TObject);
    procedure DeletefromXGraphClick(Sender: TObject);
    procedure toXPalletteClick(Sender: TObject);
  
  private
    procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;
  public
    { Public declarations }
    sortcount: Integer;
    maxst, MaxCount: Integer;
    XomUpdating: Boolean;
    OggLib: boolean;
    StPanel, StPanel2: TStatusPanel;
    function  LoadTGAResource(Name:string):Pointer;
    procedure InitGLOptions;
    procedure OpenGLGenObject;
    procedure display;
    procedure Zoomer(Step: Extended);
    function DoSelect(x: GLInt; y: GLInt): GLint;
    procedure UpdateXomTree(Save:Boolean;ReloadString:Boolean=true);
    procedure ClearName(var s:String);
    procedure OpenXomFile(FileName:String);
    procedure UpdateBuildPanel;
    procedure HexUpdate(XCntr:TContainer);
    procedure InitOggLib;
    procedure OggLoadFile(filename:String;buf:pointer);
    procedure ScanPeaks2(decoder: HSTREAM);
    procedure DrawSpectrum;
    procedure DrawTime_Line(position: QWORD; y : integer; cl : TColor);
    function SearchTreeCntr(TreeView:TTreeView;XCntr:TContainer):TTreeNode;
  end;

type TScanThread = class(TThread)
  private
    Fdecoder : HSTREAM;
  protected
    procedure Execute; override;
  public
    constructor Create(decoder:HSTREAM);
end;

type
  WAVHDR = packed record
    riff:		array[0..3] of AnsiChar;
    clen:		DWord;
    cWavFmt:		array[0..7] of AnsiChar;
    dwHdrLen:		DWord;
    wFormat:		Word;
    wNumChannels:	Word;
    dwSampleRate:	DWord;
    dwBytesPerSec:	DWord;
    wBlockAlign:	Word;
    wBitsPerSample:	Word;
    cData:		array[0..3] of AnsiChar;
    dwDataLen:		DWord;
  end;

var
  lsync : HSYNC;		// looping synchronizer handle
  chan : HSTREAM = 0;   // sample stream handle
  chan2: HSTREAM;
  killscan : boolean;
  bpp : dword; // stream bytes per pixel
  wavebufL : array of smallint;
  wavebufR : array of smallint;
  Buffer: TBitmap;
  Info:BASS_CHANNELINFO;
  WaveStream: TMemoryStream;
  WaveHdr: WAVHDR;  // WAV header
  FSB:TFSBFile;
  SOB:TSOBFile;
  FSBsound:boolean;

const
  crZoom   = 1;
  crPan    = 2;
  crRotXY  = 3;
  crPer    = 4;
  crDolly  = 5;
  crMove   = 6;
  crRotate = 9;
  crSelect = 8;
  crRotZ   = 7;
  crScale  = 10;
  crUpDown = 11;
  crFill   = 12;
  crGet    = 13;
  crErase  = 14;
  crOpenHand = 15;
  crClosedHand  = 16;

  MaxSelect = 500;     // максимальное количество объектов под курсором
  MaxDeph   = 100000.0;  // максимальная глубина

  BrdScr = 16;
var

  TempCur: TCursor;
  Scrn: TPoint;
  FormXom: TFormXom;
  TempX, TempY: Integer;
  ToolButTemp, ToolButTemp2: TToolButton;
  GpMove,TimeDrag:Boolean;
  FdTime,Fddiv:Single;

  selectBuf: array [0..MaxSelect * 4] of GLInt;
implementation

uses ImportComp, AnimF,AnimEditForm,ValueForm,XNameForm;

{$R *.dfm}

Procedure TFormXom.OpenXomFile(FileName:String);
var
  s: string;
  i:integer;
begin
      ClassTree.Enabled:=true;
      W3D:= rbW3D.Checked or rbGC.Checked;
      WUM:= rbWUM.Checked;
      WF:= rbWF.Checked;
      W4:= rbW4.Checked;
      WB:= rbWB.Checked;
      WR:= rbWR.Checked or rbWC.Checked;
      WC:= rbWC.Checked;
      W3DGC:= rbGC.Checked;
      try
      Xom.LoadXomFileName(FileName, s);
      except
      end;
      Caption := s;
      XomReplace:= Xom.saidx = Xom.XomHandle.MaxCount;
      Xom.LastXImage:=nil;
      UpdateXomTree(true,true);

      ShowBuild.Enabled:=WF;
      ButSaveXom.Enabled := False;
end;

procedure TFormXom.Button1Click(Sender: TObject);
begin
OggStopClick(Sender);
  if OpenDialog1.Execute then begin
        case OpenDialog1.FilterIndex of
        2: rbW3D.Checked:=true;
        3: rbW4.Checked:=true;
        4: rbWF.Checked:=true;
        5: rbWB.Checked:=true;
        6: rbWUM.Checked:=true;
        7: rbWR.Checked:=true;
        end;
        OpenXomFile(OpenDialog1.FileName);
        end;
end;

procedure TFormXom.ExportAnimClick(Sender: TObject);
var
 // inx: Integer;
  s: string;
begin
//  Application.MessageBox('This version for test.', 'Testing', MB_OK);
//  Exit;
//  inx := AnimBox.ItemIndex;
  s := ExtractFileName(OpenDialog1.FileName);
  SaveAnim.FileName := Format('%s[%s].xac',
    [s, CurAnimClip.Name]);
  if SaveAnim.Execute and (SaveAnim.FileName <> '') then
    CurAnimClip.SaveXAnimClip(SaveAnim.FileName);
end;

const
  MaxSingle: Single = 1E34;

function TFormXom.SearchTreeCntr(TreeView:TTreeView;XCntr:TContainer):TTreeNode;
var
i:integer;
begin
result:=Xom.BaseNode;
for i:=0 to TreeView.Items.Count-1 do
        if Xom.IsContainer(TreeView.Items[i].Data)=XCntr then begin
        result:=TreeView.Items[i];
        break;
        end;
end;

procedure TFormXom.TypeTreeChange(Sender: TObject; Node: TTreeNode);
var
  XCntr:TContainer;
  NodeTemp: TTreeNode ;
  s:string;
  i,num:integer;
begin
if (Node<>nil) and (not Xom.Loading) and (Node.Level = 1) then begin
  XCntr:=Xom.IsContainer(Node.Data);
  if not XomUpdating and not ForceOn.Checked then begin

        NodeTemp:=SearchTreeCntr(ClassTree,XCntr);
        ClassTree.Select(NodeTemp);

        end
  else
  begin
    // clear
    ClassTree.Visible := false;
    ClassTree.Items.Clear;
    Xom.TreeArray     := nil;
    SetLength(Xom.TreeArray, Xom.XomHandle.MaxCount + 1);
    Xom.TreeCount := 0;
    Xom.CntrArr.ClearNames;
    Xom.CntrArr.ClearChilds;
   // XCntr.ClearAllChilds;
    TreeProgress.Max:=Xom.XomHandle.MaxCount;
    
    try
        Xom.AddClassTree(XCntr, ClassTree, nil);
    finally
        TreeProgress.Position:=Xom.TreeCount;
        XomImport := TreeProgress.Position=TreeProgress.Max;
        TreeLabel.Caption := Format('%.1f %%', [(Xom.TreeCount) / Xom.XomHandle.MaxCount * 100]);
        if (Xom.TreeCount<>Xom.XomHandle.MaxCount) then
        begin
           s:='';
           num:=Xom.XomHandle.MaxCount;
           num:=0;
           for i:=1 to Xom.XomHandle.MaxCount do
           if  (Xom.TreeArray[i]=false) then begin
                if (num<100) then
                s:=s+
                Format('%s [%d], ',
                [PCharXTypes[Xom.CntrArr[i].Xtype], Xom.CntrArr[i].Index]);
                inc(num);
                end;
            Application.MessageBox(
                PChar(
                Format('Not have link %d containers: %s', [num,s])
                ),
                PChar('Error'), MB_ICONWARNING or MB_OK);
        end;
    end;
    ClassTree.Items.GetFirstNode.Expand(false);

    ClassTree.Select(ClassTree.Items.GetFirstNode);
    ClassTree.Visible := true;
  end;

//  StPanel.Text :=  ClassTree.Selected.Text;
end;
end;

function TFormXom.LoadTGAResource(Name:string):Pointer;
var
  Stream: TCustomMemoryStream;
begin
  Stream := TResourceStream.Create(hInstance, Name, 'TGA');
  Result := AllocMem(Stream.Size);
  Move(Stream.Memory^, Result^, Stream.Size);
  Inc(Integer(Result), 18);
  Stream.Free;
end;

procedure TFormXom.FormCreate(Sender: TObject);
begin
  TVistaAltFix.Create(Self);
  DragAcceptFiles(Handle,TRUE);
  Caption := APPVER;
  Xom := TXom.Create;
  But.GlValueList := StringsTable;
  AddClick:=AddElement1Click;
  AddMesh:=XMesh11Click;
  DeleteClick:=DelElement1Click;
  TypeTree.Constraints.MinWidth:=200;
//  But.ValueList := StringsTable;
  But.AnimButton := @AnimButton.Down;
  But.EditAnimBut := @EditAnim.Down;
  But.TrackPanel:=TrackPanel1;
  But.DrawBoxes := @DrawBoxes.Down;
  But.AnimBox := AnimBox;
  But.RotateButton := @RotateBut.Down;
  //But.JointButton := Joint;
  But.XLabel := XLabel;
//  But.XImageLab := XImageLab;
  But.TreeProgress := TreeProgress;
  But.ClassTree := ClassTree;
  But.XImage := ImageT32;
  But.Handle := Handle;
  But.Dummy := @ShowDummy.Down;
  But.Canvas := Canvas;
  But.Move := @MoveBut.Down;
  But.Rotate := @RotatBut.Down;
  But.Scale := @ScaleBut.Down;

  StPanel := StatusBar1.Panels[0];
  But.StatusM := StPanel;
  //StPanel.Width:=250;
  StPanel2 := StatusBar1.Panels[1];
  But.Status := StPanel2;
  //StPanel2.Width:=50; }
  HexEdit.Clear;
//  HexEdit.defAttributes.Color := clBlack;
  //RichEdit1.defAttributes.Style := [fsBold];

  bBitPoint2 := LoadTGAResource('Dummy');
  StarPoint  := LoadTGAResource('Star');
  BuildPoint := LoadTGAResource('Build');
  LightPoint := LoadTGAResource('Light');
  PyramidPoint := LoadTGAResource('Pyramid');

  UnActiveColor:= ColorToRGB(clBtnFace);
  ActiveColor:= ColorToRGB(clWindow);
  // загружаем простые иконки
  Screen.Cursors[crSelect] := LoadCursor(HInstance, 'SELECT');
  Screen.Cursors[crMove] := LoadCursor(HInstance, 'MOVE');
  Screen.Cursors[crRotate] := LoadCursor(HInstance, 'ROTATE');
  Screen.Cursors[crScale] := LoadCursor(HInstance, 'SCALE');
  Screen.Cursors[crPan] := LoadCursor(HInstance, 'PAN');
  Screen.Cursors[crZoom] := LoadCursor(HInstance, 'ZOOM');
  Screen.Cursors[crDolly] := LoadCursor(HInstance, 'ZOOM2');
  Screen.Cursors[crPer] := LoadCursor(HInstance, 'PER');
  Screen.Cursors[crRotXY] := LoadCursor(HInstance, 'ROTXY');
  Screen.Cursors[crRotZ] := LoadCursor(HInstance, 'ROTZ');
  Screen.Cursors[crFill] := LoadCursor(HInstance, 'FILL');
  Screen.Cursors[crGet] := LoadCursor(HInstance, 'GETFILL');
  Screen.Cursors[crErase] := LoadCursor(HInstance, 'ERASE');
  Screen.Cursors[crOpenHand] := LoadCursor(HInstance, 'OPENHAND');
  Screen.Cursors[crClosedHand] := LoadCursor(HInstance, 'CLOSEDHAND');
  //Screen.Cursors[crUpDown]:=LoadCursor(HInstance, 'UPDOWN');
  // загружаем шфирты в GL и Инициализируем его
  OpenGLBox.GL_Font := FontGL;
    // ставим активность кнопок
  SelBut.Down := true;
  ToolButTemp := SelBut;
  SelectObj := 0;
  // загружаем активный курсор в буфер
  TempCur := OpenGLBox.Cursor;
  Scrn.X := screen.DesktopRect.Right - 1;
  Scrn.Y := screen.DesktopRect.Bottom - 1;

  OpenGLBox.glBoxInit;
  InitGLOptions;
  OpenGLGenObject;
  InitOggLib;
  FSB:=TFSBFile.Create();
  SOB:=TSOBFile.Create();
  if ParamCount <> 0 then OpenXomFile(ParamStr(1));
end;

procedure TFormXom.OpenGLGenObject;
begin
  // создаем объект осей XY
  glNewList(objAxes, GL_COMPILE);
  oglAxes;
  glEndList;

  // создаем Сетку
  glNewList(objGrid, GL_COMPILE);
  oglGrid(16);
  glEndList;
end;

procedure TFormXom.InitGLOptions;
begin
  glEnable(GL_DEPTH_TEST);
  glAlphaFunc(GL_GREATER, 0.8);
  glEnable(GL_COLOR_MATERIAL);
  glShadeModel(GL_SMOOTH);
  // glEnable(GL_NORMALIZE);
  //  glEnable(GL_CULL_FACE);
  glEnable(GL_AUTO_NORMAL);
  // включение света
  glEnable(GL_LIGHTING);
  glEnable(GL_LIGHT0);
  glPolygonOffset(1.0, 1.0);
  glLightfv(GL_LIGHT0, GL_AMBIENT, @ambient);
  glLightfv(GL_LIGHT0, GL_POSITION, @l_position);
  // пропорции света
  glMaterialfv(GL_FRONT, GL_DIFFUSE, @mat_diffuse);
  glMaterialfv(GL_FRONT, GL_SPECULAR, @mat_specular);
  glMaterialfv(GL_FRONT, GL_SHININESS, @mat_shininess);

  // glSelectBuffer(SizeOf(selectBuf), @selectBuf);  // создание буфера выбора
  // очистка  TransView
  // zeromemory(@TransView, SizeOf(TransView));

  TransView.xrot := -20.0;
  TransView.yrot := 136.0;
  TransView.Per := 35.0;
  TransView.zoom := 50.0;
  AnimTimer := THRTimer.Create;
end;

// функция выделения или же выбора
function TFormXom.DoSelect(x: GLInt; y: GLInt): GLint;
var
  SelObject: GLInt;
begin
//Меняем координально режим выбора
  PSelect.x := x;
  PSelect.y := y;
  SelectMode:=True;
display;//(true);
 SelectMode:=False;
glReadBuffer(GL_BACK);
SelObject:=0;
glReadPixels(0, 0, 1, 1, GL_RGB, GL_UNSIGNED_BYTE, @SelObject);
//StatusBar1.Panels[1].text := format('%d',[SelObject]);
Result:=selObject;
end;

procedure TFormXom.display();
var
   i:integer;
    vp: TVector4i;
 //   fi,fj,
    fzoom:Glfloat;
    PMatrix, MvMatrix: TGLMatrixd4;
  wdx, wdy, wdz,
  wtx, wty, wtz,
  wtx2, wty2, wtz2: GLdouble;

begin
  // проэктировочный режим
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();// загружаем еденичную матрицу
  glViewport(0, 0, GLwidth, GLheight);

    if SelectMode then
  begin  // если режим выделения
    glGetIntegerv(GL_VIEWPORT, @vp);
    glLoadIdentity;
    // загружаем матрицу выделения
    gluPickMatrix(PSelect.x, GLHeight - PSelect.y - 4, 2, 2, vp);
    glViewport(0, 0, 1, 1);
  end;
  //  glGetFloatv(GL_PROJECTION_MATRIX, @PrMatrix);

  //  TestMinMax(10.0, 150.0, TransView.Per);
  // мартица перспективы

  gluPerspective(TransView.Per, GLwidth / GLheight, TransView.zoom / 50, MaxDeph);
  if TransView.yrot > 360.0 then
    TransView.yrot := TransView.yrot - 360;
  if TransView.yrot<-360.0 then
    TransView.yrot := TransView.yrot + 360;
  // матрица камеры
  gluLookAt(0, 0, - TransView.zoom, 0, 0, 0, 0, 1, 0);
  glRotatef(TransView.xrot, 1, 0, 0);
  glRotatef(TransView.yrot, 0, 1, 0); // смещение мира
  glTranslatef(TransView.xpos, TransView.ypos, TransView.zpos);
  //  glGetFloatv(GL_PROJECTION_MATRIX,@PrMatrix);
  //  WPar:=PrMatrix[4,4];
  // режим модели
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity();  // обновляем экран
  //  glClearDepth(0.0);
  glDepthMask(GL_TRUE);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  //  Light
  Light(position2);
  glLightfv(GL_LIGHT0, GL_POSITION, @position2);
  glDisable(GL_LIGHTING);
  glDisable(GL_BLEND);
  glDisable(GL_TEXTURE_2D);
  glDisable(GL_ALPHA_TEST);
  glEnable(GL_DEPTH_TEST);
  glDepthFunc(GL_LESS);
  glEnable(GL_CULL_FACE);

    if SelectMode then  begin

      if EditAnim.Down then begin
        glPushMatrix;
        if Xom.Mesh3D <> nil then
                Xom.Mesh3D.Draw(DrSelect);
        glPopMatrix;
      end;

      if ShowBuild.Down and (Xom.WFBuilds.Count>0) then begin
         glPushMatrix;
                glTranslatef(-300,0,-300);
                for i:=0 to Xom.WFBuilds.Count-1 do
                with Xom.WFBuilds.Items[i] do
                begin
                glPushMatrix;
                glTranslatef(Pos.X, Pos.Y, Pos.Z);
                glColor4_256(i+1);
                Xom.DrawBuild(Xom.WFBuilds.Items[i],true);
                glPopMatrix;
              //  glxDrawBitmapText(But.Canvas, Pos.X, Pos.Y, Pos.Z, BbitPoint2, '', true);
                end;
         glPopMatrix;
      end;

    end
    else begin

  // Grid
  //  glPushMatrix;
  glColor3f(0.5, 0.5, 0.5);
  glCallList(objGrid);
  //  glPopMatrix;


  glEnable(GL_LIGHTING);
  glPushMatrix;

  //    If mainBox.Xmax>10000 then glScalef(0.001,0.001,0.001);
  if Xom.Mesh3D <> nil then
  begin
    LastTexture:= 0;
    Xom.Mesh3D.Draw(DrMesh);
    Xom.Mesh3D.Draw(DrBlend);
    glDisable(GL_DEPTH_TEST);
    if DrawBones.Down then
      Xom.Mesh3D.Draw(DrBone);
    if EditAnim.Down then   begin
  glClear( GL_DEPTH_BUFFER_BIT);
  glEnable(GL_POINT_SMOOTH);
      Xom.Mesh3D.Draw(DrBoxes);

 //    glEnable(GL_DEPTH_TEST);
  glDisable(GL_POINT_SMOOTH);
    end;
  end;
  //
  glEnable(GL_LIGHTING);
  glEnable(GL_DEPTH_TEST);
  glDepthMask(GL_TRUE);
  glPopMatrix;
  //********WF Builds*************
  if ShowBuild.Down and (Xom.WFBuilds.Count>0) then begin
   glPushMatrix;
   glTranslatef(-300,0,-300);
   for i:=0 to Xom.WFBuilds.Count-1 do
   with Xom.WFBuilds.Items[i] do
   begin
   glPushMatrix;
   glTranslatef(Pos.X, Pos.Y, Pos.Z); // Смещаем ее на уже заданное смещение
   glColor3f(1,1,1);
   if SelectObj=i+1 then begin
        glColor3f(1,1,0);
        if MoveReady then begin
                GetProjectVert(PTarget.X,PTarget.Y,MAxis,p);
        if Ctrl then
                Xom.DrawBuild(Xom.WFBuilds.Items[i]);

                if MoveFirts then begin     // запоминаем начальную точку
                MoveFirts:=false; wd:=p;
                Xom.WFBuilds.Changed:=true;
                end;
                wdup.x:=-wd.x+p.x;   wdup.y:=-wd.y+p.y;  wdup.z:=-wd.z+p.z;
                glTranslatef(wdup.x, wdup.y, wdup.z);                              // перемещаем с курсором
        end;
        if But.Move^ then
                glGetFloatv(GL_MODELVIEW_MATRIX,@ObjMatrix);  // сохраняем матрицу

   end;

  // if SelectObj=i+1 then
  //      glColor(1.0,0.0,1.0);
   Xom.DrawBuild(Xom.WFBuilds.Items[i]);
   glPopMatrix;
   end;
   glPopMatrix;
   end;
  //*******WF Builds END*************
  glDisable(GL_LIGHTING);
  glDisable(GL_DEPTH_TEST);
end;
     glClear(GL_DEPTH_BUFFER_BIT);

    fzoom:=TransView.zoom/15;

    glLoadMatrixf(@ObjMatrix);
    glPushAttrib(GL_ENABLE_BIT);
    glDisable(GL_LIGHTING);
    glDisable(GL_TEXTURE_2D);
    glScalef(fzoom, fzoom, fzoom);

    if SelectMode and not MoveMode then else
    if MoveBut.Down or (RotBut.Down and(MoveBut=ToolButTemp2))  then begin
        oglDynAxes(AAxis,mMove,SelectMode,false);
    end;

    if RotatBut.Down or (RotBut.Down and(RotatBut=ToolButTemp2)) then begin
    // получаем координаты плоскости паралельной экрану
        glGetIntegerv(GL_VIEWPORT, @vp);
        glGetDoublev(GL_MODELVIEW_MATRIX, @MvMatrix);
        glGetDoublev(GL_PROJECTION_MATRIX, @PMatrix);
        gluProject(0, 0, 0, MvMatrix, PMatrix, vp,
                @wdx, @wdy, @wdz);
        gluUnProject(wdx, wdy, wdz, MvMatrix, PMatrix, vp,
                @wtx, @wty, @wtz);
        gluUnProject(wdx, wdy, -1, MvMatrix, PMatrix, vp,
                @wtx2, @wty2, @wtz2);
        eqn[0]:=wtx2-wtx;
        eqn[1]:=wty2-wty;
        eqn[2]:=wtz2-wtz;
        glGetFloatv(GL_MODELVIEW_MATRIX,@MatrixRot);
        oglDynAxes(AAxis,mRotate,SelectMode);
    end;

    if ScaleBut.Down or (RotBut.Down and(ScaleBut=ToolButTemp2))  then begin
        oglDynAxes(AAxis,mScale,SelectMode,false);
    end;
    glPopAttrib;

if not SelectMode then begin
  // Axes X,Y,Z   -  рисуем оси слево внизу для понятия
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();
  glViewport(0, 0, GLwidth div 7, GLheight div 7);
  gluPerspective(20, GLwidth / GLheight, 5, 20);
  gluLookAt(0, 0, - 10, 0, 0, 0, 0, 1, 0);
  glRotatef(TransView.xrot, 1, 0, 0);
  glRotatef(TransView.yrot, 0, 1, 0);
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity();
  glCallList(objAxes);
  // End Axes
  // выводим из того что нарисовали из буфера на экран
  SwapBuffers(OpenGLBox.GL_DC);
end;

end;

procedure TFormXom.ClearName(var s:String);
var
  i: Integer;
begin
  for i := 0 to Length(s)-1 do
    if (s[i] = '/') or (s[i] = ':') or (s[i] = '\') then
      s[i] := '_';
end;

procedure TFormXom.ExportImageClick(Sender: TObject);
var
  s: string;
  XCntr:TContainer;
begin
 XCntr:=Xom.isContainer(ClassTree.Selected.Data);
  s := XCntr.Name;
  Delete(s, Pos('.tga', s), 5);
  Delete(s, Pos('.TGA', s), 5);
  ClearName(s);
  SaveDialog2.FileName := s + '.tga';
  if SaveDialog2.Execute then
    if (SaveDialog2.FileName <> '')and (XCntr<>nil) then
      XCntr.SaveTGA(SaveDialog2.FileName, ImageT32, XLabel);
end;

procedure TFormXom.OpenGLBoxResize(Sender: TObject);
begin
  GLwidth := OpenGLBox.Width;
  GLheight := OpenGLBox.Height;
end;

procedure TFormXom.OpenGLBoxPaint(Sender: TObject);
begin
 display;
end;

procedure TFormXom.Timer1Timer(Sender: TObject);
begin
  if RotateBut.Down then
    TransView.yrot := TransView.yrot + 0.2;
  if AnimReady then
    AnimTimer.ReadTimer;
  If FormXom.Active then OpenGLBox.Repaint;
  If (PageControl1.ActivePageIndex=3) and OggLib and (bpp>0) then begin
  DrawSpectrum; // draw peak waveform
  DrawTime_Line(BASS_ChannelGetPosition(chan,BASS_POS_BYTE),0,TColor($FFFFFF)); // current pos
  PB.Repaint;
  end;
end;

procedure TFormXom.ClassTreeChange(Sender: TObject; Node: TTreeNode);
var
  MaxSky: Single;
  MaxZoom: Single;
  XCntr,i3d,XSample:TContainer;
  FSBData :TFSBData;
  SOBData :TSOBData;
  p2:Pointer;
  i,k:integer;
  s:String;

        function  FindXAnimClip(FNode:TTreeNode;var m3D:TContainer):Boolean;
        begin
        Result:=False;
        If FNode.Level=0 then exit;
        If (Xom.IsContainer(Fnode.Data)<>nil) and (TContainer(FNode.Data).Xtype=XAnimClipLibrary) then
                begin
                Result:=True;
                m3D:=TContainer(FNode.Parent.Parent.Data);
                end
                else Result:=FindXAnimClip(FNode.Parent,m3D);
        end;

begin
   if not ClassTree.Visible then exit;
   XCntr:=Xom.IsContainer(Node.Data);
    ShowDummy.Down := false;
    ShowDummyClick(sender);  
    SaveAsBin.Enabled := false;
    OggSave.Enabled:=false;
    Mp3Save.Enabled:=false;
    FSBsound:=false;
    HexEdit.ReadOnly:=true;
      // select View Tab
    if PageControl1.ActivePageIndex<>2 then
    case Node.ImageIndex of
    1,3:PageControl1.ActivePageIndex:=1;
    2,4,5,12,13,15,19:PageControl1.ActivePageIndex:=0;
    25: PageControl1.ActivePageIndex:=3;
    end;

  if (XCntr = nil) and (Node.getFirstChild <> nil) and
   ((Node.getFirstChild.ImageIndex=20) or WB) then
  begin
    Node := Node.getFirstChild;
    XCntr:= Xom.IsContainer(Node.Data);
  end;


if (XCntr=nil) and (Integer(Node.Data)>10000) then
begin

if (TObject(Node.Data) is TFSBData) then
begin
      FSBData :=TFSBData(Node.Data);
      FSBsound:=true;
    // считать информацию
      AudName.Caption:=FSBData.Name;
      SaveMp3.FileName:=FSBData.Name+'.mp3';
      OggFormat.Caption:='MP3';
      OggFileName.Caption:='SampleData';
      if FSBData.fsbver=4 then
      OggLoop.Checked:=(FSBData.fs31.lengthsamples-FSBData.fs31.loopend=1) ;
      Info.freq:=FSBData.fs31.deffreq;
      Info.chans:=FSBData.fs31.numchannels;
      Info.flags:=0;
      OggLoadFile('',FSBData.Data);
    // открыть новый файл и воспроизвести

end;

if (TObject(Node.Data) is TSOBData) then
begin
      SOBData :=TSOBData(Node.Data);
    // FSBsound:=true;
    // считать информацию
      AudName.Caption:=SOBData.Name;
      SaveWav.FileName:=SOBData.Name+'.wav';
      OggFormat.Caption:='WAV';
      OggFileName.Caption:='SampleData';
    //  if FSBData.fsbver=4 then
   //   OggLoop.Checked:=(FSBData.fs31.lengthsamples-FSBData.fs31.loopend=1) ;
      Info.freq:=SOBData.sample.freq;
      Info.chans:=SOBData.sample.chan;
      Info.flags:=0;
      if SOBData.Data<>nil then
      OggLoadFile('',SOBData.Data);
    // открыть новый файл и воспроизвести

end;

end;

  if (XCntr<>nil) then
  begin
    // clear

    ImageT32.Picture.Bitmap.Width  := 0;
    ImageT32.Picture.Bitmap.Height := 0;
    AnimBox.Clear;
    LabelTime.Caption := Format('%.2f sec', [0.0]);
    Xom.Mesh3D.Free;
    Xom.Mesh3D := nil;
    if GLError then
            Application.MessageBox(
                PChar('It''s official, you suck!!! OpenGL Crash...'),
                PChar('Error'), MB_ICONASTERISK or MB_OK);

    //NTexture := 0;
    //Material.use:=false;
    //ClassTree.Items.Clear;

    with   MainBox do
    begin
      Xmax := -MaxSingle;
      Xmin := MaxSingle;
      Ymax := -MaxSingle;
      Ymin := MaxSingle;
      Zmax := -MaxSingle;
      Zmin := MaxSingle;
    end;

    if PageControl1.ActivePageIndex=2 then HexUpdate(XCntr);

   // RichEdit1.Text := Str;
    ImageReady     := false;
    Xom3DReady     := false;
    AnimReady      := false;
    StPanel2.Text  := IntToStr(XCntr.Index);
    ShowGraph      := false;

    // если родитель XAnimClipLibrary есть , то отобразить Mesh.
    if FindXAnimClip(Node,i3d) then XCntr:=i3d;

    Xom.SelectClassTree(XCntr, Xom.Mesh3D);

    if (PageControl1.ActivePageIndex=1)and (Xom.LastXImage<>nil) then
    begin
        p2 := Xom.LastXImage.GetPoint;
        LabImgName.Caption := Xom.GetStr128(p2);
        LabImgWidth.Caption := format('%d pixels',[ Word(p2^)]); Inc(Longword(p2), 2);
        LabImgHeight.Caption := format('%d pixels',[ Word(p2^)]); Inc(Longword(p2), 2);
        LabImgMipLevels.Caption := format('%d maps',[ Word(p2^)]); Inc(Longword(p2), 2);
        LabImgFlags.Caption :=  format('%d',[ Word(p2^)]); Inc(Longword(p2), 2);
        if WC then Inc(Longword(p2), 4);
        k:=TestByte128(p2);    //Strides
        Inc(Longword(p2), 4*k);
        k:=TestByte128(p2);    //Offsets
        Inc(Longword(p2), 4*k);
        i:=Integer(p2^);
        if WR then  s:=ImageFormatWR[i] else
        s:=ImageFormatW3D[Integer(p2^)];
        LabImgFormat.Caption := s;

        Inc(Longword(p2), 4);
        s:='not used';
        if (i>8)and (not W3D) then  begin
        k:=Integer(p2^);  //Compression
        LabImgCompr.Caption :=   WRComprOp[k];
        Inc(Longword(p2), 4);
        Inc(Longword(p2)); // modif
        end else
        LabImgCompr.Caption := s;
        i := TestByte128(p2);
        LabImgSize.Caption :=  format('%d bytes',[i]);
        if Length(Xom.LastXImage.Childs)>0 then s:=Xom.LastXImage.Childs[0].Name;
        LabImgPalette.Caption := s;
    end;
    if XCntr.Xtype=XStreamData then begin
    // закрыть старый
    // считать информацию
      p2 := XCntr.Point;
      AudName.Caption:=Xom.GetStr128(p2);
      OggFileName.Caption:=Xom.GetStr128(p2);
      Info.freq:=Integer(p2^);
      Inc(Longword(p2), 3*4);
      OggLoop.Checked:=Byte(p2^)>0;
      Inc(Longword(p2), 1+5*4);
      Info.chans:=Integer(p2^);
      s:=OggFileName.Caption;
      Delete(s,1,11);
      s:=ExtractFilePath(OpenDialog1.FileName)+s;
      s:=ExpandFileName(s);
      OggLoadFile(s,nil);
      s:=AnsiUpperCase(ExtractFileExt(s));
      delete(s,1,1);
      OggFormat.Caption:=s;
    // открыть новый файл и воспроизвести
    end;

    if XCntr.Xtype=XSampleData then begin
    // закрыть старый
    // считать информацию
      p2 := XCntr.Point;
      AudName.Caption:=Xom.GetStr128(p2);
      SaveWav.FileName:=AudName.Caption+'.wav';
      OggFormat.Caption:='WAV';
      OggFileName.Caption:='SampleData';
      XSample:=Xom.CntrArr[Xom.GetIdx128(p2)];
      OggLoop.Checked:=Byte(p2^)>0;
      if WB then Inc(Longword(p2), 2+4+4) else
      Inc(Longword(p2), 1+2+4+4);
      Info.freq:=Integer(p2^);   Inc(Longword(p2), 4);
      Info.chans:=1;   
      Info.flags:=0;
      OggLoadFile('',XSample.Point);
    // открыть новый файл и воспроизвести
    end;

    Export3ds.Enabled := (XCntr.Xtype =XShape)or (XCntr.Xtype =XPsShape)or(XCntr.Xtype =XSkinShape) or (XCntr.Xtype =XCollisionGeometry) or (XCntr.Xtype =XBuildingShape);
    Import3ds.Enabled := (XCntr.Xtype =XShape) or (XCntr.Xtype =XCollisionGeometry);
    ImportVertexColor1.Enabled := (Xom.Mesh3D<>nil) and (Length(Xom.Mesh3D.Childs)>0);
    ScrollBox1Resize(self);
    SaveAsBin.Enabled := true;
    HexEdit.ReadOnly:=false;
    ExportImage.Enabled := ImageReady;
    ExportXom3D.Enabled := Xom3DReady;
    ImportXom3D.Enabled := XomReplace and Xom3DReady;
    ImportImage.Enabled := XomReplace and ImageReady;
    ImportAnim.Enabled := AnimReady;
    ExportAnim.Enabled := AnimReady;
    EditAnim.Enabled := AnimReady;
    Panel1.Visible:= AnimReady;
    Splitter2.Visible:= AnimReady;
    if AnimReady then
      AnimBoxChange(self);

    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    if Xom.Mesh3D <> nil then
      with MainBox do
      begin
        Xom.Mesh3D.GetBox(MainBox);
        TransView.Xpos := -(XMax + Xmin) / 2;
        TransView.Ypos := -(YMax + Ymin) / 2;
        TransView.Zpos := -(ZMax + Zmin) / 2;
        MaxZoom := Max((Xmax - Xmin), (Ymax - Ymin));
        MaxZoom := Max(MaxZoom, (Zmax - Zmin));
        TransView.zoom := MaxZoom * 3;
        TransView.xrot := -20.0;
        TransView.Per := 35.0;
        if WF then MaxSky:=15000 else MaxSky:= 9000;
        if XMax > MaxSky then  //sky
        begin
          TransView.Xpos := 0;
          TransView.Ypos := -86;
          TransView.Zpos := 0;
          TransView.zoom := 100;
          TransView.xrot := 30;
          TransView.Per := 90;
          //   glDisable(GL_DEPTH_TEST);
          //   glEnable(GL_CULL_FACE);
        end;
        TVModel:=TransView;
      end;
  end;
    StPanel.Text :=  Node.Text;
end;

procedure TFormXom.ExportXom3DClick(Sender: TObject);
var 
  s: string;
begin
 // Application.MessageBox('This version for test.', 'Testing', MB_OK);
 // Exit;

  s := Xom.Mesh3D.Name;
  ClearName(s);
  SaveXom3D.FileName := Format('(%s).xom3d', [s]);
  if SaveXom3D.Execute and (SaveXom3D.FileName <> '') then
  begin
    Xom.Mesh3D.SaveAsXom3d(SaveXom3D.FileName);
  end;
end;

procedure TFormXom.ImportImageClick(Sender: TObject);
begin
  if OpenDialog2.Execute and (OpenDialog2.FileName <> '') then
  begin
    ButSaveXom.Enabled := Xom.LastXImage.ImportXImage(OpenDialog2.FileName);
    ClassTreeChange(ClassTree, ClassTree.Items.GetFirstNode);
  end;
end;

procedure TFormXom.ButSaveXomClick(Sender: TObject);
begin
  FormXom.SaveDialog3.FileName := FormXom.OpenDialog1.FileName;
//  Xom.UpdateStringTable(But.GLValueList);
  Xom.SaveXom(SaveDialog3);
  Caption := Format('%s - [%s]', [APPVER,ExtractFileName(SaveDialog3.FileName)]);
end;

  //var
  //ColorUse:boolean;

procedure TFormXom.ImportXom3DClick(Sender: TObject);
var
  VirtualBufer: TMemoryStream;
  s: string;
  //  i: Integer;
  MeshXom: TMesh;
  // XTexture:integer;
  XTextureStr: TStringList;
  XCntr:TContainer;
begin
//  Application.MessageBox('Only in Full Version!!!', 'Testing', MB_OK);
 // Exit;
  if OpenDialog3.Execute and (OpenDialog3.FileName <> '') then
  begin
  //Удалить все дерево которое будем заменять. Слишком сложно!
  //Заменить старое дерево на новое.
    // read Mesh
    VirtualBufer := TMemoryStream.Create;
    VirtualBufer.LoadFromFile(OpenDialog3.FileName);
    XTextureStr := TStringList.Create;
    ImportComp.CompareTree.InTree.Items.Clear;
    ImportComp.CompareTree.OutTree.Items.Clear;
    //    ColorUse:=false;
    S := ReadName(VirtualBufer);
    if s <> 'X3D' then
    begin
      MessageBox(FormXom.Handle,
        PChar('Bad format Xom3D!!!'),
        PChar('Error'), MB_OK);
      VirtualBufer.Free;
      Exit;
    end;
    MeshXom := TMesh.Create(Xom.CntrArr);
    MeshXom.ReadXNode(VirtualBufer, XTextureStr,
      ImportComp.CompareTree.InTree, nil);
    XCntr:= TContainer(ClassTree.Selected.Data);
    Xom.BuildTree(XCntr, ImportComp.CompareTree.OutTree, nil);
    ImportComp.CompareTree.OutTree.FullExpand;
    ImportComp.CompareTree.InTree.FullExpand;
    VirtualBufer.Free;
    // compare treees
    if ImportComp.CompareTree.ShowModal = mrOk then
    begin
      Xom.XomImportObj(ImportComp.CompareTree.InTree.Items.GetFirstNode,
        ImportComp.CompareTree.OutTree.Items.GetFirstNode);
      ButSaveXom.Enabled := true;
    end;
    // import
    MeshXom.Free;
    XTextureStr.Free;
    ClassTreeChange(ClassTree, ClassTree.Items.GetFirstNode);
  end;
end;

procedure TFormXom.Expand1Click(Sender: TObject);
begin
  if ClassTree.Selected <> nil then
    ClassTree.Selected.Expand(true);
end;

procedure TFormXom.Collupse1Click(Sender: TObject);
begin
  if ClassTree.Selected <> nil then
    ClassTree.Selected.Collapse(true);
end;

procedure TFormXom.ScrollBox1Resize(Sender: TObject);
begin
  ImageT32.Left := FormXom.Scrollbox1.Width div 2 - ImageT32.Width div 2;
  ImageT32.Top := FormXom.Scrollbox1.Height div 2 - ImageT32.Height div 2;
  if ImageT32.Left < 0 then 
    ImageT32.Left := 0;
  if ImageT32.Top < 0 then 
    ImageT32.Top := 0;
end;

procedure TFormXom.UpdateGraph;
  var MaxValue,MinValue:Single;
  i,ii,j,jj:integer;
begin
  if CurAnimClip=nil then exit;
  AnimEd:=true;
  TrackPanel1.AreaSize.MaxWidth:= CurAnimClip.Time;
  j:=Length(CurAnimClip.Keys)-1;
  MaxValue:=-10000;
  MinValue:=10000;
  for i:=0 to j do
        with CurAnimClip.Keys[i] do begin
        if EditAnim.Down and (ActiveMesh<>nil)
          and (CurAnimClip.Keys[i].keytype.objname<>ActiveMesh.name)
          then Continue;
        if (SelectType<>0) and  (SelectType<>CurAnimClip.Keys[i].keytype.ktype) then
           Continue;
        CurAnimClip.SortKeyData(@CurAnimClip.Keys[i]);
        jj:=Length(data)-1;
                for ii:=0 to jj do begin
        //         if data[ii][4]>CurAnimClip.Time then begin
       //          CurAnimClip.Time:=data[ii][4];
      //           LabelTime.Caption := Format('%.2f sec', [CurAnimClip.Time]);
       //          end;
                 if data[ii][5]>MaxValue then MaxValue:=data[ii][5];
                 if data[ii][5]<MinValue then MinValue:=data[ii][5];
                end;
        end;
  if MaxValue=-10000 then MaxValue:=1;
  if MinValue=10000 then MinValue:=-1;
  if MinValue =MaxValue then MinValue:=MinValue-1;
  If not GpMove then begin
  TrackPanel1.AreaSize.MaxHeight:=MaxValue;
  TrackPanel1.AreaSize.MinHeight:=MinValue;
  end;
  AnimTimer.MaxTime := CurAnimClip.Time;
  TrackPanel1.Repaint
end;

procedure TFormXom.AnimBoxChange(Sender: TObject);
begin
  // update timer
  AnimTimer.StartTimer;
  CurAnimClip := AnimClips.GetItemID(AnimBox.ItemIndex);
  ShowGraph:=True;
  UpdateGraph;
  LabelTime.Caption := Format('%.2f sec', [AnimTimer.MaxTime]);
end;

procedure TFormXom.ImportAnimClick(Sender: TObject);
var id:integer;
begin
//  Application.MessageBox('This version for test.', 'Testing', MB_OK);
  if LoadAnim.Execute and (LoadAnim.FileName <> '') then
    begin
    CurAnimClip.Clear;
    CurAnimClip.LoadXAnimClip(LoadAnim.FileName);
    CurAnimClip.SortKeys;
    id:=AnimBox.ItemIndex;
    AnimBox.Items[id]:=CurAnimClip.Name;
    AnimBox.ItemIndex:=id;
        ActiveMesh:=nil;
        SelectObj := 0;
        SelectKey := nil;
        SelectType:= 0;
        TrackPanel1.Repaint;
     If EditAnim.Down then
     begin
      UpdateAnimTree(TreeView2);
      UpdateAnimTreeMenu(Add1,Delete1);
     end;
    AnimBoxChange(Sender);
    end;
end;

procedure TFormXom.OpenGLBoxMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  Handled:=True;
  TransView.zoom := TransView.zoom + TransView.zoom * 0.1;
   If not Timer1.Enabled then OpenGLBox.Repaint;
end;

procedure TFormXom.OpenGLBoxMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  Handled:=True;
  TransView.zoom := TransView.zoom - TransView.zoom * 0.1;
   If not Timer1.Enabled then OpenGLBox.Repaint;
end;

procedure TFormXom.Zoomer(Step: Extended);
var
  sinX, cosX, sinY, cosY: Extended;
begin
  SinCos((TransView.yrot - 90) * Pi / 180, sinY, cosY);
  SinCos((TransView.xrot - 90) * Pi / 180, sinX, cosX);
  Transview.ypos := Transview.ypos + Step * cosX;
  Transview.xpos := Transview.xpos + Step * cosY * sinX;
  Transview.zpos := Transview.zpos + Step * sinY * sinX;
end;

procedure TFormXom.OpenGLBoxMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  CurPoint: TPoint;
  sinX, cosX, sinY, cosY, Step: Extended;
  hit: Integer;
  procedure GetAxis;
  begin
              if hit>10000 then  begin
                AAxis:=TAxis(hit-10001);
                OpenGLBox.Repaint;
              end else AAxis:=MAxis;
  end;
begin
  if OpenGLBox.OnOpenGL then
  begin
    //if not (ssMiddle in Shift) and (TempCur<>OpenGLBox.Cursor) then OpenGLBox.Cursor:=TempCur;
    if (ssLeft in Shift) or (ssMiddle in Shift) then
    begin
      Ctrl:=ssCtrl in Shift;
      ShiftOn:=ssShift in Shift;
      GetCursorPos(CurPoint);
      CurPoint.X := TempX - CurPoint.X;
      CurPoint.Y := TempY - CurPoint.Y;
      //if (CurPoint.X=0) and (CurPoint.Y=0) then exit;

      case OpenGLBox.Cursor of
        crDolly:
        begin
          Zoomer(-CurPoint.Y / 10);
        end;
        crPan:
        begin
          SinCos((TransView.yrot - 90) * Pi / 180, sinY, cosY);
          SinCos(TransView.xrot * Pi / 180, sinX, cosX);
          Step := CurPoint.X / GLwidth * (TransView.zoom) *
            DegToRad(TransView.Per);
          Transview.xpos := Transview.xpos - Step * sinY;
          Transview.zpos := Transview.zpos + Step * cosY;
          Step := CurPoint.Y / GLheight * (TransView.zoom) *
            DegToRad(TransView.Per);
          Transview.ypos := Transview.ypos + Step * cosX;
          Transview.zpos := Transview.zpos + Step * sinY * sinX;
          Transview.xpos := Transview.xpos + Step * cosY * sinX;
       end;
        crRotXY:
        begin
          Transview.Xrot := Transview.Xrot + CurPoint.Y / 5;
          Transview.yrot := Transview.yrot - CurPoint.X / 5;
        end;
        crPer:
        begin
          TransView.Per := TransView.Per - CurPoint.Y / 10;
        end;
        crZoom:
        begin //UpdateActiveWindow:=true;
          TransView.zoom := TransView.zoom - CurPoint.Y / 10;
        end;
        crMove:
        begin
          PTarget.X :=X;
          PTarget.Y:=GLheight-Y-1;
       end;
        crRotate:
        begin
          PTarget.X := X;
          PTarget.Y:=GLheight-Y-1;
        end;
        crScale:
        begin
          PTarget.X := X;
          PTarget.Y:=GLheight-Y-1;
        end;
      end;


      GetCursorPos(CurPoint);
      TempX := CurPoint.X;
      TempY := CurPoint.Y;
      if CurPoint.X > Scrn.X - BrdScr then
      begin 
        TempX := BrdScr;
        setcursorpos(TempX, CurPoint.y);
      end;
      if CurPoint.X < BrdScr then 
      begin 
        TempX := Scrn.X - BrdScr;
        setcursorpos(TempX, CurPoint.y);
      end;
      if CurPoint.y > Scrn.Y - BrdScr then 
      begin 
        TempY := BrdScr;
        setcursorpos(CurPoint.x, TempY);
      end;
      if CurPoint.y < BrdScr then 
      begin
        TempY := Scrn.Y - BrdScr;
        setcursorpos(CurPoint.x, TempY);
      end;
       If not Timer1.Enabled then OpenGLBox.Repaint;
    end
    else
      case OpenGLBox.Cursor of
        crDefault, crSelect, crFill,crErase,
        crGet, crMove, crRotate, crScale:
        begin
          if MoveBut.Down then
            MoveMode := true;
          if RotatBut.Down then
            RotateMode := true;
          if ScaleBut.Down then
            ScaleMode := true;

          GetCursorPos(CurPoint);
          if (TempX = CurPoint.X) and (TempY = CurPoint.Y) then
            Exit;

          TempX := CurPoint.X;
          TempY := CurPoint.Y;
          // тестирование окон
          hit:=0;

          if EditAnim.Down or ShowBuild.Down then
                hit := DoSelect(X, Y);

          if hit > 0 then
          begin

            if MoveBut.Down then
            begin
              if hit<10000 then begin OpenGLBox.Cursor :=crDefault;  exit;end;
              OpenGLBox.Cursor := crMove;
              GetAxis;
            end
            else if RotatBut.Down then
            begin
              if hit<10000 then begin OpenGLBox.Cursor :=crDefault;  exit;end;
              OpenGLBox.Cursor := crRotate;
              GetAxis;
            end
            else if ScaleBut.Down then
            begin
              if hit<10000 then begin OpenGLBox.Cursor :=crDefault;  exit;end;
              OpenGLBox.Cursor := crScale;
              GetAxis;
            end
            else
            begin
              OpenGLBox.Cursor := crSelect;

              RotateMode := false;
              ScaleMode := false;
              MoveMode := false;
              SelectObjOn := hit;

            end;
          end
          else
            OpenGLBox.Cursor := crDefault;
          //  if SelectObj>0 then display(time,false);
        end;
      end;
    StatusBar1.Panels.Items[0].Text := Text;
    //
  end;
end;

procedure TFormXom.OpenGLBoxKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   case Key of
  VK_NUMPAD7:  TransView.xrot:=TransView.xrot+10;
  VK_NUMPAD1:  TransView.xrot:=TransView.xrot-10;
  VK_NUMPAD8:  TransView.zpos:=TransView.zpos+10;
  VK_NUMPAD2:  TransView.zpos:=TransView.zpos-10;
  VK_NUMPAD4:  TransView.xpos:=TransView.xpos+10;
  VK_NUMPAD6:  TransView.xpos:=TransView.xpos-10;
  VK_NUMPAD9:  TransView.Per:=TransView.Per+10;
  VK_NUMPAD3:  TransView.Per:=TransView.Per-10;
  end;
         if (Key=Ord('C')) and (CentrBut.Enabled) then CentrButClick(CentrBut);
         if (Key=Ord('Q')) then SelButClick(SelBut);
         if (Key=Ord('W')) and (MoveBut.Enabled)then ToolButClick(MoveBut);
         if (Key=Ord('E')) and (RotatBut.Enabled)then ToolButClick(RotatBut);
         if (Key=Ord('R')) and (ScaleBut.Enabled)then ToolButClick(ScaleBut);
         if (Key=Ord('X')) then    Zoomer(+1);
         if (Key=Ord('S')) then    Zoomer(-1);
   If not Timer1.Enabled then  OpenGLBox.Repaint;
end;

procedure TFormXom.TrackPanel1DrawGraph(Canvas: TCanvas; Rect: TRect; XDiv,
  YDiv: Single);
  var
  i,ii,j,jj,k:integer;
    P:Array of TPoint;
    P1,P2:TPoint;
 //   PushColor:TColor;
    TmRect:TRect;
  CurActiveMesh:Boolean;
  NumCurves:integer;
begin
 if ShowGraph and (CurAnimClip<>nil) then begin
 j:=Length(CurAnimClip.Keys)-1;
 SetLength(GrafKeys,0);
 NumCurves:=0;
// AnimClip.Time                        
  for i:=0 to j do
        with CurAnimClip.Keys[i] do begin
          CurActiveMesh:=(ActiveMesh<>nil)
          and (CurAnimClip.Keys[i].keytype.objname<>ActiveMesh.name);

          if EditAnim.Down and CurActiveMesh then
                Continue;

        if (SelectType<>0) and  (SelectType<>CurAnimClip.Keys[i].keytype.ktype) then
           Continue;
        Canvas.Pen.Color:=ColorHLSToRGB((i*13 mod 255), 190, 200);
        jj:=Length(data);
         SetLength(P,jj);
                for ii:=0 to jj-1 do begin
                P[ii].X:=Rect.Left+Round(XDiv*data[ii][4]);
                P[ii].Y:=Rect.Top+Round(+YDiv*TrackPanel1.AreaSize.MaxHeight-YDiv*data[ii][5]);
                end;
       //  Canvas.PolyLine(P);
        { work
                 for ii:=0 to jj-2 do
         Canvas.PolyBezier([
         Point(P[ii].x,P[ii].y),
         Point(P[ii].x+round((P[ii+1].x-P[ii].x)*data[ii][2]), P[ii].y+round((P[ii].y-P[ii+1].y)*data[ii][3])),
         Point(P[ii+1].x+round((P[ii].x-P[ii+1].x)*data[ii+1][0]), P[ii+1].y+round((P[ii+1].y-P[ii].y)*data[ii+1][1])),
         Point(P[ii+1].x,P[ii+1].y)
         ]);}

         for ii:=0 to jj-2 do begin
                P1.x := P[ii].x + round((P[ii+1].x-P[ii].x)*cos(data[ii][3])*data[ii][2]/3);
                P1.y := P[ii].y + round((P[ii+1].y-P[ii].y)*sin(data[ii][3])*data[ii][2]/3);
                P2.x := P[ii+1].x - round((P[ii+1].x-P[ii].x)*cos(data[ii+1][1])*data[ii+1][0]/3);
                P2.y := P[ii+1].y - round((P[ii+1].y-P[ii].y)*sin(data[ii+1][1])*data[ii+1][0]/3);
         Canvas.PolyBezier([P[ii],P1,P2,P[ii+1]]);
        {   PushColor:=Canvas.Pen.Color;
       Canvas.Pen.Color:=clYellow;
         Canvas.PolyLine([P[ii],P1]);
         Canvas.PolyLine([P[ii+1],P2]);
         Canvas.Pen.Color:=PushColor; }
         end;
         if EditAnim.Down then begin
         Canvas.Brush.Color:=clLime;
          k:=Length(GrafKeys);
        if  ActiveMesh<>nil then begin
                SetLength(GrafKeys,k+jj);
                SelectKdata:=@CurAnimClip.Keys[i];
                inc(NumCurves);
                end;
                for ii:=0 to jj-1 do begin
                  if SelectKey=@Data[ii] then Canvas.Brush.Color:=clRed
                  else Canvas.Brush.Color:=clLime;
                  TmRect:=Classes.Rect(P[ii].X-3,P[ii].Y-3,P[ii].X+3,P[ii].Y+3);
                if  ActiveMesh<>nil then begin
                 GrafKeys[k+ii].Frame:=@Data[ii];
                 GrafKeys[k+ii].Rect:=TmRect;
                  end else Canvas.Brush.Color:=clYellow;
                 Canvas.FillRect(TmRect);
                 Canvas.FillRect(Classes.Rect(P[ii].X-3,P[ii].Y-3,P[ii].X+3,P[ii].Y+3));
                 end;
         end;
        end;

   if NumCurves<>1 then SelectKdata:=nil;
 end;
end;


procedure TFormXom.EditAnimClick(Sender: TObject);
var TmClip:TAnimClip;
id:integer;
New:boolean;
begin
If EditAnim.Down then begin
ShowBuild.Down:=false;
BuildPanel.Visible:=false;
Showbuild.Enabled:=false;
Timer1.Enabled:=false;
new:=false;
Case AnimEditForm.FormAsk.ShowModal of
2:      begin
        TmClip:=TAnimClip.Create;
        TmClip.Copy(CurAnimClip);
        TmClip.Name:=AnimEditForm.FormAsk.Edit1.Text;
        id:=AnimClips.AddClip(TmClip); // clone;
        AnimBox.AddItem(TmClip.Name,nil);
        AnimBox.ItemIndex:=id;
        CurAnimClip:=TmClip;
        New:=true;
        end;
3:      begin
        TmClip:=TAnimClip.Create;
        // add zero keys;
        TmClip.Time:=1.0;
        TmClip.Name:=AnimEditForm.FormAsk.Edit1.Text;
        id:=AnimClips.AddClip(TmClip); // ;
        AnimBox.AddItem(TmClip.Name,nil);
        AnimBox.ItemIndex:=id;
        CurAnimClip:=TmClip;
        New:=true;
        end;
end;
ActiveMesh:=nil;
        SelectObj := 0;
        SelectKey := nil;
        SelectType:= 0;
TrackPanel1.CanSlide:=true;
TrackPanel1.Repaint;
RotateBut.Down:=False;
RotateBut.Enabled:=False;
//MoveBut.Down :=False;
Panel2.Visible:=False;
AnimBox.Enabled:=False;
AnimButton.Enabled:=False;
ImportAnim.Enabled:=False;
ExportAnim.Enabled:=False;
MoveBut.Enabled :=False;
RotatBut.Enabled :=False;
ScaleBut.Enabled :=False;
TabSheet2.TabVisible:=False;
TabSheet3.TabVisible:=False;
Splitter1.Visible:=true;
TreeView2.Width:=220;
UpdateAnimTree(TreeView2);
UpdateAnimTreeMenu(Add1,Delete1);
TreeView2.PopupMenu := AnimTreeMenu;
TreeView2.OnChanging := TreeView2Changing;
TreeView2.OnDblClick := TreeView2DblClick;
TreeView2.OnMouseUp := TreeView2MouseUp;
TreeView2.Visible:=True;
AnimEd:=false or New;
// таймер вырубаем и анимацию делаем управляемой
// при включении анимации на экране появяться контрольные кубы, которые можно будет двигать и изменять
end else
begin
TrackPanel1.CanSlide:=False;
TrackPanel1.Slider:=0;
ActiveMesh:=nil;
        SelectObj := 0;
        SelectKey := nil;
        SelectType:= 0;
TrackPanel1.Repaint;
Showbuild.Enabled:=true and WF;
Timer1.Enabled:=True;
Panel2.Visible:=True;
AnimBox.Enabled:=True;
RotateBut.Enabled:=True;
AnimButton.Enabled:=True;
ImportAnim.Enabled:=True;
ExportAnim.Enabled:=True;
TabSheet2.TabVisible:=True;
TabSheet3.TabVisible:=True;
MoveBut.Down :=False;
RotatBut.Down :=False;
ScaleBut.Down :=False;
MoveBut.Enabled :=False;
RotatBut.Enabled :=False;
ScaleBut.Enabled :=False;
TreeView2.Visible:=False;
TreeView2.Width:=200;
Splitter1.Visible:=False;
TreeView2.PopupMenu := nil;
TreeView2.OnChanging := nil;
TreeView2.OnDblClick := nil;
TreeView2.OnMouseUp := nil;
if AnimEd then begin
UpdateGraph;
id:=AnimBox.ItemIndex;
// отсортировать текущую анимацию
AnimClips.SaveAnimToXom();
// обновляем дерево
UpdateXomTree(true);

AnimBox.ItemIndex:=id;
AnimBoxChange(self);
end;
end;

end;

procedure TFormXom.ToolButton13Click(Sender: TObject);
begin
  ToolButton13.Down := false;
  ToolButton14.Down := false;
  ToolButton15.Down := false;
  ToolButton16.Down := false;
  ToolButton17.Down := false;
  ToolButton18.Down := false;
  TToolButton(Sender).Down := true;
  MAxis:=TAxis(TToolButton(Sender).Index-10);
  AAxis:=MAxis;
   If not Timer1.Enabled then  OpenGLBox.Repaint;
end;

procedure TFormXom.ToolButClick(Sender: TObject);
begin
  if (TToolButton(Sender) = MoveBut) and (MAxis = Axis_XYZ) then   ToolButton13Click(ToolButton13);
  if ToolButTemp = TToolButton(Sender) then
  begin
    ToolButTemp.Down  := false;
    if (ToolButTemp2 <> nil) and(ToolButTemp2.Enabled) then
        begin
        if (ToolButTemp2 = MoveBut) or
             (ToolButTemp2 = RotatBut) or
             (ToolButTemp2 = ScaleBut) then begin ToolButClick(ToolButTemp2); exit; end
         else ToolButTemp2 := nil;
        end;
    OpenGLBox.Cursor  := crDefault;
    SelBut.Down := true;
    ToolButTemp       := SelBut;
  end
  else
  begin
    TToolButton(Sender).Down := true;
    OpenGLBox.Cursor         := TToolButton(Sender).Index + 1;
    if ToolButTemp <> nil then
      ToolButTemp.Down := false;
    ToolButTemp2 := ToolButTemp;
    ToolButTemp := TToolButton(Sender);
    TempCur     := OpenGLBox.Cursor;
  end;

 {  if (TToolButton(Sender) = MoveBut) or
             (TToolButton(Sender) = RotatBut) or
             (TToolButton(Sender) = ScaleBut) then  HmPickBut.Down:= false;
//  if TToolButton(Sender)=MoveBut then HmPickBut.Down:= false;    }
   If not Timer1.Enabled then  OpenGLBox.Repaint;
end;

procedure TFormXom.ToolButtonSMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  StatusBar1.Panels.Items[0].Text := TToolButton(Sender).Hint;
end;

procedure TFormXom.OpenGLBoxMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  CurPoint: TPoint;
 // b, a, t, q: Integer;

begin
  if OpenGLBox.OnOpenGL then
  begin
    if Button = mbLeft then
    begin
      if OpenGLBox.Cursor = crDefault then
      if MoveBut.Down or  RotatBut.Down or
        ScaleBut.Down
        then else
      begin
        SelectObj := 0;
        SelectKey := nil;
        SelectType:= 0;
     //   ToolButton6.Enabled := false;
        ActiveMesh:=nil;

        if ShowBuild.Down then
        begin
         MoveBut.Enabled :=false;
         UpdateBuildPanel;
        end;

        if EditAnim.Down then begin
         UpdateAnimTree(TreeView2);
         UpdateGraph;
        MoveBut.Enabled :=EdMode;
        RotatBut.Enabled :=EdMode;
        ScaleBut.Enabled :=EdMode;
         end;
        OpenGLBox.Repaint;
      end;

      if OpenGLBox.Cursor = crSelect then
        if SelectObjOn > 0 then
        begin

          SelectObj := SelectObjOn;
    //      ToolButton6.Enabled := true;
          OpenGLBox.Repaint;
        If EditAnim.Down and (ActiveMesh <> nil) then begin
        UpdateAnimTree(TreeView2);
        UpdateGraph;
        EdMode:=ActiveMesh.Transform.TransType<>TTNone;
        MoveBut.Enabled :=EdMode;
        RotatBut.Enabled :=EdMode;
        ScaleBut.Enabled :=EdMode;
        end;

        if ShowBuild.Down then
        begin
         MoveBut.Enabled :=True;
         UpdateBuildPanel;
        end;
    {      if ActivePoxel <> nil then
          begin
            if ImportMapActive then
            begin
              Label4.Caption := ActivePoxel.Name;
              TreeView3.Selected := ActivePoxel.TreeNodeLink;
              RefrashList(ActivePoxel);
            end
            else if SelectPoxel<>ActivePoxel then
            begin
              SelectLabel.Caption := ActivePoxel.Name;
              TreeView1.Selected := ActivePoxel.TreeNodeLink;
              RefrashList(ActivePoxel);
              SelectDone;
            end;
          end;    }

        end
        else

        begin
      //    SelectLabel.Caption := 'None';
          SelectObj := 0;
      //    ToolButton6.Enabled := false;
                MoveBut.Enabled :=False;
                RotatBut.Enabled :=False;
                ScaleBut.Enabled :=False;
                ActiveMesh:=nil;
          OpenGLBox.Repaint;
        end;

 {     if MoveMode and (SelectObj=0) then
      begin
      SelButClick(SelBut);
      end;  }

      case OpenGLBox.Cursor of
      crMove,crRotate,crScale:
        case AAxis of
                Axis_X: ToolButton13Click(ToolButton13);
                Axis_Y: ToolButton13Click(ToolButton14);
                Axis_Z: ToolButton13Click(ToolButton15);
                Axis_XY: ToolButton13Click(ToolButton16);
                Axis_YZ: ToolButton13Click(ToolButton17);
                Axis_XZ: ToolButton13Click(ToolButton18);
                Axis_XYZ: begin
                        ToolButton13.Down := false;
                        ToolButton14.Down := false;
                        ToolButton15.Down := false;
                        ToolButton16.Down := false;
                        ToolButton17.Down := false;
                        ToolButton18.Down := false;
                        MAxis:=Axis_XYZ;
                        AAxis:=MAxis;
                        OpenGLBox.Repaint;
                               // ToolButton13Click(ToolButton18)
                        end;
                end;
      end;

      if OpenGLBox.Cursor = crMove then
      begin
        MoveReady := true;
        MoveFirts:=true;
        PTarget.X :=X;
        PTarget.Y:=GLheight-Y-1;
      end
      else
        MoveMode := false;

      if OpenGLBox.Cursor = crScale then
      begin
        ScaleReady := true;
        ScaleFirts:=true;
      end
      else
        ScaleMode := false;

      if OpenGLBox.Cursor = crRotate then
      begin
        RotateReady := true;
        RotateFirts:=true;
      end
      else
        RotateMode := false;
        
      GetCursorPos(CurPoint);
      TempX := CurPoint.X;
      TempY := CurPoint.Y;
    end;
    if Button = mbMiddle then
    begin
      GetCursorPos(CurPoint);
      TempX := CurPoint.X;
      TempY := CurPoint.Y;
      TempCur := OpenGLBox.Cursor;
      OpenGLBox.Cursor := crPan;
    end;
    if Button = mbRight then
      ToolButClick(RotBut);
  end;
end;

procedure TFormXom.OpenGLBoxMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
//var
//TempPoxel:TPoxel;
//tempTN : TTreeNode;
//k:Single;
//i,j:integer;

begin
  if mbMiddle = Button then
    OpenGLBox.Cursor := TempCur;

   if EditAnim.Down then
   if (CurAnimClip<>nil) and (MoveReady or
   ScaleReady or RotateReady) then
   begin
   CurAnimClip.UpdateAnimClip;
   UpdateGraph;
   if EditAnim.Down then UpdateAnimTree(TreeView2);
   end;

   if ShowBuild.Down then
   if MoveMode and MoveReady then begin
        if Ctrl then begin
        // делаем копию
        SelectObj:= Xom.MakeBuildCopy(SelectObj-1)+1;
        end;
         Xom.BuildTestGrid(wdup);
         With Xom.WFBuilds.Items[SelectObj-1] do begin
               Pos.X:=Pos.X+wdup.x;   // записываем данные
               Pos.Y:=Pos.Y+wdup.y;
               Pos.Z:=Pos.Z+wdup.z;
               end;
   end;
   MoveReady:=false;
   ScaleReady:=false;
   RotateReady:=false;
      If not Timer1.Enabled then  OpenGlBox.Repaint;
 //     TrackPanel1.Repaint;
      ;
      OpenGLBox.Repaint;
end;

procedure TFormXom.OpenGLBoxClick(Sender: TObject);
begin
  OpenGLBox.OnOpenGL := true;
end;

procedure TFormXom.CentrButClick(Sender: TObject);
begin
if Xom.Mesh3D<>nil then
 TransView:=TVModel else begin
  TransView.xpos:=0;
  TransView.ypos:=0;
  TransView.zpos:=0;
  TransView.xrot := -20.0;
  TransView.yrot := 136.0;
  TransView.Per := 35.0;
  TransView.zoom := 50.0;
  end;
   If not Timer1.Enabled then  OpenGlBox.Repaint;
end;

procedure TFormXom.ShowXTypesClick(Sender: TObject);
begin
 if ShowXTypes.Down then begin
  TypeTree.Visible:=true;
  Panel12.Realign;
  TreeProgress.Realign;
 end else
 begin

 TypeTree.Visible:=false;
  Panel2.Width:= Panel2.Width-TypeTree.Width;
 end;

end;

var
Edited:Boolean;

procedure TFormXom.StringsMenuPopup(Sender: TObject);
var
Enable:Boolean;
Index:integer;
Str:String;
begin
Index:=StringsTable.Selection.Top;
Str:=StringsTable.Cells[1,Index];
StringST.Caption:=Str;
Enable:=Str<>'';
StringST.Enabled:=Enable;
EditST.Enabled:=Enable;
AddNewST.Enabled:=Enable;
end;

procedure TFormXom.StringSTClick(Sender: TObject);
var
Index:integer;
Str:String;
begin
Index:=StringsTable.Selection.Top;
Str:=StringsTable.Cells[1,Index];
ClipBoard.AsText:=Str;
end;

procedure TFormXom.EditSTClick(Sender: TObject);
//var
//Index:integer;
//Str:String;
begin
//Index:=StringsTable.Selection.Top;
StringsTable.Options:=StringsTable.Options+[goEditing];
StringsTable.EditorMode:=true;
end;

procedure TFormXom.AddNewSTClick(Sender: TObject);
var
Index:integer;
S:String;
Rect:TGridRect;
begin
Index:=StringsTable.RowCount;
    s := Format('%.2x', [byte128(Index + 1)]);
Index:=StringsTable.InsertRow(s, 'NewString', true);
Rect:=STringsTable.Selection;
Rect.Top:=Index;
Rect.Bottom:=Index;
STringsTable.Selection:=Rect;
StringsTable.Options:=StringsTable.Options+[goEditing];
StringsTable.EditorMode:=true;
Edited:=true;
end;

procedure TFormXom.StringsTableSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
StringsTable.Options:=StringsTable.Options-[goEditing];
if Value<>StringsTable.Cells[ACol,ARow] then
Edited:=true;

end;

procedure TFormXom.StringsTableSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
If Edited then begin
// обновить строки
  Xom.UpdateStringTable(StringsTable);
// обновляем дерево
  UpdateXomTree(true,false);
end;
Edited:=false;

end;

procedure TFormXom.SelButClick(Sender: TObject);
begin
  ToolButTemp.Down := false;
  OpenGLBox.Cursor := crDefault;
  SelBut.Down := true;
//  HmPickBut.Down:=false;
  ToolButTemp := SelBut;
   If not Timer1.Enabled then  OpenGLBox.Repaint;
end;

procedure TFormXom.TrackPanel1Paint(Sender: TObject);
begin
     If not Timer1.Enabled then OpenGLBox.Repaint;
end;


procedure TFormXom.TrackPanel1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
 Key:TGrafKey;
 i,n:integer;
 Found:Boolean;
 CurPos:TPoint;
 fY:Single;
begin
 Found:=false;

 if TrackPanel1.Cursor=crDefault then
 If GrafKeys<>nil then begin
   n:=Length(GrafKeys);
   for i:=0 to n-1 do
    if (GrafKeys[i].Rect.Left<X) and  (GrafKeys[i].Rect.Right>X) and
      (GrafKeys[i].Rect.Top<Y) and  (GrafKeys[i].Rect.Bottom>Y) then
       begin
       Key:=GrafKeys[i];
       Found:=true;
       Break;
       end;

 if Found then begin
        if  (Key.Frame=SelectKey)  then
        begin
        TrackPanel1.Cursor:=crMove;
        end
        else begin
        TrackPanel1.Cursor:=crSelect;
        SKey:=Key.Frame;
        end;
 end;
 end;

 if GpMove and (SelectKey<>nil) then begin
        GetCursorPos(CurPos);
        if X<40 then  SelectKey[4]:=0.0 else
                SelectKey[4]:=TrackPanel1.GetFloatX;
        fY:=TrackPanel1.GetFloatY;
        If ChillMode and ((fY>ChillMax) or (fY<0))
        then
        // error
        else
        SelectKey[5]:=fY;
        UpdateGraph;
 end;
 if EditAnim.Down  and (not TimeDrag) and
 (X<TrackPanel1.Width) and  (X>40) and
 (Y<TrackPanel1.Height) and  (Y>TrackPanel1.Height-12) then
    TrackPanel1.Cursor:=crOpenHand;

 if TimeDrag then  begin
 if X<41 then X:=41;
 CurAnimClip.Time:=FdTime*((TrackPanel1.Width-40)/(X-40));
 LabelTime.Caption := Format('%.2f sec', [CurAnimClip.Time]);
 UpdateGraph;
 end;

end;

procedure TFormXom.TrackPanel1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
case  TrackPanel1.Cursor of
crSelect:
 begin
   SelectKey:=SKey;
   UpdateGraph;
 //  TrackPanel1.Repaint;
   SKey:=nil;
 // select
 end;
crMove:
 begin
 GpMove:=true;
 end;
crDefault:
 begin
   SelectKey:=nil;
 //  TrackPanel1.Repaint;
 end;
crOpenHand:
 begin
 TimeDrag:=true;
 FdTime:=TrackPanel1.GetFloatX;
 TrackPanel1.Cursor:=crClosedHand;
 end;
end;

end;

procedure TFormXom.TrackPanel1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 // if TrackPanel1.Cursor=crSelect then
 if TimeDrag then
 TimeDrag:=false;

 If GpMove then begin
 UpdateAnimTree(TreeView2);
  GpMove:=false;
 UpdateGraph;
 end;

end;

procedure TFormXom.ClassTreeCustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
Begin

if not ClassTree.Focused and Node.Selected   then
  TCustomTreeView(Sender).Canvas.Font.Color := clGreen;
end;

var
NeedUpdate:Boolean;
MainNodeSelect:Boolean;

procedure TFormXom.TreeView2Changing(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
begin
// выделение объекта
MainNodeSelect:=Node.Level=0;
if (Node.Data<>nil) then
        begin
        case Node.level of
        1: if (TObject(Node.Data) is TMesh) then
        begin
        SelectType:=0;
        ActiveMesh:=TMesh(Node.Data);
        SelectObj:=ActiveMesh.Indx;
        OpenGLBox.Repaint;
        MoveBut.Enabled :=True;
        RotatBut.Enabled :=True;
        ScaleBut.Enabled :=True;
        UpdateGraph;
        NeedUpdate:=true;
        end;
        3:
        begin
        SelectType:=Integer(Node.Data);
        SelectObjName:=Node.Parent.Parent.Text;
        TrackPanel1.Repaint;
        UpdateGraph;
        NeedUpdate:=true;
        end;
        4:
        begin
        SelectKey:=Node.Data;
        TrackPanel1.Slider:=SelectKey[4];
        TrackPanel1.Repaint;
        end;

        end;
   end;
end;


procedure TFormXom.TreeView2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if   NeedUpdate then
        UpdateAnimTree(TreeView2);
        NeedUpdate:=False;
        MoveBut.Enabled :=EdMode;
        RotatBut.Enabled :=EdMode;
        ScaleBut.Enabled :=EdMode;
end;

procedure TFormXom.TrackPanel1DblClick(Sender: TObject);
begin
if (TrackPanel1.Cursor= crMove) then
        begin
        // delete SelectKey;
        CurAnimClip.DeleteKey(SelectKey);
        SelectKey:=nil;
        GpMove:=False;
        UpdateAnimTree(TreeView2);
        UpdateGraph;
        exit;
        end;

if (TrackPanel1.Cursor= crDefault)and(SelectKdata<>nil) then
        begin
        CurAnimClip.AddKey(SelectKdata,TrackPanel1.GetFloatX,0,TrackPanel1.GetFloatY,SelectType);
        UpdateAnimTree(TreeView2);
        UpdateGraph;
        end;
end;

procedure TFormXom.TreeView2DblClick(Sender: TObject);
begin
if (MainNodeSelect) then
begin
                SelectObj := 0;
                SelectKey := nil;
                SelectType:=0;
                MoveMode:=False;
                RotateMode:=False;
                ScaleMode:=False;
                ActiveMesh:=nil;
                EdMode:=false;
                UpdateAnimTree(TreeView2);
                UpdateGraph;
                MoveBut.Down :=false;
                RotatBut.Down :=false;
                ScaleBut.Down :=false;
                MoveBut.Enabled :=EdMode;
                RotatBut.Enabled :=EdMode;
                ScaleBut.Enabled :=EdMode;
                OpenGLBox.Repaint;
        end;
end;

procedure TFormXom.DrawBonesClick(Sender: TObject);
begin
OpenGLBox.Repaint;
end;

procedure TFormXom.Copy1Click(Sender: TObject);
var
  TextBuffer: string;
  i, j: Integer;
  KData:PKeyData;
begin
  TextBuffer := '';
  //FloatToStrF(LValClip,ffFixed,16,6);
  if SelectType <> 0 then
    begin
      KData:=CurAnimClip.FindKeyNameType(SelectObjName,SelectType);
      j:=Length(KData.Data);
      for i := 0 to j-1 do
      begin
        TextBuffer := TextBuffer + Format('%.6f%s%.6f%s%.6f%s%.6f%s%.6f%s%.6f%s',
          [KData.Data[i][0], Char(#09), KData.Data[i][1],
          Char(#09), KData.Data[i][2], Char(#09),
          KData.Data[i][3], Char(#09), KData.Data[i][4],
          Char(#09), KData.Data[i][5],
          Char(13) + Char(10)]);
      end;
      //
    end
    else
      Exit;
  ClipBoard.AsText := TextBuffer;
end;

procedure TFormXom.Paste1Click(Sender: TObject);
var
  TextBuffer: string;
  i, j, k: Integer;
  v: Extended;
  KData:PKeyData;
  tData:TKeyFrame;
  IsFloat:Boolean;
begin
  TextBuffer := ClipBoard.AsText;
  if (SelectType<>0) and (TextBuffer <> '') then
    begin
      KData:=CurAnimClip.FindKeyNameType(SelectObjName,SelectType);
      SetLength(KData.Data,0);
      j := 0;
      IsFloat:=true;
      While IsFloat do begin
       for i:=0 to 5 do begin
        if i=5 then k := Pos(Char(13), TextBuffer) else
        k := Pos(Char(#09), TextBuffer);
        IsFloat := TextToFloat(PChar(Copy(TextBuffer, 0, k - 1)), v, fvExtended);
        if not IsFloat then break;
        Delete(TextBuffer, 1, k);
        tData[i] := v;
        end;
        if not IsFloat then Break;
        Delete(TextBuffer, 1, 1);
        inc(j);
        SetLength(KData.Data,j);
        KData.Data[j-1]:= tData;
      end;
      UpdateGraph;
  end;
end;

procedure TFormXom.TrackPanel1ContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
var
 // BufPoint: TPoint;
  TextBuffer: string;
  v: Extended;
begin
  TextBuffer := ClipBoard.AsText;
  Copy1.Enabled := (SelectType<>0);
  Paste1.Enabled := (SelectType<>0) and
    TextToFloat(PChar(Copy(TextBuffer, 0, Pos(Char(#09), TextBuffer) - 1)),
    v, fvExtended);
end;

procedure TFormXom.AddElement1Click(Sender: TObject);
begin
//
CurAnimClip.AddKData(TMenuItem(Sender).KeyType);
CurAnimClip.SortKeys;
UpdateAnimTreeMenu(Add1,Delete1);
MainNodeSelect:=True;
TreeView2DblClick(Sender);
end;

procedure TFormXom.DelElement1Click(Sender: TObject);
begin
//
CurAnimClip.DeleteKData(TMenuItem(Sender).KeyType);
UpdateAnimTreeMenu(Add1,Delete1);
MainNodeSelect:=True;
TreeView2DblClick(Sender);
end;

procedure TFormXom.Import3dsClick(Sender: TObject);
begin
//Импорт
  if Open3ds.Execute and (Open3ds.FileName <> '') then
  begin
    Xom.Mesh3D.Load3DS(Open3ds.FileName);
    // обновляем дерево
    UpdateXomTree(true,false);
   // ClassTreeChange(ClassTree, ClassTree.Selected);
  end;
end;

procedure TFormXom.Export3dsClick(Sender: TObject);
var
s:string;
XCntr:TContainer;
begin
//Экспорт
 s := Xom.Mesh3D.Name;
 if s='' then s:=Xom.Mesh3D.XType;
  ClearName(s);
  Save3ds.FileName := Format('%s.3ds', [s]);
  if Save3ds.Execute and (Save3ds.FileName <> '') then
  begin
    Xom.Mesh3D.SaveAs3DS(Save3ds.FileName);
  end;
end;

procedure TFormXom.Changevalue1Click(Sender: TObject);
var
CntrVal:TCntrVal;
ParentNode,CurNode:TTreeNode;
begin
// изменяем значение
CntrVal:=TCntrVal(ClassTree.Selected.Data);
ValueForm.CntrVal:=CntrVal;
if ValueForm.ChgValForm.ShowModal=mrOk then
begin
// UpdateXom;
//StrArray[CntrVal.Cntr].Update:=true;
//ClassTree.Selected

//LoadXom:=False;
//TreeView1Change(Self,Xom.BaseNode);
//LoadXom := true;
if CntrVal.XType=XString then Xom.LoadValueString(StringsTable);
ParentNode:=ClassTree.Selected.Parent;
while Xom.IsContainer(ParentNode.Data)<>CntrVal.Cntr  do
        ParentNode:=ParentNode.Parent;
ParentNode.DeleteChildren;
CurNode:=Xom.AddClassTree(CntrVal.Cntr, ClassTree, nil);
CurNode.MoveTo(ParentNode,naInsert);
ParentNode.Delete;
CurNode.Expand(false);

ButSaveXom.Enabled := True;
end;
end;

procedure TFormXom.PopupMenu1Popup(Sender: TObject);
var
Test,isObject,Test2,Test3,Test4,Test5,Test6,Test7:boolean;
CntrVal:TCntrVal;
XCntr:TContainer;
i,j:integer;
p2:pointer;
XResourcesBool:array[0..7] of boolean;
begin
isObject:= Integer(ClassTree.Selected.Data) > 10000 ;
Test:= isObject and (TObject(ClassTree.Selected.Data) is TCntrVal);//(integer(ClassTree.Selected.Data)>10000);
Test2:= Xom.IsContainer(ClassTree.Selected.Data)<>nil;
Changevalue1.Enabled:=Test;
ExportXom.Enabled:=Test2; // еще добавить проверку XNone;
ExportXomAs1.Enabled:=Test2; // еще добавить проверку XNone;
if Test2 then begin
        XCntr:=Xom.IsContainer(ClassTree.Selected.Data);
        W3D1.Enabled:=not W3D and (length(XCntr.Childs)>0) and (XCntr.Childs[0]<>nil) and (XCntr.Childs[0].Xtype=ParticleEmitterContainer);
end;
ImportXom.Enabled:=XomImport and Test2 and (ClassTree.Selected.Level>0); // еще добавить проверку XNone;
DeleteCntr.Enabled:=Test2 and (ClassTree.Selected.Level>0);
Test3:= (ClassTree.Selected.Parent<>nil)and(Xom.IsCntrSet(ClassTree.Selected.Parent.Data)<>nil);
InsertinXGraph.Enabled:=XomImport and (ClassTree.Selected.Parent<>nil) and (Xom.IsContainer(ClassTree.Selected.Parent.Data)<>nil) and (Xom.IsContainer(ClassTree.Selected.Parent.Data).Xtype=XGraphSet);
DeletefromXGraph.Enabled:=InsertinXGraph.Enabled;
InsertCntr.Enabled:=XomImport and Test3;
XColor4ubSet1.Enabled:=Test2 and (Xom.IsContainer(ClassTree.Selected.Data).Xtype=XColor4ubSet);
Test6:=Test2 and (Xom.IsContainer(ClassTree.Selected.Data).Xtype=XDataBank);

AddXResource1.Enabled:=Test6;
Test7:=false;
if Test6 then
begin
 with ClassTree.Selected do
        for i:=0 to Count-1 do
                if (Pos(XResourceDetails[7],Item[i].Text) <> 0) then
                begin
                Test7:= (Pos('XStringResourceDetails',Item[i].Item[0].Text) <> 0);
                break;
                end;
end;
FixXString1.Enabled:= Test7;

IntResources1.Enabled:= Test6 and not Test7;
UintResources1.Enabled:= Test6 and not Test7;
StringResources1.Enabled:= Test6 and not Test7;
FloatResources1.Enabled:= Test6 and not Test7;
VectorResources1.Enabled:= Test6 and not Test7;
ContainerResources1.Enabled:= Test6 and not Test7;
//StringTableResources1.Enabled:= not XResourcesBool[6];
ColorResources1.Enabled:= Test6 and not Test7;


Test4:= isObject and (TObject(ClassTree.Selected.Data) is TSetCntr);
Test5:= isObject and (ClassTree.Selected.Parent<>nil) and  (Integer(ClassTree.Selected.Parent.Data) > 10000)
and (TObject(ClassTree.Selected.Parent.Data) is TSetCntr);
AddXValue1.Enabled:=Test4;
DeleteXValue1.Enabled:=Test5;

if Test then
begin
  CntrVal:=TCntrVal(ClassTree.Selected.Data);
  Changevalue1.Caption:=format('Change [%s]',[CntrVal.IdName]);
end else
  Changevalue1.Caption:='Change value';
end;

procedure TFormXom.ClassTreeAdvancedCustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; Stage: TCustomDrawStage;
  var PaintImages, DefaultDraw: Boolean);
var
  Rect: TRect;
  oldcolor:TColor;
begin
if (Node.ImageIndex>=$01000000) and (Stage = cdPostPaint) then begin
    With Sender.Canvas do begin
    Rect := Node.DisplayRect(True);
    Rect.Left:=Rect.Left-17;
    Rect.Right:=Rect.Left+14;
    Rect.Top:=Rect.Top+1;
    Rect.Bottom:=Rect.Top+14;
    oldcolor:=Brush.Color;
    Brush.Color:= Node.ImageIndex and $ffffff;
    FillRect(Rect);
    Rectangle(Rect);
    Brush.Color:= oldcolor;
    end;
  end;
end;


procedure TFormXom.ExportXomClick(Sender: TObject);
var
NewXom:TXom;
XCntr, RootCntr:TContainer;
CurNode: TTreeNode;
s:string;
begin
// сохранение Xom файла, выделеных контейнеров
  XCntr := TContainer(ClassTree.Selected.Data);
// сначала пробигаем по дереву собирая все контейнеры
  NewXom:=TXom.Create;
//  SetLength(NewCntrArr,0);
  RootCntr:=XCntr.BuildCntrArr(NewXom.CntrArr);
// затем создаем шапку xom файла c нужными типами
  NewXom.InitXomHandle;
  Xom.BuildXomHandle(NewXom.XomHandle,NewXom.CntrArr);
// собираем все строки которые используются в контейнерах

// включить флаг обработки индексов
// включаем флаг сбора строк
// Сделаем все за один проход:
// 1. пробегаясь по коду, автоматом меняем строки и добавляем новые
// 2. автоматом меняем индексы
NewXom.ReBuild:=true;
NewXom.XomHandle.StringTable.Add('');// добавляем пустую
NewXom.OldStringTable:=Xom.XomHandle.StringTable;
CurNode:=NewXom.AddClassTree(RootCntr, ClassTree, nil);
NewXom.OldStringTable:=nil; // !!! важно
// необходимо прочитать все строки сразу, чтобы не попасть на уже замененные
CurNode.Delete;
NewXom.ReBuild:=false;
// начинаем компановку контейнеров учитывая новые индексы строк и контейнеров
s:=RootCntr.Name;
ClearName(s);
SaveDialog3.FileName:=  Format('%s_%d.xom', [s,RootCntr.Index]);
  NewXom.SaveXom(SaveDialog3);
  NewXom.Free;
end;

procedure TFormXom.UpdateXomTree(Save:boolean;ReloadString:Boolean=true);
var i:integer;
XCntr:TContainer;
begin
// обновляем дерево
if Save then  begin

  Xom.Loading:=true;
  Xom.ReBuildTypeTree(TypeTree);
  Xom.Loading:=false;
  StripSetConv.Enabled:=Xom.SearchType(XIndexedTriangleStripSet,i);

  XWeightSet1.Enabled:=not Xom.SearchType(XPaletteWeightSet,i) and Xom.SearchType(XWeightSet,i);
  XWeightSet1.Enabled:=XWeightSet1.Enabled and (i>0);
  TriStripConv.Enabled:=Xom.SearchType(XIndexedTriangleSet,i);
  TypeTree.Visible := true and ShowXTypes.Down;
  ButSaveXom.Enabled := True;
  end;

  XomUpdating := true;
  TypeTree.Selected:=nil;
  TypeTree.Select(Xom.BaseNode);

  for i:=0 to TypeTree.Items.Count-1 do
   if (TypeTree.Items[i].Level = 1) then begin
   XCntr:=Xom.IsContainer(TypeTree.Items[i].Data);
   if XCntr.Name<>'' then
   TypeTree.Items[i].Text:=format('%d. "%s"',[XCntr.Index,XCntr.Name])
   else TypeTree.Items[i].Text:=format('%d. %s',[XCntr.Index,'Data'])
  end;

  XomUpdating := false;

// обновить строки
if ReloadString then
  Xom.LoadValueString(StringsTable);
end;



procedure TFormXom.ImportXomClick(Sender: TObject);
var
NewXom:TXom;
XCntr:TContainer;
CurNode: TTreeNode;
s:string;
begin
  XCntr := TContainer(ClassTree.Selected.Data);
  if OpenDialog4.Execute and (OpenDialog4.FileName <> '') then
  begin
// открываем Xom файл, считывая контейнеры
  NewXom:=TXom.Create;
  NewXom.LoadXomFileName(OpenDialog4.FileName, s,false);
  Xom.InsertXom(NewXom,XCntr,false,nil);

  NewXom.Free;
  // обновляем дерево
  UpdateXomTree(true);
  // выделяем элемент который вставили
  XCntr:=Xom.CntrArr[Xom.LastCounter];
  CurNode:=SearchTreeCntr(ClassTree,XCntr);
  ClassTree.Select(CurNode);
  end;
end;

procedure TFormXom.InsertCntrClick(Sender: TObject);
var
NewXom:TXom;
XCntr:TContainer;
CurNode: TTreeNode;
s:string;
begin
  XCntr := TContainer(ClassTree.Selected.Data);
  if OpenDialog4.Execute and (OpenDialog4.FileName <> '') then
  begin

// открываем Xom файл, считывая контейнеры
  NewXom:=TXom.Create;
  NewXom.LoadXomFileName(OpenDialog4.FileName, s,false);
  Xom.InsertXom(NewXom,XCntr,true,Xom.IsCntrSet(ClassTree.Selected.Parent.Data));

  NewXom.Free;
  // обновляем дерево
  UpdateXomTree(true);
  // выделяем элемент который вставили
  XCntr:=Xom.CntrArr[Xom.LastCounter];
  CurNode:=SearchTreeCntr(ClassTree,XCntr);
  ClassTree.Select(CurNode);

  end;
end;

procedure TFormXom.DeleteCntrClick(Sender: TObject);
var
XCntr:TContainer;
CurNode: TTreeNode;
CntrSet:TCntrSet;
Index:integer;
begin
  XCntr := TContainer(ClassTree.Selected.Data);
  Index:= XCntr.DelNoClone(Xom.BaseCntr);
// пересчитываем размеры всех типов в старом файле
  Xom.ReSizeTypes;
// пересчет конейтейнеров;
  Xom.ReCalcCntr;
///
  Xom.OldStringTable:=Xom.XomHandle.StringTable;
  Xom.ReBuild:=true;
  CntrSet:=Xom.IsCntrSet(ClassTree.Selected.Parent.Data);
  //Уменьшить размер массива в контейнере
  if CntrSet<>nil then begin
        CntrSet.ClearIndex(Index);
        CntrSet.DecSize;
   end;//последний индекс, нужно удалить
  CurNode:=Xom.AddClassTree(Xom.BaseCntr, ClassTree, nil);
  CurNode.Delete;
  Xom.OldStringTable:=nil;
  Xom.BaseNode.Data:=Xom.BaseCntr;
  // вырубить ребуилд для всех контейнеров!!!
  Xom.CntrArr.OffReBuild;
  Xom.ReBuild:=false;
// обновляем дерево
  UpdateXomTree(true);
end;

procedure TFormXom.ForceOnClick(Sender: TObject);
begin
if not ForceOn.Checked then
        UpdateXomTree(false,false);
end;

function HexToByte (S:Pchar):Byte;
const
Convert: array['0'..'f'] of SmallInt =
    ( 0, 1, 2, 3, 4, 5, 6, 7, 8, 9,-1,-1,-1,-1,-1,-1,
     -1,10,11,12,13,14,15,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
     -1,10,11,12,13,14,15);
begin
        result := Byte((Convert[S[0]] shl 4) + Convert[S[1]]);
end;

procedure TFormXom.HexEditKeyPress(Sender: TObject; var Key: Char);
var
str:string;
begin
if not (Key in [#3,#22,#127, '0'..'9', 'a'..'f', 'A'..'F']) then
      key := #0;

if (Key in [#3, #22]) then begin
{if  (Clipboard.HasFormat(CF_TEXT)) then
begin
//Str:=ClipBoard.AsText;
// проверить длинну вставляемого кода
// удалить в нем все неверные символы   
end else key := #0;      }
exit;
end;

if HexEdit.SelLength>1 then key := #0;

if (Key <> #0) then begin
if HexEdit.SelLength=0 then HexEdit.SelLength := 1;
if HexEdit.SelText=' ' then begin
        HexEdit.SelStart:=HexEdit.SelStart+1;
        HexEdit.SelLength := 1;
        end;
end;

end;

procedure TFormXom.HexEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
oldlen:integer;
posS:integer;
begin

if (HexEdit.SelLength mod 3)<>0 then begin
  HexEdit.SelLength:=HexEdit.SelLength-(HexEdit.SelLength mod 3);
end;

if Key=VK_DELETE then begin
  if HexEdit.SelLength=0 then HexEdit.SelLength := 3;
end;

  posS:=Pos(' ',HexEdit.SelText);

if ((ssCtrl in Shift) and (Key = ord('V'))) then
  if HexEdit.SelLength=0 then posS:=3-(HexEdit.SelStart mod 3);


  if posS=2 then
        begin
          oldlen:=HexEdit.SelLength;
          HexEdit.SelStart := HexEdit.SelStart-1;
          HexEdit.SelLength := oldlen;
        end;

  if posS=1 then
        begin
          oldlen:=HexEdit.SelLength;
          HexEdit.SelStart := HexEdit.SelStart+1;
          HexEdit.SelLength := oldlen;
        end;

end;

procedure TFormXom.SaveAsBinClick(Sender: TObject);
var
  VirtualBufer: TMemoryStream;
  XCntr:TContainer;
begin
  XCntr := Xom.IsContainer(ClassTree.Selected.Data);
  if XCntr <> nil then
  begin
    SaveDialog1.FileName := Format('(%d).bin', [XCntr.Index]);

    if SaveDialog1.Execute then
      if SaveDialog1.FileName <> '' then
      begin
        VirtualBufer := TMemoryStream.Create;
        VirtualBufer.Write(XCntr.point^, XCntr.size);
        VirtualBufer.SaveToFile(SaveDialog1.FileName);
        VirtualBufer.Free;
      end;
  end;
end;

procedure TFormXom.HexUpdate(XCntr:TContainer);
var
str:string;
k,size:integer;
p:pointer;
begin
    // HEX
    Str := '';
    p   := XCntr.point;
    size := XCntr.size;
 //   if size>500000 then size :=500000;
    HexEdit.Visible:=false;
    HexEdit.Lines.Clear;
    for k := 0 to size - 1 do
      Str := Str + Format('%.2x ', [Byte(Pointer(Longword(p) + k)^)]);
    HexEdit.Lines.Add(Str);
    HexEdit.Visible:=true;
end;

procedure TFormXom.WriteHex1Click(Sender: TObject);
var
i,j,len:integer;
str:PChar;
Text:String;
_byte:Byte;
  VirtualBufer: TMemoryStream;
  XCntr:TContainer;
  xSize:integer;
begin
  XCntr := Xom.IsContainer(ClassTree.Selected.Data);
VirtualBufer:=TMemoryStream.Create;
Text:=HexEdit.Lines.Text;
// хорошо бы удалить все переводы коретки
str:=Pchar(Text);
j:=0;
len:=Length(Text)-2;
while j<len do begin
 _byte:=HexToByte(str);
 VirtualBufer.Write(_byte,1);
 inc(Longword(str),3);
 inc(j,3);
end;
{for j:=0 to HexEdit.Lines.Count-1 do
        for i:=0 to 7 do begin
          str:=Pchar(HexEdit.Lines[j])+i*3;
          if Length(str)=0 then break;
          _byte:=HexToByte(str);
          VirtualBufer.Write(_byte,1);
        end;  }
    XCntr.FreeXMem;
    XCntr.Update := true;
    xSize := VirtualBufer.Position;
    XCntr.point := AllocMem(xSize);
    Move(VirtualBufer.Memory^, XCntr.point^, xSize);
    XCntr.size:= xSize;
    VirtualBufer.Free;
  // обновляем дерево
  UpdateXomTree(true);
end;

procedure TFormXom.HexEditContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
var
Text,s:string;
str:PChar;
i:integer;
p:pointer;
val:single;
bytes:array[0..3]of byte;
begin
WriteHex1.Enabled:=SaveAsBin.Enabled;  // если нужно добавить проверку
p:=@Bytes[0];
Integer(p^):=0;
// преобразуем выделеный текст в индекс
if HexEdit.SelLength>1 then begin
 Text:=TrimLeft(HexEdit.SelText);
for i:=0 to 3 do begin
          str:=Pchar(Text)+i*3;
          if Length(str)=0 then break;
          bytes[i]:=HexToByte(str);
end;
i:=TestByte128(p);
HexIndex.Caption:=format('Index = %d',[i]);
p:=@Bytes[0];
s:=Xom.GetStr128(p);
HexStr.Caption:=format('Str = "%s"',[s]);
p:=@Bytes[0];
val:=Single(p^);
HexFloat.Caption:=format('Float = "%.2f"',[val]);
end;
end;

procedure TFormXom.StripSetConvClick(Sender: TObject);
var
i,StartIndex,Index,Count:Integer;
begin
// конвертирование XIndexedTriangleStripSet
// в XIndexedTriangleSet с удалением старого и созданием нового типа
// Нужно заменить XIndexedTriangleStripSet и XIndexSet
// Замену делаем сразу во всем файле
//StripSetConv.Enabled:=False;
if Xom.SearchType(XIndexedTriangleStripSet,Index) then
begin
  Count:=Xom.XomHandle.TypesInfo[Index].Size;
  StartIndex:=Xom.CntrArr.FoundXType(XIndexedTriangleStripSet)-Count;
  for i:=0 to Count-1 do
     Xom.CntrArr[StartIndex+i].StripSetToTri;  //функция автоматом конвертирует контейнер и XIndexSet
  Xom.SetType(Index,TRIGUID,XIndexedTriangleSet);
  // обновляем дерево
  UpdateXomTree(true);
end;
end;

procedure TFormXom.TriStripConvClick(Sender: TObject);
var
i,StartIndex,Index,Count:Integer;
begin
if Xom.SearchType(XIndexedTriangleSet,Index) then
begin
  Count:=Xom.XomHandle.TypesInfo[Index].Size;
  StartIndex:=Xom.CntrArr.FoundXType(XIndexedTriangleSet)-Count;
  for i:=0 to Count-1 do
     Xom.CntrArr[StartIndex+i].TriToStripSet;  //функция автоматом конвертирует контейнер и XIndexSet
  Xom.SetType(Index,STRIPGUID,XIndexedTriangleStripSet);
  // обновляем дерево
  UpdateXomTree(true);
end;
end;

procedure TFormXom.WMDropFiles(var Msg: TWMDropFiles);
var
  CFileName: array[0..MAX_PATH] of Char;
begin
  try
    if DragQueryFile(Msg.Drop, 0, CFileName, MAX_PATH) > 0 then
    begin
      if (Pos('.XOM',UpperCase(CFileName))<>0)then
                OpenXomFile(CFileName);
      Msg.Result := 0;
    end;
  finally
    DragFinish(Msg.Drop);
  end;
end;



procedure TFormXom.ShowBuildClick(Sender: TObject);
var
OldNode,CurNode:TTreeNode;
begin
if ShowBuild.Down=False then begin
BuildPanel.Visible:=false;
Panel2.Visible:=True;
MoveBut.Down :=False;
MoveBut.Enabled :=False;
if Xom.WFBuilds.Changed then begin
// тут заменяем контейнер
 Xom.FortsBuildUpdate;

if Xom.WFBuilds.NewString then Xom.LoadValueString(StringsTable);
OldNode:=Xom.WFBuilds.Node ;
OldNode.DeleteChildren;
CurNode:=Xom.AddClassTree(Xom.WFBuilds.Cntr, ClassTree, nil);
CurNode.MoveTo(OldNode,naInsert);
OldNode.Delete;
CurNode.Expand(false);
ButSaveXom.Enabled := True;
 Xom.WFBuilds.Changed:=false;
end;
end else begin
BuildPanel.Visible:=true;
Panel2.Visible:=False;
UpdateBuildPanel;
end;
end;

procedure TFormXom.UpdateBuildClick(Sender: TObject);
begin
// сохраняем изменения
With Xom.WFBuilds.Items[SelectObj-1] do begin
// выгружаем данные
Name:=EdName.Text;
Star:=ChStar.Checked;
if TypeBox.ItemIndex=16 then BuildType:=255 else
BuildType:=TypeBox.ItemIndex;
PlayerID:=Round(BTeam.GetFloatVal);
Connections:=0;
  if ChLink00.Checked then Connections:= Connections or (1 shl 0);
  if ChLink01.Checked then Connections:= Connections or (1 shl 1);
  if ChLink02.Checked then Connections:= Connections or (1 shl 2);
  if ChLink03.Checked then Connections:= Connections or (1 shl 3);
  if ChLink04.Checked then Connections:= Connections or (1 shl 4);
  if ChLink05.Checked then Connections:= Connections or (1 shl 5);
  if ChLink06.Checked then Connections:= Connections or (1 shl 6);
  if ChLink07.Checked then Connections:= Connections or (1 shl 7);
end;
Xom.WFBuilds.Changed:=true;
Xom.WFBuilds.NewString:=true;
end;

procedure TFormXom.UpdateBuildPanel;
var
Enabl:Boolean;
begin
// обновляем данные
Enabl:=SelectObj>0;
Label7.Enabled:=Enabl;
Label8.Enabled:=Enabl;
EdName.Enabled:=Enabl;
ChStar.Enabled:=Enabl;
BTeam.Enabled:=Enabl;
LinkBox.Enabled:=Enabl;
UpdateBuild.Enabled:=Enabl;
BuildDelete.Enabled:=Enabl;
if Enabl then with Xom.WFBuilds.Items[SelectObj-1] do begin
        // загружаем их
        EdName.Text:=Name;
        ChStar.Checked:=Star;
        if BuildType>16 then TypeBox.ItemIndex:=16 else
        TypeBox.ItemIndex:=BuildType;

        BTeam.FloatVal:=PlayerID;
  ChLink00.Checked:= (Connections and (1 shl 0))>0;
  ChLink01.Checked:= (Connections and (1 shl 1))>0;
  ChLink02.Checked:= (Connections and (1 shl 2))>0;
  ChLink03.Checked:= (Connections and (1 shl 3))>0;
  ChLink04.Checked:= (Connections and (1 shl 4))>0;
  ChLink05.Checked:= (Connections and (1 shl 5))>0;
  ChLink06.Checked:= (Connections and (1 shl 6))>0;
  ChLink07.Checked:= (Connections and (1 shl 7))>0;
end;

end;

procedure TFormXom.PaintLinesPaint(Sender: TObject);
var
bp,Pmax:TPoint;
begin
Pmax.X:=PaintLines.Width;
PMax.Y:=PaintLines.Height;
bp.X:=Pmax.X div 2;
bP.Y:=PMax.Y div 2;

with PaintLines.Canvas do begin
        if ChLink00.Checked then  begin MoveTo(bp.X,bP.Y);LineTo(Pmax.X,bP.Y); end;
        if ChLink01.Checked then  begin MoveTo(bp.X,bP.Y);LineTo(bp.X,PMax.Y); end;
        if ChLink02.Checked then  begin MoveTo(bp.X,bP.Y);LineTo(0,bP.Y); end;
        if ChLink03.Checked then  begin MoveTo(bp.X,bP.Y);LineTo(bp.X,0); end;
        if ChLink04.Checked then  begin MoveTo(bp.X,bP.Y);LineTo(Pmax.X,Pmax.Y); end;
        if ChLink05.Checked then  begin MoveTo(bp.X,bP.Y);LineTo(Pmax.X,0); end;
        if ChLink06.Checked then  begin MoveTo(bp.X,bP.Y);LineTo(0,Pmax.Y); end;
        if ChLink07.Checked then  begin MoveTo(bp.X,bP.Y);LineTo(0,0); end;
end;
end;

procedure TFormXom.ChLink00Click(Sender: TObject);
begin
PaintLines.Repaint;
end;

procedure TFormXom.BuildDeleteClick(Sender: TObject);
var
i:Integer;
begin
for i:=SelectObj-1 to Xom.WFBuilds.Count-2 do
begin
Xom.WFBuilds.Items[i]:=Xom.WFBuilds.Items[i+1];
end;
SetLength(Xom.WFBuilds.Items,Xom.WFBuilds.Count-1);
Xom.WFBuilds.Count:=Length(Xom.WFBuilds.Items);
Xom.WFBuilds.Changed:=true;
end;

procedure TFormXom.TabSheet3Show(Sender: TObject);
var
XCntr:TContainer;
begin
// обновление хекса
if ClassTree.Selected<> nil then begin
XCntr := Xom.IsContainer(ClassTree.Selected.Data);
if XCntr<>nil then HexUpdate(XCntr);
end;
end;

procedure TFormXom.StringsTableDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  TW, TL : integer; //Text Width, Text Left
  Options: Longint;
  Text:WideString;
  X, Y: Integer;
begin
{
if (ARow>0) and (ACol>0)then begin

  StringsTable.Canvas.FillRect(Rect);
  Text:=Utf8Decode(StringsTable.Cells[ACol, ARow]);
  X:=Rect.Left+2;
  y:=Rect.Top+2;
With StringsTable.Canvas do
begin
  Options := ETO_CLIPPED or ETO_OPAQUE;
  Windows.ExtTextOutW(Handle, X, Y, Options, @Rect, PWideChar(Text),
    Length(Text), nil);
//  StringsTable.Canvas.TextRect(Rect, Rect.Left+2, Rect.Top+2, Utf8Decode(StringsTable.Cells[ACol, ARow]));
end;

end; }
end;

procedure TFormXom.StringSTDrawItem(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; Selected: Boolean);
begin
//
end;


procedure TFormXom.FilltoWhite1Click(Sender: TObject);
var
XCntr:TContainer;
Num:Integer;
p2:Pointer;
begin
  XCntr := TContainer(ClassTree.Selected.Data);
  p2:=XCntr.GetPoint;
  Num:=TestByte128(p2);
  XCntr.FillColor(Num,255);
  // обновляем дерево
  UpdateXomTree(true);
end;

procedure TFormXom.FillToBlack1Click(Sender: TObject);
var
XCntr:TContainer;
Num:Integer;
p2:Pointer;
begin
  XCntr := TContainer(ClassTree.Selected.Data);
  p2:=XCntr.GetPoint;
  Num:=TestByte128(p2);
  XCntr.FillColor(Num,0);
  // обновляем дерево
  UpdateXomTree(true);
end;

procedure TFormXom.ImportVertexColor1Click(Sender: TObject);
var VCMesh:TMesh;
begin
 if OpenVertexColor.Execute then begin
   VCMesh:=TMesh.Create(Xom.CntrArr);
   VCMesh.ReadVCFile(OpenVertexColor.FileName);
   // загружаем цвета
   // пробегаемся по всему мешу делая поиск подобных вертексов и изменяя их цвет.
   // с обновлением контейнера
   Xom.Mesh3D.TestApplyVC(VCMesh);
   VCMesh.Free;
   UpdateXomTree(true);
 end;
end;


procedure TFormXom.ScanPeaks2(decoder : HSTREAM);
var
  cpos,level : DWord;
  peak : array[0..1] of DWORD;
  position : DWORD;
  counter : integer;
begin
  setlength(wavebufL,0);
  setlength(wavebufR,0);
  setlength(wavebufL,PB.Width);
  setlength(wavebufR,PB.Width);
  cpos := 0;
  peak[0] := 0;
  peak[1] := 0;
  counter := 0;
  killscan:=false;
  while not killscan do
  begin
    level := BASS_ChannelGetLevel(decoder); // scan peaks
    if (peak[0]<LOWORD(level)) then
      peak[0]:=LOWORD(level); // set left peak
		if (peak[1]<HIWORD(level)) then
      peak[1]:=HIWORD(level); // set right peak
    if BASS_ChannelIsActive(decoder) <> BASS_ACTIVE_PLAYING then
    begin
      position := cardinal(-1); // reached the end
		end else
      position := BASS_ChannelGetPosition(decoder,BASS_POS_BYTE) div bpp;

    if position > cpos then
    begin
      inc(counter);
      if counter <= length(wavebufL)-1 then
      begin
        wavebufL[counter] := peak[0];
        wavebufR[counter] := peak[1];
      end;

      if (position >= dword(Buffer.Width)) then
        break;
      cpos := position;
     end;


    peak[0] := 0;
    peak[1] := 0;
  end;
//  if decoder<>chan then
  BASS_StreamFree(decoder); // free the decoder
end;

//------------------------------------------------------------------------------

{ TScanThread }

constructor TScanThread.Create(decoder: HSTREAM);
begin
  inherited create(false);
  Priority := tpNormal;
  FreeOnTerminate := true;
  FDecoder := decoder;
end;

procedure TScanThread.Execute;
begin
  inherited;
  FormXom.ScanPeaks2(FDecoder);
  Terminate;
end;

//------------------------------------------------------------------------------


procedure TFormXom.DrawTime_Line(position : QWORD; y : integer; cl : TColor);
var
  sectime : single;
  str:string;
  x : integer;
begin
  sectime := BASS_ChannelBytes2Seconds(chan,position);
  x := position div bpp;
  //format time
  str := format('%.2f',[sectime]);

  //drawline
  Buffer.Canvas.Pen.Color := cl;
  Buffer.Canvas.MoveTo(x,0);
  Buffer.Canvas.LineTo(x,Buffer.Height);

  //drawtext
  Buffer.Canvas.Font.Color := cl;
  Buffer.Canvas.Font.Style := [fsBold];
  if x > Buffer.Width-20 then
    dec(x,40);
  SetBkMode(Buffer.Canvas.Handle,TRANSPARENT);
  Buffer.Canvas.TextOut(x+2,y,str);
end;               


procedure TFormXom.DrawSpectrum;
var
  i,ht : integer;
begin
  //clear background
  Buffer.Canvas.Brush.Color := clBlack;
  Buffer.Canvas.FillRect(Rect(0,0,Buffer.Width,Buffer.Height));

  //draw peaks
  ht := Buffer.Height div 2;
  for i:=0 to length(wavebufL)-1 do
  begin
    Buffer.Canvas.MoveTo(i,ht);
	  Buffer.Canvas.Pen.Color := clLime;
    Buffer.Canvas.LineTo(i,ht-trunc((wavebufL[i]/32768)*ht));
    Buffer.Canvas.Pen.Color := clLime;
    Buffer.Canvas.MoveTo(i,ht+2);
	  Buffer.Canvas.LineTo(i,ht+2+trunc((wavebufR[i]/32768)*ht));
  end;
end;

procedure ErrorPop(str:string);
begin
  //show last BASS errorcode when no argument is given, else show given text.
  if str = '' then
    Showmessage('Error code: '+inttostr(BASS_ErrorGetCode()))
  else
    Showmessage(str);
  //Application.Terminate;
end;

procedure LoopSyncProc(handle: HSYNC; channel, data: DWORD; user: Pointer); stdcall;
begin
     if FormXom.OggLoop.Checked then
        BASS_ChannelSetPosition(channel,0,BASS_POS_BYTE);
end;


procedure TFormXom.OggLoadFile(filename:String;buf:pointer);
var
  data : array[0..2000] of SmallInt;
  i,len,bytesPerSample : integer;
begin
 //
 if OggLib then
 begin
    BASS_ChannelStop(chan);
    BASS_StreamFree(chan);

      Oggrate.Caption:=format('%d Hz',[Info.freq]);
      if Info.chans=1 then
        oggchan.Caption:='Mono'
      else
      oggchan.Caption:='Stereo';

    if filename='' then begin
     WaveStream.Free;
     //  chan := BASS_StreamCreate(Info.freq, Info.Chans, Info.flags,STREAMPROC_PUSH,nil);
     WaveStream := TMemoryStream.Create;
        len:=Integer(buf^);
        Inc(Longword(buf),4);
     if fsbsound then Mp3Save.Enabled:=true else
     begin
     with WaveHdr do
        begin
		riff := 'RIFF';
		clen := len+44-8;
		cWavFmt := 'WAVEfmt ';
		dwHdrLen := 16;
		wFormat := 1;
		wNumChannels := Info.Chans;
		dwSampleRate := Info.freq;
                wBitsPerSample := 16;
       	        wBlockAlign := (wBitsPerSample div 8)*wNumChannels;
		dwBytesPerSec := dwSampleRate*wBlockAlign;

		cData := 'data';
		dwDataLen := len;
        end;
	WaveStream.Write(WaveHdr, SizeOf(WAVHDR));
        OggSave.Enabled:=true;
     end;
        WaveStream.Write(buf^, len);
        // complete the WAV header

	// create a stream from the recorded data
	chan := BASS_StreamCreateFile(True, WaveStream.Memory, 0, WaveStream.Size, 0);
        
   //  BASS_StreamPutData(chan,buf,len);
  //   BASS_StreamPutData(chan, nil, BASS_STREAMPROC_END);
    end else
  //creating stream
    chan := BASS_StreamCreateFile(FALSE,pchar(filename),0,0,0);

   if (chan = 0) then
      begin
        OggStatus.Caption:='Not loaded';
        ErrorPop('Can''t play file');
        Exit;
      end;


   if (filename='') and (not FSBsound) then begin
        OggFileSize.Caption:=trimLeft(FormatFloat('# ### ### ### byte', len));
    end else begin
        OggFileSize.Caption:=trimLeft(FormatFloat('# ### ### ### byte', BASS_StreamGetFilePosition(chan,BASS_FILEPOS_END)));
        len:=BASS_ChannelGetLength(chan,BASS_POS_BYTE); // the length in bytes
    end;
    OggTime.Caption:=FormatFloat('##0.## sec',  BASS_ChannelBytes2Seconds(chan, len)); // the length in seconds
    OggStatus.Caption:='Loaded';
    Oggbitrate.Caption:=FormatFloat('##0.## kbit/s', (BASS_StreamGetFilePosition(chan,BASS_FILEPOS_END) / (125 * BASS_ChannelBytes2Seconds(chan, len))) + 0.5);
    //playing stream and setting global vars
    for i:=0 to length(data)-1 do data[0] := 0;
    bpp := BASS_ChannelGetLength(chan,BASS_POS_BYTE) div   Buffer.Width; // stream bytes per pixel
    if (bpp < BASS_ChannelSeconds2Bytes(chan,0.02)) then // minimum 20ms per pixel (BASS_ChannelGetLevel scans 20ms)
      bpp := BASS_ChannelSeconds2Bytes(chan,0.02);
     //getting peak levels in seperate thread, stream handle as parameter
    if filename='' then
    begin      
    //chan2:=chan
    chan2 := BASS_StreamCreateFile(True, WaveStream.Memory, 0, WaveStream.Size, BASS_STREAM_DECODE);
  //   chan2 := BASS_StreamCreate(Info.freq, Info.Chans, BASS_STREAM_DECODE ,STREAMPROC_PUSH,nil);
 //    BASS_StreamPutData(chan2,buf,len);
  //   BASS_StreamPutData(chan2, nil, BASS_STREAMPROC_END);
  //   ScanPeaks2(chan2);
     end
    else      begin
    chan2 := BASS_StreamCreateFile(FALSE,pchar(filename),0,0,BASS_STREAM_DECODE);
     end;
    killscan:=true;
    TScanThread.Create(chan2); // start scanning peaks in a new thread

   // if OggLoop.Checked and (OggLoopend>0) then
    BASS_ChannelSetSync(chan,BASS_SYNC_POS,len,LoopSyncProc,0);
  //  else
  //  BASS_ChannelSetSync(chan,BASS_SYNC_END or BASS_SYNC_MIXTIME,0,LoopSyncProc,0); // set sync to loop at end
    BASS_ChannelPlay(chan,FALSE); // start playing
 end;
end;

procedure TFormXom.InitOggLib;
begin
OggLib:=true;	// check the correct BASS was loaded
if (HIWORD(BASS_GetVersion) <> BASSVERSION) then
	begin
		MessageBox(0,'An incorrect version of BASS.DLL was loaded',0,MB_ICONERROR);
                OggLib:=false;
	end;

  Buffer := TBitmap.Create;
  Buffer.Width:= PB.Width;
  Buffer.Height:= PB.Height;
  PB.Parent.DoubleBuffered := true;

  //set array size
  setlength(wavebufL,PB.Width);
  setlength(wavebufR,PB.Width);

  //init BASS

if OggLib then begin
  if not BASS_Init(-1,44100,0,Application.Handle,nil) then
    ErrorPop('Can''t initialize device');
end;

end;

procedure TFormXom.OggPauseClick(Sender: TObject);
begin
if OggLib then
 begin
  if OggPause.Down then
        BASS_Pause()
        else
        BASS_Start();
 end;
end;

procedure TFormXom.OggStopClick(Sender: TObject);
begin
 if OggLib and (chan<>0) then
 begin
   BASS_ChannelStop(chan);
   BASS_ChannelSetPosition(chan,0,BASS_POS_BYTE);
 end;
end;

procedure TFormXom.PBPaint(Sender: TObject);
begin
  PB.Canvas.Draw(0,0,Buffer);
end;

procedure TFormXom.Panel18Resize(Sender: TObject);
begin
  Buffer.Width:= PB.Width;
  Buffer.Height:= PB.Height;
end;

procedure TFormXom.OggPlayClick(Sender: TObject);
begin
if OggLib and (chan<>0) then
BASS_ChannelPlay(chan,FALSE);
end;

procedure TFormXom.OggSaveClick(Sender: TObject);
begin
	if SaveWav.Execute then
		WaveStream.SaveToFile(SaveWav.FileName);
end;


procedure TFormXom.FSBOpenClick(Sender: TObject);
var
s:string;
begin
if OggLib and (chan<>0) then
begin
    BASS_ChannelStop(chan);
    BASS_StreamFree(chan);
end;
        if FSBDialog.Execute then
        begin
                s := ExtractFileName(FSBDialog.FileName);
                Caption:=Format('%s - [%s]', [APPVER,s]);
                FSB.OpenFile(FSBDialog.FileName,ClassTree);
        end;
end;

procedure TFormXom.Mp3saveClick(Sender: TObject);
begin
	if SaveMp3.Execute then
		WaveStream.SaveToFile(SaveMp3.FileName);
end;

procedure TFormXom.SobOpenClick(Sender: TObject);
var
s:string;
begin
if OggLib and (chan<>0) then
begin
    BASS_ChannelStop(chan);
    BASS_StreamFree(chan);
end;
        if SobDialog.Execute then
        begin
                s := ExtractFileName(SobDialog.FileName);
                Caption:=Format('%s - [%s]', [APPVER,s]);
                SOB.OpenFile(SobDialog.FileName,ClassTree);
        end;
end;

procedure TFormXom.PBMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if OggLib and (chan<>0) then
begin
        BASS_ChannelSetPosition(chan,dword(x)*bpp,BASS_POS_BYTE);
end;
end;

procedure TFormXom.ClassTreeDblClick(Sender: TObject);
begin
if ClassTree.Selected<> nil then
ClassTreeChange(Sender,ClassTree.Selected);
end;

type    TBinItem = record
                Name:Integer;
                Str:Integer;
        end;

        ABinItem = array of TBinItem;

        TBinFile = record
                Version:Integer;
                BlockLength:Integer;
                NumStrings:Integer;
                SizeItem:Integer;
                IndexTable: ABinItem;
                Data:Pointer;
        end;
procedure TFormXom.OpenLangClick(Sender: TObject);
var
i:integer;
Buf:TMemoryStream;
Size,SavePos:LongWord;
s:string;
bin:TBinFile;
begin
 if OpenLangDialog.Execute then
        begin
          s := ExtractFileName(OpenLangDialog.FileName);
          Caption:=Format('%s - [%s]', [APPVER,s]);
          Buf := TMemoryStream.Create;
          Buf.LoadFromFile(OpenLangDialog.FileName);
          Buf.ReadBuffer(bin.Version,4);
          Buf.ReadBuffer(bin.BlockLength,4);
          SavePos:=Buf.Position;
          bin.Data:=AllocMem(bin.BlockLength);
          Buf.ReadBuffer(bin.Data^,bin.BlockLength);
          Buf.Position:=SavePos;
          Buf.ReadBuffer(bin.NumStrings,4);
          SetLength(bin.IndexTable,bin.NumStrings);
          Buf.ReadBuffer(bin.SizeItem,4);
          Size:=bin.NumStrings*bin.SizeItem;
          Buf.ReadBuffer(bin.IndexTable[0],Size);
          Buf.Free;

          LangStrings.Cells[0,0]:='№';
          LangStrings.Cells[1,0]:='Name';
          LangStrings.Cells[2,0]:='Value';
          LangStrings.ColWidths[0]:=30;
          LangStrings.ColWidths[1]:=55;
          LangStrings.ColWidths[2]:=400;
          LangStrings.RowCount:=bin.NumStrings;

          for i:=0 to bin.NumStrings-1 do
          begin
            LangStrings.Cells[0,i+1]:=format('%d',[i]);
            LangStrings.Cells[1,i+1]:=format('%x',[bin.IndexTable[i].Name]);//Utf8Decode(PChar(Pointer(LongWord(bin.Data)+bin.IndexTable[i].Name)));
            LangStrings.Cells[2,i+1]:=Utf8Decode(PChar(Pointer(LongWord(bin.Data)+bin.IndexTable[i].Str)));
          end;
          FreeMem(bin.Data);
        end;
end;

procedure TFormXom.LangStringsSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
if ACol=2 then
 LangString.Text:=  LangStrings.Cells[ACol,ARow];
end;

procedure TFormXom.ShowUVClick(Sender: TObject);
var
  s: string;
  XCntr:TContainer;
begin
Xom.ViewUV:=ShowUV.Checked;
if ShowUV.Checked then begin
        Xom.LastUV.DrawUV(ImageT32.Picture.Bitmap);
        ImageT32.Repaint;
        end else
if Xom.LastXImage<>nil then begin
  Xom.LastXImage.ViewTga(ImageT32, true, XLabel);
  end;
end;

procedure TFormXom.AddXValue1Click(Sender: TObject);
var
SetCntr:TSetCntr;
ParentNode,CurNode:TTreeNode;
begin
SetCntr:=TSetCntr(ClassTree.Selected.Data);
SetCntr.AddElement;
ParentNode:=ClassTree.Selected.Parent;
while Xom.IsContainer(ParentNode.Data)<>SetCntr.Cntr  do
        ParentNode:=ParentNode.Parent;
ParentNode.DeleteChildren;
CurNode:=Xom.AddClassTree(SetCntr.Cntr, ClassTree, nil);
CurNode.MoveTo(ParentNode,naInsert);
ParentNode.Delete;
CurNode.Expand(false);

ButSaveXom.Enabled := True;

end;

procedure TFormXom.DeleteXValue1Click(Sender: TObject);
var
SetCntr:TSetCntr;
ParentNode,CurNode:TTreeNode;
begin
ParentNode:=ClassTree.Selected.Parent;
SetCntr:=TSetCntr(ParentNode.Data);
SetCntr.DeleteElement(ClassTree.Selected.Index);
while Xom.IsContainer(ParentNode.Data)<>SetCntr.Cntr  do
        ParentNode:=ParentNode.Parent;
ParentNode.DeleteChildren;
CurNode:=Xom.AddClassTree(SetCntr.Cntr, ClassTree, nil);
CurNode.MoveTo(ParentNode,naInsert);
ParentNode.Delete;
CurNode.Expand(false);

ButSaveXom.Enabled := True;

end;

procedure TFormXom.FindTextClick(Sender: TObject);
var
  i,index: integer;
  Found:boolean;
  s:String;
begin
  index:= 0;
   Found:=false;
  if ClassTree.Selected<>nil then index:= ClassTree.Selected.AbsoluteIndex+1;
  s:=Search.Text;
  for i := index to ClassTree.Items.Count - 1 do
    if Pos(AnsiUpperCase(s),AnsiUpperCase(ClassTree.Items[i].Text)) <> 0 then
    begin
      ClassTree.Selected := ClassTree.Items[i];
      ClassTree.SetFocus;
      Found:=True;
      break;
    end;

  if not found then
  Application.MessageBox(
                PChar(
                Format('Search string "%s" not found', [s])
                ),
                PChar('Information'), MB_ICONASTERISK or MB_OK);
end;

procedure TFormXom.SearchKeyPress(Sender: TObject; var Key: Char);
begin
if Key = #13 then
  begin
    FindTextClick(Sender);
    Key := #0;
  end;
end;

procedure TFormXom.ShowDummyClick(Sender: TObject);
begin
if not EditAnim.Down then begin
if ShowDummy.Down then begin
Splitter1.Visible:=true;
TreeView2.Width:=220;
UpdateDummyTree(TreeView2,Xom.Mesh3D);
UpdateDummyTreeMenu(DummySelect);
TreeView2.PopupMenu := DummyMenu;
TreeView2.OnChanging := nil;
TreeView2.OnDblClick := nil;
TreeView2.OnMouseUp := nil;
TreeView2.Visible:=true;
end else
begin
TreeView2.Visible:=False;
TreeView2.Width:=200;
Splitter1.Visible:=False;
TreeView2.PopupMenu := nil;
TreeView2.OnChanging := nil;
TreeView2.OnDblClick := nil;
TreeView2.OnMouseUp := nil;
end;
end;
end;

procedure TFormXom.XMesh11Click(Sender: TObject);
var
Mesh:TMesh;
begin
Mesh:=TMesh(TreeView2.Selected.Data);
SetLength(Mesh.Childs,1);
Xom.UpdateAnimFlag:=false;
Xom.SelectClassTree(Xom.CntrArr[TMenuItem(Sender).CntrIdx],Mesh.Childs[0]);
Xom.UpdateAnimFlag:=true;
UpdateDummyTree(TreeView2,Xom.Mesh3D);
end;

procedure TFormXom.DeleteXMesh1Click(Sender: TObject);
var
Mesh:TMesh;
begin
Mesh:=TMesh(TreeView2.Selected.Data);
SetLength(Mesh.Childs,0);
UpdateDummyTree(TreeView2,Xom.Mesh3D);
end;

procedure TFormXom.DummyMenuPopup(Sender: TObject);
var
Mesh:TMesh;
begin
DummySelect.Enabled:=false;
DeleteXMesh1.Enabled:=false;
if (TreeView2.Selected<>nil) and  (TreeView2.Selected.Data<>nil) then begin
Mesh:=TMesh(TreeView2.Selected.Data);
DummySelect.Enabled:=true;
DeleteXMesh1.Enabled:=Length(Mesh.Childs)=1;
end;
end;


procedure TFormXom.XResourcesClick(Sender: TObject);
var
XCntr:TContainer;
begin
XCntr := TContainer(ClassTree.Selected.Data);
//if XCntr.Xtype = XDataBank then
if FormName.ShowModal=mrOk then
begin
if FormName.XName.Text='' then  begin
            Application.MessageBox(
                PChar('It''s official, you suck!!!'),
                PChar('Error'), MB_ICONASTERISK or MB_OK);
FormName.XName.Text:='NewName';
end;
Xom.AddToXDataBank(XCntr,TMenuItem(Sender).Tag,FormName.XName.Text);
  // обновляем дерево
  UpdateXomTree(true);
  // выделяем элемент который вставили
  XCntr:=Xom.CntrArr[Xom.LastCounter];
  ClassTree.Select(SearchTreeCntr(ClassTree,XCntr));
end;

end;

procedure TFormXom.FixXString1Click(Sender: TObject);
var
XCntr:TContainer;
begin
XCntr := TContainer(ClassTree.Selected.Data);
  Xom.FixXDataBank(XCntr);
    // обновляем дерево
  UpdateXomTree(true);
  // выделяем элемент который вставили
  XCntr:=Xom.CntrArr[Xom.LastCounter];
  ClassTree.Select(SearchTreeCntr(ClassTree,XCntr));
end;

procedure TFormXom.W3D1Click(Sender: TObject);
//export as w3d
var
NewXom:TXom;
XCntr, RootCntr:TContainer;
CurNode: TTreeNode;
s:string;
begin
// сохранение Xom файла, выделеных контейнеров
  XCntr := TContainer(ClassTree.Selected.Data);
// сначала пробигаем по дереву собирая все контейнеры
  NewXom:=TXom.Create;
//  SetLength(NewCntrArr,0);
  RootCntr:=XCntr.BuildCntrArr(NewXom.CntrArr);
// затем создаем шапку xom файла c нужными типами
  NewXom.InitXomHandle;
  Xom.BuildXomHandle(NewXom.XomHandle,NewXom.CntrArr);
// собираем все строки которые используются в контейнерах

// включить флаг обработки индексов
// включаем флаг сбора строк
// Сделаем все за один проход:
// 1. пробегаясь по коду, автоматом меняем строки и добавляем новые
// 2. автоматом меняем индексы
NewXom.ReBuild:=true;
NewXom.AsW3D:=true;
NewXom.XomHandle.StringTable.Add('');// добавляем пустую
NewXom.OldStringTable:=Xom.XomHandle.StringTable;
CurNode:=NewXom.AddClassTree(RootCntr, ClassTree, nil);
NewXom.OldStringTable:=nil; // !!! важно
// необходимо прочитать все строки сразу, чтобы не попасть на уже замененные
CurNode.Delete;
NewXom.ReBuild:=false;
// начинаем компановку контейнеров учитывая новые индексы строк и контейнеров
s:=RootCntr.Name;
ClearName(s);
SaveDialog3.FileName:=  Format('%s_%d.xom', [s,RootCntr.Index]);
  NewXom.SaveXom(SaveDialog3);
  NewXom.Free;
end;

procedure TFormXom.InsertinXGraphClick(Sender: TObject);
var
NewXom:TXom;
XCntr,XGraphCntr:TContainer;
CurNode,LinkNode: TTreeNode;
s:string;
begin
  LinkNode:=ClassTree.Selected;
  XGraphCntr := TContainer(LinkNode.Parent.Data);
  XCntr:= TContainer(LinkNode.getFirstChild.Data);
  if OpenDialog4.Execute and (OpenDialog4.FileName <> '') then
  begin

// открываем Xom файл, считывая контейнеры
  NewXom:=TXom.Create;
  NewXom.LoadXomFileName(OpenDialog4.FileName, s,false);
  Xom.InsertXGraphSetXom(NewXom,XCntr,true,XGraphCntr.CntrSet);

  NewXom.Free;
  // обновляем дерево
  UpdateXomTree(true);
  // выделяем элемент который вставили
  XCntr:=Xom.CntrArr[Xom.LastCounter];
  CurNode:=SearchTreeCntr(ClassTree,XCntr);
  ClassTree.Select(CurNode);

  end;
end;

procedure TFormXom.DeletefromXGraphClick(Sender: TObject);
var
XCntr:TContainer;
CurNode: TTreeNode;
CntrSet:TCntrSet;
Index:integer;

ParentNode,LinkNode:TTreeNode;
begin
LinkNode:=ClassTree.Selected;
ParentNode:=LinkNode.Parent;
Index:=0;
if (LinkNode.Count=1) then begin
XCntr:=Xom.IsContainer(LinkNode.getFirstChild.Data);
if (XCntr<>nil) then Index:= XCntr.DelNoClone(Xom.BaseCntr);
end;
// пересчитываем размеры всех типов в старом файле
  Xom.ReSizeTypes;
// пересчет конейтейнеров;
  Xom.ReCalcCntr;
///
  Xom.OldStringTable:=Xom.XomHandle.StringTable;
  Xom.ReBuild:=true;

  CntrSet:=Xom.IsContainer(ParentNode.Data).CntrSet;
  //Уменьшить размер массива в контейнере
  if CntrSet<>nil then begin
        CntrSet.ClearGraphSetIndex(Index);
        CntrSet.DecSize;
   end;//последний индекс, нужно удалить

  CurNode:=Xom.AddClassTree(Xom.BaseCntr, ClassTree, nil);
  CurNode.Delete;
  Xom.OldStringTable:=nil;
  Xom.BaseNode.Data:=Xom.BaseCntr;
  // вырубить ребуилд для всех контейнеров!!!
  Xom.CntrArr.OffReBuild;
  Xom.ReBuild:=false;
// обновляем дерево
  UpdateXomTree(true);
/////////////////////////////
end;

procedure TFormXom.toXPalletteClick(Sender: TObject);
var
i,StartIndex,Index,Count:Integer;
begin
// конвертирование в XPaletteWeightSet
// нужно найти XWeightSet
// сконвертировать его в XPaletteWeightSet
// добавить XPaletteWeightSet тип после  XWeightSet
// изменить размер XWeightSet на 0
// изменить размер XPaletteWeightSet на Count
if Xom.SearchType(XWeightSet,Index) then
begin
  Count:=Xom.XomHandle.TypesInfo[Index].Size;
  StartIndex:=Xom.CntrArr.FoundXType(XWeightSet)-Count;
  for i:=0 to Count-1 do
     Xom.CntrArr[StartIndex+i].WeightSetToPalette;  //функция автоматом конвертирует контейнер и XIndexSet
  Xom.SetType(Index,PWGUID,XPaletteWeightSet);
  // обновляем дерево
  UpdateXomTree(true);
end;
end;

end.
