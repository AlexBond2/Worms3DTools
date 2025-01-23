program XomView_v2_9;

uses
  Forms,
  xomview_2_9 in 'xomview_2_9.pas' {FormXom},
  ImportComp in 'ImportComp.pas' {CompareTree},
  AnimF in 'AnimF.pas' {AnimForm},
  AnimEditForm in 'AnimEditForm.pas' {FormAsk},
  ValueForm in 'ValueForm.pas' {ChgValForm},
  fsblib in 'fsblib.pas',
  soblib in 'soblib.pas',
  CrystalDXT in 'CrystalDXT.pas';
{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormXom, FormXom);
  Application.CreateForm(TCompareTree, CompareTree);
  Application.CreateForm(TAnimForm, AnimForm);
  Application.CreateForm(TFormAsk, FormAsk);
  Application.CreateForm(TChgValForm, ChgValForm);
  Application.Run;
end.
