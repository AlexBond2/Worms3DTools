unit AnimEditForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormAsk = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Edit1: TEdit;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAsk: TFormAsk;

implementation

{$R *.dfm}

procedure TFormAsk.Button2Click(Sender: TObject);
begin
Button1.Visible:=False;
Button2.Visible:=False;
Edit1.Text:='NewClone';
Edit1.Visible:=True;
Button3.Caption:='Clone';
Button3.ModalResult:=2;
end;

procedure TFormAsk.Button3Click(Sender: TObject);
begin
if Button1.Visible then begin
Button1.Visible:=False;
Button2.Visible:=False;
Edit1.Text:='NewAnim';
Edit1.Visible:=True;
Button3.Caption:='New';
Button3.ModalResult:=3;
end;
end;

procedure TFormAsk.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Button1.Visible:=True;
Button2.Visible:=True;
Edit1.Visible:=False;
Button3.Caption:='New clip';
Button3.ModalResult:=mrNone;
end;

end.
