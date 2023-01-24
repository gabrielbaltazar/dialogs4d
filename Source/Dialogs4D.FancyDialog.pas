unit Dialogs4D.FancyDialog;

interface

// Base on 99 Coders Fancy Dialog

uses
  FMX.Objects,
  FMX.Layouts,
  FMX.Types,
  FMX.Graphics,
  FMX.StdCtrls,
  FMX.Ani,
  FMX.VirtualKeyboard,
  FMX.Platform,
  Dialogs4D.Interfaces,
  Dialogs4D.Base,
  System.SysUtils,
  System.UITypes,
  System.Classes;

type
  TDialogs4DFancyDialog = class(TDialogs4DBase, IDialog4D)
  private
    FRectBackground: TRectangle;
    FLayoutBackground: TLayout;
    FRectMessage: TRectangle;
    FArc: TArc;
    FRectIcon1: TRectangle;
    FRectIcon2: TRectangle;
    FLabelIcon: TLabel;
    FArcAnimated: TFloatAnimation;
    FBackgroundAnimation: TFloatAnimation;
    FLabelTitle: TLabel;
    FLabelMessage: TLabel;
    FLayoutButtons: TLayout;
    FRectPrimaryButton: TRectangle;
    FLabelPrimaryButton: TLabel;
    FRectSecondButton: TRectangle;
    FLabelSecondButton: TLabel;

    procedure ResetComponents;

    procedure BtnMouseDown(ASender: TObject; AButton: TMouseButton;
      AShift: TShiftState; X, Y: Single);
    procedure BtnMouseUp(ASender: TObject; AButton: TMouseButton;
      AShift: TShiftState; X, Y: Single);
    procedure CloseDialog(ASender: TObject);
    procedure EndAnimationArc(ASender: TObject);
    procedure EndAnimation(ASender: TObject);
    procedure ClickPrimaryButton(ASender: TObject);
    procedure ClickSecondButton(ASender: TObject);

    procedure CreateRectBackground;
    procedure CreateLayoutBrackground;
    procedure CreateRectMessage;
    procedure CreateArc;
    procedure CreateRectIcon1;
    procedure CreateRectIcon2;
    procedure CreateLabelIcon;
    procedure CreateAnimatedArc;
    procedure CreateAnimatedBackground;
    procedure CreateLabelTitle;
    procedure CreateLabelMessage;
    procedure CreateLayoutButton;
    procedure CreateRectPrimaryButton;
    procedure CreateLabelPrimaryButton;
    procedure CreateRectSecondButton;
    procedure CreateLabelSecondButton;
  protected
    function Show: IDialog4D; override;
  public
    class function New: IDialog4D;
  end;

implementation

{ TDialogs4DFancyDialog }

const
  GRAY_COLOR = $FFAAAAAA;

procedure TDialogs4DFancyDialog.BtnMouseDown(ASender: TObject;
  AButton: TMouseButton; AShift: TShiftState; X, Y: Single);
begin
  TRectangle(ASender).Opacity := 0.8;
end;

procedure TDialogs4DFancyDialog.BtnMouseUp(ASender: TObject;
  AButton: TMouseButton; AShift: TShiftState; X, Y: Single);
begin
  TRectangle(ASender).Opacity := 1;
end;

procedure TDialogs4DFancyDialog.ClickPrimaryButton(ASender: TObject);
begin
  FRectMessage.Tag := 1;
  CloseDialog(ASender);
end;

procedure TDialogs4DFancyDialog.ClickSecondButton(ASender: TObject);
begin
  FRectMessage.Tag := 2;
  CloseDialog(ASender);
end;

procedure TDialogs4DFancyDialog.CloseDialog(ASender: TObject);
begin
  FBackgroundAnimation.StartValue := 1;
  FBackgroundAnimation.StopValue := 0;
  FBackgroundAnimation.Duration := 0.15;
  FBackgroundAnimation.PropertyName := 'Opacity';
  FBackgroundAnimation.AnimationType := TAnimationType.&In;
  FBackgroundAnimation.Interpolation := TInterpolationType.Circular;
  FBackgroundAnimation.Start;
end;

procedure TDialogs4DFancyDialog.CreateAnimatedArc;
begin
  FArcAnimated := TFloatAnimation.Create(FComponent);
  FArcAnimated.Parent := FArc;
  FArcAnimated.Delay := 0.1;
  FArcAnimated.StartValue := 0;
  FArcAnimated.StopValue := 360;
  FArcAnimated.Duration := 0.4;
  FArcAnimated.PropertyName := 'EndAngle';
  FArcAnimated.AnimationType := TAnimationType.&In;
  FArcAnimated.Interpolation := TInterpolationType.Circular;
  FArcAnimated.OnFinish := EndAnimationArc;
end;

procedure TDialogs4DFancyDialog.CreateAnimatedBackground;
begin
  FBackgroundAnimation := TFloatAnimation.Create(FLayoutBackground);
  FBackgroundAnimation.Parent := FLayoutBackground;
  FBackgroundAnimation.OnFinish := EndAnimation;
end;

procedure TDialogs4DFancyDialog.CreateArc;
begin
  FArc := TArc.Create(FComponent);
  FArc.Visible := true;
  FArc.Parent := FRectMessage;
  FArc.Align := TAlignLayout.MostTop;
  FArc.Margins.Top := 40;
  FArc.Margins.Right := Trunc((FRectMessage.Width - 110) / 2);
  FArc.Margins.Left := FArc.Margins.Right;
  FArc.Height := 110;
  FArc.EndAngle := 0;
  FArc.Stroke.Color := $FF35BD27;
  FArc.Stroke.Thickness := 3;
  FArc.StartAngle := -90;
end;

procedure TDialogs4DFancyDialog.CreateLabelIcon;
begin
  FLabelIcon := TLabel.Create(FArc);
  FLabelIcon.Parent := FArc;
  FLabelIcon.Align := TAlignLayout.Client;
  FLabelIcon.Font.Size := 30;
  FLabelIcon.FontColor := GRAY_COLOR;
  FLabelIcon.TextSettings.HorzAlign := TTextAlign.Center;
  FLabelIcon.TextSettings.VertAlign := TTextAlign.Center;
  FLabelIcon.StyledSettings := [TStyledSetting.Family, TStyledSetting.Style];
  FLabelIcon.Text := EmptyStr;
  FLabelIcon.VertTextAlign := TTextAlign.Center;
  FLabelIcon.Trimming := TTextTrimming.None;
end;

procedure TDialogs4DFancyDialog.CreateLabelMessage;
begin
  FLabelMessage := TLabel.Create(FComponent);
  FLabelMessage.Parent := FRectMessage;
  FLabelMessage.Align := TAlignLayout.Client;
  FLabelMessage.Margins.Top := 20;
  FLabelMessage.Margins.Left := 20;
  FLabelMessage.Margins.Right := 20;
  FLabelMessage.Font.Size := 15;
  FLabelMessage.Height := 60;
  FLabelMessage.Width := FRectMessage.Width - 4;
  FLabelMessage.FontColor := $FF848484;
  FLabelMessage.TextSettings.HorzAlign := TTextAlign.Center;
  FLabelMessage.TextSettings.VertAlign := TTextAlign.Leading;
  FLabelMessage.StyledSettings := [TStyledSetting.Family, TStyledSetting.Style];
  FLabelMessage.Text := 'Message Success.';
  FLabelMessage.VertTextAlign := TTextAlign.Leading;
  FLabelMessage.Trimming := TTextTrimming.None;
end;

procedure TDialogs4DFancyDialog.CreateLabelPrimaryButton;
begin
  FLabelPrimaryButton := TLabel.Create(FComponent);
  FLabelPrimaryButton.Parent := FRectPrimaryButton;
  FLabelPrimaryButton.Align := TAlignLayout.Contents;
  FLabelPrimaryButton.Font.Size := 17;
  FLabelPrimaryButton.FontColor := $FFFFFFFF;
  FLabelPrimaryButton.TextSettings.HorzAlign := TTextAlign.Center;
  FLabelPrimaryButton.TextSettings.VertAlign := TTextAlign.Center;
  FLabelPrimaryButton.StyledSettings := [TStyledSetting.Family, TStyledSetting.Style];
  FLabelPrimaryButton.Text := FTextPrimaryButton;
  FLabelPrimaryButton.VertTextAlign := TTextAlign.Center;
  FLabelPrimaryButton.Trimming := TTextTrimming.None;
  FLabelPrimaryButton.HitTest := False;
end;

procedure TDialogs4DFancyDialog.CreateLabelSecondButton;
begin
  // Label botao 2...
  FLabelSecondButton := TLabel.Create(FComponent);
  FLabelSecondButton.Parent := FRectSecondButton;
  FLabelSecondButton.Align := TAlignLayout.Contents;
  FLabelSecondButton.Font.Size := 17;
  FLabelSecondButton.FontColor := $FFFFFFFF;
  FLabelSecondButton.TextSettings.HorzAlign := TTextAlign.Center;
  FLabelSecondButton.TextSettings.VertAlign := TTextAlign.Center;
  FLabelSecondButton.StyledSettings := [TStyledSetting.Family, TStyledSetting.Style];
  FLabelSecondButton.Text := FTextSecondButton;
  FLabelSecondButton.VertTextAlign := TTextAlign.Center;
  FLabelSecondButton.Trimming := TTextTrimming.None;
  FLabelSecondButton.HitTest := False;
end;

procedure TDialogs4DFancyDialog.CreateLabelTitle;
begin
  FLabelTitle := TLabel.Create(FComponent);
  FLabelTitle.Parent := FRectMessage;
  FLabelTitle.Align := TAlignLayout.Top;
  FLabelTitle.Margins.Top := 30;
  FLabelTitle.Margins.Left := 20;
  FLabelTitle.Margins.Right := 20;
  FLabelTitle.Font.Size := 19;
  FLabelTitle.Height := 25;
  FLabelTitle.Width := FRectMessage.Width - 4;
  FLabelTitle.FontColor := $FF2C2C2C;
  FLabelTitle.TextSettings.HorzAlign := TTextAlign.Center;
  FLabelTitle.TextSettings.VertAlign := TTextAlign.Leading;
  FLabelTitle.StyledSettings := [TStyledSetting.Family, TStyledSetting.Style];
  FLabelTitle.VertTextAlign := TTextAlign.Leading;
  FLabelTitle.Trimming := TTextTrimming.None;
end;

procedure TDialogs4DFancyDialog.CreateLayoutBrackground;
begin
  FLayoutBackground := TLayout.Create(FComponent);
  FLayoutBackground.Opacity := 0;
  FLayoutBackground.Parent := FComponent;
  FLayoutBackground.Align := TAlignLayout.Contents;
  FLayoutBackground.Visible := False;
end;

procedure TDialogs4DFancyDialog.CreateLayoutButton;
begin
  FLayoutButtons := TLayout.Create(FComponent);
  FLayoutButtons.Parent := FRectMessage;
  FLayoutButtons.Align := TAlignLayout.Bottom;
  FLayoutButtons.Height := 50;
  FLayoutButtons.Margins.Left := 10;
  FLayoutButtons.Margins.Right := 10;
  FLayoutButtons.Margins.Bottom := 25;
end;

procedure TDialogs4DFancyDialog.CreateRectBackground;
begin
  FRectBackground := TRectangle.Create(FComponent);
  FRectBackground.Opacity := 0;
  FRectBackground.Parent := FComponent;
  FRectBackground.Align := TAlignLayout.Contents;
  FRectBackground.Fill.Color := TAlphaColorRec.Black;
  FRectBackground.Fill.Kind := TBrushKind.Solid;
  FRectBackground.Stroke.Kind := TBrushKind.None;
  FRectBackground.Visible := False;
end;

procedure TDialogs4DFancyDialog.CreateRectIcon1;
begin
  FRectIcon1 := TRectangle.Create(FArc);
  FRectIcon1.Opacity := 1;
  FRectIcon1.Parent := FArc;
  FRectIcon1.Align := TAlignLayout.Center;
  FRectIcon1.Visible := True;
  FRectIcon1.Height := 5;
  FRectIcon1.Stroke.Kind := TBrushKind.None;
  FRectIcon1.XRadius := 3;
  FRectIcon1.YRadius := 3;
end;

procedure TDialogs4DFancyDialog.CreateRectIcon2;
begin
  FRectIcon2 := TRectangle.Create(FArc);
  FRectIcon2.Opacity := 1;
  FRectIcon2.Align := TAlignLayout.Center;
  FRectIcon2.Parent := FArc;
  FRectIcon2.Visible := True;
  FRectIcon2.Height := 5;
  FRectIcon2.Stroke.Kind := TBrushKind.None;
  FRectIcon2.XRadius := 3;
  FRectIcon2.YRadius := 3;
end;

procedure TDialogs4DFancyDialog.CreateRectMessage;
begin
  FRectMessage := TRectangle.Create(FComponent);
  FRectMessage.Opacity := 1;
  FRectMessage.Fill.Color := $FFFFFFFF;
  FRectMessage.Parent := FLayoutBackground;
  FRectMessage.Align := TAlignLayout.Center;
  FRectMessage.Width := 280;
  FRectMessage.Height := 400;
  FRectMessage.Visible := true;
  FRectMessage.Stroke.Kind := TBrushKind.None;
  FRectMessage.XRadius := 6;
  FRectMessage.YRadius := 6;
end;

procedure TDialogs4DFancyDialog.CreateRectPrimaryButton;
begin
  FRectPrimaryButton := TRectangle.Create(FComponent);
  FRectPrimaryButton.Opacity := 1;
  FRectPrimaryButton.Fill.Color := Self.FColorPrimaryButton;
  FRectPrimaryButton.Parent := FLayoutButtons;
  FRectPrimaryButton.Align := TAlignLayout.None;
  FRectPrimaryButton.Width := 190;
  FRectPrimaryButton.Height := 50;
  FRectPrimaryButton.Stroke.Kind := TBrushKind.None;
  FRectPrimaryButton.XRadius := 4;
  FRectPrimaryButton.YRadius := 4;
  FRectPrimaryButton.OnMouseDown := Self.BtnMouseDown;
  FRectPrimaryButton.OnMouseUp := Self.BtnMouseUp;
  FRectPrimaryButton.OnClick := ClickPrimaryButton;
  FRectPrimaryButton.Visible := False;
end;

procedure TDialogs4DFancyDialog.CreateRectSecondButton;
begin
  FRectSecondButton := TRectangle.Create(FComponent);
  FRectSecondButton.Opacity := 1;
  FRectSecondButton.Fill.Color := Self.FColorSecondButton;
  FRectSecondButton.Parent := FLayoutButtons;
  FRectSecondButton.Align := TAlignLayout.None;
  FRectSecondButton.Width := 190;
  FRectSecondButton.Height := 50;
  FRectSecondButton.Stroke.Kind := TBrushKind.None;
  FRectSecondButton.XRadius := 4;
  FRectSecondButton.YRadius := 4;
  FRectSecondButton.OnMouseDown := Self.BtnMouseDown;
  FRectSecondButton.OnMouseUp := Self.BtnMouseUp;
  FRectSecondButton.OnClick := ClickSecondButton;
  FRectSecondButton.Visible := False;
end;

procedure TDialogs4DFancyDialog.EndAnimation(ASender: TObject);
begin
  FRectBackground.Visible := False;
  FLayoutBackground.Visible := False;
  try
    if FRectMessage.Tag = 1 then
      if Assigned(FOnClickPrimaryButton) then
        FOnClickPrimaryButton(Self);
    if FRectMessage.Tag = 2 then
      if Assigned(FOnClickSecondButton) then
        FOnClickSecondButton(Self);
  finally
    FOnClickPrimaryButton := nil;
    FOnClickSecondButton := nil;
  end;
end;

procedure TDialogs4DFancyDialog.EndAnimationArc(ASender: TObject);
begin
  if FType = dtSuccess then
  begin
    FRectIcon1.Margins.Right := 38;
    FRectIcon1.Margins.Top := 21;
    FRectIcon1.RotationAngle := 45;
    FRectIcon2.Margins.Left := 20;
    FRectIcon2.RotationAngle := 135;
    TAnimator.AnimateFloat(FRectIcon1, 'Width', 30, 0.1);
    TAnimator.AnimateFloatDelay(FRectIcon2, 'Width', 60, 0.1, 0.1);
  end;
  if FType = dtError then
  begin
    FRectIcon1.Margins.Right := 0;
    FRectIcon1.Margins.Top := 0;
    FRectIcon1.RotationAngle := 45;
    FRectIcon2.RotationAngle := 135;
    FRectIcon2.Margins.Left := 0;
    TAnimator.AnimateFloat(FRectIcon1, 'Width', 60, 0.1);
    TAnimator.AnimateFloatDelay(FRectIcon2, 'Width', 60, 0.1, 0.1);
  end;
  if FType = dtWarning then
  begin
    FLabelIcon.Margins.Bottom := 5;
    FLabelIcon.Text := '!';
    FLabelIcon.Font.Size := 70;
  end;
  if FType = dtInfo then
  begin
    FLabelIcon.Margins.Bottom := 5;
    FLabelIcon.Text := 'i';
    FLabelIcon.Font.Size := 70;
  end;
  if FType = dtQuestion then
  begin
    FLabelIcon.Margins.Bottom := 5;
    FLabelIcon.Text := '?';
    FLabelIcon.Font.Size := 70;
  end;
end;

class function TDialogs4DFancyDialog.New: IDialog4D;
begin
  Result := Self.Create;
end;

procedure TDialogs4DFancyDialog.ResetComponents;
begin
  FreeAndNil(FLabelSecondButton);
  FreeAndNil(FRectSecondButton);
  FreeAndNil(FLabelPrimaryButton);
  FreeAndNil(FRectPrimaryButton);
  FreeAndNil(FLayoutButtons);
  FreeAndNil(FLabelMessage);
  FreeAndNil(FLabelTitle);
  FreeAndNil(FBackgroundAnimation);
  FreeAndNil(FArcAnimated);
  FreeAndNil(FLabelIcon);
  FreeAndNil(FRectIcon2);
  FreeAndNil(FRectIcon1);
  FreeAndNil(FArc);
  FreeAndNil(FRectMessage);
  FreeAndNil(FLayoutBackground);
  FreeAndNil(FRectBackground);
end;

function TDialogs4DFancyDialog.Show: IDialog4D;
var
  LService: IFMXVirtualKeyboardService;
begin
  Result := Self;
  try
    ResetComponents;
    CreateRectBackground;
    CreateLayoutBrackground;
    CreateRectMessage;
    CreateArc;
    CreateRectIcon1;
    CreateRectIcon2;
    CreateLabelIcon;
    CreateAnimatedArc;
    CreateAnimatedBackground;
    CreateLabelTitle;
    CreateLabelMessage;
    CreateLayoutButton;
    CreateRectPrimaryButton;
    CreateLabelPrimaryButton;
    CreateRectSecondButton;
    CreateLabelSecondButton;

    FRectIcon1.Width := 0;
    FRectIcon2.Width := 0;
    FLabelIcon.Text := EmptyStr;

    if FType = dtQuestion then
    begin
      FArc.Stroke.Color := FQuestionColor;
      FRectIcon1.Fill.Color := FQuestionColor;
      FRectIcon2.Fill.Color := FQuestionColor;
      FLabelIcon.FontColor := FQuestionColor;
    end
    else
    if FType = dtWarning then
    begin
      FArc.Stroke.Color := FWarningColor;
      FRectIcon1.Fill.Color := FWarningColor;
      FRectIcon2.Fill.Color := FWarningColor;
      FLabelIcon.FontColor := FWarningColor;
    end
    else
    if FType = dtError then
    begin
      FArc.Stroke.Color := FErrorColor;
      FRectIcon1.Fill.Color := FErrorColor;
      FRectIcon2.Fill.Color := FErrorColor;
    end
    else
    if FType = dtInfo then
    begin
      FArc.Stroke.Color := FInfoColor;
      FRectIcon1.Fill.Color := FInfoColor;
      FRectIcon2.Fill.Color := FInfoColor;
      FLabelIcon.FontColor := FInfoColor;
    end
    else
    begin
      FArc.Stroke.Color := FSuccessColor;
      FRectIcon1.Fill.Color := FSuccessColor;
      FRectIcon2.Fill.Color := FSuccessColor;
      FLabelIcon.FontColor := FSuccessColor;
    end;

    FRectBackground.Opacity := 0;
    FRectBackground.Visible := True;
    FLayoutBackground.Opacity := 0;
    FLayoutBackground.Visible := True;
    FLabelTitle.Text := FTitle;
    FLabelMessage.Text := FMessage;
    FLabelPrimaryButton.Text := FTextPrimaryButton;
    FLabelSecondButton.Text := FTextSecondButton;
    FRectPrimaryButton.Visible := FLabelPrimaryButton.Text <> EmptyStr;
    FRectSecondButton.Visible := FLabelSecondButton.Text <> EmptyStr;
    if (FRectPrimaryButton.Visible) and (FRectSecondButton.Visible) then
    begin
      FRectPrimaryButton.Align := TAlignLayout.Left;
      FRectSecondButton.Align := TAlignLayout.Right;

      FRectPrimaryButton.Width := (FLayoutButtons.Width / 2) - 6;
      FRectSecondButton.Width := FRectPrimaryButton.Width;
    end
    else
    if (FRectPrimaryButton.Visible) then
    begin
      FRectPrimaryButton.Align := TAlignLayout.Center;
      FRectPrimaryButton.Width := FLayoutButtons.Width - 30;
    end;

    FArc.EndAngle := 0;
    FArcAnimated.Start;

    TAnimator.AnimateFloat(FRectBackground, 'Opacity', FBackgroundOpacity, 0.15);
    TAnimator.AnimateFloatDelay(FLayoutBackground, 'Opacity', 1, 0.3, 0.2);
    FRectMessage.BringToFront;

    // Hide Virtual Keyboard
    TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService,
      IInterface(LService));
    if (LService <> nil) then
      LService.HideVirtualKeyboard;
    LService := nil;
  finally
    ResetValues;
  end;
end;

end.
