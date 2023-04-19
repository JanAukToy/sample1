// *****************************************************************************
// Created by JanAukToy
// [Github] https://github.com/JanAukToy
// *****************************************************************************
unit Form_Main;

interface

uses
  System.SysUtils, System.Classes, Vcl.Forms, Vcl.ComCtrls, Vcl.Controls,
  
  cls_AudioDeviceList;

type
  TFormMain = class(TForm)
    pgctrl_Device: TPageControl;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private �錾 }
    f_AudioDeviceList: TAudioDeviceList;
  public
    { Public �錾 }
  end;

var
  FormMain: TFormMain;

implementation

uses
  cls_AudioDevice, cmp_DevicePage;

{$R *.dfm}

// *****************************************************************************
// Constructor
procedure TFormMain.FormCreate(Sender: TObject);
var
  ii: Integer;
  l_DevicePage: TDevicePage;
begin
  // Create Audio Device List
  f_AudioDeviceList := TAudioDeviceList.Create;

  // Create Device Pages
  for ii := 0 to f_AudioDeviceList.Count - 1 do
  begin
    l_DevicePage := TDevicePage.Create(Self);
    l_DevicePage.Caption := f_AudioDeviceList[ii].FriendlyName;
    l_DevicePage.PageControl := pgctrl_Device;
  end;
end;

// *****************************************************************************
// Destructor
procedure TFormMain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(f_AudioDeviceList);
end;

end.
