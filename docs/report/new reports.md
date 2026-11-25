PS D:\Code\Shelf dart> Get-WinEvent -FilterHashtable @{LogName='Application'; ProviderName='Application Error'} -MaxEvents 10 | Where-Object { $_.Message -like '*shelf*' } | Format-List TimeCreated, Message


TimeCreated : 11/25/2026 3:37:22 PM
Message     : Faulting application name: shelf.exe, version: 0.1.6.0, time stamp: 0x6b06ac44
              Faulting module name: file_saver_plugin.dll, version: 0.0.0.0, time stamp: 0x6b06ac42
              Exception code: 0xc00000fd
              Fault offset: 0x000000000010f177
              Faulting process id: 0x29A8
              Faulting application start time: 0x1DD7CC08A7E4C3D
              Faulting application path: D:\Code\Shelf dart\build\windows\x64\runner\Debug\shelf.exe
              Faulting module path: D:\Code\Shelf dart\build\windows\x64\runner\Debug\file_saver_plugin.dll
              Report Id: 7c164a62-2bfc-4d32-b1b6-74012f23df4f
              Faulting package full name:
              Faulting package-relative application ID:

TimeCreated : 11/25/2026 3:35:31 PM
Message     : Faulting application name: shelf.exe, version: 0.1.6.0, time stamp: 0x6b06abb8
              Faulting module name: file_saver_plugin.dll, version: 0.0.0.0, time stamp: 0x6b06abb6
              Exception code: 0xc00000fd
              Fault offset: 0x000000000010f177
              Faulting process id: 0x38B0
              Faulting application start time: 0x1DD7CC036F8910C
              Faulting application path: D:\Code\Shelf dart\build\windows\x64\runner\Debug\shelf.exe
              Faulting module path: D:\Code\Shelf dart\build\windows\x64\runner\Debug\file_saver_plugin.dll
              Report Id: a2485f96-8112-4492-ae8d-e0b06c81cac6
              Faulting package full name:
              Faulting package-relative application ID:

TimeCreated : 11/25/2026 3:34:23 PM
Message     : Faulting application name: shelf.exe, version: 0.1.6.0, time stamp: 0x6b06aa4a
              Faulting module name: file_saver_plugin.dll, version: 0.0.0.0, time stamp: 0x6b06aa48
              Exception code: 0xc00000fd
              Fault offset: 0x000000000010f177
              Faulting process id: 0x43D8
              Faulting application start time: 0x1DD7CBF5DB4DBFE
              Faulting application path: D:\Code\Shelf dart\build\windows\x64\runner\Debug\shelf.exe
              Faulting module path: D:\Code\Shelf dart\build\windows\x64\runner\Debug\file_saver_plugin.dll
              Report Id: ca406aa4-92ed-4601-9463-9b7cb436b63a
              Faulting package full name:
              Faulting package-relative application ID:

TimeCreated : 11/25/2026 12:47:48 AM
Message     : Faulting application name: shelf.exe, version: 0.1.6.0, time stamp: 0x6b05db65
              Faulting module name: file_saver_plugin.dll, version: 0.0.0.0, time stamp: 0x6b05db63
              Exception code: 0xc00000fd
              Fault offset: 0x000000000010f177
              Faulting process id: 0x5554
              Faulting application start time: 0x1DD7C440BDED801
              Faulting application path: D:\Code\Shelf dart\build\windows\x64\runner\Debug\shelf.exe
              Faulting module path: D:\Code\Shelf dart\build\windows\x64\runner\Debug\file_saver_plugin.dll
              Report Id: efcca1ac-2376-4b2b-abd3-b36d9e9849f0
              Faulting package full name:
              Faulting package-relative application ID:

TimeCreated : 11/25/2026 12:03:57 AM
Message     : Faulting application name: shelf.exe, version: 0.1.6.0, time stamp: 0x6b05d119
              Faulting module name: file_saver_plugin.dll, version: 0.0.0.0, time stamp: 0x6b05d118
              Exception code: 0xc00000fd
              Fault offset: 0x000000000010f177
              Faulting process id: 0x6D8
              Faulting application start time: 0x1DD7C3DE8BF21F9
              Faulting application path: D:\Code\Shelf dart\build\windows\x64\runner\Debug\shelf.exe
              Faulting module path: D:\Code\Shelf dart\build\windows\x64\runner\Debug\file_saver_plugin.dll
              Report Id: 1dbf1700-1867-4d9a-bddb-3d1ca10edf78
              Faulting package full name:
              Faulting package-relative application ID:

TimeCreated : 11/24/2026 11:25:41 PM
Message     : Faulting application name: shelf.exe, version: 0.1.6.0, time stamp: 0x6b05c840
              Faulting module name: file_saver_plugin.dll, version: 0.0.0.0, time stamp: 0x6b05c83f
              Exception code: 0xc00000fd
              Fault offset: 0x000000000010f177
              Faulting process id: 0x51E4
              Faulting application start time: 0x1DD7C38A2738AE7
              Faulting application path: D:\Code\Shelf dart\build\windows\x64\runner\Debug\shelf.exe
              Faulting module path: D:\Code\Shelf dart\build\windows\x64\runner\Debug\file_saver_plugin.dll
              Report Id: 61fe840d-fec2-4c8b-8cad-0ef9ce8cf8ec
              Faulting package full name:
              Faulting package-relative application ID:


