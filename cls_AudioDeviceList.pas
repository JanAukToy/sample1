// *****************************************************************************
// Created by JanAukToy
// [Github] https://github.com/JanAukToy
// *****************************************************************************
unit cls_AudioDeviceList;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Win.ComObj,
  System.SyncObjs,
  System.Generics.Collections,
  Winapi.Windows,
  Winapi.ActiveX,

  JAT.MMDeviceAPI, JAT.EndpointVolume, JAT.AudioClient, cls_AudioDevice;

type
  TAudioDeviceList = class(TObjectList<TAudioDevice>)
  private
    f_DeviceEnumerator: IMMDeviceEnumerator;
    f_DeviceCollection: IMMDeviceCollection;
  public
    constructor Create(const a_CoInitializeExFlag
      : ShortInt = COINIT_APARTMENTTHREADED);
    destructor Destroy; override;

    procedure Reload();
  end;

implementation

uses
  System.StrUtils,
  Winapi.PropSys;

{ TAudioDevices }

// *****************************************************************************
// Constructor
constructor TAudioDeviceList.Create(const a_CoInitializeExFlag
  : ShortInt = COINIT_APARTMENTTHREADED);
begin
  inherited Create; // Create Self Object List

  // Get COM Class�@https://learn.microsoft.com/ja-jp/windows/win32/coreaudio/enumerating-audio-devices
  if Succeeded(CoCreateInstance(CLSID_IMMDeviceEnumerator, nil,
    CLSCTX_INPROC_SERVER, IID_IMMDeviceEnumerator, f_DeviceEnumerator)) then
  begin
    // Get Audio Device Collection
    Reload;
  end;
end;

// *****************************************************************************
// Destructor
destructor TAudioDeviceList.Destroy;
begin
  CoUninitialize();

  inherited;
end;

// *****************************************************************************
// Reload Self ( ReGet Audio Device Collection
procedure TAudioDeviceList.Reload();
var
  ii: Integer;
  l_Count: Cardinal;
  l_Device: IMMDevice;
begin
  // First, Destroy Device and Clear List
  Self.Clear();

  // Check Already Get Class
  if Assigned(f_DeviceEnumerator) then
  begin
    // Get Audio Device Collection (Render = Output Sound)
    if Succeeded(f_DeviceEnumerator.EnumAudioEndpoints(eRender,
      DEVICE_STATE_ACTIVE, f_DeviceCollection)) and
    // Get Count on Collection
      Succeeded(f_DeviceCollection.GetCount(l_Count)) then
    begin
      for ii := 0 to l_Count - 1 do
      begin
        // Get Device
        if Succeeded(f_DeviceCollection.Item(ii, l_Device)) then
        begin
          // Add List
          Self.Add(TAudioDevice.Create(l_Device));
        end;
      end;
    end;
  end;
end;

end.