program SystemT;

uses
  Vcl.Forms,
  U_Cliente in 'U_Cliente.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
