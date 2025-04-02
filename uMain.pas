unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, uTuilleInterf,
  cxGraphics, dxUIAClasses, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxSpinEdit , uTuilleDevExpress;

type
  TForm1 = class(TForm)
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ComboBox1: TComboBox;
    BitBtn3: TBitBtn;
    cxSpinEdit1: TcxSpinEdit;
    Label1: TLabel;
    cxSpinEdit2: TcxSpinEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Déclarations privées }
     FAbstractTuilePanel  : TAbstractTuile ;
     procedure pdxTileControl1ItemClick(Sender: TComponent);
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BitBtn1Click(Sender: TObject);
begin

  if Assigned(FAbstractTuilePanel) then
    exit;

  var i : Integer ;
  ComboBox1.Clear;
  for i := 1 to 10 do
    ComboBox1.Items.AddObject('prio '+i.tostring, TObject(i));
  try
    FAbstractTuilePanel  := TAbstractTuile.Create(TdxTuilePanelFactory.Create) ;

    FAbstractTuilePanel.Make(self, Panel2, ComboBox1.Items, pdxTileControl1ItemClick);

  finally
//    FreeAndNil(FTuilePanel);
  end;

end;

procedure TForm1.pdxTileControl1ItemClick(Sender: TComponent);
begin
  ShowMessage('Click on Item Prio sequence = '+ Sender.Tag.ToString) ;
  // do something
end;



procedure TForm1.BitBtn2Click(Sender: TObject);
begin
   if Assigned( FAbstractTuilePanel)  then
    FreeAndNil(FAbstractTuilePanel);
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
  if Not Assigned( FAbstractTuilePanel)  then
    exit;

  var TuileItem : ITuileItem :=  FAbstractTuilePanel.TuilePanel.fGetTuileItemByID(cxSpinEdit1.Value) ;
  if TuileItem<>nil then
  begin
    TuileItem.Text2  := cxSpinEdit2.Value ;
  end;

end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned( FAbstractTuilePanel)  then
    FreeAndNil(FAbstractTuilePanel);

end;

end.
