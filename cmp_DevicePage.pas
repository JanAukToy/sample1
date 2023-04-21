// *****************************************************************************
// Created by JanAukToy
// [Github] https://github.com/JanAukToy
// *****************************************************************************
unit cmp_DevicePage;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Vcl.ComCtrls,

  cls_AudioDevice;

type
  TLanguageType = (ltEnglish, ltJapanese);

  TPropertyBox = class(TGroupBox)
  private
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
  end;

  TDevicePropertyBox = class(TPropertyBox)
  private
    f_Device: TAudioDevice;

    procedure SetLanguage(const a_LanguageType: TLanguageType);
  public
    constructor Create(AOwner: TComponent; const a_Device: TAudioDevice;
      const a_LanguageType: TLanguageType);
    destructor Destroy; override;
    property Language: TLanguageType write SetLanguage;

    procedure UpdateProperties();
  end;

  TAdudioPropertyBox = class(TPropertyBox)
  private
    f_Device: TAudioDevice;

    procedure SetLanguage(const a_LanguageType: TLanguageType);
  public
    constructor Create(AOwner: TComponent; const a_Device: TAudioDevice;
      const a_LanguageType: TLanguageType);
    destructor Destroy; override;
    property Language: TLanguageType write SetLanguage;

    procedure UpdateProperties();
  end;

  TDevicePage = class(TTabSheet)
    procedure OnResizeDevicePage(Sender: TObject);
  private
    f_Device: TAudioDevice;
    f_DevicePropertyBox: TDevicePropertyBox;
    f_AudioPropertyBox: TAdudioPropertyBox;

    procedure SetLanguage(const a_LanguageType: TLanguageType);
  public
    constructor Create(AOwner: TComponent; const a_Device: TAudioDevice;
      const a_LanguageType: TLanguageType);
    destructor Destroy; override;

    property Language: TLanguageType write SetLanguage;
  end;

const
  PITCH_SIZE: Integer = 10;

implementation

uses
  System.StrUtils;

{ TDevicePage }

// *****************************************************************************
// Constructor
constructor TDevicePage.Create(AOwner: TComponent; const a_Device: TAudioDevice;
  const a_LanguageType: TLanguageType);
begin
  inherited Create(AOwner);

  // Store Argments
  f_Device := a_Device;

  // Set Caption
  Self.Caption := f_Device.FriendlyName;

  // Create Child Boxes
  f_DevicePropertyBox := TDevicePropertyBox.Create(Self, a_Device,
    a_LanguageType);
  f_AudioPropertyBox := TAdudioPropertyBox.Create(Self, a_Device,
    a_LanguageType);

  // Set Parent
  f_DevicePropertyBox.Parent := Self;
  f_AudioPropertyBox.Parent := Self;

  // Set Resize Event
  Self.OnResize := OnResizeDevicePage;
end;

// *****************************************************************************
// Destructor
destructor TDevicePage.Destroy;
begin
  if Assigned(f_DevicePropertyBox) then
    FreeAndNil(f_DevicePropertyBox);
  if Assigned(f_AudioPropertyBox) then
    FreeAndNil(f_AudioPropertyBox);

  inherited;
end;

// *****************************************************************************
// Device Page Resize Event
procedure TDevicePage.OnResizeDevicePage(Sender: TObject);
var
  l_Width: Integer;
begin
  // Resizing Child GroupBox

  // Set Width to Propety Box
  l_Width := Self.Width div 2 - Round(PITCH_SIZE * 2);
  f_DevicePropertyBox.Width := l_Width;
  f_AudioPropertyBox.Width := l_Width;
end;

// *****************************************************************************
// Set Language
procedure TDevicePage.SetLanguage(const a_LanguageType: TLanguageType);
begin
  // Set Language at PropertyBoxes
  f_DevicePropertyBox.Language := a_LanguageType;
  f_AudioPropertyBox.Language := a_LanguageType;
end;

{ TAdudioPropertyBox }

// *****************************************************************************
// Constructor
constructor TAdudioPropertyBox.Create(AOwner: TComponent;
  const a_Device: TAudioDevice; const a_LanguageType: TLanguageType);
begin
  inherited Create(AOwner);

  // Store Argments
  f_Device := a_Device;

  // Set Language
  SetLanguage(a_LanguageType);
end;

// *****************************************************************************
// Destructor
destructor TAdudioPropertyBox.Destroy;
begin
  inherited;
end;

// *****************************************************************************
// Set LanguageType
procedure TAdudioPropertyBox.SetLanguage(const a_LanguageType: TLanguageType);
begin
  Self.Caption := IfThen(a_LanguageType = ltEnglish, 'Audio Properties',
    '�I�[�f�B�I�ݒ�');
end;

// *****************************************************************************
// Update Props
procedure TAdudioPropertyBox.UpdateProperties;
begin;
end;

{ TDevicePropertyBox }

// *****************************************************************************
// Constructor
constructor TDevicePropertyBox.Create(AOwner: TComponent;
  const a_Device: TAudioDevice; const a_LanguageType: TLanguageType);
begin
  inherited Create(AOwner);

  // Store Argments
  f_Device := a_Device;

  // Set Language
  SetLanguage(a_LanguageType);
end;

// *****************************************************************************
// Destructor
destructor TDevicePropertyBox.Destroy;
begin
  inherited;
end;

// *****************************************************************************
// Set LanguageType
procedure TDevicePropertyBox.SetLanguage(const a_LanguageType: TLanguageType);
begin
  Self.Caption := IfThen(a_LanguageType = ltEnglish, 'Device Properties',
    '�f�o�C�X�ݒ�');
end;

// *****************************************************************************
// Update Props
procedure TDevicePropertyBox.UpdateProperties;
begin;
end;

{ TPropertyBox }

// *****************************************************************************
// Constructor
constructor TPropertyBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  // Setting
  Self.Align := alLeft;
  Self.AlignWithMargins := True;
  Self.Margins.SetBounds(PITCH_SIZE, PITCH_SIZE, PITCH_SIZE, PITCH_SIZE);
  Self.Padding.SetBounds(PITCH_SIZE, PITCH_SIZE, PITCH_SIZE, PITCH_SIZE);
end;

// *****************************************************************************
// Destructor
destructor TPropertyBox.Destroy;
begin
  inherited;
end;

end.