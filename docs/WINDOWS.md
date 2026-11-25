# Shelf — Windows Development & Distribution

## Prerequisites

- **Windows 10/11** (64-bit)
- **Visual Studio 2022 or 2026** with **Desktop development with C++** workload
- **Developer Mode** enabled (Settings → Privacy & security → For developers)
- **Flutter SDK** (3.19+), `flutter` in PATH
- **Inno Setup 6** (for building the installer)
- **Git** (optional, for cloning)

## Environment Variables (`.env`)

Create a `.env` file at the repository root with **publishable keys only**:

```ini
SUPABASE_URL=https://<your-project>.supabase.co
SUPABASE_ANON_KEY=sb_publishable_<your-publishable-anon-key>
GOOGLE_WEB_CLIENT_ID=<web-client-id>.apps.googleusercontent.com
GOOGLE_ANDROID_CLIENT_ID=<android-client-id>.apps.googleusercontent.com
WORKER_BASE_URL=https://<your-worker>.workers.dev
```

> ⚠️ **Never commit `.env`**. The file is bundled as a Flutter asset (`flutter: assets: - .env`) and ships inside the installed app. Only **publishable** values (Supabase URL, anon/publishable key, Worker base URL, Google client IDs) are allowed. No service-role keys, secrets, or private keys.

## Run / Debug

```powershell
flutter run -d windows
```

- First run may take a minute (CMake configure + ninja build).
- Hot reload works (`r` in the terminal).

## Build Release Binary

```powershell
flutter build windows --release
```

Output: `build/windows/x64/runner/Release/shelf.exe` + DLLs + `data/flutter_assets/`

## Build the Installer (`.exe`)

### One-time setup

1. Install **Inno Setup 6** (add `ISCC.exe` to PATH, or note its full path).
2. Ensure the **VC++ Redist x64** folder is present (installed with the VS C++ workload). Typical path:
   ```
   C:\Program Files\Microsoft Visual Studio\18\Community\VC\Redist\MSVC\14.52.37025\x64\Microsoft.VC145.CRT
   ```
   (Version numbers vary; the script auto-detects the latest.)

### Build

```powershell
cd installer
.\build_installer.ps1
```

Optional parameters:
- `-ISCCPath "C:\Program Files (x86)\Inno Setup 6\ISCC.exe"`
- `-VCRedistPath "C:\...\Microsoft.VC145.CRT"`

Output: `build/installer/Shelf-Setup-<version>.exe` (per-user, no admin prompt).

### What the installer does

- Installs to `%LOCALAPPDATA%\Programs\Shelf` (per-user, no UAC).
- Bundles `msvcp140.dll`, `vcruntime140.dll`, `vcruntime140_1.dll` app-locally (no system VC++ install required).
- Creates Start Menu shortcut; optional Desktop shortcut (unchecked by default).
- "Launch Shelf" checkbox on finish.
- Clean uninstall via Start Menu → Shelf → Uninstall.

### AppId (Inno Setup)

```
{d14ca536-d2d1-436b-a3cb-8c32e8383e82}
```

**Never change this GUID.** It identifies the application for upgrades/uninstalls across versions.

## Supabase & Google OAuth Prerequisites

From the roadmap:

1. **Supabase project** with:
   - Auth → Providers → Google enabled
   - Auth → URL Configuration → Site URL = `https://<your-domain>` (or `http://localhost:3000` for dev)
   - Redirect URLs: `https://<your-domain>/auth/callback`, `io.supabase.shelf://login-callback` (deep link scheme)
2. **Google Cloud Console** OAuth 2.0 client IDs:
   - **Web** client ID → `GOOGLE_WEB_CLIENT_ID`
   - **Android** client ID → `GOOGLE_ANDROID_CLIENT_ID`
   - Authorized redirect URIs must include Supabase callback URL.
3. **Cloudflare Worker** (B2 proxy) deployed and `WORKER_BASE_URL` set.

## SmartScreen Note

The installer is **not code-signed**. On first run, Windows SmartScreen shows "Windows protected your PC".

- Click **More info** → **Run anyway**.
- For distribution, obtain an EV code-signing certificate and sign both `shelf.exe` and the installer.

## Troubleshooting

| Issue | Fix |
|-------|-----|
| `flutter build windows` fails with CMake errors | `flutter clean` then retry |
| `ISCC.exe` not found | Install Inno Setup 6, add to PATH, or pass `-ISCCPath` |
| VC++ DLLs missing | Install VS C++ workload, or pass `-VCRedistPath` |
| App crashes on launch (missing DLL) | Ensure the three VC++ DLLs are copied next to `shelf.exe` (script does this) |
| Installer asks for admin | `PrivilegesRequired=lowest` in `.iss` — ensure you're not running the script elevated |

## File List for Distribution

Only these files are needed on the target machine (inside the installer):

```
shelf.exe
flutter_windows.dll
data/flutter_assets/...
data/icudtl.dat
data/libapp.so (AOT snapshot)
*.dll (plugins + pdfium + VC++ runtime)
```

The installer bundles all of the above.