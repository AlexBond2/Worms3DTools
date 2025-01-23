unit OpenGL_Box;

interface

uses
  SysUtils, Classes, Controls, ExtCtrls, OpenGlx, Windows,
  Messages, Variants, Graphics, Forms, Dialogs;
{$DEFINE NOMULTI}
type
  TOpenGLBox = class(TPanel)
  private
    FOnPaint: TNotifyEvent;
    procedure SetOnOpenGL(Value: Boolean);
    function GetActive: Boolean;
  public
    Gl_RC: HGLRC;
    GL_DC: HDC;
    GL_Font: Integer;
    procedure glBoxInit; virtual;
    destructor Destroy; override;

  protected
    procedure Paint; override;
  published
    property OnOpenGL: Boolean read GetActive write SetOnOpenGL;
    property OnPaint: TNotifyEvent read FOnPaint write FOnPaint;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
  end;

procedure Register;

implementation

//------------------------------------------------------------------------------

procedure Register;
begin
  RegisterComponents('PanelX', [TOpenGLBox]);
end;

//------------------------------------------------------------------------------

{ TOpenGLBox }

//------------------------------------------------------------------------------

procedure TOpenGLBox.glBoxInit();
var
  pfd: PIXELFORMATDESCRIPTOR;
  PixelFormat:integer;
begin

  
  zeromemory(@pfd, SizeOf(pfd));
  pfd.nSize := SizeOf(PIXELFORMATDESCRIPTOR);
  pfd.nVersion := 1;

  pfd.dwFlags := PFD_DRAW_TO_WINDOW or PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER;

  pfd.iPixelType := PFD_TYPE_RGBA;
  pfd.cColorBits := 32;
  pfd.cDepthBits := 32;
  pfd.iLayerType := PFD_MAIN_PLANE;


  GL_DC := GetDC(Handle);
{$IFDEF DEBUG}
Writeln('GetDC...Ok');
{$ENDIF}
  PixelFormat:=ChoosePixelFormat(GL_DC, @pfd);
{$IFDEF DEBUG}
Writeln('ChoosePixelFormat...Ok');
{$ENDIF}
  SetPixelFormat(GL_DC, PixelFormat, @pfd);
{$IFDEF DEBUG}
Writeln('SetPixelFormat...Ok');
{$ENDIF}
  Gl_RC := wglCreateContext(GL_DC);
{$IFDEF DEBUG}
Writeln('wglCreateContext...Ok');
{$ENDIF}
{$IFDEF GL20}
  ActivateRenderingContext(GL_DC, Gl_RC);
{$ELSE}
  wglMakeCurrent(GL_DC, Gl_RC);
{$ENDIF}
{$IFDEF DEBUG}
Writeln('wglMakeCurrent...Ok');
{$ENDIF}
  SelectObject(GL_DC, Font.Handle);
  wglUseFontBitmaps(GL_DC, 0, 256, GL_Font);
{$IFDEF NOMULTI}
  InitOpenGL;
{$IFDEF DEBUG}
Writeln('InitOpenGL...Ok');
{$ENDIF}
{$ENDIF}
end;
//------------------------------------------------------------------------------

procedure TOpenGLBox.Paint;
begin
  //inherited;
  if Assigned(FOnPaint) then 
    FOnPaint(Self);
end;
//---------------------------
{procedure TOpenGLBox.OnClick;
begin
OnOpenGL:=true;
inherited;
end;      }
//---------------------------

function TOpenGLBox.GetActive: Boolean;
begin
  Result := Focused;
end;
//---------------------------

procedure TOpenGLBox.SetOnOpenGL(Value: Boolean);
begin
  if Value then
    SetFocus;
end;
  //------------------------------------------------------------------------------
  //------------------------------------------------------------------------------}
destructor TOpenGLBox.Destroy;
begin
{$IFDEF GL20}
  DeactivateRenderingContext; // Deactivates the current context
{$ELSE}
  wglMakeCurrent(0, 0);
{$ENDIF}
  wglDeleteContext(Gl_RC);
//  ReleaseDC(Handle, Gl_DC);

  inherited Destroy;
end;
//------------------------------------------------------------------------------


end.
