program SampleDialog4D;

uses
  System.StartUpCopy,
  FMX.Forms,
  FSampleDialog4D in 'FSampleDialog4D.pas' {frmSampleDialog4D},
  Dialogs4D.Interfaces in '..\Source\Dialogs4D.Interfaces.pas',
  Dialogs4D.Base in '..\Source\Dialogs4D.Base.pas',
  Dialogs4D.FancyDialog in '..\Source\Dialogs4D.FancyDialog.pas',
  Dialogs4D.Loading in '..\Source\Dialogs4D.Loading.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmSampleDialog4D, frmSampleDialog4D);
  Application.Run;
end.
