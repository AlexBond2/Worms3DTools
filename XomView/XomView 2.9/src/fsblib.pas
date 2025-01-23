unit fsblib;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes,ComCtrls,Contnrs;


const
 FSOUND_FSB_NAMELEN =   30;
{$EXTERNALSYM FSOUND_FSB_NAMELEN}

//    Defines for FSOUND_FSB_HEADER^.mode field
 FSOUND_FSB_SOURCE_FORMAT =         $00000001;  (* all samples stored in their original compressed format *)
{$EXTERNALSYM FSOUND_FSB_SOURCE_FORMAT}
 FSOUND_FSB_SOURCE_BASICHEADERS =   $00000002;  (* samples should use the basic header structure *)
{$EXTERNALSYM FSOUND_FSB_SOURCE_BASICHEADERS}

//    Defines for FSOUND_FSB_HEADER^.version field
 FSOUND_FSB_VERSION_3_1 =           $00030001;  (* FSB version 3.1 *)
{$EXTERNALSYM FSOUND_FSB_VERSION_3_1}

//    16 byte header.
type
	FSOUND_FSB_HEADER_FSB1 = packed record
		id : array[0..3] of char;      (* 'FSB1' *)
		numsamples: integer; (* number of samples in the file *)
		datasize: integer;   (* size in bytes of compressed sample data *)
		dunno_null: integer;
	end;

	TFSOUND_FSB_HEADER_FSB1 = FSOUND_FSB_HEADER_FSB1;
	{$EXTERNALSYM TFSOUND_FSB_HEADER_FSB1}

//    16 byte header.
	FSOUND_FSB_HEADER_FSB2 = packed record
		id : array[0..3] of char;      (* 'FSB2' *)
		numsamples: integer; (* number of samples in the file *)
		shdrsize: integer;   (* size in bytes of all of the sample headers including extended information *)
		datasize: integer;   (* size in bytes of compressed sample data *)
	end;
	TFSOUND_FSB_HEADER_FSB2 = FSOUND_FSB_HEADER_FSB2;
	{$EXTERNALSYM TFSOUND_FSB_HEADER_FSB2}

//    24 byte header.
	FSOUND_FSB_HEADER_FSB3 = packed record
		id : array[0..3] of char;      (* 'FSB3' *)
		numsamples: integer; (* number of samples in the file *)
		shdrsize: integer;   (* size in bytes of all of the sample headers including extended information *)
		datasize: integer;   (* size in bytes of compressed sample data *)
		version: Cardinal;    (* extended fsb version *)
		mode: Cardinal;       (* flags that apply to all samples in the fsb *)
	end;
	TFSOUND_FSB_HEADER_FSB3 = FSOUND_FSB_HEADER_FSB3;
	{$EXTERNALSYM TFSOUND_FSB_HEADER_FSB3}

	FSOUND_FSB_HEADER_FSB4 = packed record
		id : array[0..3] of char;      (* 'FSB4' *)
		numsamples: integer; (* number of samples in the file *)
		shdrsize: integer;   (* size in bytes of all of the sample headers including extended information *)
		datasize: integer;   (* size in bytes of compressed sample data *)
		version: Cardinal;    (* extended fsb version *)
		mode: Cardinal;       (* flags that apply to all samples in the fsb *)
		zero : array[0..1] of Cardinal;    (* ??? *)
		hash : array[0..3] of Cardinal;   (* hash??? *)
	end;
	TFSOUND_FSB_HEADER_FSB4 = FSOUND_FSB_HEADER_FSB4;
	{$EXTERNALSYM TFSOUND_FSB_HEADER_FSB4}

	FSOUND_FSB_HEADER_FSB5 = packed record
		id : array[0..3] of char;      (* 'FSB5' *)
		version: integer;    // ???
		numsamples: integer; (* number of samples in the file *)
		shdrsize: integer;   (* size in bytes of all of the sample headers including extended information *)
		namesize: integer;   // size of the name table
		datasize: integer;   (* size in bytes of compressed sample data *)
		mode: Cardinal;       (* flags that apply to all samples in the fsb *)
		zero : array[0..1] of Cardinal;    (* ??? *)
		hash : array[0..3] of Cardinal;   (* hash??? *)
		dummy : array[0..1] of Cardinal;   (* ??? *)
	end;
	TFSOUND_FSB_HEADER_FSB5 = FSOUND_FSB_HEADER_FSB5;
	{$EXTERNALSYM TFSOUND_FSB_HEADER_FSB5}

//    64 byte sample header.
	FSOUND_FSB_SAMPLE_HEADER_1 = packed record
		name : array[0..31] of char;
		lengthsamples: Cardinal;
		lengthcompressedbytes: Cardinal;
		deffreq: integer;
		defpri: word;
		numchannels: word;    (* I'm not sure! *)
		defvol: word;
		defpan: Smallint;
		mode: Cardinal;
		loopstart: Cardinal;
		loopend: Cardinal;
	end;

//    64 byte sample header.
       FSOUND_FSB_SAMPLE_HEADER_2 = packed record
		size: word;
		name : array[0..FSOUND_FSB_NAMELEN-1] of char;
		lengthsamples: Cardinal;
		lengthcompressedbytes: Cardinal;
		loopstart: Cardinal;
		loopend: Cardinal;
		mode: Cardinal;
		deffreq: integer;
		defvol: word;
		defpan: Smallint;
		defpri: word;
		numchannels: word;
	end;

//    80 byte sample header.
	FSOUND_FSB_SAMPLE_HEADER_3_1 = packed record
		size: word;
		name : array[0..FSOUND_FSB_NAMELEN-1] of char;
		lengthsamples: Cardinal;
		lengthcompressedbytes: Cardinal;
		loopstart: Cardinal;
		loopend: Cardinal;
		mode: Cardinal;
		deffreq: integer;
		defvol: word;
		defpan: Smallint;
		defpri: word;
		numchannels: word;
		mindistance: Single;
		maxdistance: Single;
		varfreq: integer;
		varvol: word;
		varpan: Smallint;
	end;

//    8 byte sample header.
	FSOUND_FSB_SAMPLE_HEADER_BASIC = packed record
		lengthsamples: Cardinal;
		lengthcompressedbytes: Cardinal;
	end;
	TFSOUND_FSB_SAMPLE_HEADER_BASIC = FSOUND_FSB_SAMPLE_HEADER_BASIC;
	{$EXTERNALSYM TFSOUND_FSB_SAMPLE_HEADER_BASIC}


const
 FSOUND_LOOP_OFF =          $00000001; (* For non looping samples. *)
{$EXTERNALSYM FSOUND_LOOP_OFF}
 FSOUND_LOOP_NORMAL =       $00000002; (* For forward looping samples. *)
{$EXTERNALSYM FSOUND_LOOP_NORMAL}
 FSOUND_LOOP_BIDI =         $00000004; (* For bidirectional looping samples. (no effect if in hardware). *)
{$EXTERNALSYM FSOUND_LOOP_BIDI}
 FSOUND_8BITS =             $00000008; (* For 8 bit samples. *)
{$EXTERNALSYM FSOUND_8BITS}
 FSOUND_16BITS =            $00000010; (* For 16 bit samples. *)
{$EXTERNALSYM FSOUND_16BITS}
 FSOUND_MONO =              $00000020; (* For mono samples. *)
{$EXTERNALSYM FSOUND_MONO}
 FSOUND_STEREO =            $00000040; (* For stereo samples. *)
{$EXTERNALSYM FSOUND_STEREO}
 FSOUND_UNSIGNED =          $00000080; (* For user created source data containing unsigned samples. *)
{$EXTERNALSYM FSOUND_UNSIGNED}
 FSOUND_SIGNED =            $00000100; (* For user created source data containing signed data. *)
{$EXTERNALSYM FSOUND_SIGNED}
 FSOUND_DELTA =             $00000200; (* For user created source data stored as delta values. *)
{$EXTERNALSYM FSOUND_DELTA}
 FSOUND_IT214 =             $00000400; (* For user created source data stored using IT214 compression. *)
{$EXTERNALSYM FSOUND_IT214}
 FSOUND_IT215 =             $00000800; (* For user created source data stored using IT215 compression. *)
{$EXTERNALSYM FSOUND_IT215}
 FSOUND_HW3D =              $00001000; (* Attempts to make samples use 3d hardware acceleration. (if the card supports it) *)
{$EXTERNALSYM FSOUND_HW3D}
 FSOUND_2D =                $00002000; (* Tells software (not hardware) based sample not to be included in 3d processing. *)
{$EXTERNALSYM FSOUND_2D}
 FSOUND_STREAMABLE =        $00004000; (* For a streamimg sound where you feed the data to it. *)
{$EXTERNALSYM FSOUND_STREAMABLE}
 FSOUND_LOADMEMORY =        $00008000; (* "name" will be interpreted as a pointer to data for streaming and samples. *)
{$EXTERNALSYM FSOUND_LOADMEMORY}
 FSOUND_LOADRAW =           $00010000; (* Will ignore file format and treat as raw pcm. *)
{$EXTERNALSYM FSOUND_LOADRAW}
 FSOUND_MPEGACCURATE =      $00020000; (* For FSOUND_Stream_Open - for accurate FSOUND_Stream_GetLengthMs/FSOUND_Stream_SetTime. WARNING, see FSOUND_Stream_Open for inital opening time performance issues. *)
{$EXTERNALSYM FSOUND_MPEGACCURATE}
 FSOUND_FORCEMONO =         $00040000; (* For forcing stereo streams and samples to be mono - needed if using FSOUND_HW3D and stereo data - incurs a small speed hit for streams *)
{$EXTERNALSYM FSOUND_FORCEMONO}
 FSOUND_HW2D =              $00080000; (* 2D hardware sounds. allows hardware specific effects *)
{$EXTERNALSYM FSOUND_HW2D}
 FSOUND_ENABLEFX =          $00100000; (* Allows DX8 FX to be played back on a sound. Requires DirectX 8 - Note these sounds cannot be played more than once, be 8 bit, be less than a certain size, or have a changing frequency *)
{$EXTERNALSYM FSOUND_ENABLEFX}
 FSOUND_MPEGHALFRATE =      $00200000; (* For FMODCE only - decodes mpeg streams using a lower quality decode, but faster execution *)
{$EXTERNALSYM FSOUND_MPEGHALFRATE}
 FSOUND_IMAADPCM =          $00400000; (* Contents are stored compressed as IMA ADPCM *)
{$EXTERNALSYM FSOUND_IMAADPCM}
 FSOUND_VAG =               $00800000; (* For PS2 only - Contents are compressed as Sony VAG format *)
{$EXTERNALSYM FSOUND_VAG}
//#define FSOUND_NONBLOCKING      0x01000000 /* For FSOUND_Stream_Open/FMUSIC_LoadSong - Causes stream or music to open in the background and not block the foreground app. See FSOUND_Stream_GetOpenState or FMUSIC_GetOpenState to determine when it IS ready. */
 FSOUND_XMA =               $01000000;
{$EXTERNALSYM FSOUND_XMA}
 FSOUND_GCADPCM =           $02000000; (* For Gamecube only - Contents are compressed as Gamecube DSP-ADPCM format *)
{$EXTERNALSYM FSOUND_GCADPCM}
 FSOUND_MULTICHANNEL =      $04000000; (* For PS2 and Gamecube only - Contents are interleaved into a multi-channel (more than stereo) format *)
{$EXTERNALSYM FSOUND_MULTICHANNEL}
 FSOUND_USECORE0 =          $08000000; (* For PS2 only - Sample/Stream is forced to use hardware voices 00-23 *)
{$EXTERNALSYM FSOUND_USECORE0}
 FSOUND_USECORE1 =          $10000000; (* For PS2 only - Sample/Stream is forced to use hardware voices 24-47 *)
{$EXTERNALSYM FSOUND_USECORE1}
 FSOUND_LOADMEMORYIOP =     $20000000; (* For PS2 only - "name" will be interpreted as a pointer to data for streaming and samples. The address provided will be an IOP address *)
{$EXTERNALSYM FSOUND_LOADMEMORYIOP}
 FSOUND_IGNORETAGS =        $40000000; (* Skips id3v2 etc tag checks when opening a stream, to reduce seek/read overhead when opening files (helps with CD performance) *)
{$EXTERNALSYM FSOUND_IGNORETAGS}
 FSOUND_STREAM_NET =        $80000000; (* Specifies an internet stream *)
{$EXTERNALSYM FSOUND_STREAM_NET}
 FSOUND_NORMAL =            (FSOUND_16BITS or FSOUND_SIGNED or FSOUND_MONO);
{$EXTERNALSYM FSOUND_NORMAL}

const
 FMOD_SOUND_FORMAT_NONE	= 0;             (* Unitialized / unknown. *)
 FMOD_SOUND_FORMAT_PCM8	= 1;             (* 8bit integer PCM data. *)
 FMOD_SOUND_FORMAT_PCM16	= 2;            (* 16bit integer PCM data. *)
 FMOD_SOUND_FORMAT_PCM24	= 3;            (* 24bit integer PCM data. *)
 FMOD_SOUND_FORMAT_PCM32	= 4;            (* 32bit integer PCM data. *)
 FMOD_SOUND_FORMAT_PCMFLOAT	= 5;         (* 32bit floating point PCM data. *)
 FMOD_SOUND_FORMAT_GCADPCM	= 6;          (* Compressed Nintendo 3DS/Wii DSP data. *)
 FMOD_SOUND_FORMAT_IMAADPCM	= 7;         (* Compressed IMA ADPCM data. *)
 FMOD_SOUND_FORMAT_VAG	= 8;              (* Compressed PlayStation Portable ADPCM data. *)
 FMOD_SOUND_FORMAT_HEVAG	= 9;            (* Compressed PSVita ADPCM data. *)
 FMOD_SOUND_FORMAT_XMA	= 10;              (* Compressed Xbox360 XMA data. *)
 FMOD_SOUND_FORMAT_MPEG	= 11;             (* Compressed MPEG layer 2 or 3 data. *)
 FMOD_SOUND_FORMAT_CELT	= 12;             (* Compressed CELT data. *)
 FMOD_SOUND_FORMAT_AT9	= 13;              (* Compressed PSVita ATRAC9 data. *)
 FMOD_SOUND_FORMAT_XWMA	= 14;             (* Compressed Xbox360 xWMA data. *)
 FMOD_SOUND_FORMAT_VORBIS	= 15;           (* Compressed Vorbis data. *)
 FMOD_SOUND_FORMAT_MAX	= 17;              (* Maximum number of sound formats supported. *)
 FMOD_SOUND_FORMAT_FORCEINT = 65536;  (* Makes sure this enum is signed 32bit. *)

type
	FMOD_SOUND_FORMAT = FMOD_SOUND_FORMAT_NONE..FMOD_SOUND_FORMAT_FORCEINT;
	{$EXTERNALSYM FMOD_SOUND_FORMAT}

const FMOD_SOUND_FORMAT_IT214 =  (FMOD_SOUND_FORMAT_MAX + 1);
{$EXTERNALSYM FMOD_SOUND_FORMAT_IT214}
const FMOD_SOUND_FORMAT_IT215 =  (FMOD_SOUND_FORMAT_MAX + 2);
{$EXTERNALSYM FMOD_SOUND_FORMAT_IT215}

type
	u8 = Byte;
	{$EXTERNALSYM u8}
	u16 = Word;
	{$EXTERNALSYM u16}
	u32 = Longword;
	{$EXTERNALSYM u32}

type
  TFSBData = class
    constructor Create(_name:string);
    destructor Destroy; override;
  private

  public
    Name:string;
    fs31:FSOUND_FSB_SAMPLE_HEADER_3_1;
    fsbver:integer;
    Data:Pointer;
    procedure MakeFS(_fs31: FSOUND_FSB_SAMPLE_HEADER_3_1;
        fb: TMemoryStream; Size: Integer);
    end;

  TFSBChunks = class(TObjectList)
    private
        function GetItems(Index: Integer): TFSBData;
        procedure SetItems(Index: Integer; const Value: TFSBData);
    public
    property Items[Index: Integer]: TFSBData read GetItems write SetItems; default;
  end;


  TFSBFile = class
    constructor Create();
    destructor Destroy; override;
  private
    fb:TMemoryStream;
    FSBChunks:TFSBChunks;
    fsb_offset : Int64;
    procedure ReCreate;
    procedure frch(var data; size:Integer);
    function fr32:integer;
    function fr16:word;
    function fr8:byte;
    function frchs():string;
    function check_sign_endian: Integer;
  public
    function OpenFile(filename:string;Tree:TTreeView):integer;
    procedure std_err;
  end;

implementation


{ TFSBFile }

function TFSBFile.check_sign_endian: Integer;
var
  sign : array[0..3] of char;
begin

    fb.position:=0;
    frch(sign, SizeOf(sign));
    fb.position:=0;

if((sign[0] = 'F') and (sign[1] = 'S') and (sign[2] = 'B'))then
        result:=integer(sign[3])
else
        result:= (-1);

end;

constructor TFSBFile.Create();
begin

end;

destructor TFSBFile.Destroy;
begin
  FSBChunks.Free;
  fb.free;
  inherited;
end;

procedure TFSBFile.frch(var data; size: Integer);
begin
    fb.ReadBuffer(data,size);
end;

function TFSBFile.fr32:integer;
begin
    fb.ReadBuffer(Result,4);
end;

function TFSBFile.fr16:word;
begin
    fb.ReadBuffer(Result,2);
end;

function TFSBFile.fr8:byte;
begin
    fb.ReadBuffer(Result,1);
end;

function TFSBFile.frchs():string;
  var
  s:String;
  Ch:char;
  begin
     S:='';
      Repeat
            fb.ReadBuffer(Ch, 1);//Name of Object;
            S := S + Ch;
      until Ch = #0;
      result:=copy(s,0,Length(s)-1);
  end;

function TFSBFile.OpenFile(filename: string;Tree:TTreeView): integer;
var
 addhead,codec,head_ver,verbose ,nullfiles,force_ima,rebbuffsz:integer;
 nameoff, fileoff, baseoff, size, samples,offset,datasize,cType,t32,current_offset:u32;
 sign:byte;
 i,num,len,freq,head_mode,list,
 rebuild,moresize_dumpsz,pcm_endian,aligned :Integer;
 chans,bits,moresize:u16;
 t64 : Int64;
 moresize_dump:Pointer;
 fname,rebfile,listfile,folder:Cardinal;

    fh1:FSOUND_FSB_HEADER_FSB1;
    fh2:FSOUND_FSB_HEADER_FSB2;
    fh3:FSOUND_FSB_HEADER_FSB3;
    fh4:FSOUND_FSB_HEADER_FSB4;
    fh5:FSOUND_FSB_HEADER_FSB5;
    fs1:FSOUND_FSB_SAMPLE_HEADER_1;
    fs2:FSOUND_FSB_SAMPLE_HEADER_2;
    fs31:FSOUND_FSB_SAMPLE_HEADER_3_1;
    fsb:FSOUND_FSB_SAMPLE_HEADER_BASIC;

 name,mode: string;

  Node:TTreeNode;

  procedure AddVar(sname:string;value:Integer);
  begin
    Tree.Items.AddChild(Node,format('%s = %d',[sname,value]))
  end;

  procedure AddVarf(sname:string;value:single);
  begin
    Tree.Items.AddChild(Node,format('%s = %f',[sname,value]))
  end;

  procedure AddVars(sname:string;value:string);
  begin
    Tree.Items.AddChild(Node,format('%s = %s',[sname,value]))
  end;

begin
  t64:=0;

  Tree.Visible:=false;
  Tree.Items.Clear;
  ReCreate;
  fb.LoadFromFile(filename);
 // fd := FileOpen(filename, fmOpenRead);
  sign := check_sign_endian;

  if(char(sign) = '1') then  begin
        frch(fh1,sizeof(fh1));
        num       := fh1.numsamples;
        nameoff   := SizeOf(fh1);
        fileoff   := SizeOf(fh1) + (num * SizeOf(fs1));
        head_ver  := 1;
        head_mode := 0;
  end else
  if(char(sign)= '2') then  begin
        frch(fh2,sizeof(fh2));
        num       := fh2.numsamples;
        nameoff   := SizeOf(fh2);
        fileoff   := SizeOf(fh2) + fh2.shdrsize;
        head_ver  := 2;
        head_mode := 0;
  end else
  if(char(sign)= '3') then  begin
        frch(fh3,sizeof(fh3));
        num       := fh3.numsamples;
        nameoff   := SizeOf(fh3);
        fileoff   := SizeOf(fh3) + fh3.shdrsize;
        head_ver  := 3;
        head_mode := fh3.mode;
  end
  else
  if(char(sign)= '4') then  begin
        frch(fh4,sizeof(fh4));
        num       := fh4.numsamples;
        nameoff   := SizeOf(fh4);
        fileoff   := SizeOf(fh4) + fh4.shdrsize;
        head_ver  := 4;
        head_mode := fh4.mode;
  end else
  if(char(sign) = '5') then  begin
        frch(fh5,sizeof(fh5));
        num       := fh5.numsamples;
        nameoff   := SizeOf(fh5) + fh5.shdrsize;
        fileoff   := SizeOf(fh5) + fh5.shdrsize + fh5.namesize;
        datasize  := fh5.datasize;
        head_ver  := 5;
        head_mode := 0;
        if(fh5.zero[1] and 1)>0 then head_mode:= head_mode or $08;  // big endian
  end
  else begin
        //printf(' nError: this tool doesn't support FSB mod c', sign and $ff);
        exit;
     end;

  if(head_mode and $08)>0 then begin
        //printf('- big endian samples n');
        pcm_endian := 1;
     end;
  if(head_mode and $40)>0 then begin
        //printf('- aligned files n');
        aligned := 1;
     end;

    baseoff := fileoff;

   FSBChunks.Count:=num;
   for i := 0 to  num-1 do begin
        name:='';  // I need to use it because filenames are truncated!
        Node:=Tree.Items.AddChild(nil,name);

        if(head_ver = 1) then  begin
            frch(fs1, sizeof(fs1));
            //StrFmt(name, ' mod .*s', SizeOf(fs1.name), fs1.name);
            samples  := fs1.lengthsamples;
            freq     := fs1.deffreq;
         //   mode     := fs1.mode;//show_mode(fs1.mode,  and codec,  and chans,  and bits);  // chans only here?
            size     := fs1.lengthcompressedbytes;
        end
        else if(head_ver = 2) then  begin
            frch(fs2, sizeof(fs2));
           // MODEZ(fs2)
        end
        else if(head_ver = 3) then  begin
            if((head_mode and FSOUND_FSB_SOURCE_BASICHEADERS) and i)>0 then  begin
                frch(fsb, sizeof(fsb));
                name:= IntToStr(i);
              //  StrFmt(name, NULLNAME, i);
                size     := fsb.lengthcompressedbytes;
                samples  := fsb.lengthsamples;
                //freq, chans, mode and moresize are the same of the first file
              end
              else begin
                if(fh3.version = FSOUND_FSB_VERSION_3_1) then  begin          // 3.1
                    frch(fs31, sizeof(fs31));
                 //   MODEZ(fs31)
                 end else begin                                             // 3.0
                    frch(fs2, sizeof(fs2));
                 //   MODEZ(fs2)
                 end;
             end;
         end
         else
         if(head_ver = 4) then  begin
            if((head_mode and FSOUND_FSB_SOURCE_BASICHEADERS) and i)>0 then  begin
                frch(fsb, sizeof(fsb));
                name:= IntToStr(i);
                size     := fsb.lengthcompressedbytes;
                samples  := fsb.lengthsamples;
                fs31.lengthcompressedbytes:=size;
                fs31.lengthsamples:=samples;

                AddVar('lengthsamples',fs31.lengthsamples);
                AddVar('lengthcompressedbytes',fs31.lengthcompressedbytes);

                //freq, chans, mode and moresize are the same of the first file
             end else begin
                frch(fs31, sizeof(fs31));
                name    :=  fs31.name;
                size     := fs31.lengthcompressedbytes;
                AddVar('lengthsamples',fs31.lengthsamples);
                AddVar('lengthcompressedbytes',fs31.lengthcompressedbytes);
                AddVar('loopstart',fs31.loopstart);
                AddVar('loopend',fs31.loopend);
                AddVar('mode',fs31.mode);
                AddVar('deffreq',fs31.deffreq);
                AddVar('defvol',fs31.defvol);
                AddVar('defpan',fs31.defpan);
                AddVar('defpri',fs31.defpri);
                AddVar('numchannels',fs31.numchannels);
                AddVarf('mindistance',fs31.mindistance);
                AddVarf('maxdistance',fs31.maxdistance );
                AddVar('varfreq',fs31.varfreq);
                AddVar('varvol',fs31.varvol);
                AddVar('varpan',fs31.varpan );

             end;
        end
        else if(head_ver = 5) then  begin
            moresize := 0;
            freq    := 44100;
            chans   := 1;
            bits    := 16;
            codec   := fh5.mode;
            case fh5.mode of
                FMOD_SOUND_FORMAT_PCM8:        bits := 8;
                FMOD_SOUND_FORMAT_PCM16:       bits := 16;
                FMOD_SOUND_FORMAT_PCM24:       bits := 24;
                FMOD_SOUND_FORMAT_PCM32:       bits := 32;
                FMOD_SOUND_FORMAT_PCMFLOAT:    bits := 32;
            end;

            case fh5.mode of
                FMOD_SOUND_FORMAT_PCM8:        mode := 'pcm8';
                FMOD_SOUND_FORMAT_PCM16:       mode := 'pcm16';
                FMOD_SOUND_FORMAT_PCM24:       mode := 'pcm24';
                FMOD_SOUND_FORMAT_PCM32:       mode := 'pcm32';
                FMOD_SOUND_FORMAT_PCMFLOAT:    mode := 'float';
                FMOD_SOUND_FORMAT_GCADPCM:     mode := 'gc';
                FMOD_SOUND_FORMAT_IMAADPCM:    mode := 'ima';
                FMOD_SOUND_FORMAT_VAG:         mode := 'vag';
                FMOD_SOUND_FORMAT_HEVAG:       mode := 'hevag';
                FMOD_SOUND_FORMAT_XMA:         mode := 'xma';
                FMOD_SOUND_FORMAT_MPEG:        mode := 'mp3';
                FMOD_SOUND_FORMAT_CELT:        mode := 'celt';
                FMOD_SOUND_FORMAT_AT9:         mode := 'at9';
                FMOD_SOUND_FORMAT_XWMA:        mode := 'xwma';
                FMOD_SOUND_FORMAT_VORBIS:      mode := 'ogg';
                else          mode := '';
             end;

            offset   := fr32;  //
            samples  := fr32 shr 2;   // ???
            fs31.lengthsamples:=samples;
            cType     := offset and $ff;  // mode
            fs31.mode:=cType;
            offset := offset shr 8;
            offset := offset * $40;
                                                 // FSB5_SAMPLE_80
            if(cType and $20)>0 then chans := 2; // FSB5_SAMPLE_STEREO=$20
            fs31.loopend:=0;                   // FSB5_SAMPLE_MPEG_PADDED4=$10
            while(cType and 1)>0 do begin  // FSB5_SAMPLE_EXTRAPARAMS=$1
                t32  := fr32;
                cType := t32 and 1;
                len  := (t32 and $ffffff) shr 1;  // size = 8
                t32:= t32 shr 24;
                t64 := fb.Position;

                case(t32) of
                $2: chans := fr8;
                $4: freq  := fr32;
                $6: begin  //type=6   loop loop
                        fs31.loopstart:=fr32;
                        fs31.loopend:=fr32;
                    end;
                 else exit;
                 end;
                t64:= t64 + len;
                fb.Position:=t64;
               // myfseek(fd, t64, FILE_BEGIN);
             end;
            fs31.deffreq:=freq;
            fs31.numchannels:=chans;

            t64 := fb.Position;
            if(fb.Position < nameoff) then  begin
                size := fr32;
                if(size=0) then
                    size := fb.Size
                 else begin
                    size:= size shr 8;
                    size:= size * $40;
                    size:= size + baseoff;
                 end;
             end else
                size := fb.Size;

            fb.Position:=t64;
            fileoff := baseoff + offset;
            size:= size - fileoff;
            fs31.lengthcompressedbytes:=size;


            if(fh5.namesize>0) then  begin
                t64 := fb.Position;
                fb.Position:=nameoff + (i * 4);
                fb.Position:=nameoff + fr32;
                name:=frchs;
                fb.Position:=t64;
             end else begin
                name:=IntToStr(i);
             end;
               //  fs31.name:=name;

                AddVar('lengthsamples',fs31.lengthsamples);
                AddVar('lengthcompressedbytes',fs31.lengthcompressedbytes);
                if fs31.loopend>0 then begin
                AddVar('loopstart',fs31.loopstart);
                AddVar('loopend',fs31.loopend);
                end;
                AddVar('mode',fs31.mode);
                AddVar('deffreq',fs31.deffreq);
                AddVar('numchannels',fs31.numchannels);

         end else begin
        //printf(' nError: you must update this tool adding support for head version  mod d', head_ver);
            exit;
         end;

         current_offset := fb.Position;

         fb.Position:=fileoff;
        // extract_file(name, freq, chans, bits, size, moresize_dump, moresize,Tree);


        Node.Text:=name;
        Node.ImageIndex:=25;
        Node.SelectedIndex:=25;

        FSBChunks[i]:=TFSBData.Create(name);
        FSBChunks[i].MakeFS(fs31,fb,size);
        FSBChunks[i].fsbver:=head_ver;
        Node.Data:=FSBChunks[i];

         fileoff := fileoff+ size;
         fb.Position:=current_offset;

    end;
  fb.Free;
  Tree.Visible:=true;
end;

procedure TFSBFile.ReCreate;
begin
 fb:=TMemoryStream.Create;
 FSBChunks.Free;
 FSBChunks:=TFSBChunks.Create();
end;

procedure TFSBFile.std_err;
begin

end;

{ TFSBData }

constructor TFSBData.Create(_name:string);
begin
 Name:=_name;
end;

destructor TFSBData.Destroy;
begin
if (Data<>nil) then
      FreeMem(Data);
  inherited;
end;

procedure TFSBData.MakeFS(_fs31: FSOUND_FSB_SAMPLE_HEADER_3_1; fb: TMemoryStream; Size: Integer);
var
  P:pointer;
begin
  fs31:=_fs31;
  p := AllocMem(Size+4);
  Data:=p;
  Move(Size, p^, 4);
  inc(Longword(p),4);
  fb.ReadBuffer(p^,Size);
end;

{ TFSBChunks }

function TFSBChunks.GetItems(Index: Integer): TFSBData;
begin
 Result := TFSBData(inherited GetItem(Index));
end;

procedure TFSBChunks.SetItems(Index: Integer; const Value: TFSBData);
begin
 inherited SetItem(Index, Value);
end;

end.
