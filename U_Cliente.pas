unit U_Cliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, REST.Types, Vcl.StdCtrls, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, Vcl.Mask, Vcl.ExtCtrls,
  FireDAC.Stan.StorageBin, FireDAC.Stan.Async, FireDAC.DApt, Vcl.ComCtrls,
  System.ImageList, Vcl.ImgList, Vcl.ToolWin, Vcl.Grids, Vcl.DBGrids,
  Datasnap.DBClient, Vcl.Buttons;

type
  TForm2 = class(TForm)
    btn1: TButton;
    edtlogradouro: TEdit;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    FDMemTable1: TFDMemTable;
    edtnumero: TEdit;
    edtcomple: TEdit;
    edtbairro: TEdit;
    edtlocalidade: TEdit;
    edtUF: TEdit;
    edtpais: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    medtcep: TMaskEdit;
    lbl8: TLabel;
    edtnome: TEdit;
    lbl9: TLabel;
    edtidenti: TEdit;
    edtcpf: TEdit;
    lbl10: TLabel;
    lbl11: TLabel;
    lbl12: TLabel;
    edtEMAIL: TEdit;
    lblEMAIL: TLabel;
    pnl1: TPanel;
    Ds1: TDataSource;
    clbr1: TCoolBar;
    tlb1: TToolBar;
    il1: TImageList;
    btnnovo: TToolButton;
    btncancela: TToolButton;
    btnexcluir: TToolButton;
    btnalterar: TToolButton;
    btnfechar: TToolButton;
    btnsalvar: TToolButton;
    btncarregar: TToolButton;
    btn14: TToolButton;
    btn15: TToolButton;
    btn16: TToolButton;
    cdsclienteFDMemTable1nome: TStringField;
    dbgrd1: TDBGrid;
    cdsclienteFDMemTable1identi: TStringField;
    cdsclienteFDMemTable1cpf: TStringField;
    cdsclienteFDMemTable1fone: TStringField;
    cdsclienteFDMemTable1email: TStringField;
    medt2: TMaskEdit;
    cdsclienteFDMemTable1cep: TStringField;
    cdsclienteFDMemTable1logradouro: TStringField;
    cdsclienteFDMemTable1numero: TStringField;
    cdsclienteFDMemTable1complem: TStringField;
    cdsclienteFDMemTable1bairro: TStringField;
    cdsclienteFDMemTable1cidade: TStringField;
    cdsclienteFDMemTable1uf: TStringField;
    cdsclienteFDMemTable1pais: TStringField;
    dlgOpen1: TOpenDialog;
    dlgSave1: TSaveDialog;
    btn2: TBitBtn;
    procedure btn1Click(Sender: TObject);
    procedure btnsalvarClick(Sender: TObject);
    procedure btnnovoClick(Sender: TObject);
    procedure edtnomeKeyPress(Sender: TObject; var Key: Char);
    procedure btncarregarClick(Sender: TObject);
    procedure btnfecharClick(Sender: TObject);
    procedure Ds1StateChange(Sender: TObject);
    procedure btncancelaClick(Sender: TObject);
    procedure btn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.btnsalvarClick(Sender: TObject);
begin
   if (edtnome.Text = '')or (edtcpf.Text = '') then
   begin
    ShowMessage('preencha os campos obrgatorios');
    Exit
    end;

    FDMemTable1.FieldByName('nome').AsString:=edtnome.Text;
    FDMemTable1.FieldByName('identi').AsString:=edtidenti.Text;
    FDMemTable1.FieldByName('cpf').AsString:=edtcpf.Text;
    FDMemTable1.FieldByName('fone').AsString:=medt2.Text;
    FDMemTable1.FieldByName('email').AsString:=edtEMAIL.Text;
    FDMemTable1.FieldByName('cep').AsString:=medtcep.Text;
    FDMemTable1.FieldByName('logradouro').AsString:=edtlogradouro.Text;
    FDMemTable1.FieldByName('numero').AsString:=edtnumero.Text;
    FDMemTable1.FieldByName('complem').AsString:=edtcomple.Text;
    FDMemTable1.FieldByName('bairro').AsString:=edtbairro.Text;
    FDMemTable1.FieldByName('localidade').AsString:=edtlocalidade.Text;
    FDMemTable1.FieldByName('uf').AsString:=edtUF.Text;
    FDMemTable1.FieldByName('pais').AsString:=edtpais.Text;

    FDMemTable1.Post;
end;

procedure TForm2.btn2Click(Sender: TObject);
begin


    if dlgSave1.Execute = True then
    FDMemTable1.SaveToFile(dlgSave1.FileName);
end;

procedure TForm2.btncancelaClick(Sender: TObject);
begin
     FDMemTable1.Cancel;
end;

procedure TForm2.btncarregarClick(Sender: TObject);
begin
   if dlgOpen1.Execute= true then
   FDMemTable1.LoadFromFile(dlgOpen1.FileName);

end;

procedure TForm2.btn1Click(Sender: TObject);
begin
     RESTClient1.BaseURL:='https://viacep.com.br/ws/'+medtcep.Text+'/json/';
     RESTRequest1.Execute;

    begin
    edtlogradouro.Text:=FDMemTable1.FieldByName('logradouro').AsString;
    edtcomple.Text:=FDMemTable1.FieldByName('complem').AsString;
    edtbairro.Text:=FDMemTable1.FieldByName('bairro').AsString;
    edtlocalidade.Text:=FDMemTable1.FieldByName('localidade').AsString;
    edtUF.Text:=FDMemTable1.FieldByName('UF').AsString;

end;
      end;


procedure TForm2.btnnovoClick(Sender: TObject);
begin
   FDMemTable1.Append;
   edtnome.SetFocus;
end;

procedure TForm2.btnfecharClick(Sender: TObject);
begin
Close;
end;

procedure TForm2.Ds1StateChange(Sender: TObject);
begin
btnnovo.Enabled:=ds1.State in [dsBrowse];
btnsalvar.Enabled:=ds1.State in [dsinsert,dsedit];
btnexcluir.Enabled:=ds1.State in [dsbrowse];
btncancela.Enabled:=ds1.State in [dsinsert,dsedit];
btnalterar.Enabled:=ds1.State in [dsbrowse];

btnfechar.Enabled:=ds1.State in [dsBrowse];

end;

procedure TForm2.edtnomeKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then
begin
  SelectNext(ActiveControl,True,true);
  key:=#0;
  end;

end;

end.
