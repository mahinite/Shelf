Text dump of where we are at now:
1. Invite via email address works but invite code has this error: Could not join room:

PostgrestException(message: Invalid invite code, code: P0001, details: Bad Request, hint: null)  - High priority bug

2. This would be great if this was possible : In B2, pdf saves with the same name which was given to the scanned file at the time of creation in app post scan. currently it names randomely. i.e. b445729hfbabad.pdf etc. 
Having this feature would also help if we need to manually delete any file from B2 later. (low-mid priority as we can already control deletion within app)- if this is possible, an extension of the tweak could be renaming a pdf within ui also renames in B2(optional)
3. We need to ensure when pdf merging through pdf_combiner, duplicates dont live in B2, rather only the updated file replaces the old pdf. So the old pdf gets replaced by the newer version(which has added pages). -High priority
4. Auto update feature- (I want to leverage free service options or flutter packages for this task to aim an efficient and hassle free pathway.)

Research about point 4:(Random AI suggestion dump)
free way to integrate auto update feature in flutter apps efficiently without google play store

For a free and efficient auto-update integration in Flutter without the Google Play Store, the best option is **Shorebird**, which allows over-the-air (OTA) updates by patching Dart code. This approach is **free for up to 5,000 patches per month** and requires minimal code changes, as it automatically handles diffs and applies updates in the background.

### Recommended Solution: Shorebird
*   **Mechanism**: Compiles only changed Dart code to JavaScript and pushes patches independently of the app store.
*   **Setup**: Replace standard build commands with `shorebird release` and `shorebird patch`.
*   **Cost**: Generous free tier for small to medium apps; paid for higher volume.
*   **Compatibility**: Works on **Android and iOS** without user interaction for the update download.

### Alternative Free Options
If Shorebird is unsuitable, consider these open-source packages:
*   **`flutter_autoupdate`**: Handles downloading and installing APKs (Android) or launching the App Store (iOS) using a remote version JSON file.
*   **`in_app_update`**: Provides Android-specific in-app updates but **does not support iOS**.
*   **Custom JSON Check**: Use `http` and `package_info_plus` to check a remote JSON file for new versions, then manually download and install the APK via `flutter_downloader` or `ota_update`.

### Key Considerations
*   **iOS Limitations**: Apple generally prohibits direct binary updates outside the App Store. **Shorebird** is one of the few methods that bypasses this by patching interpreted code.
*   **Android Permissions**: Manual APK updates require requesting **storage and install permissions** from the user.
*   **Security**: Ensure your server hosting update files or JSON configs is secure to prevent malicious updates.



Here's a fully free pipeline that matches your exact workflow:

## Recommended Stack

| Component | Tool | Cost |
|-----------|------|------|
| APK hosting + version check | **GitHub Releases** | Free (2 GB/release, public repo) |
| Download + install in-app | **`ota_update`** | Free (MIT) |
| Version comparison | **`package_info_plus`** | Free |

## How It Works

1. **You** build a new APK, upload it as a **GitHub Release** (with a tag like `v1.0.1`).
2. **The app** on each user's phone checks the latest GitHub release via the free GitHub API on startup.
3. If the remote version > local version, it downloads the APK (with progress) and fires the Android install intent.
4. User taps "Install" → clean install over the old one.

## Quick Implementation with `ota_update`

```yaml
# pubspec.yaml
dependencies:
  ota_update: ^4.0.1
  package_info_plus: ^8.0.0
  http: ^1.2.0
```

```dart
import 'package:ota_update/ota_update.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:http/http.dart' as http;

Future<void> checkAndUpdate() async {
  final packageInfo = await PackageInfo.fromPlatform();
  final currentVersion = packageInfo.version; // e.g. "1.0.0"

  // 1. Fetch latest release from GitHub (free API, no auth for public repos)
  final resp = await http.get(
    Uri.parse('https://api.github.com/repos/YOUR_USER/YOUR_REPO/releases/latest'),
  );
  if (resp.statusCode != 200) return;

  final data = jsonDecode(resp.body);
  final latestTag = data['tag_name'].substring(1); // strip "v"

  // 2. Compare versions (use package:version for proper semver comparison)
  if (Version.parse(latestTag) <= Version.parse(currentVersion)) return;

  // 3. Get APK download URL from release assets
  final apkUrl = data['assets'][0]['browser_download_url'];

  // 4. Download + install (handles progress, FileProvider, install intent)
  OtaUpdate()
      .execute(
        apkUrl,
        destinationFilename: 'app-update.apk',
        // Optional: verify integrity
        // sha256checksum: '...',
      ).listen((OtaEvent event) {
    // event.status: OtaStatus.downloading / OtaStatus.installed / OtaStatus.failed
    // event.progress: 0.0 → 1.0
    if (event.status == OtaStatus.installed) {
      // Restart or prompt user
    }
  });
}
```

## Android Manifest Requirements

```xml
<!-- AndroidManifest.xml -->
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.REQUEST_INSTALL_PACKAGES" />

<!-- FileProvider for APK install on Android 7+ -->
<provider
    android:name="androidx.core.content.FileProvider"
    android:authorities="${applicationId}.fileprovider"
    android:exported="false"
    android:grantUriPermissions="true">
    <meta-data
        android:name="android.support.FILE_PROVIDER_PATHS"
        android:resource="@xml/file_paths" />
</provider>
```

## Free Hosting Options for the APK

| Service | Free Tier | Notes |
|---------|-----------|-------|
| **GitHub Releases** | 2 GB/release | Best option — doubles as version check via API |
| **Cloudflare R2** | 10 GB storage, **zero egress fees** | Good if you want a custom CDN URL |
| **Firebase Storage** | 10 GB / 1 GB egress per month | Fine for small user bases |

GitHub Releases is the easiest: you just run `gh release create v1.0.1 app-release.apk` from your terminal and you're done.

## Alternative: `flutter_auto_update` (Toasty360)

If you want a more opinionated "it just works" package that wraps the entire GitHub Releases → download → install flow with built-in UI dialogs:

```yaml
dependencies:
  autoupdate: ^1.0.0  # pub.dev/packages/autoupdate (Toasty360)
```

```dart
final config = AutoUpdaterConfig(
  githubRepo: 'your-username/your-repo',
  apkFileName: 'app-release.apk',
  checkOnStartup: true,
  autoInstall: true,
);
initAutoUpdater(config);
```

This is the least-code option but gives you less control over the update UI.

## Important Caveat

> Android **requires** the user to tap "Install" on the system dialog — there is no way to silently replace a running APK without root or device-admin privileges. This is a hard OS-level security restriction. The flow is: your app downloads the APK → user sees the system install prompt → taps OK → clean install. This is the same experience Telegram, Signal, etc. give their non-Play-Store builds.

## Bonus: Hot-Patching Without Full APK

If you only need to patch **Dart code** (not native plugins), look at **`flutter_patcher`** (MIT, self-hosted). It swaps `libapp.so` + assets on next cold start — no install prompt needed. You still host the patch on your own server (Cloudflare R2 free tier works great). This is the closest thing to "truly automatic" updates on Android without a store.


Key requirements:
No app store involvement. Avoiding github release hassle if possible. Or combine it with flutter packages to even out the task pressure and keep everything synced and consistent. Free of cost.