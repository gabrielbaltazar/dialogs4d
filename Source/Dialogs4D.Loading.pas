unit Dialogs4D.Loading;

interface

// Based on uLoading from 99 Coders

uses
  Dialogs4D.Interfaces,
  System.SysUtils,
  System.UITypes,
  System.Classes,
  FMX.Types,
  FMX.Controls,
  FMX.StdCtrls,
  FMX.Objects,
  FMX.Effects,
  FMX.Layouts,
  FMX.Forms,
  FMX.Graphics,
  FMX.Ani,
  FMX.VirtualKeyboard,
  FMX.Platform;

type
  TDialogs4DLoading = class(TInterfacedObject, IDialogLoading)
  private
    FForm: TForm;
    FMessage: string;
    FMessageDetail: string;
    FHeigth: Single;
    FWidth: Single;
    FColor: TAlphaColor;
    FFontName: TFontName;
    FLayout: TLayout;
    FBackground: TRectangle;
    FArc: TArc;
    FLabelMessage: TLabel;
    FLabelDetail: TLabel;
    FAnimation: TFloatAnimation;

    procedure DestroyComponents;
    procedure CreateBackground;
    procedure CreateLayout;
    procedure CreateArc;
    procedure CreateAnimation;
    procedure CreateLabel;
    procedure CreateLabelDetail;
  protected
    function Form(AValue: TForm): IDialogLoading;
    function FontName(AValue: TFontName): IDialogLoading;
    function Message(AValue: string): IDialogLoading;
    function DetailMessage(AValue: string): IDialogLoading;
    function Color(AValue: TAlphaColor): IDialogLoading;
    function Heigth(AValue: Single): IDialogLoading;
    function Width(AValue: Single): IDialogLoading;
    function Show: IDialogLoading;
    function Hide: IDialogLoading;
  public
    constructor Create;
    class function New: IDialogLoading;
    destructor Destroy; override;
  end;

implementation

{ TDialogs4DLoading }

function TDialogs4DLoading.Message(AValue: string): IDialogLoading;
begin
  Result := Self;
  FMessage := AValue;
  if Assigned(FLayout) then
  begin
    try
      if Assigned(FLabelMessage) then
      begin
        TThread.Synchronize(TThread.CurrentThread,
          procedure
          begin
            FLabelMessage.Text := AValue;
          end);
      end;
    except
    end;
  end;
end;

function TDialogs4DLoading.FontName(AValue: TFontName): IDialogLoading;
begin
  Result := Self;
  FFontName := AValue;
end;

function TDialogs4DLoading.Form(AValue: TForm): IDialogLoading;
begin
  Result := Self;
  FForm := AValue;
end;

destructor TDialogs4DLoading.Destroy;
begin
  DestroyComponents;
  inherited;
end;

procedure TDialogs4DLoading.CreateLabel;
begin
  if not Assigned(FLabelMessage) then
  begin
    FLabelMessage := TLabel.Create(nil);
    FLabelMessage.Parent := FLayout;
    FLabelMessage.Align := TAlignLayout.Center;
    FLabelMessage.Margins.Top := FArc.Height + 100;
    FLabelMessage.Font.Size := 13;
    FLabelMessage.Font.Family := FFontName;
    FLabelMessage.Height := 70;
    FLabelMessage.Width := FForm.Width - 100;
    FLabelMessage.FontColor := 4294901759;
    FLabelMessage.TextSettings.HorzAlign := TTextAlign.Center;
    FLabelMessage.TextSettings.VertAlign := TTextAlign.Leading;
    FLabelMessage.StyledSettings := [TStyledSetting.Family, TStyledSetting.Style];
    FLabelMessage.Text := FMessage;
    FLabelMessage.VertTextAlign := TTextAlign.Leading;
    FLabelMessage.Trimming := TTextTrimming.None;
    FLabelMessage.TabStop := False;
    FLabelMessage.SetFocus;
  end;
end;

procedure TDialogs4DLoading.CreateLabelDetail;
begin
  if not Assigned(FLabelDetail) then
  begin
    FLabelDetail := TLabel.Create(nil);
    FLabelDetail.Parent := FLayout;
    FLabelDetail.Align := TAlignLayout.Center;
    FLabelDetail.Margins.Top := FLabelMessage.Margins.Top + 50;
    FLabelDetail.Font.Size := 13;
    FLabelDetail.Font.Family := FFontName;
    FLabelDetail.Height := 70;
    FLabelDetail.Width := FForm.Width - 100;
    FLabelDetail.FontColor := 4294901759;
    FLabelDetail.TextSettings.HorzAlign := TTextAlign.Center;
    FLabelDetail.TextSettings.VertAlign := TTextAlign.Leading;
    FLabelDetail.StyledSettings := [TStyledSetting.Family, TStyledSetting.Style];
    FLabelDetail.Text := FMessageDetail;
    FLabelDetail.VertTextAlign := TTextAlign.Leading;
    FLabelDetail.Trimming := TTextTrimming.None;
    FLabelDetail.TabStop := False;
  end;
end;

function TDialogs4DLoading.Color(AValue: TAlphaColor): IDialogLoading;
begin
  Result := Self;
  FColor := AValue;
end;

constructor TDialogs4DLoading.Create;
begin
  FFontName := 'Roboto';
  FWidth := 25;
  FHeigth := 25;
  FColor := 4294901759;
end;

procedure TDialogs4DLoading.CreateAnimation;
begin
  if not Assigned(FAnimation) then
  begin
    FAnimation := TFloatAnimation.Create(FForm);
    FAnimation.Parent := FArc;
    FAnimation.StartValue := 0;
    FAnimation.StopValue := 360;
    FAnimation.Duration := 0.8;
    FAnimation.Loop := true;
    FAnimation.PropertyName := 'RotationAngle';
    FAnimation.AnimationType := TAnimationType.InOut;
    FAnimation.Interpolation := TInterpolationType.Linear;
    FAnimation.Start;
  end;
end;

procedure TDialogs4DLoading.CreateArc;
begin
  if not Assigned(FArc) then
  begin
    FArc := TArc.Create(FForm);
    FArc.Visible := True;
    FArc.Parent := FLayout;
    FArc.Align := TAlignLayout.Center;
//    FArc.Margins.Bottom := 55;
    FArc.Width := FWidth;
    FArc.Height := FHeigth;
    FArc.EndAngle := 300;
    FArc.Stroke.Color := FColor;
    FArc.Stroke.Thickness := 3;
    FArc.BringToFront;
//    FArc.Position.X := trunc((FLayout.Width - FArc.Width) / 2);
//    FArc.Position.Y := 0;
  end;
end;

procedure TDialogs4DLoading.CreateLayout;
begin
  if not Assigned(FLayout) then
  begin
    FLayout := TLayout.Create(FForm);
    FLayout.Opacity := 0;
    FLayout.Parent := FForm;
    FLayout.Visible := True;
    FLayout.Align := TAlignLayout.Contents;
    FLayout.Width := 250;
    FLayout.Height := 78;
    FLayout.Visible := True;
  end;
end;

procedure TDialogs4DLoading.CreateBackground;
begin
  if not Assigned(FBackground) then
  begin
    FBackground := TRectangle.Create(FForm);
    FBackground.Opacity := 0;
    FBackground.Parent := FForm;
    FBackground.Visible := True;
    FBackground.Align := TAlignLayout.Contents;
    FBackground.Fill.Color := TAlphaColorRec.Black;
    FBackground.Fill.Kind := TBrushKind.Solid;
    FBackground.Stroke.Kind := TBrushKind.None;
    FBackground.Visible := True;
  end;
end;

procedure TDialogs4DLoading.DestroyComponents;
begin
  try
    if Assigned(FLayout) then
    begin
      try
        if Assigned(FLabelDetail) then
          FLabelDetail.DisposeOf;
        if Assigned(FLabelMessage) then
          FLabelMessage.DisposeOf;
        if Assigned(FAnimation) then
          FAnimation.DisposeOf;
        if Assigned(FArc) then
          FArc.DisposeOf;
        if Assigned(FBackground) then
          FBackground.DisposeOf;
        if Assigned(FLayout) then
          FLayout.DisposeOf;
      except
      end;
    end;
  finally
    FLabelDetail := nil;
    FLabelMessage := nil;
    FAnimation := nil;
    FArc := nil;
    FBackground := nil;
    FLayout := nil;
  end;
end;

function TDialogs4DLoading.DetailMessage(AValue: string): IDialogLoading;
begin
  Result := Self;
  FMessageDetail := AValue;
  if Assigned(FLayout) then
  begin
    try
      if Assigned(FLabelDetail) then
      begin
        TThread.Synchronize(TThread.CurrentThread,
          procedure
          begin
            FLabelDetail.Text := AValue;
          end);
      end;
    except
    end;
  end;
end;

function TDialogs4DLoading.Heigth(AValue: Single): IDialogLoading;
begin
  Result := Self;
  FHeigth := AValue;
end;

function TDialogs4DLoading.Hide: IDialogLoading;
begin
  DestroyComponents;
end;

class function TDialogs4DLoading.New: IDialogLoading;
begin
  Result := Self.Create;
end;

function TDialogs4DLoading.Show: IDialogLoading;
var
  LService: IFMXVirtualKeyboardService;
begin
  CreateBackground;
  CreateLayout;
  CreateArc;
  CreateAnimation;
  CreateLabel;
  CreateLabelDetail;

  TAnimator.AnimateFloat(FBackground, 'Opacity', 0.7);
//  FBackground.AnimateFloat('Opacity', 0.7);
  TAnimator.AnimateFloat(FLayout, 'Opacity', 1);
//  FLayout.AnimateFloat('Opacity', 1);
  FLayout.BringToFront;

  TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService,
    IInterface(LService));
  if (LService <> nil) then
    LService.HideVirtualKeyboard;
  LService := nil;
end;

function TDialogs4DLoading.Width(AValue: Single): IDialogLoading;
begin
  Result := Self;
  FWidth := AValue;
end;

end.
