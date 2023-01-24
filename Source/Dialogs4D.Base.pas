unit Dialogs4D.Base;

interface

uses
  FMX.Types,
  System.SysUtils,
  System.UITypes,
  Dialogs4D.Interfaces;

type
  TDialogs4DBase = class(TInterfacedObject, IDialog4D)
  protected
    FComponent: TFmxObject;
    FType: TDialogType;
    FTitle: string;
    FMessage: string;
    FBackgroundOpacity: Single;
    FTextPrimaryButton: string;
    FColorPrimaryButton: TAlphaColor;
    FOnClickPrimaryButton: TCallbackDialog;
    FTextSecondButton: string;
    FColorSecondButton: TAlphaColor;
    FOnClickSecondButton: TCallbackDialog;
    FSuccessColor: TAlphaColor;
    FWarningColor: TAlphaColor;
    FErrorColor: TAlphaColor;
    FInfoColor: TAlphaColor;
    FQuestionColor: TAlphaColor;

    procedure ResetValues;

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
    function Show: IDialog4D; virtual; abstract;
  public
    constructor Create; virtual;
  end;

implementation

{ TDialogs4DBase }

function TDialogs4DBase.BackgroundOpacity(AValue: Single): IDialog4D;
begin
  Result := Self;
  FBackgroundOpacity := AValue;
end;

function TDialogs4DBase.ColorPrimaryButton(AValue: TAlphaColor): IDialog4D;
begin
  Result := Self;
  FColorPrimaryButton := AValue;
end;

function TDialogs4DBase.ColorSecondButton(AValue: TAlphaColor): IDialog4D;
begin
  Result := Self;
  FColorSecondButton := AValue;
end;

function TDialogs4DBase.Component(AValue: TFmxObject): IDialog4D;
begin
  Result := Self;
  FComponent := AValue;
end;

constructor TDialogs4DBase.Create;
begin
  FType := dtInfo;
  FOnClickPrimaryButton := nil;
  FOnClickSecondButton := nil;
  ResetValues;
end;

function TDialogs4DBase.ErrorColor(AValue: TAlphaColor): IDialog4D;
begin
  Result := Self;
  FErrorColor := AValue;
end;

function TDialogs4DBase.InfoColor(AValue: TAlphaColor): IDialog4D;
begin
  Result := Self;
  FInfoColor := Avalue;
end;

function TDialogs4DBase.Message(AValue: string): IDialog4D;
begin
  Result := Self;
  FMessage := AValue;
end;

function TDialogs4DBase.OnClickPrimaryButton(AValue: TCallbackDialog): IDialog4D;
begin
  Result := Self;
  FOnClickPrimaryButton := AValue;
end;

function TDialogs4DBase.OnClickSecondButton(AValue: TCallbackDialog): IDialog4D;
begin
  Result := Self;
  FOnClickSecondButton := AValue;
end;

function TDialogs4DBase.QuestionColor(AValue: TAlphaColor): IDialog4D;
begin
  Result := Self;
  FQuestionColor := AValue;
end;

procedure TDialogs4DBase.ResetValues;
begin
  FBackgroundOpacity := 0.7;
  FColorPrimaryButton := $FF0696B9;
  FColorSecondButton := $FFD45A4F;
  FSuccessColor := $FF35BD27; // Green
  FErrorColor := $FFE64D4D; // Red
  FQuestionColor := $FFAAAAAA; // Gray
  FInfoColor := $FF3085D6; // Blue
  FWarningColor := $FFF3A867; // Orange
  FTitle := EmptyStr;
  FMessage := EmptyStr;
  FTextPrimaryButton := EmptyStr;
  FTextSecondButton := EmptyStr;
end;

function TDialogs4DBase.SuccessColor(AValue: TAlphaColor): IDialog4D;
begin
  Result := Self;
  FSuccessColor := AValue;
end;

function TDialogs4DBase.TextPrimaryButton(AValue: string): IDialog4D;
begin
  Result := Self;
  FTextPrimaryButton := AValue;
end;

function TDialogs4DBase.TextSecondButton(AValue: string): IDialog4D;
begin
  Result := Self;
  FTextSecondButton := AValue;
end;

function TDialogs4DBase.Title(AValue: string): IDialog4D;
begin
  Result := Self;
  FTitle := AValue;
end;

function TDialogs4DBase.&Type(AValue: TDialogType): IDialog4D;
begin
  Result := Self;
  FType := AValue;
end;

function TDialogs4DBase.WarningColor(AValue: TAlphaColor): IDialog4D;
begin
  Result := Self;
  FWarningColor := AValue;
end;

end.
