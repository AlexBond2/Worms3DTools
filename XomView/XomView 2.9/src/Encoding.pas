unit Encoding;

{$I jedi.inc}

interface

uses
  Windows,
  SysUtils;

type
  EEncodingError = class(Exception);

  TCharArray = array of Char;
  TBytes = array of Byte;
  {$IFNDEF UNICODE}
  UnicodeString = WideString;
  {$ENDIF}
  
  TEncoding = class
  {$IFDEF SUPPORTS_STRICT}strict{$ENDIF} private
    {$IFDEF SUPPORTS_CLASS_FIELDS}
    class var
      FASCIIEncoding: TEncoding;
      FBigEndianUnicodeEncoding: TEncoding;
      FDefaultEncoding: TEncoding;
      FUnicodeEncoding: TEncoding;
      FUTF7Encoding: TEncoding;
      FUTF8Encoding: TEncoding;
    {$ENDIF}
  {$IFDEF SUPPORTS_STRICT}strict{$ENDIF} protected
    FIsSingleByte: Boolean;
    FMaxCharSize: Integer;
    function GetByteCount(Chars: PChar; CharCount: Integer): Integer; overload; virtual; abstract;
    function GetBytes(Chars: PChar; CharCount: Integer; Bytes: PByte; ByteCount: Integer): Integer; overload; virtual; abstract;
    function GetCharCount(Bytes: PByte; ByteCount: Integer): Integer; overload; virtual; abstract;
    function GetChars(Bytes: PByte; ByteCount: Integer; Chars: PChar; CharCount: Integer): Integer; overload; virtual; abstract;
  public
    class function Convert(Source, Destination: TEncoding; Bytes: TBytes): TBytes; overload;
    class function Convert(Source, Destination: TEncoding; Bytes: TBytes; StartIndex, Count: Integer): TBytes; overload;
    class procedure FreeEncodings;
    class function IsStandardEncoding(AEncoding: TEncoding): Boolean; {$IFDEF SUPPORTS_STATIC}static;{$ENDIF}
    class function GetBufferEncoding(const Buffer: TBytes; var AEncoding: TEncoding): Integer; {$IFDEF SUPPORTS_STATIC}static;{$ENDIF}
    function GetByteCount(const Chars: TCharArray): Integer; overload;
    function GetByteCount(const Chars: TCharArray; CharIndex, CharCount: Integer): Integer; overload;
    function GetByteCount(const S: string): Integer; overload;
    function GetByteCount(const S: string; CharIndex, CharCount: Integer): Integer; overload;
    function GetBytes(const Chars: TCharArray): TBytes; overload;
    function GetBytes(const Chars: TCharArray; CharIndex, CharCount: Integer;
      var Bytes: TBytes; ByteIndex: Integer): Integer; overload;
    function GetBytes(const S: string): TBytes; overload;
    function GetBytes(const S: string; CharIndex, CharCount: Integer;
      var Bytes: TBytes; ByteIndex: Integer): Integer; overload;
    function GetCharCount(const Bytes: TBytes): Integer; overload;
    function GetCharCount(const Bytes: TBytes; ByteIndex, ByteCount: Integer): Integer; overload;
    function GetChars(const Bytes: TBytes): TCharArray; overload;
    function GetChars(const Bytes: TBytes; ByteIndex, ByteCount: Integer): TCharArray; overload;
    function GetChars(const Bytes: TBytes; ByteIndex, ByteCount: Integer;
      var Chars: TCharArray; CharIndex: Integer): Integer; overload;
    class function GetEncoding(CodePage: Integer): TEncoding; {$IFDEF SUPPORTS_STATIC}static;{$ENDIF}
    function GetMaxByteCount(CharCount: Integer): Integer; virtual; abstract;
    function GetMaxCharCount(ByteCount: Integer): Integer; virtual; abstract;
    function GetPreamble: TBytes; virtual; abstract;
    function GetString(const Bytes: TBytes): string; overload;
    function GetString(const Bytes: TBytes; ByteIndex, ByteCount: Integer): string; overload;
    class function ASCII: TEncoding;
    class function BigEndianUnicode: TEncoding;
    class function Default: TEncoding;
    property IsSingleByte: Boolean read FIsSingleByte;
    class function Unicode: TEncoding;
    class function UTF7: TEncoding;
    class function UTF8: TEncoding;
  end;

  TMBCSEncoding = class(TEncoding)
  private
    FCodePage: Cardinal;
    FMBToWCharFlags: Cardinal;
    FWCharToMBFlags: Cardinal;
  {$IFDEF SUPPORTS_STRICT}strict{$ENDIF} protected
    function GetByteCount(Chars: PChar; CharCount: Integer): Integer; overload; override;
    function GetBytes(Chars: PChar; CharCount: Integer; Bytes: PByte; ByteCount: Integer): Integer; overload; override;
    function GetCharCount(Bytes: PByte; ByteCount: Integer): Integer; overload; override;
    function GetChars(Bytes: PByte; ByteCount: Integer; Chars: PChar; CharCount: Integer): Integer; overload; override;
  public
    constructor Create; overload; virtual;
    constructor Create(CodePage: Integer); overload; virtual;
    constructor Create(CodePage, MBToWCharFlags, WCharToMBFlags: Integer); overload; virtual;
    function GetMaxByteCount(CharCount: Integer): Integer; override;
    function GetMaxCharCount(ByteCount: Integer): Integer; override;
    function GetPreamble: TBytes; override;
  end;

  TUTF7Encoding = class(TMBCSEncoding)
  {$IFDEF SUPPORTS_STRICT}strict{$ENDIF} protected
    function GetByteCount(Chars: PChar; CharCount: Integer): Integer; overload; override;
    function GetBytes(Chars: PChar; CharCount: Integer; Bytes: PByte; ByteCount: Integer): Integer; overload; override;
    function GetCharCount(Bytes: PByte; ByteCount: Integer): Integer; overload; override;
    function GetChars(Bytes: PByte; ByteCount: Integer; Chars: PChar; CharCount: Integer): Integer; overload; override;
  public
    constructor Create; override;
    function GetMaxByteCount(CharCount: Integer): Integer; override;
    function GetMaxCharCount(ByteCount: Integer): Integer; override;
  end;

  TUTF8Encoding = class(TUTF7Encoding)
  public
    constructor Create; override;
    function GetMaxByteCount(CharCount: Integer): Integer; override;
    function GetMaxCharCount(ByteCount: Integer): Integer; override;
    function GetPreamble: TBytes; override;
  end;

  TUnicodeEncoding = class(TEncoding)
  {$IFDEF SUPPORTS_STRICT}strict{$ENDIF} protected
    function GetByteCount(Chars: PChar; CharCount: Integer): Integer; overload; override;
    function GetBytes(Chars: PChar; CharCount: Integer; Bytes: PByte; ByteCount: Integer): Integer; overload; override;
    function GetCharCount(Bytes: PByte; ByteCount: Integer): Integer; overload; override;
    function GetChars(Bytes: PByte; ByteCount: Integer; Chars: PChar; CharCount: Integer): Integer; overload; override;
  public
    constructor Create; virtual;
    function GetMaxByteCount(CharCount: Integer): Integer; override;
    function GetMaxCharCount(ByteCount: Integer): Integer; override;
    function GetPreamble: TBytes; override;
  end;

  TBigEndianUnicodeEncoding = class(TUnicodeEncoding)
  {$IFDEF SUPPORTS_STRICT}strict{$ENDIF} protected
    function GetBytes(Chars: PChar; CharCount: Integer; Bytes: PByte; ByteCount: Integer): Integer; overload; override;
    function GetChars(Bytes: PByte; ByteCount: Integer; Chars: PChar; CharCount: Integer): Integer; overload; override;
  public
    function GetPreamble: TBytes; override;
  end;

implementation

resourcestring
  rsInvalidSourceArray                           = 'Invalid source array';
  rsInvalidDestinationArray                      = 'Invalid destination array';
  rsCharIndexOutOfBoundsFmt                      = 'Character index out of bounds (%d)';
  rsByteIndexOutOfBoundsFmt                      = 'Start index out of bounds (%d)';
  rsInvalidCharCountFmt                          = 'Invalid count (%d)';
  rsInvalidDestinationIndexFmt                   = 'Invalid destination index (%d)';
  rsInvalidCodePage                              = 'Invalid code page';

{$IFNDEF SUPPORTS_CLASS_FIELDS}
var
  FASCIIEncoding: TEncoding;
  FBigEndianUnicodeEncoding: TEncoding;
  FDefaultEncoding: TEncoding;
  FUnicodeEncoding: TEncoding;
  FUTF7Encoding: TEncoding;
  FUTF8Encoding: TEncoding;
{$ENDIF}

{ TEncoding }

function InterlockedCompareExchangePointer(var Destination: Pointer; Exchange: Pointer; Comparand: Pointer): Pointer;
asm
  XCHG    EAX,ECX
  LOCK CMPXCHG [ECX],EDX
end;

class function TEncoding.Convert(Source, Destination: TEncoding; Bytes: TBytes): TBytes;
begin
  Result := Destination.GetBytes(Source.GetChars(Bytes));
end;

class function TEncoding.Convert(Source, Destination: TEncoding; Bytes: TBytes;
  StartIndex, Count: Integer): TBytes;
begin
  Result := Destination.GetBytes(Source.GetChars(Bytes, StartIndex, Count));
end;

class procedure TEncoding.FreeEncodings;
begin
  FreeAndNil(FDefaultEncoding);
  FreeAndNil(FASCIIEncoding);
  FreeAndNil(FUTF7Encoding);
  FreeAndNil(FUTF8Encoding);
  FreeAndNil(FUnicodeEncoding);
  FreeAndNil(FBigEndianUnicodeEncoding);
end;

class function TEncoding.ASCII: TEncoding;
var
  LEncoding: TEncoding;
begin
  if FASCIIEncoding = nil then
  begin
    LEncoding := TMBCSEncoding.Create(20127, 0, 0);
    if InterlockedCompareExchangePointer(Pointer(FASCIIEncoding), LEncoding, nil) <> nil then
      FreeAndNil(LEncoding);
  end;
  Result := FASCIIEncoding;
end;

class function TEncoding.BigEndianUnicode: TEncoding;
var
  LEncoding: TEncoding;
begin
  if FBigEndianUnicodeEncoding = nil then
  begin
    LEncoding := TBigEndianUnicodeEncoding.Create;
    if InterlockedCompareExchangePointer(Pointer(FBigEndianUnicodeEncoding), LEncoding, nil) <> nil then
      FreeAndNil(LEncoding);
  end;
  Result := FBigEndianUnicodeEncoding;
end;

class function TEncoding.GetBufferEncoding(const Buffer: TBytes; var AEncoding: TEncoding): Integer;

  function ContainsPreamble(const Buffer, Signature: TBytes): Boolean;
  var
    I: Integer;
  begin
    Result := True;
    if Length(Buffer) >= Length(Signature) then
    begin
      for I := 1 to Length(Signature) do
        if Buffer[I - 1] <> Signature [I - 1] then
        begin
          Result := False;
          Break;
        end;
    end
    else
      Result := False;
  end;

var
  Preamble: TBytes;
begin
  Result := 0;
  Preamble := nil;
  if AEncoding = nil then
  begin
    // Find the appropraite encoding
    AEncoding := TEncoding.Unicode;
    if not ContainsPreamble(Buffer, AEncoding.GetPreamble) then
    begin
      AEncoding := TEncoding.BigEndianUnicode;
      if not ContainsPreamble(Buffer, AEncoding.GetPreamble) then
      begin
        AEncoding := TEncoding.UTF8;
        if not ContainsPreamble(Buffer, AEncoding.GetPreamble) then
          AEncoding := TEncoding.Default;
      end;
    end;
    Result := Length(AEncoding.GetPreamble);
  end
  else
  begin
    Preamble := AEncoding.GetPreamble;
    if ContainsPreamble(Buffer, Preamble) then
      Result := Length(Preamble);
  end;
end;

function TEncoding.GetByteCount(const Chars: TCharArray): Integer;
begin
  Result := GetByteCount(Chars, 0, Length(Chars));
end;

function TEncoding.GetByteCount(const Chars: TCharArray; CharIndex,
  CharCount: Integer): Integer;
begin
  Result := GetByteCount(@Chars[CharIndex], CharCount);
end;

function TEncoding.GetByteCount(const S: string): Integer;
begin
  Result := GetByteCount(PChar(S), Length(S));
end;

function TEncoding.GetByteCount(const S: string; CharIndex, CharCount: Integer): Integer;
begin
  if CharIndex < 1 then
    raise EEncodingError.CreateFmt(rsCharIndexOutOfBoundsFmt, [CharIndex]);
  if CharCount < 0 then
    raise EEncodingError.CreateFmt(rsInvalidCharCountFmt, [CharCount]);
  if (Length(S) - CharIndex + 1) < CharCount then
    raise EEncodingError.CreateFmt(rsInvalidCharCountFmt, [CharCount]);

  Result := GetByteCount(PChar(@S[CharIndex]), CharCount);
end;

function TEncoding.GetBytes(const Chars: TCharArray): TBytes;
var
  Len: Integer;
begin
  Len := GetByteCount(Chars);
  SetLength(Result, Len);
  GetBytes(Chars, 0, Length(Chars), Result, 0);
end;

function TEncoding.GetBytes(const Chars: TCharArray; CharIndex, CharCount: Integer;
  var Bytes: TBytes; ByteIndex: Integer): Integer;
var
  Len: Integer;
begin
  if (Chars = nil) and (CharCount <> 0) then
    raise EEncodingError.Create(rsInvalidSourceArray);
  if (Bytes = nil) and (CharCount <> 0) then
    raise EEncodingError.Create(rsInvalidDestinationArray);
  if CharIndex < 0 then
    raise EEncodingError.CreateFmt(rsCharIndexOutOfBoundsFmt, [CharIndex]);
  if CharCount < 0 then
    raise EEncodingError.CreateFmt(rsInvalidCharCountFmt, [CharCount]);
  if (Length(Chars) - CharIndex) < CharCount then
    raise EEncodingError.CreateFmt(rsInvalidCharCountFmt, [CharCount]);
  Len := Length(Bytes);
  if (ByteIndex < 0) or (ByteIndex > Len) then
    raise EEncodingError.CreateFmt(rsInvalidDestinationIndexFmt, [ByteIndex]);
  if Len - ByteIndex < GetByteCount(Chars, CharIndex, CharCount) then
    raise EEncodingError.Create(rsInvalidDestinationArray);

  Result := GetBytes(@Chars[CharIndex], CharCount, @Bytes[ByteIndex], Len - ByteIndex);
end;

function TEncoding.GetBytes(const S: string): TBytes;
var
  Len: Integer;
begin
  Len := GetByteCount(S);
  SetLength(Result, Len);
  GetBytes(S, 1, Length(S), Result, 0);
end;

function TEncoding.GetBytes(const S: string; CharIndex, CharCount: Integer;
  var Bytes: TBytes; ByteIndex: Integer): Integer;
var
  Len: Integer;
begin
  if (Bytes = nil) and (CharCount <> 0) then
    raise EEncodingError.Create(rsInvalidSourceArray);
  if CharIndex < 1 then
    raise EEncodingError.CreateFmt(rsCharIndexOutOfBoundsFmt, [CharIndex]);
  if CharCount < 0 then
    raise EEncodingError.CreateFmt(rsInvalidCharCountFmt, [CharCount]);
  if (Length(S) - CharIndex + 1) < CharCount then
    raise EEncodingError.CreateFmt(rsInvalidCharCountFmt, [CharCount]);
  Len := Length(Bytes);
  if (ByteIndex < 0) or (ByteIndex > Len) then
    raise EEncodingError.CreateFmt(rsInvalidDestinationIndexFmt, [ByteIndex]);
  if Len - ByteIndex < GetByteCount(S, CharIndex, CharCount) then
    raise EEncodingError.Create(rsInvalidDestinationArray);

  Result := GetBytes(@S[CharIndex], CharCount, @Bytes[ByteIndex], Len - ByteIndex);
end;

function TEncoding.GetCharCount(const Bytes: TBytes): Integer;
begin
  Result := GetCharCount(Bytes, 0, Length(Bytes));
end;

function TEncoding.GetCharCount(const Bytes: TBytes; ByteIndex, ByteCount: Integer): Integer;
begin
  if (Bytes = nil) and (ByteCount <> 0) then
    raise EEncodingError.Create(rsInvalidSourceArray);
  if ByteIndex < 0 then
    raise EEncodingError.CreateFmt(rsByteIndexOutOfBoundsFmt, [ByteIndex]);
  if ByteCount < 0 then
    raise EEncodingError.CreateFmt(rsInvalidCharCountFmt, [ByteCount]);
  if (Length(Bytes) - ByteIndex) < ByteCount then
    raise EEncodingError.CreateFmt(rsInvalidCharCountFmt, [ByteCount]);

  Result := GetCharCount(@Bytes[ByteIndex], ByteCount);
end;

function TEncoding.GetChars(const Bytes: TBytes): TCharArray;
begin
  Result := GetChars(Bytes, 0, Length(Bytes));
end;

function TEncoding.GetChars(const Bytes: TBytes; ByteIndex, ByteCount: Integer): TCharArray;
var
  Len: Integer;
begin
  if (Bytes = nil) and (ByteCount <> 0) then
    raise EEncodingError.Create(rsInvalidSourceArray);
  if ByteIndex < 0 then
    raise EEncodingError.CreateFmt(rsByteIndexOutOfBoundsFmt, [ByteIndex]);
  if ByteCount < 0 then
    raise EEncodingError.CreateFmt(rsInvalidCharCountFmt, [ByteCount]);
  if (Length(Bytes) - ByteIndex) < ByteCount then
    raise EEncodingError.CreateFmt(rsInvalidCharCountFmt, [ByteCount]);

  Len := GetCharCount(Bytes, ByteIndex, ByteCount);
  SetLength(Result, Len);
  GetChars(@Bytes[ByteIndex], ByteCount, PChar(Result), Len);
end;

function TEncoding.GetChars(const Bytes: TBytes; ByteIndex, ByteCount: Integer;
  var Chars: TCharArray; CharIndex: Integer): Integer;
var
  LCharCount: Integer;
begin
  if (Bytes = nil) and (ByteCount <> 0) then
    raise EEncodingError.Create(rsInvalidSourceArray);
  if ByteIndex < 0 then
    raise EEncodingError.CreateFmt(rsByteIndexOutOfBoundsFmt, [ByteIndex]);
  if ByteCount < 0 then
    raise EEncodingError.CreateFmt(rsInvalidCharCountFmt, [ByteCount]);
  if (Length(Bytes) - ByteIndex) < ByteCount then
    raise EEncodingError.CreateFmt(rsInvalidCharCountFmt, [ByteCount]);

  LCharCount := GetCharCount(Bytes, ByteIndex, ByteCount);
  if (CharIndex < 0) or (CharIndex> Length(Chars)) then
    raise EEncodingError.CreateFmt(rsInvalidDestinationIndexFmt, [CharIndex]);
  if CharIndex + LCharCount > Length(Chars) then
    raise EEncodingError.Create(rsInvalidDestinationArray);

  Result := GetChars(@Bytes[ByteIndex], ByteCount, @Chars[CharIndex], Length(Chars) - CharIndex);
end;

class function TEncoding.Default: TEncoding;
var
  LEncoding: TEncoding;
begin
  if FDefaultEncoding = nil then
  begin
    LEncoding := TMBCSEncoding.Create(CP_ACP, 0, 0);
    if InterlockedCompareExchangePointer(Pointer(FDefaultEncoding), LEncoding, nil) <> nil then
      FreeAndNil(LEncoding);
  end;
  Result := FDefaultEncoding;
end;

class function TEncoding.GetEncoding(CodePage: Integer): TEncoding;
begin
  Result := TMBCSEncoding.Create(CodePage);
end;

function TEncoding.GetString(const Bytes: TBytes): string;
begin
  Result := GetString(Bytes, 0, Length(Bytes));
end;

function TEncoding.GetString(const Bytes: TBytes; ByteIndex, ByteCount: Integer): string;
var
  LChars: TCharArray;
begin
  LChars := GetChars(Bytes, ByteIndex, ByteCount);
  SetString(Result, PChar(LChars), Length(LChars));
end;

class function TEncoding.Unicode: TEncoding;
var
  LEncoding: TEncoding;
begin
  if FUnicodeEncoding = nil then
  begin
    LEncoding := TUnicodeEncoding.Create;
    if InterlockedCompareExchangePointer(Pointer(FUnicodeEncoding), LEncoding, nil) <> nil then
      FreeAndNil(LEncoding);
  end;
  Result := FUnicodeEncoding;
end;

class function TEncoding.UTF7: TEncoding;
var
  LEncoding: TEncoding;
begin
  if FUTF7Encoding = nil then
  begin
    LEncoding := TUTF7Encoding.Create;
    if InterlockedCompareExchangePointer(Pointer(FUTF7Encoding), LEncoding, nil) <> nil then
      FreeAndNil(LEncoding);
  end;
  Result := FUTF7Encoding;
end;

class function TEncoding.UTF8: TEncoding;
var
  LEncoding: TEncoding;
begin
  if FUTF8Encoding = nil then
  begin
    LEncoding := TUTF8Encoding.Create;
    if InterlockedCompareExchangePointer(Pointer(FUTF8Encoding), LEncoding, nil) <> nil then
      FreeAndNil(LEncoding);
  end;
  Result := FUTF8Encoding;
end;

class function TEncoding.IsStandardEncoding(AEncoding: TEncoding): Boolean;
begin
  Result :=
    (AEncoding = FASCIIEncoding) or
    (AEncoding = FBigEndianUnicodeEncoding) or
    (AEncoding = FDefaultEncoding) or
    (AEncoding = FUnicodeEncoding) or
    (AEncoding = FUTF7Encoding) or
    (AEncoding = FUTF8Encoding);
end;

{ TMBCSEncoding }

constructor TMBCSEncoding.Create;
begin
  Create(CP_ACP, 0, 0);
end;

constructor TMBCSEncoding.Create(CodePage: Integer);
begin
  FCodePage := CodePage;
  Create(CodePage, 0, 0);
end;

constructor TMBCSEncoding.Create(CodePage, MBToWCharFlags, WCharToMBFlags: Integer);
var
  LCPInfo: TCPInfo;
begin
  FCodePage := CodePage;
  FMBToWCharFlags := MBToWCharFlags;
  FWCharToMBFlags := WCharToMBFlags;

  if not GetCPInfo(FCodePage, LCPInfo) then
    raise EEncodingError.Create(rsInvalidCodePage);
  FMaxCharSize := LCPInfo.MaxCharSize;
  FIsSingleByte := FMaxCharSize = 1;
end;

function TMBCSEncoding.GetByteCount(Chars: PChar; CharCount: Integer): Integer;
begin
{$IFDEF UNICODE}
  Result := WideCharToMultiByte(FCodePage, FWCharToMBFlags,
    PChar(Chars), CharCount, nil, 0, nil, nil);
{$ELSE}
  Result := CharCount;
{$ENDIF}
end;

function TMBCSEncoding.GetBytes(Chars: PChar; CharCount: Integer; Bytes: PByte;
  ByteCount: Integer): Integer;
begin
{$IFDEF UNICODE}
  Result := WideCharToMultiByte(FCodePage, FWCharToMBFlags,
    PChar(Chars), CharCount, PAnsiChar(Bytes), ByteCount, nil, nil);
{$ELSE}
  Result := CharCount;
  Move(Chars^, Bytes^, Result);
{$ENDIF}
end;

function TMBCSEncoding.GetCharCount(Bytes: PByte; ByteCount: Integer): Integer;
begin
{$IFDEF UNICODE}
  Result := MultiByteToWideChar(FCodePage, FMBToWCharFlags,
    PAnsiChar(Bytes), ByteCount, nil, 0);
{$ELSE}
  Result := ByteCount;
{$ENDIF}
end;

function TMBCSEncoding.GetChars(Bytes: PByte; ByteCount: Integer; Chars: PChar;
  CharCount: Integer): Integer;
begin
{$IFDEF UNICODE}
  Result := MultiByteToWideChar(FCodePage, FMBToWCharFlags,
    PAnsiChar(Bytes), ByteCount, PChar(Chars), CharCount);
{$ELSE}
  Result := CharCount;
  Move(Bytes^, Chars^, CharCount * SizeOf(AnsiChar));
{$ENDIF}
end;

function TMBCSEncoding.GetMaxByteCount(CharCount: Integer): Integer;
begin
  Result := (CharCount + 1) * FMaxCharSize;
end;

function TMBCSEncoding.GetMaxCharCount(ByteCount: Integer): Integer;
begin
  Result := ByteCount;
end;

function TMBCSEncoding.GetPreamble: TBytes;
begin
  SetLength(Result, 0);
end;

{ TUTF7Encoding }

constructor TUTF7Encoding.Create;
begin
  inherited Create(CP_UTF7);
end;

function TUTF7Encoding.GetByteCount(Chars: PChar; CharCount: Integer): Integer;
begin
{$IFDEF UNICODE}
  Result := inherited GetByteCount(Chars, CharCount);
{$ELSE}
  Result := WideCharToMultiByte(FCodePage, FWCharToMBFlags,
    PWideChar(UnicodeString(string(Chars))), CharCount, nil, 0, nil, nil);
{$ENDIF}
end;

function TUTF7Encoding.GetBytes(Chars: PChar; CharCount: Integer; Bytes: PByte;
  ByteCount: Integer): Integer;
begin
{$IFDEF UNICODE}
  Result := inherited GetBytes(Chars, CharCount, Bytes, ByteCount);
{$ELSE}
  Result := WideCharToMultiByte(FCodePage, FWCharToMBFlags,
    PWideChar(UnicodeString(string(Chars))), CharCount, PAnsiChar(Bytes),
    ByteCount, nil, nil);
{$ENDIF}
end;

function TUTF7Encoding.GetCharCount(Bytes: PByte; ByteCount: Integer): Integer;
begin
{$IFDEF UNICODE}
  Result := inherited GetCharCount(Bytes, ByteCount);
{$ELSE}
  Result := MultiByteToWideChar(FCodePage, FWCharToMBFlags,
    PAnsiChar(Bytes), ByteCount, nil, 0);
{$ENDIF}
end;

function TUTF7Encoding.GetChars(Bytes: PByte; ByteCount: Integer; Chars: PChar;
  CharCount: Integer): Integer;
{$IFNDEF UNICODE}
var
  AStr: AnsiString;
  UStr: UnicodeString;
{$ENDIF}
begin
{$IFDEF UNICODE}
  Result := inherited GetChars(Bytes, ByteCount, Chars, CharCount);
{$ELSE}
  SetLength(UStr, CharCount);
  Result := MultiByteToWideChar(FCodePage, FWCharToMBFlags,
    PAnsiChar(Bytes), ByteCount, PWideChar(UStr), CharCount);
  AStr := AnsiString(UStr);
  Move(AStr[1], Chars^, Length(AStr));
{$ENDIF}
end;

function TUTF7Encoding.GetMaxByteCount(CharCount: Integer): Integer;
begin
  Result := (CharCount * 3) + 2;
end;

function TUTF7Encoding.GetMaxCharCount(ByteCount: Integer): Integer;
begin
  Result := ByteCount;
end;

{ TUTF8Encoding }

constructor TUTF8Encoding.Create;
begin
  inherited Create(CP_UTF8);
end;

function TUTF8Encoding.GetMaxByteCount(CharCount: Integer): Integer;
begin
  Result := (CharCount + 1) * 3;
end;

function TUTF8Encoding.GetMaxCharCount(ByteCount: Integer): Integer;
begin
  Result := ByteCount + 1;
end;

function TUTF8Encoding.GetPreamble: TBytes;
begin
  SetLength(Result, 3);
  Result[0] := $EF;
  Result[1] := $BB;
  Result[2] := $BF;
end;

{ TUnicodeEncoding }

constructor TUnicodeEncoding.Create;
begin
  FIsSingleByte := False;
  FMaxCharSize := 4;
end;

function TUnicodeEncoding.GetByteCount(Chars: PChar; CharCount: Integer): Integer;
begin
{$IFDEF UNICODE}
  Result := CharCount * SizeOf(Char);
{$ELSE}
  Result := MultiByteToWideChar(CP_ACP, 0, PChar(Chars), CharCount,
    nil, 0) * SizeOf(WideChar);
{$ENDIF}
end;

function TUnicodeEncoding.GetBytes(Chars: PChar; CharCount: Integer;
  Bytes: PByte; ByteCount: Integer): Integer;
begin
{$IFDEF UNICODE}
  Result := CharCount * SizeOf(Char);
  Move(Chars^, Bytes^, Result);
{$ELSE}
  Result := MultiByteToWideChar(CP_ACP, 0, PChar(Chars), CharCount,
    PWideChar(Bytes), ByteCount) * SizeOf(WideChar);
{$ENDIF}
end;

function TUnicodeEncoding.GetCharCount(Bytes: PByte; ByteCount: Integer): Integer;
begin
{$IFDEF UNICODE}
  Result := ByteCount div SizeOf(Char);
{$ELSE}
  Result := WideCharToMultiByte(CP_ACP, 0, PWideChar(Bytes), ByteCount, nil, 0,
    nil, nil) div SizeOf(WideChar);
{$ENDIF}
end;

function TUnicodeEncoding.GetChars(Bytes: PByte; ByteCount: Integer;
  Chars: PChar; CharCount: Integer): Integer;
begin
{$IFDEF UNICODE}
  Result := CharCount;
  Move(Bytes^, Chars^, CharCount * SizeOf(Char));
{$ELSE}
  Result := WideCharToMultiByte(CP_ACP, 0, PWideChar(Bytes), CharCount,
    PChar(Chars), ByteCount, nil, nil);
{$ENDIF}
end;

function TUnicodeEncoding.GetMaxByteCount(CharCount: Integer): Integer;
begin
  Result := (CharCount + 1) * 2;
end;

function TUnicodeEncoding.GetMaxCharCount(ByteCount: Integer): Integer;
begin
  Result := (ByteCount div 2) + (ByteCount and 1) + 1;
end;

function TUnicodeEncoding.GetPreamble: TBytes;
begin
  SetLength(Result, 2);
  Result[0] := $FF;
  Result[1] := $FE;
end;

{ TBigEndianUnicodeEncoding }

procedure SwapBytes(P1, P2: PByte); {$IFDEF SUPPORTS_INLINE}inline;{$ENDIF}
var
  B: Byte;
begin
  B := P1^;
  P1^ := P2^;
  P2^ := B;
end;

function TBigEndianUnicodeEncoding.GetBytes(Chars: PChar; CharCount: Integer;
  Bytes: PByte; ByteCount: Integer): Integer;
var
  I: Integer;
{$IFNDEF UNICODE}
  B2: PByte;
{$ENDIF}
begin
{$IFDEF UNICODE}
  for I := 0 to CharCount - 1 do
  begin
    Bytes^ := Hi(Word(Chars^));
    Inc(Bytes);
    Bytes^ := Lo(Word(Chars^));
    Inc(Bytes);
    Inc(Chars);
  end;
  Result := CharCount * SizeOf(WideChar);
{$ELSE}
  Result := inherited GetBytes(Chars, CharCount, Bytes, ByteCount);
  for I := 1 to Result do
  begin
    B2 := Bytes;
    Inc(B2);
    SwapBytes(Bytes, B2);
    Inc(Bytes, 2);
  end;
{$ENDIF}
end;

function TBigEndianUnicodeEncoding.GetChars(Bytes: PByte; ByteCount: Integer;
  Chars: PChar; CharCount: Integer): Integer;
var
  P: PByte;
  I: Integer;
{$IFNDEF UNICODE}
  B2: PByte;
{$ENDIF}
begin
{$IFDEF UNICODE}
  P := Bytes;
  Inc(P);
  for I := 0 to CharCount - 1 do
  begin
    Chars^ := WideChar(MakeWord(P^, Bytes^));
    Inc(Bytes, 2);
    Inc(P, 2);
    Inc(Chars);
  end;
  Result := CharCount;
{$ELSE}
  P := Bytes;
  for I := 1 to CharCount do
  begin
    B2 := P;
    Inc(B2);
    SwapBytes(P, B2);
    Inc(P, 2);
  end;
  Result := inherited GetChars(Bytes, ByteCount, Chars, CharCount);
{$ENDIF}
end;

function TBigEndianUnicodeEncoding.GetPreamble: TBytes;
begin
  SetLength(Result, 2);
  Result[0] := $FE;
  Result[1] := $FF;
end;

initialization
  // Does nothing

finalization
  TEncoding.FreeEncodings;

end.
