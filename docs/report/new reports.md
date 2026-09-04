PS D:\Code\Shelf dart> flutter run
Launching lib\main.dart on A059 in debug mode...
Warning: Flutter support for your project's Android Gradle Plugin version (Android Gradle Plugin version 8.11.1) will soon be dropped. Please upgrade your Android Gradle Plugin version to a version of at least Android Gradle Plugin version 9.0.1 soon.
Alternatively, use the flag "--android-skip-build-dependency-validation" to bypass this check.

Potential fix: Your project's AGP version is typically defined in the plugins block of the `settings.gradle` file (D:\Code\Shelf dart\android/settings.gradle), by a plugin with the id of com.android.application. 
If you don't see a plugins block, your project was likely created with an older template version. In this case it is most likely defined in the top-level build.gradle file (D:\Code\Shelf dart\android/build.gradle) by the following line in the dependencies block of the buildscript: "classpath 'com.android.tools.build:gradle:<version>'".

Warning: Flutter support for your project's Kotlin version (2.2.20) will soon be dropped. Please upgrade your Kotlin version to a version of at least 2.3.20 soon.
Alternatively, use the flag "--android-skip-build-dependency-validation" to bypass this check.

Potential fix: Your project's KGP version is typically defined in the plugins block of the `settings.gradle` file (D:\Code\Shelf dart\android/settings.gradle), by a plugin with the id of org.jetbrains.kotlin.android. 
If you don't see a plugins block, your project was likely created with an older template version, in which case it is most likely defined in the top-level build.gradle file (D:\Code\Shelf dart\android/build.gradle) by the ext.kotlin_version property.

Warning: SDK processing. This version only understands SDK XML versions up to 3 but an SDK XML file of version 4 was encountered. This can happen if you use versions of Android Studio and the command-line tools that were released at different times.
Running Gradle task 'assembleDebug'...                             25.1s
√ Built build\app\outputs\flutter-apk\app-debug.apk
Installing build\app\outputs\flutter-apk\app-debug.apk...           4.5s
I/FlutterActivityAndFragmentDelegate( 9238): If you are attempting to set --enable-dart-profiling via Intent extras to launch a Flutter component outside of using the Flutter CLI, note that support for setting engine flags on Android via Intent will soon be dropped; see https://github.com/flutter/flutter/issues/180686 for more information on this breaking change. To migrate, set --enable-dart-profiling or any other flags specified via Intent extras on the command line instead or see https://github.com/flutter/flutter/blob/main/docs/engine/Flutter-Android-Engine-Flags.md for alternative methods.
D/FlutterJNI( 9238): Beginning load of flutter...
D/FlutterJNI( 9238): flutter (null) was loaded normally!
I/flutter ( 9238): [IMPORTANT:flutter/shell/platform/android/android_context_vk_impeller.cc(62)] Using the Impeller rendering backend (Vulkan).
D/FlutterRenderer( 9238): Width is zero. 0,0
I/flutter ( 9238): supabase.supabase_flutter: INFO: ***** Supabase init completed ***** 
Syncing files to device A059...                                     85ms

Flutter run key commands.
r Hot reload. 
R Hot restart.
h List all available interactive commands.
d Detach (terminate "flutter run" but leave application running).
c Clear the screen
q Quit (terminate the application on the device).

A Dart VM Service on A059 is available at: http://127.0.0.1:50529/PMUtwm-3fcY=/
The Flutter DevTools debugger and profiler on A059 is available at:
http://127.0.0.1:50529/PMUtwm-3fcY=/devtools/?uri=ws://127.0.0.1:50529/PMUtwm-3fcY=/ws
I/flutter ( 9238): [auth] AuthGate init. currentSession before listener == null? false
I/flutter ( 9238): LOAD ROOMS: user = 3dbbb6d5-bfb1-4aa5-a322-2a7fbfccb681
I/flutter ( 9238): LOAD ROOMS: session exists = true
I/flutter ( 9238): [auth] onAuthStateChange event=AuthChangeEvent.initialSession sessionBefore=non-null sessionAfter=non-null
I/Choreographer( 9238): Skipped 121 frames!  The application may be doing too much work on its main thread.
E/m.example.shelf( 9238): Invalid resource ID 0x00000000.
W/System.err( 9238): android.content.res.Resources$NotFoundException: String resource ID #0x0
W/System.err( 9238):    at android.content.res.Resources.getText(Resources.java:470)
W/System.err( 9238):    at android.content.res.Resources.getString(Resources.java:563)
W/System.err( 9238):    at com.nothing.experience.sdk.NothingExperience.getAppName(NothingExperience.java:81)
W/System.err( 9238):    at com.nothing.experience.sdk.NothingExperience.<init>(NothingExperience.java:49)
W/System.err( 9238):    at com.nothing.experience.sdk.NothingExperience.getInstance(NothingExperience.java:65)
W/System.err( 9238):    at com.nothing.experience.AppTracking.<init>(AppTracking.java:20)
W/System.err( 9238):    at com.nothing.experience.AppTracking.getInstance(AppTracking.java:27)
W/System.err( 9238):    at com.nothing.performance.NtPerformanceDataTrackingImpl$pjy.run(go/retraceme 18ee05ccf48bb61fa914e6d0d55dcad75a215a68e84a8b0879b2a3ca130637a4:128)
W/System.err( 9238):    at android.os.Handler.handleCallback(Handler.java:995)
W/System.err( 9238):    at android.os.Handler.dispatchMessage(Handler.java:103)
W/System.err( 9238):    at android.os.Looper.loopOnce(Looper.java:283)
W/System.err( 9238):    at android.os.Looper.loop(Looper.java:392)
W/System.err( 9238):    at android.os.HandlerThread.run(HandlerThread.java:94)
I/WindowExtensionsImpl( 9238): Initializing Window Extensions, vendor API level=9, activity embedding enabled=true
D/FlutterRenderer( 9238): Width is zero. 0,0
I/m.example.shelf( 9238): Compiler allocated 5190KB to compile void android.view.ViewRootImpl.performTraversals()
D/NtViewRootImpl( 9238): mPopUpViewOffsets: offset=(0.0, 0.0), scale=(1.0, 1.0)
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
W/qdgralloc( 9238): GetSize: Pixel format: 0x3b is not supported by gralloc
W/qdgralloc( 9238): gralloc failed to allocate buffer for size 0 format 59 AWxAH 1x1 usage 2816
E/Gralloc4( 9238): isSupported(1, 1, 59, 1, ...) failed with 7
E/GraphicBufferAllocator( 9238): Failed to allocate (4 x 4) layerCount 1 format 59 usage b00: 2
E/AHardwareBuffer( 9238): GraphicBuffer(w=4, h=4, lc=1) failed (Unknown error -2), handle=0x0
W/qdgralloc( 9238): GetSize: Pixel format: 0x3b is not supported by gralloc
W/qdgralloc( 9238): gralloc failed to allocate buffer for size 0 format 59 AWxAH 1x1 usage 2816
E/Gralloc4( 9238): isSupported(1, 1, 59, 1, ...) failed with 7
E/GraphicBufferAllocator( 9238): Failed to allocate (4 x 4) layerCount 1 format 59 usage b00: 2
E/AHardwareBuffer( 9238): GraphicBuffer(w=4, h=4, lc=1) failed (Unknown error -2), handle=0x0
W/qdgralloc( 9238): getInterlacedFlag: getMetaData returned 3, defaulting to interlaced_flag = 0
W/qdgralloc( 9238): getInterlacedFlag: getMetaData returned 3, defaulting to interlaced_flag = 0
W/qdgralloc( 9238): getInterlacedFlag: getMetaData returned 3, defaulting to interlaced_flag = 0
W/qdgralloc( 9238): getInterlacedFlag: getMetaData returned 3, defaulting to interlaced_flag = 0
W/qdgralloc( 9238): getInterlacedFlag: getMetaData returned 3, defaulting to interlaced_flag = 0
I/Choreographer( 9238): Skipped 85 frames!  The application may be doing too much work on its main thread.
I/HWUI    ( 9238): Davey! duration=726ms; Flags=1, FrameTimelineVsyncId=184909465, IntendedVsync=430954498763999, Vsync=430955207097304, InputEventId=0, HandleInputStart=430955213436539, AnimationStart=430955213437059, PerformTraversalsStart=430955213437528, DrawStart=430955218246487, FrameDeadline=430954510430665, FrameStartTime=430955212909664, FrameInterval=8333333, WorkloadTarget=11666666, SyncQueued=430955218896643, SyncStart=430955219016487, IssueDrawCommandsStart=430955219318726, SwapBuffers=430955223592893, FrameCompleted=430955225270809, DequeueBufferDuration=1837968, QueueBufferDuration=244427, GpuCompleted=430955225270809, SwapBuffersCompleted=430955224543414, DisplayPresentTime=0, CommandSubmissionCompleted=430955223592893, 
D/WindowLayoutComponentImpl( 9238): Register WindowLayoutInfoListener on Context=com.example.shelf.MainActivity@52c4c8f, of which baseContext=android.app.ContextImpl@d0b4f6a
D/NtViewRootImpl( 9238): mPopUpViewOffsets: offset=(0.0, 0.0), scale=(1.0, 1.0)
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/InsetsController( 9238): hide(ime(), fromIme=false)
I/ImeTracker( 9238): com.example.shelf:84e90505: onCancelled at PHASE_CLIENT_ALREADY_HIDDEN
I/flutter ( 9238): [auth] onAuthStateChange event=AuthChangeEvent.tokenRefreshed sessionBefore=non-null sessionAfter=non-null
D/ProfileInstaller( 9238): Installing profile for com.example.shelf
I/flutter ( 9238): LOAD ROOMS: user = 3dbbb6d5-bfb1-4aa5-a322-2a7fbfccb681
I/flutter ( 9238): LOAD ROOMS: session exists = true
W/WindowOnBackDispatcher( 9238): sendCancelIfRunning: isInProgress=false callback=io.flutter.embedding.android.FlutterActivity$1@d7e0428
I/flutter ( 9238): [scan] _handleScanTap ENTERED, context.mounted=true
I/flutter ( 9238): [scan] calling FlutterDocScanner().getScannedDocumentAsImages()
D/TransportRuntime.JobInfoScheduler( 9238): Scheduling upload for context TransportContext(cct, VERY_LOW, MSRodHRwczovL2ZpcmViYXNlbG9nZ2luZy5nb29nbGVhcGlzLmNvbS92MGNjL2xvZy9iYXRjaD9mb3JtYXQ9anNvbl9wcm90bzNc) with jobId=-668130304 in 86400000ms(Backend next call timestamp 0). Attempt 1
D/TransportRuntime.SQLiteEventStore( 9238): Storing event with priority=VERY_LOW, name=FIREBASE_ML_SDK for destination cct
D/TransportRuntime.JobInfoScheduler( 9238): Upload for context TransportContext(cct, VERY_LOW, MSRodHRwczovL2ZpcmViYXNlbG9nZ2luZy5nb29nbGVhcGlzLmNvbS92MGNjL2xvZy9iYXRjaD9mb3JtYXQ9anNvbl9wcm90bzNc) is already scheduled. Returning...
D/TransportRuntime.SQLiteEventStore( 9238): Storing event with priority=VERY_LOW, name=FIREBASE_ML_SDK for destination cct
D/TransportRuntime.JobInfoScheduler( 9238): Upload for context TransportContext(cct, VERY_LOW, MSRodHRwczovL2ZpcmViYXNlbG9nZ2luZy5nb29nbGVhcGlzLmNvbS92MGNjL2xvZy9iYXRjaD9mb3JtYXQ9anNvbl9wcm90bzNc) is already scheduled. Returning...
I/ContentCaptureHelper( 9238): Setting logging level to OFF
D/InsetsController( 9238): Setting requestedVisibleTypes to -14 (was -9)
D/VRI[MainActivity]( 9238): visibilityChanged oldVisibility=true newVisibility=false
D/NtViewRootImpl( 9238): mPopUpViewOffsets: offset=(0.0, 0.0), scale=(1.0, 1.0)
D/NtViewRootImpl( 9238): mPopUpViewOffsets: offset=(0.0, 0.0), scale=(1.0, 1.0)
D/InsetsController( 9238): hide(ime(), fromIme=false)
I/ImeTracker( 9238): com.example.shelf:29ced18f: onCancelled at PHASE_CLIENT_ALREADY_HIDDEN
D/ViewRootImpl( 9238): Skipping stats log for color mode
I/flutter ( 9238): [scan] scanner returned. result==null? false. runtimeType=ImageScanResult. toString="ImageScanResult(images: [file:///data/user/0/com.example.shelf/cache/mlkit_docscan_ui_client/1017991222214740.jpg, file:///data/user/0/com.example.shelf/cache/mlkit_docscan_ui_client/1017991253823386.jpg], count: 2)"
I/flutter ( 9238): [scan] imagePaths count=2
I/flutter ( 9238): [scan] imagePaths=2 paths. About to call Navigator.push to ScanConfigScreen.
I/flutter ( 9238): [scan] calling Navigator.of(context).push(MaterialPageRoute(builder: ScanConfigScreen))
I/flutter ( 9238): [scan] Navigator.push returned (sync). Awaiting frame.
W/InteractionJankMonitor( 9238): Initializing without READ_DEVICE_CONFIG permission. enabled=false, interval=1, missedFrameThreshold=3, frameTimeThreshold=64, package=com.example.shelf
W/qdgralloc( 9238): GetSize: Pixel format: 0x3b is not supported by gralloc
W/qdgralloc( 9238): gralloc failed to allocate buffer for size 0 format 59 AWxAH 1x1 usage 2816
E/Gralloc4( 9238): isSupported(1, 1, 59, 1, ...) failed with 7
E/GraphicBufferAllocator( 9238): Failed to allocate (4 x 4) layerCount 1 format 59 usage b00: 2
E/AHardwareBuffer( 9238): GraphicBuffer(w=4, h=4, lc=1) failed (Unknown error -2), handle=0x0
W/qdgralloc( 9238): GetSize: Pixel format: 0x3b is not supported by gralloc
W/qdgralloc( 9238): gralloc failed to allocate buffer for size 0 format 59 AWxAH 1x1 usage 2816
E/Gralloc4( 9238): isSupported(1, 1, 59, 1, ...) failed with 7
E/GraphicBufferAllocator( 9238): Failed to allocate (4 x 4) layerCount 1 format 59 usage b00: 2
E/AHardwareBuffer( 9238): GraphicBuffer(w=4, h=4, lc=1) failed (Unknown error -2), handle=0x0
W/qdgralloc( 9238): getInterlacedFlag: getMetaData returned 3, defaulting to interlaced_flag = 0
W/qdgralloc( 9238): getInterlacedFlag: getMetaData returned 3, defaulting to interlaced_flag = 0
W/qdgralloc( 9238): getInterlacedFlag: getMetaData returned 3, defaulting to interlaced_flag = 0
W/qdgralloc( 9238): getInterlacedFlag: getMetaData returned 3, defaulting to interlaced_flag = 0
W/qdgralloc( 9238): getInterlacedFlag: getMetaData returned 3, defaulting to interlaced_flag = 0
I/m.example.shelf( 9238): AssetManager2(0xb400007c430d29b8) locale list changing from [] to [en-GB]
I/m.example.shelf( 9238): AssetManager2(0xb400007c430db018) locale list changing from [] to [en-GB]
I/m.example.shelf( 9238): AssetManager2(0xb400007c430da6b8) locale list changing from [] to [en-GB]
I/m.example.shelf( 9238): AssetManager2(0xb400007c430e29f8) locale list changing from [] to [en-GB]
I/m.example.shelf( 9238): AssetManager2(0xb400007c430e26d8) locale list changing from [] to [en-GB]
D/TransportRuntime.SQLiteEventStore( 9238): Storing event with priority=VERY_LOW, name=FIREBASE_ML_SDK for destination cct
D/TransportRuntime.JobInfoScheduler( 9238): Upload for context TransportContext(cct, VERY_LOW, MSRodHRwczovL2ZpcmViYXNlbG9nZ2luZy5nb29nbGVhcGlzLmNvbS92MGNjL2xvZy9iYXRjaD9mb3JtYXQ9anNvbl9wcm90bzNc) is already scheduled. Returning...
D/NtViewRootImpl( 9238): mPopUpViewOffsets: offset=(0.0, 0.0), scale=(1.0, 1.0)
D/InsetsController( 9238): hide(ime(), fromIme=false)
I/ImeTracker( 9238): com.example.shelf:7717fd34: onCancelled at PHASE_CLIENT_ALREADY_HIDDEN
D/VRI[GmsDocumentScanningDelegateActivity]( 9238): visibilityChanged oldVisibility=true newVisibility=false
W/WindowOnBackDispatcher( 9238): sendCancelIfRunning: isInProgress=false callback=android.app.Activity$$ExternalSyntheticLambda0@f56cf
D/ViewRootImpl( 9238): Skipping stats log for color mode
I/ImeTracker( 9238): com.example.shelf:9aa3ede7: onRequestShow at ORIGIN_CLIENT reason SHOW_SOFT_INPUT fromUser false
D/InsetsController( 9238): show(ime(), fromIme=false)
D/InsetsController( 9238): Setting requestedVisibleTypes to -1 (was -9)
I/AssistStructure( 9238): Flattened final assist data: 416 bytes, containing 1 windows, 3 views
D/InputConnectionAdaptor( 9238): The input method toggled cursor monitoring on
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
I/ImeTracker( 9238): com.example.shelf:9aa3ede7: onShown
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
I/ImeTracker( 9238): com.example.shelf:36eb83cf: onRequestHide at ORIGIN_CLIENT reason HIDE_SOFT_INPUT fromUser false
D/InsetsController( 9238): hide(ime(), fromIme=false)
W/WindowOnBackDispatcher( 9238): sendCancelIfRunning: isInProgress=false callback=android.view.ImeBackAnimationController@dad3cd9
D/InsetsController( 9238): Setting requestedVisibleTypes to -9 (was -1)
D/CompatChangeReporter( 9238): Compat change id reported: 395521150; UID 10446; state: ENABLED
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
W/RemoteInputConnectionImpl( 9238): requestCursorUpdates on inactive InputConnection
I/ImeTracker( 9238): system_server:1a5893e6: onCancelled at PHASE_CLIENT_ON_CONTROLS_CHANGED
I/ImeTracker( 9238): com.example.shelf:a5530f78: onRequestShow at ORIGIN_CLIENT reason SHOW_SOFT_INPUT fromUser false
D/InsetsController( 9238): show(ime(), fromIme=false)
D/InsetsController( 9238): Setting requestedVisibleTypes to -1 (was -9)
D/InputConnectionAdaptor( 9238): The input method toggled cursor monitoring on
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
I/ImeTracker( 9238): com.example.shelf:a5530f78: onShown
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/InsetsController( 9238): Setting requestedVisibleTypes to -9 (was -1)
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
I/ImeTracker( 9238): com.example.shelf:1cc7fab0: onRequestHide at ORIGIN_CLIENT reason HIDE_SOFT_INPUT_REQUEST_HIDE_WITH_CONTROL fromUser true
W/WindowOnBackDispatcher( 9238): sendCancelIfRunning: isInProgress=false callback=android.view.ImeBackAnimationController@dad3cd9
D/InsetsController( 9238): hide(ime(), fromIme=false)
I/ImeTracker( 9238): com.example.shelf:1cc7fab0: onCancelled at PHASE_CLIENT_ALREADY_HIDDEN
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/FlutterJNI( 9238): Sending viewport metrics to the engine.
D/InputConnectionAdaptor( 9238): The input method toggled cursor monitoring on
I/ImeTracker( 9238): system_server:31038d2d: onCancelled at PHASE_CLIENT_ON_CONTROLS_CHANGED
D/InputConnectionAdaptor( 9238): The input method toggled cursor monitoring off
D/InputConnectionAdaptor( 9238): The input method toggled cursor monitoring on
D/InputConnectionAdaptor( 9238): The input method toggled cursor monitoring off
I/ImeTracker( 9238): com.example.shelf:21496852: onRequestHide at ORIGIN_CLIENT reason HIDE_SOFT_INPUT fromUser false
D/InsetsController( 9238): hide(ime(), fromIme=false)
I/ImeTracker( 9238): com.example.shelf:21496852: onCancelled at PHASE_CLIENT_ALREADY_HIDDEN
W/WindowOnBackDispatcher( 9238): sendCancelIfRunning: isInProgress=false callback=io.flutter.embedding.android.FlutterActivity$1@d7e0428


NEW ISSUE:
Document does save and gets saved in shelf b2 bucket. but, when i go to that room>subject>chapter where i saved, it just becomes a new folder(the document i saved) without becoming a pdf file. and even when i go to that folder> it says document pages will appear here but it is empty.

Now for B2, i went to the website, went to my bucket and browse files. I can see 2 folders- Documents and pages. Documents stores pdf and pages store jpg.
For testing i downloaded a pdf from documents b2 directly from web, but when i opened it, it was corrupted, like, it showed gray or full white. no contents. 

one concern: if my b2 store both versions- pdf in on folder and jpg pages in pages folder of the same scanned content simultaneously, it is very inefficient and eats storage. since we will use pdf combiner flutter package for add to existing afterall the pages storing makes no sense.