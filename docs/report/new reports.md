execution:

The fix is complete. Here's a summary of changes made to `lib/core/widgets/hierarchy_picker_sheet.dart`:

**Query fixes (matching proven working patterns from the codebase):**
1. **_loadRooms()**: `.select('id, name, created_by, created_at, subjects(count)').order('created_at', ...)` — matches `home_screen.dart` pattern and `Room.fromJson` requirements
2. **_loadSubjects()**: `.select('id, room_id, name, color, position, created_at, chapters(count)').order('position', ...)` — matches `room_screen.dart` pattern and `Subject.fromJson` requirements
3. **_loadChapters()**: `.select('id, subject_id, name, position, created_at').order('position', ...)` — matches `Chapter.fromJson` requirements (position sort is correct)
4. **_loadDocuments()**: `.select('id, chapter_id, title, created_at, updated_at, file_path, file_size, page_count, position').order('position', ...)` — matches `Document.fromJson` requirements (position sort is correct)

**Error handling:**
- All four loaders wrapped in try/catch with `_isLoading`/`_errorMessage` state
- `_buildBody()` renders loading spinner, or error message with **Retry** button that re-runs the relevant loader for the current level

**Cleanup:**
- Removed unused imports (`document_list_item.dart`, `app_theme.dart`)
- Fixed color reference: `AppColors.error` → `AppColors.destructive`

**Verification:**
- `flutter analyze` → No issues
- `flutter test` → Passes
- PostgREST count syntax (`subjects(count)`, `chapters(count)`) confirmed working in existing codebase (`home_screen.dart`, `room_screen.dart`)




PS D:\Code\Shelf dart> flutter logs
Showing A059 logs:
D/FlutterJNI(18601): Beginning load of flutter...
D/FlutterJNI(18601): flutter (null) was loaded normally!
I/flutter (18601): [IMPORTANT:flutter/shell/platform/android/android_context_vk_impeller.cc(62)] Using the Impeller rendering backend (Vulkan).
I/flutter (18601): The Dart VM service is listening on http://127.0.0.1:32957/za1Zt5-C2YI=/
D/FlutterRenderer(18601): Width is zero. 0,0
I/flutter (18601): supabase.supabase_flutter: INFO: ***** Supabase init completed *****
I/flutter (18601): [auth] AuthGate init. currentSession before listener == null? false
I/flutter (18601): LOAD ROOMS: user = 3dbbb6d5-bfb1-4aa5-a322-2a7fbfccb681
I/flutter (18601): LOAD ROOMS: session exists = true
I/flutter (18601): [auth] onAuthStateChange event=AuthChangeEvent.initialSession sessionBefore=non-null sessionAfter=non-null
D/FlutterRenderer(18601): Width is zero. 0,0
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
I/flutter (18601): [scan] _handleScanTap ENTERED, context.mounted=true
I/flutter (18601): [scan] calling FlutterDocScanner().getScannedDocumentAsImages()
D/FlutterJNI(18601): Sending viewport metrics to the engine.
I/flutter (18601): [scan] scanner returned. result==null? false. runtimeType=ImageScanResult. toString="ImageScanResult(images: [file:///data/user/0/com.example.shelf/cache/mlkit_docscan_ui_client/953692900472124.jpg, file:///data/user/0/com.example.shelf/cache/mlkit_docscan_ui_client/953692917303113.jpg], count: 2)"
I/flutter (18601): [scan] imagePaths count=2
I/flutter (18601): [scan] imagePaths=2 paths. About to call Navigator.push to ScanConfigScreen.
I/flutter (18601): [scan] calling Navigator.of(context).push(MaterialPageRoute(builder: ScanConfigScreen))
I/flutter (18601): [scan] Navigator.push returned (sync). Awaiting frame.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.
D/FlutterJNI(18601): Sending viewport metrics to the engine.


Error message on selecting save:

Save failed: PathNotFoundException: Cannot open file, path = 'file:///data/user/0/ com.example.shelf/cache/ mlkit_docscan_ui_client/ 953692900472124.jpg' (OS Error: No such file or directory, errno = 2)

other bugs:

1. in hierarchy picker sheet.dart run, the list even shows deleted rooms. Deleted rooms should be permanently deleted. 

2. ux bug, in hierachy select, user presses select once, this action is again repeated in scan config screen( where the add to exist, create new tabs are). The select last action button in scan config is unnecessary.
