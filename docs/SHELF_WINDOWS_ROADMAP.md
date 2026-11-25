# Shelf for Windows — Roadmap

Companion desktop app for Shelf. Same Supabase accounts, same rooms/subjects/chapters/documents as the Android app. **Primary job: sign in with Google, browse, read PDFs, download PDFs, print.** Upload/scan is out of scope for the MVP.

Repo state this plan was written against: `mahinite/Shelf` @ v0.1.6 (Nov 4, 2026). The repo has `android/` only — no `windows/` folder yet.

---

## 1. Locked decisions

| Topic | Decision |
|---|---|
| Positioning | Companion to Android. Shared accounts and data. No Windows-only data. |
| MVP scope | Google login → browse rooms/subjects/chapters → read PDF → download PDF → print PDF. Create/rename/delete rooms, subjects, chapters keep working as on mobile (same permission rules). |
| Not in MVP | Scan, PDF import/upload, appending pages, auto-update, sidebar/split-pane layout, Microsoft Store. |
| Add (center) button | Hidden on Windows for MVP. Repurposed later as "Import PDF". |
| Design | Same `DESIGN.md`, colours, Inter, light + dark themes as Android. Layout adapts to wide windows (centered content column, no redesign). |
| Auth | Google is primary. Existing email/password accounts can still sign in. **Email sign-up is hidden on Windows** (avoids Supabase free-tier confirmation emails). |
| Input | Right-click = long-press everywhere. Hover cursors. Reader keyboard shortcuts. |
| Printing | Ctrl+P and a Print action in the reader. |
| Updates | Manual download of installer for now. Later: GitHub Release carries `.exe` + `.apk`; Windows app compares its version to the latest `.exe` release. |
| Backend | **No changes** to Supabase schema/RLS, Cloudflare Worker, or B2. |
| Build machine | Mahin's Windows PC. |

## 2. Architecture notes

### 2.1 Platform gating (one place only)
Add `lib/core/platform/platform_support.dart` exposing simple static flags (e.g. `isWindows`, `isAndroid`, `isDesktop`, `supportsScan`, `supportsNativeGoogleSignIn`, `supportsOtaUpdate`). Every Windows-specific branch reads these flags. No scattered `Platform.isX` calls. Android behaviour must remain functionally identical.

Things that currently assume Android and need gating (found in v0.1.6):
- `main.dart` initialises `GoogleSignIn` unconditionally and requires `GOOGLE_WEB_CLIENT_ID` and `GOOGLE_ANDROID_CLIENT_ID` (non-null assertions). `google_sign_in` 7.2.0 has no Windows support — `pubspec.lock` contains only the android, ios, web and platform-interface packages.
- The Google sign-in call is implemented **three times**: `login_screen.dart` (~69), `signup_screen.dart` (~98) and `google_sign_in_button.dart`. All reachable entry points must be gated in Phase 2 and routed in Phase 3.
- `app_scaffold.dart` imports `flutter_doc_scanner` and calls it from the bottom bar's centre button.
- `update_service.dart` is already guarded by `Platform.isAndroid` (verify it stays inert; `ota_update` must never be invoked on Windows).
- `scan_service.dart` and `scan_config_screen.dart` use `pdf_combiner` / `flutter_image_compress` (mobile-only plugins). They stay untouched and unreachable on Windows.
- Flutter skips plugins that don't declare Windows support, so these packages should still compile; they only fail at runtime if called.

### 2.2 Google sign-in on Windows (loopback OAuth)
`google_sign_in` can't be used. Use Supabase's browser OAuth with PKCE and a **loopback redirect**:

1. App starts a tiny `HttpServer` bound to `127.0.0.1` on a fixed port (try 54123, then 54124, 54125).
2. App calls `supabase.auth.signInWithOAuth(OAuthProvider.google, redirectTo: 'http://127.0.0.1:<port>/auth-callback', authScreenLaunchMode: externalApplication)`.
3. User signs in in their default browser; Supabase redirects to the loopback URL with `?code=…`.
4. App captures the request, answers with a small "You can close this tab" page, closes the server, and calls `exchangeCodeForSession(code)`.
5. `AuthGate` already listens to `onAuthStateChange` and swaps to `HomeScreen`.

Why loopback rather than a `shelf://` custom protocol: no registry setup, no single-instance/second-process handling, works from a plain `flutter run` and from the installed app.

**Manual prerequisites (Mahin, in dashboards — not code):**
- Supabase → Authentication → URL Configuration → add redirect URLs: `http://127.0.0.1:54123/auth-callback`, `http://127.0.0.1:54124/auth-callback`, `http://127.0.0.1:54125/auth-callback`.
- Supabase → Authentication → Providers → Google: confirm the **web client ID and client secret** are both set (browser OAuth needs the secret; the Android ID-token flow doesn't).
- Google Cloud Console → the *web* OAuth client → Authorized redirect URIs must include `https://upaujekfbvqfldyxaeso.supabase.co/auth/v1/callback`.
- Same Google account on phone and Windows resolves to the same Supabase user (identity is matched by email). Verify in Phase 3 testing.

### 2.3 Wide-screen layout (no redesign)
- Background (`NotebookBackground`) fills the whole window.
- Content is a centered column: `AppLayout.listMaxWidth = 720`, reader `AppLayout.readerMaxWidth = 960`. Phones (< 720 dp wide) are unaffected.
- Apply the frame **once, in `AppScaffold`**, around `body`. The create-FABs are `Positioned` inside each screen's `Stack`; framing at the scaffold level keeps them aligned to the column instead of floating at the far window edge.
- Bottom bar: full-width background/border, inner row constrained to the same column width.
- Bottom sheets / dialogs / snackbars get a max width (~480–560) so they don't span a 1920px window.
- Window minimum size ~ 420×640 so narrow snapped windows still work.

### 2.4 Download and print
- Download: `FileSaver.saveAs` is used today. Verify it opens a Save dialog on Windows. If not, use `file_selector` (`getSaveLocation`) + `File.writeAsBytes`.
- Print: first try the `printing` package. **Known risk:** `printing` and `pdfrx` both ship a pdfium library on Windows; they may conflict at build or runtime. Phase 6 spikes this on a throwaway branch. Fallback (Plan B): write the cached PDF to a temp file and open it in the user's default PDF app (`url_launcher`), where Ctrl+P works.

## 3. Phases

Each phase = one branch (`windows/p<N>-<name>`), one Kilo/Nemotron session, one verified `git push`. Do not start a phase until the previous phase's **gate** is passed.

| # | Phase | Outcome | Gate (you → Claude) |
|---|---|---|---|
| 0 | Environment + read-only recon | PC ready; Claude sees the real files before any edits | Paste P0 report to Claude; Claude confirms plan or adjusts P1–P8 prompts |
| 1 | Windows scaffold + first run | `windows/` generated; app launches (even if auth is broken) | Paste raw `flutter run -d windows` output + screenshot of login screen |
| 2 | Platform gating | No Android-only code runs on Windows; Windows doesn't crash at startup; Scan button hidden; Android unchanged | Windows launches clean; Android debug build on your phone still scans + logs in |
| 3 | Google sign-in on Windows | Browser OAuth loopback works; session persists; email login kept, sign-up hidden | Real sign-in on PC; same rooms visible as phone |
| 4 | Wide-screen layout | Centered column, FABs/bottom bar/sheets sized properly, reader width capped | Screenshots at 1920×1080, 1280×720, min size; Android phone unchanged |
| 5 | Desktop input + reader shortcuts | Right-click actions, hover cursors, keyboard shortcuts | Manual shortcut checklist passes |
| 6 | Download + print (+ settings share check) | Save dialog works; Ctrl+P works (or Plan B) | Real PDF downloaded and printed to PDF/printer |
| 7 | Window polish + icon | Title, min size, remembered geometry, ICO icon, metadata | Visual check in taskbar/titlebar/Alt-Tab |
| 8 | Release build + installer | `Shelf-Setup-<version>.exe` installs and runs on a clean machine | Install on a second PC/VM/Windows Sandbox and run full QA |

## 4. Final QA checklist (after Phase 8)

Auth
- [ ] Google sign-in from a cold start; sign out; sign in again
- [ ] Close and reopen the app: still signed in
- [ ] Cancel the browser flow / close the tab: app recovers, button usable again
- [ ] Same Google account shows the same rooms as the phone
- [ ] Existing email/password account can sign in; no sign-up link on Windows

Browse / read
- [ ] Rooms → Subjects → Chapters → Documents navigation works; back button + Esc work
- [ ] Create/rename/delete follows the same permission rules as mobile (creator-only deletes etc.)
- [ ] Small PDF, 100+ page PDF, large (30 MB+) PDF all open; scrolling smooth
- [ ] Mouse wheel scroll, Ctrl+wheel zoom, double-click zoom, fast-scroll handle with mouse
- [ ] Shortcuts: PgUp/PgDn, arrows, Home/End, Ctrl +/−/0, Ctrl+S, Ctrl+P, Esc
- [ ] No page-wash-out or context menu on right-click inside the reader (same as mobile long-press rule)

Download / print
- [ ] Download via right-click menu and Ctrl+S: file saved, opens correctly, name sanitised
- [ ] Print dialog appears (or Plan B opens default PDF app)

Layout / look
- [ ] 1920×1080, 2560×1440, 4K at 150% and 200% scaling
- [ ] Narrow window (min size) is usable
- [ ] Light and dark themes both correct; follows the in-app setting
- [ ] FABs sit inside the content column; bottom bar and sheets are not full-bleed

Packaging
- [ ] Installer runs without admin prompt, creates Start Menu entry, uninstalls cleanly
- [ ] Runs on a machine **without** Flutter/VS installed
- [ ] `.env` values present in the release build (login + worker calls work)
- [ ] App shows correct name, icon, version in Explorer → Properties

Regression (Android)
- [ ] Debug/release APK still signs in with Google, scans, saves, opens, downloads

## 5. Risks and mitigations

| Risk | Mitigation |
|---|---|
| Loopback redirect rejected by Supabase | Fixed ports pre-registered; if still rejected, fall back to custom scheme `shelf://auth-callback` + `app_links` single-instance handling (separate phase) |
| `printing` ↔ `pdfrx` pdfium clash | Phase 6 spike on a throwaway branch; Plan B open in default app |
| `FileSaver.saveAs` unsupported on Windows | `file_selector` save dialog |
| `share_plus` (crash-log share in Settings) limited on Windows | Verify in Phase 6; fallback = hide on Windows or "show in folder" |
| Layout changes leak into Android | All sizing via max-width constraints that no-op below 720 dp; Android regression test after P4 |
| Agent claims fixes it didn't make | Every prompt demands raw command output, full-file prints, `git diff`, and `git log --oneline -5` |
| Unsigned exe → SmartScreen warning | Expected for MVP; document "More info → Run anyway". Code signing is a later decision |

## 6. After the MVP (not planned in detail)

1. **Update check** — GitHub Release with `Shelf-Setup-x.y.z.exe` + `.apk`; Windows `UpdateService` picks the `.exe` asset, compares versions, opens the download in the browser (or silent installer later).
2. **Import PDF** — repurpose the Add button on Windows; PDF-only via file picker + drag-and-drop. Must stamp `file_path` on the document row **before** the Worker PUT and set `page_count`.
3. **Desktop layout v2** — sidebar tree (Rooms › Subjects › Chapters) with a reader pane.
4. **In-PDF search**, page thumbnails.
5. **Code signing / Store distribution.**
