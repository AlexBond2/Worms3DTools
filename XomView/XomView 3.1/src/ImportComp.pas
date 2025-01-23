unit ImportComp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls;

type
  TCompareTree = class(TForm)
    Panel1: TPanel;
    InTree: TTreeView;
    OutTree: TTreeView;
    Splitter1: TSplitter;
    Button1: TButton;
    Button2: TButton;
    Panel2: TPanel;
    Panel3: TPanel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CompareTree: TCompareTree;

implementation

{$R *.dfm}
Function Compare(InNode,OutNode:TTreeNode):Boolean;
var i:integer;
begin
 Result:=false;
 if(InNode.Text<>OutNode.Text) or
 (InNode.count<>OutNode.count) then begin InNode.Selected:=true; exit; end;
 for i:=0 to InNode.count-1 do
   if(not compare(InNode[i],OutNode[i])) then exit;
 Result:=True;
end;

procedure TCompareTree.FormShow(Sender: TObject);
begin
Button1.Enabled:=Compare(InTree.Items.GetFirstNode,OutTree.Items.GetFirstNode);
end;

end.
