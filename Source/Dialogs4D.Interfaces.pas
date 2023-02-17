unit Dialogs4D.Interfaces;

interface

uses
  FMX.Types,
  FMX.Forms,
  System.UITypes;

type
  TCallbackDialog = procedure(ASender: TObject) of object;

  TDialogType = (dtSuccess, dtWarning, dtError,
    dtInfo, dtQuestion);

  IDialog4D = interface
    ['{9E4DC1B0-9068-4366-A0A4-A21773ABAEA2}']
    function Component(AValue: TFmxObject): IDialog4D;
    function &Type(AValue: TDialogType): IDialog4D;
    function Title(AValue: string): IDialog4D;
    function Message(AValue: string): IDialog4D;
    function BackgroundOpacity(AValue: Single): IDialog4D;
    function TextPrimaryButton(AValue: string): IDialog4D;
    function ColorPrimaryButton(AValue: TAlphaColor): IDialog4D;
    function OnClickPrimaryButton(AValue: TCallbackDialog): IDialog4D;
    function TextSecondButton(AValue: string): IDialog4D;
    function ColorSecondButton(AValue: TAlphaColor): IDialog4D;
    function OnClickSecondButton(AValue: TCallbackDialog): IDialog4D;
    function SuccessColor(AValue: TAlphaColor): IDialog4D;
    function WarningColor(AValue: TAlphaColor): IDialog4D;
    function ErrorColor(AValue: TAlphaColor): IDialog4D;
    function InfoColor(AValue: TAlphaColor): IDialog4D;
    function QuestionColor(AValue: TAlphaColor): IDialog4D;
    function Show: IDialog4D;
  end;

  IDialogLoading = interface
    ['{958A715C-D1A1-4E63-A344-8386F225A70B}']
    function Form(AValue: TForm): IDialogLoading;
    function FontName(AValue: TFontName): IDialogLoading;
    function Message(AValue: string): IDialogLoading;
    function DetailMessage(AValue: string): IDialogLoading;
    function Color(AValue: TAlphaColor): IDialogLoading;
    function Heigth(AValue: Single): IDialogLoading;
    function Width(AValue: Single): IDialogLoading;
    function Show: IDialogLoading;
    function Hide: IDialogLoading;
  end;

function NewDialog: IDialog4D;
function NewDialogLoading: IDialogLoading;

implementation

uses
  Dialogs4D.FancyDialog,
  Dialogs4D.Loading;

function NewDialog: IDialog4D;
begin
  Result := TDialogs4DFancyDialog.New;
end;

function NewDialogLoading: IDialogLoading;
begin
  Result := TDialogs4DLoading.New;
end;

end.
