unit soblib;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes,ComCtrls,Contnrs,StrUtils,Dialogs;

type
  TSOB_HEADER = packed record
        id : array[0..3] of char; //   CTF2
        ver: array[0..3] of byte; //01 00 00 02
        numsamples: Longword;
        unknown: Longword;
        end;

 // name
 // notes
 // mixgroup
 // flags
 // level
 // cents
 // ambient
 // minAmbient
 // retrigger
 // pan
 // randomPan
 // Items...

  TSOB_SAMPLE = packed record
        id : array[0..3] of byte;// 01 01 00 00
        FF : Longword; // ffffffff
        zeros: array[0..5] of Longword;
        items: longword; //01
        dummy: array[0..1] of Longword;
        end;

  TSAB_HEADER = packed record
        id : array[0..3] of char; //   CSW2
        ver: array[0..3] of byte; //01 00 00 02
        numsamples: Longword;
        aSampleAlign: Longword;
        offset: Longword;
        nSlotNumber: Longword;
        end;

  TSAB_SAMPLE = packed record
        is_file: Longword;
        chan: Longword;
        freq: Longword;
        size: Longword;
        loopstart: Longword;
        loopend: Longword;
        offset: Longword;
        end;

type
  TSOBData = class
    constructor Create(_name:string);
    destructor Destroy; override;
  private

  public
    id:Integer;
    Name:string;
    sample:TSAB_SAMPLE;
    Data:Pointer;
    Node:TTreeNode;
    procedure ReadSOB(fb: TMemoryStream;smp:TSAB_SAMPLE; Size: Integer);
    procedure ReadSAB(fb: TMemoryStream;smp:TSAB_SAMPLE; Size,BlockSize: Integer);
    end;

  TSOBChunks = class(TObjectList)
    private
        function GetItems(Index: Integer): TSOBData;
        procedure SetItems(Index: Integer; const Value: TSOBData);
    public
    property Items[Index: Integer]: TSOBData read GetItems write SetItems; default;
  end;

  TSOBFile = class
    constructor Create();
    destructor Destroy; override;
  private
    SOB:TMemoryStream;
    SAB:TMemoryStream;
    SOBChunks:TSOBChunks;
    SABChunks:TSOBChunks;
    procedure ReCreate;
  public
    function OpenFile(Filename:string;Tree:TTreeView):integer;
  end;

implementation

{ TSOBFile }

constructor TSOBFile.Create;
begin

end;

destructor TSOBFile.Destroy;
begin
    SOBChunks.Free;
    SABChunks.Free;
    SOB.Free;
    SAB.Free;
  inherited;
end;

function TSOBFile.OpenFile(Filename: string; Tree: TTreeView): integer;
label
 closep;
var
 s:String;
 name,mode: string;
 Node, MainNode, INode:TTreeNode;
 i,num,id,namesize:integer;
 sobh:TSOB_HEADER;
 sabh:TSAB_HEADER;
 sobs:TSOB_SAMPLE;
 sabs:TSAB_SAMPLE;
 oldpos,baseoffset:longword;
 cname: array [0..255]of char;
 val:integer;
 valf:single;

   procedure AddVar(sname:string;value:Integer);
  begin
    Tree.Items.AddChild(INode,format('%s = %d',[sname,value]))
  end;

  procedure AddReadVal(nnode:TTreeNode;nname:string);
  begin
  SOB.Read(val,4);
  Tree.Items.AddChild(nnode,format('%s = %d',[nname,val]))
  end;

  procedure AddReadValf(nnode:TTreeNode;nname:string);
  begin
  SOB.Read(valf,4);
  Tree.Items.AddChild(nnode,format('%s = %f',[nname,valf]))
  end;

  procedure AddSampleObject(ID:integer);
  begin
  if (id>-1) and (SABChunks[id]<>nil) then
  begin
        //AddVar('id',SABChunks[id].id);
        AddVar('sampleRate',SABChunks[id].sample.freq);
        AddVar('channels',SABChunks[id].sample.chan);
        AddVar('loopStart',SABChunks[id].sample.loopstart);
        AddVar('loopEnd',SABChunks[id].sample.loopend);
        AddVar('size',SABChunks[id].sample.size);
        INode.Data:=SABChunks[id];
  end;
  end;

  procedure AddSoundItem();
  var
  k:integer;
  begin
     Node.Text:='soundItem';
     for k:=1 to sobs.items do begin
          INode:=Tree.Items.AddChild(Node,'entryItem');
          INode.ImageIndex:=25;
          INode.SelectedIndex:=25;
          SOB.Read(val,4); // index;
          AddReadVal(INode,'sampleBankIndex');
          AddReadVal(INode,'sampleObjectIndex');
          AddSampleObject(val);
          SOB.Seek(4*4,1);
        //  AddReadVal(INode,'level');
        //  AddReadVal(INode,'cents');
       //   AddReadVal(INode,'randomCents');
       //   AddReadVal(INode,'randomLevel');
          end;
  end;

  procedure AddSequeenceItem();
  var
  k:integer;
  begin
     Node.Text:='sequenceItem';
     for k:=1 to sobs.items do begin
          INode:=Tree.Items.AddChild(Node,'trackItem');
         // INode.ImageIndex:=25;
         // INode.SelectedIndex:=25;
          SOB.Read(val,4); // index;
          AddReadVal(INode,'soundBank');
          AddReadVal(INode,'soundName');
          AddReadValf(INode,'time');
          end;
  end;

  procedure AddMatrixItem();
  var
  k:integer;
  begin
     Node.Text:='matrixItem';
     SOB.Seek(32,1); // matrixItem 2(matrixItem)
     for k:=1 to sobs.items do begin
          INode:=Tree.Items.AddChild(Node,'matrixItem');
          INode.ImageIndex:=25;
          INode.SelectedIndex:=25;
          AddReadVal(INode,'sampleBankIndex');
          AddReadVal(INode,'sampleObjectIndex');
          AddSampleObject(val);
          SOB.Seek(4*2,1);
          end;
  end;

  procedure AddInterleavedItem();
  var
  k:integer;
  begin
     Node.Text:='interleavedItem';
   //  Node.ImageIndex:=25;
   //  Node.SelectedIndex:=25;
   //  INode:=Node;
    // AddSampleObject(0);
     for k:=1 to sobs.items do begin
          INode:=Tree.Items.AddChild(Node,'sampleItem');
          INode.ImageIndex:=25;
          INode.SelectedIndex:=25;
          AddReadVal(INode,'sampleBankIndex');
          AddReadVal(INode,'sampleObjectIndex');
          AddSampleObject(val);
          SOB.Seek(4*2,1);
          end;
  end;
begin
  Tree.Visible:=false;
  Tree.Items.Clear;
  ReCreate;

  // читаем sab и достаем из него все звуки
  s:=filename;
  s:=AnsiReplaceText(s,'.sob','.sab');
  SAB.LoadFromFile(s);
    SAB.ReadBuffer(sabh,sizeof(sabh));
    num:=sabh.numsamples;
    baseoffset:=sizeof(sabh)+sizeof(sabs)*num;
    id:=0;
  SABChunks.Count:=num;
  for i := 0 to  num-1 do begin
   
        SAB.ReadBuffer(sabs,sizeof(sabs));
        //id:=i;
        if sabs.is_file>0 then begin
    //    if id=SOBChunks.Count then goto closep;
        SABChunks[i]:=TSOBData.Create('');
        SABChunks[i].id:=i;
        oldpos:=SAB.Position;
        if (sabh.ver[0]=6) then begin
        SAB.Position:=sabh.aSampleAlign;
        SABChunks[i].ReadSAB(SAB,sabs,sabs.size,sabh.aSampleAlign);
        SABChunks[i+1]:=TSOBData.Create('');
        SABChunks[i+1].id:=i;
        SAB.Position:=sabh.aSampleAlign*2;
        SABChunks[i+1].ReadSAB(SAB,sabs,sabs.size,sabh.aSampleAlign);
        end else
        begin
        SAB.Position:=baseoffset+sabs.offset;
     //   AddVar('offset',baseoffset+sabs.offset);
        SABChunks[i].ReadSOB(SAB,sabs,sabs.size);
        end;
        SAB.Position:=oldpos;
        end;
   end;
  // читаем sob и достаем из него все имена
  SOB.LoadFromFile(filename);
  s:=ExtractFileName(filename);
  name:=AnsiReplaceText(s,'.sob','');

  SOB.ReadBuffer(sobh,sizeof(sobh));
  num:=sobh.numsamples;
  SOBChunks.Count:=num;
  MainNode:=Tree.Items.AddChild(nil,format('soundCollection "%s"',[name]));
   for i := 0 to  num-1 do begin
       SOB.ReadBuffer(sobs,sizeof(sobs)); //$48

       SOBChunks[i]:=TSOBData.Create('');
      // SOBChunks[i].id:=sobs.id[0];

        Node:=Tree.Items.AddChild(MainNode,'');
        SOBChunks[i].Node:=Node;
       //
     //   AddVar('id',sobs.id[0]);

       if sobs.FF<>$ffffffff then begin
        Showmessage(format('Error reading SOB stream[%d] 0x%x',[i,SOB.Position]));
        goto closep;
        end;
       if (sobs.id[0]and 1)>0 then SOB.Seek(64,1);
       case sobs.id[0] of
       0,1,5: AddSoundItem;     //     101B
       8,9: AddSequeenceItem;   //    1001B
       32:  AddInterleavedItem; //  100000B
       65:  AddMatrixItem;      // 1000001B
      // else name:= 'none';
       end;

   end;
//   Showmessage(format('Error reading SOB stream[%d] 0x%x',[i,SOB.Position]));
  // SOB.ReadBuffer(num,4);
   // читаем названия
   for i := 0 to  num-1 do begin
     SOB.ReadBuffer(id,4);
     SOB.ReadBuffer(namesize,4);
     FillChar(cname,255,0);
     SOB.ReadBuffer(cname,namesize);
     SOBChunks[i].Name:=cname;
     name:=format('%s [%d] "%s"',[SOBChunks[i].Node.Text,i,SOBChunks[i].Name]);
     SOBChunks[i].Node.Text:=name;
     SOBChunks[i].Node.Expanded:=true;
   end;

  closep:
  SAB.Free;
  SOB.Free;
  MainNode.Expanded:=true;
  Tree.Visible:=true;
end;

procedure TSOBFile.ReCreate;
begin
 SOB:=TMemoryStream.Create;
 SAB:=TMemoryStream.Create;
 SABChunks.Free;
 SABChunks:=TSOBChunks.Create();
 SOBChunks.Free;
 SOBChunks:=TSOBChunks.Create();
end;

{ TSOBChunks }

function TSOBChunks.GetItems(Index: Integer): TSOBData;
begin
 Result := TSOBData(inherited GetItem(Index));
end;

procedure TSOBChunks.SetItems(Index: Integer; const Value: TSOBData);
begin
 inherited SetItem(Index, Value);
end;

{ TSOBData }

constructor TSOBData.Create(_name: string);
begin
 Name:=_name;
end;

destructor TSOBData.Destroy;
begin
if (Data<>nil) then
      FreeMem(Data);
  inherited;
end;

procedure TSOBData.ReadSOB(fb: TMemoryStream; smp:TSAB_SAMPLE; Size: Integer);
var
  P:pointer;
begin
  sample:=smp;
  p := AllocMem(Size+4);
  Data:=p;
  Move(Size, p^, 4);
  inc(Longword(p),4);
  fb.ReadBuffer(p^,Size);
end;

procedure TSOBData.ReadSAB(fb: TMemoryStream; smp:TSAB_SAMPLE; Size,BlockSize: Integer);
var
  P:pointer;
  i,num:integer;
begin
  sample:=smp;
  p := AllocMem(Size+4);
  Data:=p;
  Move(Size, p^, 4);
  inc(Longword(p),4);
  num:= size div BlockSize;
  for i:=0 to num-1 do begin
        fb.ReadBuffer(p^,blocksize);
        inc(Longword(p),blocksize);
        fb.Seek(blocksize,1);
  end;
end;

end.
