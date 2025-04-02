program TuileFactoryProject;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {Form1},
  uTuilleInterf in 'uTuilleInterf.pas',
  uTuilleDevExpress in 'uTuilleDevExpress.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True; // Enable memory leak detection
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
