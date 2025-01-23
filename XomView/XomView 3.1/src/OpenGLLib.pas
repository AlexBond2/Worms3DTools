unit OpenGLLib;

interface

uses
  Windows, OpenGLx, Math;

type
  Tver         = array[0..2] of GLfloat;
  AVer         = array of TVer;
  TFace        = array[0..3] of Word;
  AFace        = array of TFace;
  Tpnt         = array[0..1] of GLfloat;
  ATCoord      = array of Tpnt;
  Tvector      = record
      X, Y, Z: GLfloat;
  end;

  TBox = record
    Xmin, Ymin, Zmin: GLfloat;
    Xmax, Ymax, Zmax: GLfloat;
  end;

  TMatrix = array[1..4, 1..4] of GLfloat;
  Color4d    = array[0..3] of GLfloat;
  TArInt  = array of Integer;

  type TXYZ = record
        x,y,z:real;
        end;
     TAxis = (Axis_X,Axis_Y,Axis_Z,Axis_XY,Axis_YZ,Axis_XZ,Axis_XYZ);
     TMode = (mMove,mRotate,mScale);
const
  clrX = 10001;
  clrY = 10002;
  clrZ = 10003;
  clrXY = 10004;
  clrYZ = 10005;
  clrXZ = 10006;
  clrXYZ = 10007;
procedure oglAxes;
procedure oglDynAxes(Axis:TAxis;Mode:TMode;Select:Boolean;Layers:boolean = false);
procedure oglTarget(Torget: GlFloat);
function Vert(const x, y, z: GLFloat): TVer;
function glGenNormal(const fVert1, fVert2, fVert3: Tver): Tver;
procedure oglBox(HSize: Double; Mode: Cardinal);
procedure oglPyramid(HSize: Double; Mode: Cardinal);
procedure oglLumpCyl;
procedure oglLumpLight;
procedure oglStar;
procedure oglCircle(circle_points: Integer);
procedure oglGrid(GridMax: Integer);
procedure Rotate(x, y, z: Single);
procedure glColor4_256(RGBA: Cardinal);

var eqn:array[0..3] of real = (1,0,0,0);
MatrixRot: TMatrix;
eqn_rot:TXYZ;

implementation

procedure glColor4_256(RGBA: Cardinal);
var
  color4: color4d;
begin
  color4[0] := (RGBA and $ff) / 255.0;
  RGBA := RGBA shr 8;
  color4[1] := (RGBA and $ff) / 255.0;
  RGBA := RGBA shr 8;
  color4[2] := (RGBA and $ff) / 255.0;
  RGBA := RGBA shr 8;
  color4[3] := (RGBA and $ff) / 255.0;
  glColor4fv(@color4);
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

procedure oglCircle(circle_points: Integer);
var
  i: Integer;
  angle: glFloat;
begin
  glBegin(GL_LINE_LOOP);
  for i := 0 to circle_points do
  begin
    angle := 2 * Pi * i / circle_points;
    glVertex2f(Cos(angle), Sin(angle));
  end;
  glEnd;
end;

procedure oglCircleF(circle_points: Integer);
var
  i: Integer;
  angle: glFloat;
begin
  glBegin(GL_TRIANGLE_FAN);
  glVertex3f(0, 0, 0);
  for i := 0 to circle_points do
  begin
    angle := 2 * Pi * i / circle_points;
    glVertex2f(Cos(angle), Sin(angle));
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

procedure oglDynAxes(Axis: TAxis; Mode: TMode; Select: Boolean; Layers:boolean = false);
var 
  f, d, g, h, k, p,m,t,length,theta: Single;
  n,a,b:TXYZ;
  label next1,next2,next3;
  procedure glxText(x, y, z: Single; s: string);
  begin
    glRasterPos3f(x, y, z);
    glCallLists(1, GL_UNSIGNED_BYTE, Pointer(S));
  end;
begin
  m := 1.0;
  t := 1.2;
  f := 0.05;
  d := f / 2;
  g := 1.732050807569 * d;
  h := 0.7;
  k := 0.2;
  p := 0.4;  
  glListBase(2000);//FontGL

  if select then glLineWidth(8);
  if Mode = mRotate then
  begin
  k := 0;
  m := 0.4;
  t := 0.5;
  end;

  if select then glColor4_256(clrX)
  else if (Axis = Axis_X) or (Axis = Axis_XY) or (Axis = Axis_XZ) or (Axis = Axis_XYZ) then
    glColor3f(1, 1, 0) else glColor3f(1, 0, 0);


 // создаем орбиту по X
  if Mode = mRotate then
  begin
  if (not select)then if (Axis = Axis_X) then glColor3f(1, 1, 0) else glColor3f(1, 0, 0);
  glClipPlane(GL_CLIP_PLANE0,@eqn);
  glEnable(GL_CLIP_PLANE0);

  glPushMatrix;
  glRotatef(90, 0, 1, 0);
  oglCircle(100);
  glPopMatrix;
  glDisable(GL_CLIP_PLANE0);
  if (not select) then
        begin
        if (Axis = Axis_X) then
          glColor3f(1, 0, 0) else glColor3f(0.5, 0.5, 0.5);
        end else goto next1;
  end;

  if not select then glxText(t, 0, 0, 'x');
  glBegin(GL_LINES);
  glVertex3f(k, 0, 0);
  glVertex3f(m, 0, 0);
  if Mode <> mRotate then
  begin
    if not Layers then begin
    if select then glColor4_256(clrXY) else if (Axis <> Axis_XY)and (Axis <> Axis_XYZ)
                then glColor3f(1, 0, 0) else  glColor3f(1, 1, 0);
    if Mode = mScale then glVertex3f(p * 2, 0, 0);
    if Mode = mMove then glVertex3f(p, 0, 0);
    glVertex3f(p, p, 0);
    end;
    if select then glColor4_256(clrXZ) else if (Axis <> Axis_XZ)and(Axis <> Axis_XYZ)
                then glColor3f(1, 0, 0) else glColor3f(1, 1, 0);
    if Mode = mScale then glVertex3f(p * 2, 0, 0);
    if Mode = mMove then glVertex3f(p, 0, 0);
    glVertex3f(p, 0, p);
  end;
  glEnd;

  if Mode = mMove then
    if not select then 
    begin
      glColor3f(1, 0, 0);
      glBegin(GL_TRIANGLE_FAN);
      glVertex3f(1, 0, 0);
      glVertex3f(h, - f, 0);
      glVertex3f(h, - d, - g);
      glVertex3f(h, d, - g);
      glVertex3f(h, f, 0);
      glVertex3f(h, d, g);
      glVertex3f(h, - d, g);
      glVertex3f(h, - f, 0);
      glEnd;
      glColor3f(0.5, 0, 0);
      glBegin(GL_TRIANGLE_FAN);
      glVertex3f(h, 0, 0);
      glVertex3f(h, - f, 0);
      glVertex3f(h, - d, g);
      glVertex3f(h, d, g);
      glVertex3f(h, f, 0);
      glVertex3f(h, d, - g);
      glVertex3f(h, - d, - g);
      glVertex3f(h, - f, 0);
      glEnd;
    end;
  /////////////////////////////////////////
  next1:
  if Layers then goto next2;
  if select then glColor4_256(clrY)
  else if (Axis = Axis_Y) or (Axis = Axis_XY) or (Axis = Axis_YZ) or (Axis = Axis_XYZ) then
    glColor3f(1, 1, 0) else glColor3f(0, 1, 0);


  // создаем орбиту по Y
  if Mode = mRotate then
  begin
  if (not select)then if(Axis = Axis_Y) then  glColor3f(1, 1, 0) else glColor3f(0, 1, 0);
  glEnable(GL_CLIP_PLANE0);
  glPushMatrix;
    glRotatef(-eqn_rot.X, 1, 0, 0);//X
  glRotatef(90, 1, 0, 0);
  oglCircle(100);
  glPopMatrix;
  glDisable(GL_CLIP_PLANE0);
   glRotatef(-eqn_rot.X, 1, 0, 0);//X
  if (not select) then
        begin
        if (Axis = Axis_Y) then
          glColor3f(0, 1, 0) else glColor3f(0.5, 0.5, 0.5);
        end else goto next2;
  end;

  glBegin(GL_LINES);
  glVertex3f(0, k, 0);
  glVertex3f(0, m, 0);
  if Mode <> mRotate then
  begin
    if select then glColor4_256(clrXY) else if (Axis <> Axis_XY)and(Axis <> Axis_XYZ)
                then glColor3f(0, 1, 0) else  glColor3f(1, 1, 0);
    if Mode = mMove then glVertex3f(0, p, 0);
    if Mode = mScale then glVertex3f(0, p * 2, 0);
    glVertex3f(p, p, 0);

    if select then glColor4_256(clrYZ) else if (Axis <> Axis_YZ)and(Axis <> Axis_XYZ)
                then glColor3f(0, 1, 0) else glColor3f(1, 1, 0);
    if Mode = mScale then glVertex3f(0, p * 2, 0);
    if Mode = mMove then glVertex3f(0, p, 0);
    glVertex3f(0, p, p);
  end;
  glEnd;
  if not select then glxText(0, t, 0, 'y');
  if Mode = mMove then
    if not select then
    begin
      glColor3f(0, 1, 0);
      glBegin(GL_TRIANGLE_FAN);
      glVertex3f(0, 1, 0);
      glVertex3f(-f, h, 0);
      glVertex3f(-d, h, g);
      glVertex3f(d, h, g);
      glVertex3f(f, h, 0);
      glVertex3f(d, h, - g);
      glVertex3f(-d, h, - g);
      glVertex3f(-f, h, 0);
      glEnd;
      glColor3f(0, 0.5, 0);
      glBegin(GL_TRIANGLE_FAN);
      glVertex3f(0, h, 0);
      glVertex3f(-f, h, 0);
      glVertex3f(-d, h, - g);
      glVertex3f(d, h, - g);
      glVertex3f(f, h, 0);
      glVertex3f(d, h, g);
      glVertex3f(-d, h, g);
      glVertex3f(-f, h, 0);
      glEnd;
    end;
  //////////////////////////////////
next2:
  if select then glColor4_256(clrZ)
  else if (Axis = Axis_Z) or (Axis = Axis_YZ) or (Axis = Axis_XZ) or (Axis = Axis_XYZ)  then
    glColor3f(1, 1, 0) else glColor3f(0, 0, 1);
  // создаем орбиту по Z
  if Mode = mRotate then
  begin
  if (not select)then if (Axis = Axis_Z) then glColor3f(1, 1, 0) else glColor3f(0, 0, 1);
  glLoadMatrixf(@MatrixRot);
  glEnable(GL_CLIP_PLANE0);
  glRotatef(-eqn_rot.X, 1, 0, 0);//X
  glRotatef(-eqn_rot.y, 0, 1, 0);//y
  oglCircle(100);
  glDisable(GL_CLIP_PLANE0);
  if (not select) then
        begin
        if (Axis = Axis_Z) then
          glColor3f(0, 0, 1) else glColor3f(0.5, 0.5, 0.5);
        end else goto next3;
  end;

  glBegin(GL_LINES);
  glVertex3f(0, 0, k);
  glVertex3f(0, 0, m);
  if Mode <> mRotate then
  begin
  if not Layers then begin
    if select then glColor4_256(clrYZ) else if (Axis <> Axis_YZ)and(Axis <> Axis_XYZ)
                then glColor3f(0, 0, 1) else glColor3f(1, 1, 0);
    if Mode = mScale then glVertex3f(0, 0, 2 * p);
    if Mode = mMove then glVertex3f(0, 0, p);
    glVertex3f(0, p, p);
    end;
    if select then glColor4_256(clrXZ) else if (Axis <> Axis_XZ)and(Axis <> Axis_XYZ)
                then glColor3f(0, 0, 1) else glColor3f(1, 1, 0);
    if Mode = mScale then glVertex3f(0, 0, 2 * p);
    if Mode = mMove then glVertex3f(0, 0, p);
    glVertex3f(p, 0, p);
  end;
  glEnd;
  if not select then glxText(0, 0, t, 'z');

  if Mode = mMove then
    if not select then
    begin
      glColor3f(0, 0, 1);
      glBegin(GL_TRIANGLE_FAN);
      glVertex3f(0, 0, 1);
      glVertex3f(-f, 0, h);
      glVertex3f(-d, - g, h);
      glVertex3f(d, - g, h);
      glVertex3f(f, 0, h);
      glVertex3f(d, g, h);
      glVertex3f(-d, g, h);
      glVertex3f(-f, 0, h);
      glEnd;
      glColor3f(0, 0, 0.5);
      glBegin(GL_TRIANGLE_FAN);
      glVertex3f(0, 0, h);
      glVertex3f(-f, 0, h);
      glVertex3f(-d, g, h);
      glVertex3f(d, g, h);
      glVertex3f(f, 0, h);
      glVertex3f(d, - g, h);
      glVertex3f(-d, - g, h);
      glVertex3f(-f, 0, h);
      glEnd;
    end;
///////////////////
next3:
  if (Mode = mRotate) and (not select) then
  begin
    glLoadMatrixf(@MatrixRot);
    glPushAttrib(GL_ENABLE_BIT);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA,
      GL_ONE_MINUS_SRC_ALPHA);
  glColor4f(0.5, 0.5, 0.5, 0.5);
  glPushMatrix;
   n.x:= eqn[0]; b.x:= 0;
   n.y:= eqn[1]; b.y:= 0;
   n.z:= eqn[2]; b.z:= 1;
  a.x:=n.y*b.z-b.y*n.z;
  a.y:=b.x*n.z-n.x*b.z;
  a.z:=n.x*b.y-b.x*n.y;
  theta:=arccos((n.x*b.x+n.y*b.y+n.z*b.z)/
  (sqrt(n.x*n.x+n.y*n.y+n.z*n.z)*sqrt(b.x*b.x+b.y*b.y+b.z*b.z))) ;
  glRotated(-theta/pi*180, a.x, a.y, a.z);
 // »так мы имеем два вектора начальный (0,0,1)
 // и тот на котором должна быть окружность (eqn[0], eqn[1], eqn[2])
 // повернуть пространство на разницу между углами через перпендикул€рный
 // вектор.
  oglCircleF(100);
  glPopMatrix;
  end;
  ////////////////////////
  if (Mode = mScale) and (not select) then
  begin
    glPushAttrib(GL_ENABLE_BIT);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA,
      GL_ONE_MINUS_SRC_ALPHA);
    glEnable(GL_POINT_SMOOTH);
    glPointSize(8);
    glBegin(GL_POINTS);
    glColor3f(1, 0, 0);
    glVertex3f(1, 0, 0);
    glColor3f(0, 0, 1);
    glVertex3f(0, 0, 1);
    if not Layers then begin
    glColor3f(0, 1, 0);
    glVertex3f(0, 1, 0);
    end;
    glEnd;
    glPointSize(1.0);
    glPopAttrib;
  end;
  //////////////////////////
  if (Mode = mMove) and (not select) then 
  begin
    glPushAttrib(GL_ENABLE_BIT);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA,
      GL_ONE_MINUS_SRC_ALPHA);
    glDisable(GL_CULL_FACE);
    glBegin(GL_TRIANGLE_FAN);
    glColor4f(1, 1, 0, 0.5);
    glVertex3f(0, 0, 0);
    case Axis of
      Axis_XY: 
      if not Layers then begin
        glVertex3f(0, p, 0);
        glVertex3f(p, p, 0);
        glVertex3f(p, 0, 0);
      end;
      Axis_YZ: 
      if not Layers then begin
        glVertex3f(0, p, 0);
        glVertex3f(0, p, p);
        glVertex3f(0, 0, p);
      end;
      Axis_XZ: 
      begin
        glVertex3f(p, 0, 0);
        glVertex3f(p, 0, p);
        glVertex3f(0, 0, p);
      end;
    end;
    glEnd;

    glPopAttrib;
  end;

 if (Mode = mScale) and (select)and not Layers then
  begin
    glPushAttrib(GL_ENABLE_BIT);
    glDisable(GL_CULL_FACE);
    glBegin(GL_TRIANGLE_FAN);
    glColor4_256(clrXYZ);
    glVertex3f(0, 0, 0);
        glVertex3f(0, p, 0);
        glVertex3f(p, 0, 0);
        glVertex3f(0, 0, p);
        glVertex3f(0, p, 0);
    glEnd;
    glPopAttrib;
  end;

 if (Mode = mScale) and (not select) then
  begin
    glPushAttrib(GL_ENABLE_BIT);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA,
      GL_ONE_MINUS_SRC_ALPHA);
    glDisable(GL_CULL_FACE);
    glBegin(GL_TRIANGLE_FAN);
    glColor4f(1, 1, 0, 0.5);
    glVertex3f(0, 0, 0);
    case Axis of
      Axis_XY:
      if not Layers then begin
        glVertex3f(0, 2*p, 0);
        glVertex3f(2*p, 0, 0);
      end;
      Axis_YZ:
      if not Layers then begin
        glVertex3f(0, 2*p, 0);
        glVertex3f(0, 0, 2*p);
      end;
      Axis_XZ:
      begin
        glVertex3f(2*p, 0, 0);
        glVertex3f(0, 0, 2*p);
      end;
      Axis_XYZ:
      if not Layers then begin
        glVertex3f(0, 2*p, 0);
        glVertex3f(2*p, 0, 0);
        glVertex3f(0, 0,  2*p);
        glVertex3f(0,  2*p, 0);
      end;
    end;
    glEnd;

    glPopAttrib;
  end;
  glLineWidth(1.0);
  //////////////////////////////////
  // glEnable(GL_LIGHTING);
end;

procedure oglTarget(Torget: GlFloat);
begin
  glBegin(GL_LINES);
  glVertex3f(-Torget, 0, 0);
  glVertex3f(Torget, 0, 0);
  glVertex3f(0, - Torget, 0);
  glVertex3f(0, Torget, 0);
  glVertex3f(0, 0, - Torget);
  glVertex3f(0, 0, Torget);
  glEnd;
end;

function Vert(const x, y, z: GLFloat): TVer;
begin
  Result[0] := x;
  Result[1] := y;
  Result[2] := z;
end;

function glGenNormal(const fVert1, fVert2, fVert3: Tver): Tver;
var
  Qx, Qy, Qz, Px, Py, Pz: GLfloat;
begin
  Qx := fVert2[0] - fVert1[0];
  Qy := fVert2[1] - fVert1[1];
  Qz := fVert2[2] - fVert1[2];

  Px := fVert3[0] - fVert1[0];
  Py := fVert3[1] - fVert1[1];
  Pz := fVert3[2] - fVert1[2];

  Result[0] := Pz * Qy - Py * Qz;
  Result[1] := Px * Qz - Pz * Qx;
  Result[2] := Py * Qx - Px * Qy;
  // result:=Vert((Py*Qz - Pz*Qy),(Pz*Qx - Px*Qz),(Px*Qy - Py*Qx));
  //  glNormal3f((Py*Qz - Pz*Qy),(Pz*Qx - Px*Qz),(Px*Qy - Py*Qx));
end;

procedure glNormalize( var n:Tver );
  var len:single;
begin
len := sqrt(n[0]*n[0] + n[1]*n[1] + n[2]*n[2] ); // вычисл€ем длину нормали
n[0] := n[0] / len;
n[1] := n[1] / len;
n[2] := n[2] / len;
end;

// 20 Verticies
// 108 Normals
// 36 Triangles
const
Star_face_indicies: array [0..35,0..5] of byte = (
// Star
	(0,1,11 ,0,1,2 ), (0,11,10 ,3,4,5 ), (1,2,12 ,6,7,8 ), (1,12,11 ,9,10,11 ),
	(2,3,13 ,12,13,14 ), (2,13,12 ,15,16,17 ), (3,4,14 ,18,19,20 ),
	(3,14,13 ,21,22,23 ), (4,5,15 ,24,25,26 ), (4,15,14 ,27,28,29 ),
	(5,6,16 ,30,31,32 ), (5,16,15 ,33,34,35 ), (6,7,17 ,36,37,38 ),
	(6,17,16 ,39,40,41 ), (7,8,18 ,42,43,44 ), (7,18,17 ,45,46,47 ),
	(8,9,19 ,48,49,50 ), (8,19,18 ,51,52,53 ), (9,0,10 ,54,55,56 ),
	(9,10,19 ,57,58,59 ), (9,1,0 ,60,61,62 ), (5,7,6 ,63,64,65 ),
	(7,9,8 ,66,67,68 ), (3,5,4 ,69,70,71 ), (1,3,2 ,72,73,74 ), (3,7,5 ,75,76,77 ),
	(1,7,3 ,78,79,80 ), (1,9,7 ,81,82,83 ), (19,10,11 ,84,85,86 ),
	(15,16,17 ,87,88,89 ), (17,18,19 ,90,91,92 ), (13,14,15 ,93,94,95 ),
	(11,12,13 ,96,97,98 ), (13,15,17 ,99,100,101 ), (11,13,17 ,102,103,104 ),
	(11,17,19 ,105,106,107 )
);
Star_vertices: array [0..19,0..2] of GLFloat = (
(47.5528,165.451,-10.0),(17.6336,174.271,-10.0),(5.17631e-07,200.0,-10.0),
(-17.6336,174.271,-10.0),(-47.5528,165.451,-10.0),(-28.5317,140.729,-10.0),
(-29.3893,109.549,-10.0),(1.55778e-06,120.0,-10.0),(29.3893,109.549,-10.0),
(28.5317,140.729,-10.0),(47.5528,165.451,10.0),(17.6336,174.271,10.0),
(5.17631e-07,200.0,10.0),(-17.6336,174.271,10.0),(-47.5528,165.451,10.0),
(-28.5317,140.729,10.0),(-29.3893,109.549,10.0),(1.55778e-06,120.0,10.0),
(29.3893,109.549,10.0),(28.5317,140.729,10.0)
);
Star_normals: array  [0..107,0..2] of GLFloat = (
(0.282753,0.959193,0.0),(0.282753,0.959193,0.0),(0.282753,0.959193,0.0),
(0.282753,0.959193,0.0),(0.282753,0.959193,0.0),(0.282753,0.959193,0.0),
(0.824871,0.565321,0.0),(0.824871,0.565321,0.0),(0.824871,0.565321,0.0),
(0.824871,0.565321,0.0),(0.824871,0.565321,0.0),(0.824871,0.565321,0.0),
(-0.824871,0.565321,0.0),(-0.824871,0.565321,0.0),(-0.824871,0.565321,0.0),
(-0.824871,0.565321,0.0),(-0.824871,0.565321,0.0),(-0.824871,0.565321,0.0),
(-0.282753,0.959193,0.0),(-0.282753,0.959193,0.0),(-0.282753,0.959193,0.0),
(-0.282753,0.959193,0.0),(-0.282753,0.959193,0.0),(-0.282753,0.959193,0.0),
(-0.792551,-0.609805,0.0),(-0.792551,-0.609805,0.0),(-0.792551,-0.609805,0.0),
(-0.792551,-0.609805,0.0),(-0.792551,-0.609805,0.0),(-0.792551,-0.609805,0.0),
(-0.999622,0.027493,0.0),(-0.999622,0.027493,0.0),(-0.999622,0.027493,0.0),
(-0.999622,0.027493,0.0),(-0.999622,0.027493,0.0),(-0.999622,0.027493,0.0),
(0.335048,-0.942201,0.0),(0.335048,-0.942201,0.0),(0.335048,-0.942201,0.0),
(0.335048,-0.942201,0.0),(0.335048,-0.942201,0.0),(0.335048,-0.942201,0.0),
(-0.335047,-0.942201,0.0),(-0.335047,-0.942201,0.0),(-0.335047,-0.942201,0.0),
(-0.335047,-0.942201,0.0),(-0.335047,-0.942201,0.0),(-0.335047,-0.942201,0.0),
(0.999622,0.0274932,0.0),(0.999622,0.0274932,0.0),(0.999622,0.0274932,0.0),
(0.999622,0.0274932,0.0),(0.999622,0.0274932,0.0),(0.999622,0.0274932,0.0),
(0.792551,-0.609805,0.0),(0.792551,-0.609805,0.0),(0.792551,-0.609805,0.0),
(0.792551,-0.609805,0.0),(0.792551,-0.609805,0.0),(0.792551,-0.609805,0.0),
(0.0,0.0,-1.0),(0.0,0.0,-1.0),(0.0,0.0,-1.0),
(0.0,0.0,-1.0),(0.0,0.0,-1.0),(0.0,0.0,-1.0),
(0.0,0.0,-1.0),(0.0,0.0,-1.0),(0.0,0.0,-1.0),
(0.0,0.0,-1.0),(0.0,0.0,-1.0),(0.0,0.0,-1.0),
(0.0,0.0,-1.0),(0.0,0.0,-1.0),(0.0,0.0,-1.0),
(0.0,0.0,-1.0),(0.0,0.0,-1.0),(0.0,0.0,-1.0),
(0.0,0.0,-1.0),(0.0,0.0,-1.0),(0.0,0.0,-1.0),
(0.0,0.0,-1.0),(0.0,0.0,-1.0),(0.0,0.0,-1.0),
(0.0,0.0,1.0),(0.0,0.0,1.0),(0.0,0.0,1.0),
(0.0,0.0,1.0),(0.0,0.0,1.0),(0.0,0.0,1.0),
(0.0,0.0,1.0),(0.0,0.0,1.0),(0.0,0.0,1.0),
(0.0,0.0,1.0),(0.0,0.0,1.0),(0.0,0.0,1.0),
(0.0,0.0,1.0),(0.0,0.0,1.0),(0.0,0.0,1.0),
(0.0,0.0,1.0),(0.0,0.0,1.0),(0.0,0.0,1.0),
(0.0,0.0,1.0),(0.0,0.0,1.0),(0.0,0.0,1.0),
(0.0,0.0,1.0),(0.0,0.0,1.0),(0.0,0.0,1.0)
);

procedure oglStar;
var i,j:integer;
vi,ni:integer;
begin
 glBegin (GL_TRIANGLES);
      for i:=0 to 35 do
       begin
       for j:=0 to 2 do
        begin
          vi := Star_face_indicies[i][j];
          ni := Star_face_indicies[i][j+3];//Normal index
           glNormal3f (Star_normals[ni][0],Star_normals[ni][1],Star_normals[ni][2]);
           glVertex3f (Star_vertices[vi][0],Star_vertices[vi][1],Star_vertices[vi][2]);
        end;
      end;
 glEnd();
end;

// 32 Verticies
// 96 Normals
// 32 Triangles
const
lump_face_indicies: array [0..31,0..5] of byte = (
// LightLump
	(0,6,7 ,0,1,2 ), (6,1,14 ,3,4,5 ), (6,14,7 ,6,7,8 ), (7,14,2 ,9,10,11 ),
	(18,7,8 ,12,13,14 ), (7,2,15 ,15,16,17 ), (7,15,8 ,18,19,20 ),
	(8,15,3 ,21,22,23 ), (19,20,9 ,24,25,26 ), (21,22,16 ,27,28,29 ),
	(23,16,9 ,30,31,32 ), (9,16,4 ,33,34,35 ), (24,9,6 ,36,37,38 ),
	(9,4,17 ,39,40,41 ), (9,17,6 ,42,43,44 ), (6,17,1 ,45,46,47 ),
	(5,11,10 ,48,49,50 ), (11,2,14 ,51,52,53 ), (11,14,10 ,54,55,56 ),
	(10,14,1 ,57,58,59 ), (25,12,11 ,60,61,62 ), (12,3,15 ,63,64,65 ),
	(12,15,11 ,66,67,68 ), (11,15,2 ,69,70,71 ), (26,13,27 ,72,73,74 ),
	(13,4,16 ,75,76,77 ), (13,16,28 ,78,79,80 ), (29,16,30 ,81,82,83 ),
	(31,10,13 ,84,85,86 ), (10,1,17 ,87,88,89 ), (10,17,13 ,90,91,92 ),
	(13,17,4 ,93,94,95 )
);
lump_vertices: array [0..31,0..2] of GLFloat = (
(0.0,30.0,-1.74846e-06),(40.0,70.0,1.89703e-22),(0.0,70.0,40.0),
(-40.0,70.0,1.89703e-22),(0.0,70.0,-40.0),(0.0,110.0,1.74846e-06),
(28.2843,41.7157,-1.23634e-06),(0.0,41.7157,28.2843),(-28.2843,41.7157,-1.23634e-06),
(0.0,41.7157,-28.2843),(28.2843,98.2843,1.23634e-06),(0.0,98.2843,28.2843),
(-28.2843,98.2843,1.23634e-06),(0.0,98.2843,-28.2843),(28.2843,70.0,28.2843),
(-28.2843,70.0,28.2843),(-28.2843,70.0,-28.2843),(28.2843,70.0,-28.2843),
(0.0,30.0,-1.74846e-06),(0.0,30.0,-1.74846e-06),(-28.2843,41.7157,-1.23634e-06),
(-28.2843,41.7157,-1.23634e-06),(-40.0,70.0,1.89703e-22),(-28.2843,41.7157,-1.23634e-06),
(0.0,30.0,-1.74846e-06),(0.0,110.0,1.74846e-06),(0.0,110.0,1.74846e-06),
(-28.2843,98.2843,1.23634e-06),(-28.2843,98.2843,1.23634e-06),(-28.2843,98.2843,1.23634e-06),
(-40.0,70.0,1.89703e-22),(0.0,110.0,1.74846e-06)
);

lump_normals: array  [0..95,0..2] of GLFloat = (
(0.357407,-0.862856,0.357407),(0.630353,-0.630353,0.453112),(0.453112,-0.630353,0.630353),
(0.630353,-0.630353,0.453112),(0.862856,-0.357407,0.357407),(0.630353,-0.453112,0.630353),
(0.630353,-0.630353,0.453112),(0.630353,-0.453112,0.630353),(0.453112,-0.630353,0.630353),
(0.453112,-0.630353,0.630353),(0.630353,-0.453112,0.630353),(0.357407,-0.357407,0.862856),
(-0.357407,-0.862856,0.357407),(-0.453112,-0.630353,0.630353),(-0.630353,-0.630353,0.453112),
(-0.453112,-0.630353,0.630353),(-0.357407,-0.357407,0.862856),(-0.630353,-0.453112,0.630353),
(-0.453112,-0.630353,0.630353),(-0.630353,-0.453112,0.630353),(-0.630353,-0.630353,0.453112),
(-0.630353,-0.630353,0.453112),(-0.630353,-0.453112,0.630353),(-0.862856,-0.357407,0.357407),
(-0.357407,-0.862856,-0.357407),(-0.357407,-0.862856,-0.357407),(-0.453112,-0.630353,-0.630353),
(-0.862856,-0.357407,-0.357407),(-0.862856,-0.357407,-0.357407),(-0.630353,-0.453112,-0.630353),
(-0.57735,-0.57735,-0.57735),(-0.630353,-0.453112,-0.630353),(-0.453112,-0.630353,-0.630353),
(-0.453112,-0.630353,-0.630353),(-0.630353,-0.453112,-0.630353),(-0.357407,-0.357407,-0.862856),
(0.357407,-0.862856,-0.357407),(0.453112,-0.630353,-0.630353),(0.630353,-0.630353,-0.453112),
(0.453112,-0.630353,-0.630353),(0.357407,-0.357407,-0.862856),(0.630353,-0.453112,-0.630353),
(0.453112,-0.630353,-0.630353),(0.630353,-0.453112,-0.630353),(0.630353,-0.630353,-0.453112),
(0.630353,-0.630353,-0.453112),(0.630353,-0.453112,-0.630353),(0.862856,-0.357407,-0.357407),
(0.357407,0.862856,0.357407),(0.453112,0.630353,0.630353),(0.630353,0.630353,0.453112),
(0.453112,0.630353,0.630353),(0.357407,0.357407,0.862856),(0.630353,0.453112,0.630353),
(0.453112,0.630353,0.630353),(0.630353,0.453112,0.630353),(0.630353,0.630353,0.453112),
(0.630353,0.630353,0.453112),(0.630353,0.453112,0.630353),(0.862856,0.357407,0.357407),
(-0.357407,0.862856,0.357407),(-0.630353,0.630353,0.453112),(-0.453112,0.630353,0.630353),
(-0.630353,0.630353,0.453112),(-0.862856,0.357407,0.357407),(-0.630353,0.453112,0.630353),
(-0.630353,0.630353,0.453112),(-0.630353,0.453112,0.630353),(-0.453112,0.630353,0.630353),
(-0.453112,0.630353,0.630353),(-0.630353,0.453112,0.630353),(-0.357407,0.357407,0.862856),
(-0.357407,0.862856,-0.357407),(-0.453112,0.630353,-0.630353),(-0.357407,0.862856,-0.357407),
(-0.453112,0.630353,-0.630353),(-0.357407,0.357407,-0.862856),(-0.630353,0.453112,-0.630353),
(-0.453112,0.630353,-0.630353),(-0.630353,0.453112,-0.630353),(-0.57735,0.57735,-0.57735),
(-0.862856,0.357407,-0.357407),(-0.630353,0.453112,-0.630353),(-0.862856,0.357407,-0.357407),
(0.357407,0.862856,-0.357407),(0.630353,0.630353,-0.453112),(0.453112,0.630353,-0.630353),
(0.630353,0.630353,-0.453112),(0.862856,0.357407,-0.357407),(0.630353,0.453112,-0.630353),
(0.630353,0.630353,-0.453112),(0.630353,0.453112,-0.630353),(0.453112,0.630353,-0.630353),
(0.453112,0.630353,-0.630353),(0.630353,0.453112,-0.630353),(0.357407,0.357407,-0.862856)
);

procedure oglLumpLight;
var i,j:integer;
vi,ni:integer;
begin
 glBegin (GL_TRIANGLES);
      for i:=0 to 31 do
       begin
       for j:=0 to 2 do
        begin
          vi := lump_face_indicies[i][j];
          ni := lump_face_indicies[i][j+3];//Normal index
           glNormal3f (lump_normals[ni][0],lump_normals[ni][1],lump_normals[ni][2]);
           glVertex3f (lump_vertices[vi][0],lump_vertices[vi][1],lump_vertices[vi][2]);
        end;
      end;
 glEnd();
end;


// 23 Verticies
// 96 Normals
// 32 Triangles

const
cyl_face_indicies: array [0..31,0..5] of byte = (
// Cylinder
	(0,2,1 ,0,1,2 ), (0,3,18 ,3,4,5 ), (0,4,3 ,6,7,8 ), (0,5,4 ,9,10,11 ),
	(0,6,5 ,12,13,14 ), (0,7,6 ,15,16,17 ), (0,8,7 ,18,19,20 ), (0,1,8 ,21,22,23 ),
	(1,10,9 ,24,25,26 ), (1,2,10 ,27,28,29 ), (19,11,20 ,30,31,32 ),
	(21,3,11 ,33,34,35 ), (3,12,11 ,36,37,38 ), (3,4,12 ,39,40,41 ),
	(4,13,12 ,42,43,44 ), (4,5,13 ,45,46,47 ), (5,14,13 ,48,49,50 ),
	(5,6,14 ,51,52,53 ), (6,15,14 ,54,55,56 ), (6,7,15 ,57,58,59 ),
	(7,16,15 ,60,61,62 ), (7,8,16 ,63,64,65 ), (8,9,16 ,66,67,68 ),
	(8,1,9 ,69,70,71 ), (17,9,10 ,72,73,74 ), (17,22,11 ,75,76,77 ),
	(17,11,12 ,78,79,80 ), (17,12,13 ,81,82,83 ), (17,13,14 ,84,85,86 ),
	(17,14,15 ,87,88,89 ), (17,15,16 ,90,91,92 ), (17,16,9 ,93,94,95 )
);
cyl_vertices: array [0..22,0..2] of GLFloat = (
(0.0,40.0,-2.47075e-23),(30.0,40.0,-2.47075e-23),(21.2132,40.0,21.2132),
(-1.31134e-06,40.0,30.0),(-21.2132,40.0,21.2132),(-30.0,40.0,-2.62268e-06),
(-21.2132,40.0,-21.2132),(3.93403e-06,40.0,-30.0),(21.2132,40.0,-21.2132),
(30.0,-100.0,-6.11959e-06),(21.2132,-100.0,21.2132),(-1.31134e-06,-100.0,30.0),
(-21.2132,-100.0,21.2132),(-30.0,-100.0,-8.74228e-06),(-21.2132,-100.0,-21.2132),
(3.93403e-06,-100.0,-30.0),(21.2132,-100.0,-21.2132),(0.0,-100.0,-6.11959e-06),
(21.2132,40.0,21.2132),(21.2132,40.0,21.2132),(21.2132,-100.0,21.2132),
(21.2132,40.0,21.2132),(21.2132,-100.0,21.2132)
);
cyl_normals: array  [0..95,0..2] of GLFloat = (
(0.0,1.0,0.0),(0.0,1.0,0.0),(0.0,1.0,0.0),
(0.0,1.0,0.0),(0.0,1.0,0.0),(0.0,1.0,0.0),
(0.0,1.0,0.0),(0.0,1.0,0.0),(0.0,1.0,0.0),
(0.0,1.0,0.0),(0.0,1.0,0.0),(0.0,1.0,0.0),
(0.0,1.0,0.0),(0.0,1.0,0.0),(0.0,1.0,0.0),
(0.0,1.0,0.0),(0.0,1.0,0.0),(0.0,1.0,0.0),
(0.0,1.0,0.0),(0.0,1.0,0.0),(0.0,1.0,0.0),
(0.0,1.0,0.0),(0.0,1.0,0.0),(0.0,1.0,0.0),
(0.92388,-1.61843e-08,0.382683),(0.92388,-1.61843e-08,0.382683),(0.92388,-1.67276e-08,0.382683),
(0.92388,-1.61843e-08,0.382683),(0.92388,-1.56409e-08,0.382683),(0.92388,-1.61843e-08,0.382683),
(0.382683,-3.77606e-08,0.92388),(0.382683,-3.77606e-08,0.92388),(0.382683,-3.77606e-08,0.92388),
(0.382683,-3.77606e-08,0.92388),(0.382683,-3.77606e-08,0.92388),(0.382683,-3.77606e-08,0.92388),
(-0.382683,-3.77606e-08,0.92388),(-0.382683,-3.77606e-08,0.92388),(-0.382683,-3.77606e-08,0.92388),
(-0.382683,-3.77606e-08,0.92388),(-0.382683,-3.77606e-08,0.92388),(-0.382683,-3.77606e-08,0.92388),
(-0.92388,-1.61843e-08,0.382683),(-0.92388,-1.61843e-08,0.382683),(-0.92388,-1.56409e-08,0.382683),
(-0.92388,-1.61843e-08,0.382683),(-0.92388,-1.67276e-08,0.382683),(-0.92388,-1.61843e-08,0.382683),
(-0.92388,1.61843e-08,-0.382684),(-0.92388,1.61843e-08,-0.382684),(-0.92388,1.67276e-08,-0.382684),
(-0.92388,1.61843e-08,-0.382684),(-0.92388,1.56409e-08,-0.382684),(-0.92388,1.61843e-08,-0.382684),
(-0.382683,3.77606e-08,-0.92388),(-0.382683,3.77606e-08,-0.92388),(-0.382683,3.77606e-08,-0.92388),
(-0.382683,3.77606e-08,-0.92388),(-0.382683,3.77606e-08,-0.92388),(-0.382683,3.77606e-08,-0.92388),
(0.382684,3.77606e-08,-0.923879),(0.382684,3.77606e-08,-0.923879),(0.382684,3.77606e-08,-0.923879),
(0.382684,3.77606e-08,-0.923879),(0.382684,3.77606e-08,-0.923879),(0.382684,3.77606e-08,-0.923879),
(0.92388,1.61843e-08,-0.382683),(0.92388,1.61843e-08,-0.382683),(0.92388,1.56409e-08,-0.382683),
(0.92388,1.61843e-08,-0.382683),(0.92388,1.67276e-08,-0.382683),(0.92388,1.61843e-08,-0.382683),
(0.0,-1.0,0.0),(0.0,-1.0,0.0),(0.0,-1.0,0.0),
(0.0,-1.0,0.0),(0.0,-1.0,0.0),(0.0,-1.0,0.0),
(0.0,-1.0,0.0),(0.0,-1.0,0.0),(0.0,-1.0,0.0),
(0.0,-1.0,0.0),(0.0,-1.0,0.0),(0.0,-1.0,0.0),
(0.0,-1.0,0.0),(0.0,-1.0,0.0),(0.0,-1.0,0.0),
(0.0,-1.0,0.0),(0.0,-1.0,0.0),(0.0,-1.0,0.0),
(0.0,-1.0,0.0),(0.0,-1.0,0.0),(0.0,-1.0,0.0),
(0.0,-1.0,0.0),(0.0,-1.0,0.0),(0.0,-1.0,0.0)
);

procedure oglLumpCyl;
var i,j:integer;
vi,ni:integer;
begin
 glBegin (GL_TRIANGLES);
      for i:=0 to 31 do
       begin
       for j:=0 to 2 do
        begin
          vi := cyl_face_indicies[i][j];
          ni := cyl_face_indicies[i][j+3];//Normal index
           glNormal3f (cyl_normals[ni][0],cyl_normals[ni][1],cyl_normals[ni][2]);
           glVertex3f (cyl_vertices[vi][0],cyl_vertices[vi][1],cyl_vertices[vi][2]);
        end;
      end;
 glEnd();
end;

procedure oglBox(HSize: Double; Mode: Cardinal);
var
  VertArr: array [1..8] of TVer;
  Norm: TVer;
  procedure Flat(i, j, k, w: Integer);
  begin
    glBegin(Mode);
    Norm := glGenNormal(VertArr[i], VertArr[j], VertArr[k]);
    glNormalize(Norm);
    glNormal3fv(@Norm);
    glVertex3fv(@VertArr[i]);
    glVertex3fv(@VertArr[j]);
    glVertex3fv(@VertArr[k]);
    glVertex3fv(@VertArr[w]);
    glEnd;
  end;
begin
  VertArr[1] := Vert(-HSize, - HSize, - HSize);
  VertArr[2] := Vert(-HSize, - HSize, HSize);
  VertArr[3] := Vert(-HSize, HSize, HSize);
  VertArr[4] := Vert(-HSize, HSize, - HSize);
  VertArr[6] := Vert(HSize, HSize, HSize);
  VertArr[7] := Vert(HSize, HSize, - HSize);
  VertArr[8] := Vert(HSize, - HSize, HSize);
  VertArr[5] := Vert(HSize, - HSize, - HSize);

  Flat(1, 2, 3, 4);
  Flat(4, 3, 6, 7);
  Flat(5, 8, 2, 1);
  Flat(8, 6, 3, 2);
  Flat(7, 5, 1, 4);
  Flat(7, 6, 8, 5);
end;

procedure oglPyramid(HSize: Double; Mode: Cardinal);
var
  VertArr: array [1..8] of TVer;
  Norm: TVer;
  procedure Flat(i, j, k, w: Integer);
  begin
    glBegin(Mode);
    Norm := glGenNormal(VertArr[i], VertArr[j], VertArr[k]);
    glNormalize(Norm);
    glNormal3fv(@Norm);
    glVertex3fv(@VertArr[i]);
    glVertex3fv(@VertArr[j]);
    glVertex3fv(@VertArr[k]);
    glVertex3fv(@VertArr[w]);
    glEnd;
  end;
  procedure Flat3(i, j, k: Integer);
  begin
    glBegin(GL_TRIANGLES);
    Norm := glGenNormal(VertArr[i], VertArr[j], VertArr[k]);
    glNormalize(Norm);
    glNormal3fv(@Norm);
    glVertex3fv(@VertArr[i]);
    glVertex3fv(@VertArr[j]);
    glVertex3fv(@VertArr[k]);
    glEnd;
  end;
begin
  VertArr[1] := Vert(-HSize, - HSize, - HSize);
  VertArr[2] := Vert(-HSize, - HSize, HSize);
  VertArr[3] := Vert(0, HSize, 0);
  VertArr[4] := Vert(0, HSize, 0);
  VertArr[6] := Vert(0, HSize, 0);
  VertArr[7] := Vert(0, HSize, 0);
  VertArr[8] := Vert(HSize, - HSize, HSize);
  VertArr[5] := Vert(HSize, - HSize, - HSize);

  Flat3(1, 2, 3);
  Flat3(7, 5, 1);
  Flat3(6, 8, 5);
  Flat3(8, 3, 2);
  Flat(5, 8, 2, 1);
end;

procedure Rotate(x, y, z: Single);
begin
  glRotatef(Z, 0, 0, 1);//Z
  glRotatef(Y, 0, 1, 0);//y
  glRotatef(X, 1, 0, 0);//X
end;

end.
