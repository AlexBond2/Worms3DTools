program XomView_v3_1;

uses
  Forms,
  xomview_3_1 in 'xomview_3_1.pas' {FormXom},
  ImportComp in 'ImportComp.pas' {CompareTree},
  AnimF in 'AnimF.pas' {AnimForm},
  AnimEditForm in 'AnimEditForm.pas' {FormAsk},
  ValueForm in 'ValueForm.pas' {ChgValForm},
  fsblib in 'fsblib.pas',
  soblib in 'soblib.pas',
  CrystalDXT in 'CrystalDXT.pas',
  XomMeshLib in 'XomMeshLib.pas',
  XomCntrLib in 'XomCntrLib.pas',
  XNameForm in 'XNameForm.pas' {FormName};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormXom, FormXom);
  Application.CreateForm(TCompareTree, CompareTree);
  Application.CreateForm(TAnimForm, AnimForm);
  Application.CreateForm(TFormAsk, FormAsk);
  Application.CreateForm(TChgValForm, ChgValForm);
  Application.CreateForm(TFormName, FormName);
  Application.Run;
end.
