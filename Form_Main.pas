//******************************************************************************
// Created by JanAukToy
// [Github] https://github.com/JanAukToy
//******************************************************************************
unit Form_Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,

  cls_SoundDevices;

type
  TFormMain = class(TForm)
    TrayIcon1: TTrayIcon;
    pnl_Client: TPanel;
    GroupBox1: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private �錾 }
    f_SoundDevices: TSoundDevices;
  public
    { Public �錾 }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

//******************************************************************************
// �R���X�g���N�^�[
procedure TFormMain.FormCreate(Sender: TObject);
begin
  // �T�E���h�f�o�C�X�C���X�^���X����
  f_SoundDevices := TSoundDevices.Create;

  // �f�o�C�X�R���N�V�����擾
  if f_SoundDevices.GetDeviceCollection then
  begin

  end;
end;

//******************************************************************************
// �f�X�g���N�^�[
procedure TFormMain.FormDestroy(Sender: TObject);
begin
  ;
end;

end.