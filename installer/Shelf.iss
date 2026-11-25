; Shelf Windows Installer Script
; Inno Setup 6
; AppId: {d14ca536-d2d1-436b-a3cb-8c32e8383e82} (NEVER CHANGE)

#define AppName "Shelf"
#define AppVersion "0.1.6"
#define AppPublisher "Shelf Team"
#define AppURL "https://github.com/mahinite/Shelf"
#define AppExeName "shelf.exe"
#define AppId "{{d14ca536-d2d1-436b-a3cb-8c32e8383e82}}"

[Setup]
AppId={#AppId}
AppName={#AppName}
AppVersion={#AppVersion}
AppPublisher={#AppPublisher}
AppPublisherURL={#AppURL}
AppSupportURL={#AppURL}
AppUpdatesURL={#AppURL}
DefaultDirName={localappdata}\Programs\{#AppName}
DefaultGroupName={#AppName}
DisableDirPage=yes
DisableProgramGroupPage=yes
LicenseFile=
OutputDir=.
OutputBaseFilename=Shelf-Setup-{#AppVersion}
SetupIconFile=D:\Code\Shelf dart\windows\runner\resources\app_icon.ico
Compression=lzma
SolidCompression=yes
PrivilegesRequired=lowest
ArchitecturesInstallIn64BitMode=x64compatible
ArchitecturesAllowed=x64
SetupLogging=yes

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "..\build\staging\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{group}\{#AppName}"; Filename: "{app}\{#AppExeName}"; WorkingDir: "{app}"
Name: "{group}\{cm:UninstallProgram,{#AppName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#AppName}"; Filename: "{app}\{#AppExeName}"; WorkingDir: "{app}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#AppExeName}"; Description: "{cm:LaunchProgram,{#AppName}}"; Flags: nowait postinstall skipifsilent

[UninstallDelete]
Type: filesandordirs; Name: "{app}"

[UninstallRun]
; No additional commands needed

[Registry]
; No registry entries needed