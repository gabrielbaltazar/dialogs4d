unit FSampleDialog4D;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.StdCtrls, FMX.Controls.Presentation,
  Dialogs4D.Interfaces,
  Dialogs4D.FancyDialog;
type
  TfrmSampleDialog4D = class(TForm)
    btnSuccess: TButton;
    Label1: TLabel;
    edtTitle: TEdit;
    Edit1: TEdit;
    Label2: TLabel;
    btnError: TButton;
    btnQuestion: TButton;
    procedure btnSuccessClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnErrorClick(Sender: TObject);
    procedure btnQuestionClick(Sender: TObject);
  private
    FDialog: IDialog4D;

    procedure OnClickYes(ASender: TObject);
    procedure OnClickNo(ASender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSampleDialog4D: TfrmSampleDialog4D;

implementation

{$R *.fmx}

procedure TfrmSampleDialog4D.btnErrorClick(Sender: TObject);
begin
  FDialog
    .&Type(dtError)
    .Title('Teste')
    .Message('Olá')
    .TextPrimaryButton('OK')
    .Show;
end;

procedure TfrmSampleDialog4D.btnQuestionClick(Sender: TObject);
begin
  FDialog
    .&Type(dtQuestion)
    .Title('Confirm')
    .Message('Confirm the operation?')
    .TextPrimaryButton('Yes')
    .TextSecondButton('No')
    .OnClickPrimaryButton(Self.OnClickYes)
    .OnClickSecondButton(Self.OnClickNo)
    .Show;
end;

procedure TfrmSampleDialog4D.btnSuccessClick(Sender: TObject);
begin
  FDialog
    .&Type(dtSuccess)
    .Title('Teste')
    .Message('Olá')
    .ColorPrimaryButton($FFF85F6A)
    .ColorSecondButton($FFF85F6A)
    .TextPrimaryButton('OK')
    .TextSecondButton('Canecl')
    .Show;
end;

procedure TfrmSampleDialog4D.FormCreate(Sender: TObject);
begin
  FDialog := TDialogs4DFancyDialog.New;
  FDialog.Component(Self);
end;

procedure TfrmSampleDialog4D.OnClickNo(ASender: TObject);
begin
  ShowMessage('No');
end;

procedure TfrmSampleDialog4D.OnClickYes(ASender: TObject);
begin
  ShowMessage('Yes');
end;

initialization
  ReportMemoryLeaksOnShutdown := True;

end.
