Could not load members.

PostgrestException(message: Could not find the function public.get_room_members(room_id) in the schema cache, code: PGRST202, details: Searched for the function public.get_room_members with parameter room_id or with a single unnamed json/ jsonb parameter, but no matches were found in the schema cache., hint: Perhaps you meant to call the function public.get_room_members(target_room_id))


logs:
D/FlutterJNI( 2409): Beginning load of flutter...
D/FlutterJNI( 2409): flutter (null) was loaded normally!
I/flutter ( 2409): [IMPORTANT:flutter/shell/platform/android/android_context_vk_impeller.cc(62)] Using the Impeller rendering backend (Vulkan).
D/FlutterRenderer( 2409): Width is zero. 0,0
I/flutter ( 2409): supabase.supabase_flutter: INFO: ***** Supabase init completed ***** 
I/flutter ( 2409): [auth] AuthGate init. currentSession before listener == null? false
I/flutter ( 2409): LOAD ROOMS: user = 3dbbb6d5-bfb1-4aa5-a322-2a7fbfccb681
I/flutter ( 2409): LOAD ROOMS: session exists = true
I/flutter ( 2409): [auth] onAuthStateChange event=AuthChangeEvent.initialSession sessionBefore=non-null sessionAfter=non-null
I/Choreographer( 2409): Skipped 163 frames!  The application may be doing too much work on its main thread.
E/m.example.shelf( 2409): Invalid resource ID 0x00000000.
W/System.err( 2409): android.content.res.Resources$NotFoundException: String resource ID #0x0
W/System.err( 2409):    at android.content.res.Resources.getText(Resources.java:470)
W/System.err( 2409):    at android.content.res.Resources.getString(Resources.java:563)
W/System.err( 2409):    at com.nothing.experience.sdk.NothingExperience.getAppName(NothingExperience.java:81)
W/System.err( 2409):    at com.nothing.experience.sdk.NothingExperience.<init>(NothingExperience.java:49)
W/System.err( 2409):    at com.nothing.experience.sdk.NothingExperience.getInstance(NothingExperience.java:65)
W/System.err( 2409):    at com.nothing.experience.AppTracking.<init>(AppTracking.java:20)
W/System.err( 2409):    at com.nothing.experience.AppTracking.getInstance(AppTracking.java:27)
W/System.err( 2409):    at com.nothing.performance.NtPerformanceDataTrackingImpl$pjy.run(go/retraceme 18ee05ccf48bb61fa914e6d0d55dcad75a215a68e84a8b0879b2a3ca130637a4:128)
W/System.err( 2409):    at android.os.Handler.handleCallback(Handler.java:995)
W/System.err( 2409):    at android.os.Handler.dispatchMessage(Handler.java:103)
W/System.err( 2409):    at android.os.Looper.loopOnce(Looper.java:283)
W/System.err( 2409):    at android.os.Looper.loop(Looper.java:392)
W/System.err( 2409):    at android.os.HandlerThread.run(HandlerThread.java:94)
I/WindowExtensionsImpl( 2409): Initializing Window Extensions, vendor API level=9, activity embedding enabled=true
D/FlutterRenderer( 2409): Width is zero. 0,0
I/m.example.shelf( 2409): Compiler allocated 5190KB to compile void android.view.ViewRootImpl.performTraversals()
D/NtViewRootImpl( 2409): mPopUpViewOffsets: offset=(0.0, 0.0), scale=(1.0, 1.0)
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
W/qdgralloc( 2409): GetSize: Pixel format: 0x3b is not supported by gralloc
W/qdgralloc( 2409): gralloc failed to allocate buffer for size 0 format 59 AWxAH 1x1 usage 2816
E/Gralloc4( 2409): isSupported(1, 1, 59, 1, ...) failed with 7
E/GraphicBufferAllocator( 2409): Failed to allocate (4 x 4) layerCount 1 format 59 usage b00: 2
E/AHardwareBuffer( 2409): GraphicBuffer(w=4, h=4, lc=1) failed (Unknown error -2), handle=0x0
W/qdgralloc( 2409): GetSize: Pixel format: 0x3b is not supported by gralloc
W/qdgralloc( 2409): gralloc failed to allocate buffer for size 0 format 59 AWxAH 1x1 usage 2816
E/Gralloc4( 2409): isSupported(1, 1, 59, 1, ...) failed with 7
E/GraphicBufferAllocator( 2409): Failed to allocate (4 x 4) layerCount 1 format 59 usage b00: 2
E/AHardwareBuffer( 2409): GraphicBuffer(w=4, h=4, lc=1) failed (Unknown error -2), handle=0x0
W/qdgralloc( 2409): getInterlacedFlag: getMetaData returned 3, defaulting to interlaced_flag = 0
W/qdgralloc( 2409): getInterlacedFlag: getMetaData returned 3, defaulting to interlaced_flag = 0
W/qdgralloc( 2409): getInterlacedFlag: getMetaData returned 3, defaulting to interlaced_flag = 0
W/qdgralloc( 2409): getInterlacedFlag: getMetaData returned 3, defaulting to interlaced_flag = 0
W/qdgralloc( 2409): getInterlacedFlag: getMetaData returned 3, defaulting to interlaced_flag = 0
I/Choreographer( 2409): Skipped 70 frames!  The application may be doing too much work on its main thread.
D/WindowLayoutComponentImpl( 2409): Register WindowLayoutInfoListener on Context=com.example.shelf.MainActivity@6f73e87, of which baseContext=android.app.ContextImpl@73460a4
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/NtViewRootImpl( 2409): mPopUpViewOffsets: offset=(0.0, 0.0), scale=(1.0, 1.0)
D/InsetsController( 2409): hide(ime(), fromIme=false)
I/ImeTracker( 2409): com.example.shelf:e6d133a4: onCancelled at PHASE_CLIENT_ALREADY_HIDDEN
I/ImeTracker( 2409): system_server:52225068: onCancelled at PHASE_CLIENT_ON_CONTROLS_CHANGED
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
W/WindowOnBackDispatcher( 2409): sendCancelIfRunning: isInProgress=false callback=android.view.ImeBackAnimationController@bfc722f
Syncing files to device A059...                                    147ms

Flutter run key commands.
r Hot reload. 
R Hot restart.
h List all available interactive commands.
d Detach (terminate "flutter run" but leave application running).
c Clear the screen
q Quit (terminate the application on the device).

A Dart VM Service on A059 is available at: http://127.0.0.1:62975/u_JYa-_tNFo=/
The Flutter DevTools debugger and profiler on A059 is available at:
http://127.0.0.1:62975/u_JYa-_tNFo=/devtools/?uri=ws://127.0.0.1:62975/u_JYa-_tN
Fo=/ws
I/flutter ( 2409): [auth] onAuthStateChange event=AuthChangeEvent.tokenRefreshed sessionBefore=non-null sessionAfter=non-null
D/ProfileInstaller( 2409): Installing profile for com.example.shelf
D/VRI[MainActivity]( 2409): visibilityChanged oldVisibility=true newVisibility=false
D/ViewRootImpl( 2409): Skipping stats log for color mode
W/qdgralloc( 2409): GetSize: Pixel format: 0x3b is not supported by gralloc
W/qdgralloc( 2409): gralloc failed to allocate buffer for size 0 format 59 AWxAH 1x1 usage 2816
E/Gralloc4( 2409): isSupported(1, 1, 59, 1, ...) failed with 7
E/GraphicBufferAllocator( 2409): Failed to allocate (4 x 4) layerCount 1 format 59 usage b00: 2
E/AHardwareBuffer( 2409): GraphicBuffer(w=4, h=4, lc=1) failed (Unknown error -2), handle=0x0
W/qdgralloc( 2409): GetSize: Pixel format: 0x3b is not supported by gralloc
W/qdgralloc( 2409): gralloc failed to allocate buffer for size 0 format 59 AWxAH 1x1 usage 2816
E/Gralloc4( 2409): isSupported(1, 1, 59, 1, ...) failed with 7
E/GraphicBufferAllocator( 2409): Failed to allocate (4 x 4) layerCount 1 format 59 usage b00: 2
E/AHardwareBuffer( 2409): GraphicBuffer(w=4, h=4, lc=1) failed (Unknown error -2), handle=0x0
W/qdgralloc( 2409): getInterlacedFlag: getMetaData returned 3, defaulting to interlaced_flag = 0
W/qdgralloc( 2409): getInterlacedFlag: getMetaData returned 3, defaulting to interlaced_flag = 0
W/qdgralloc( 2409): getInterlacedFlag: getMetaData returned 3, defaulting to interlaced_flag = 0
W/qdgralloc( 2409): getInterlacedFlag: getMetaData returned 3, defaulting to interlaced_flag = 0
W/qdgralloc( 2409): getInterlacedFlag: getMetaData returned 3, defaulting to interlaced_flag = 0
D/NtViewRootImpl( 2409): mPopUpViewOffsets: offset=(0.0, 0.0), scale=(1.0, 1.0)
D/InsetsController( 2409): hide(ime(), fromIme=false)
I/ImeTracker( 2409): com.example.shelf:2f36063e: onCancelled at PHASE_CLIENT_ALREADY_HIDDEN
I/ImeTracker( 2409): system_server:90d4f1ae: onCancelled at PHASE_CLIENT_ON_CONTROLS_CHANGED
I/m.example.shelf( 2409): AssetManager2(0xb400007c430eb9b8) locale list changing from [] to [en-GB]
I/m.example.shelf( 2409): AssetManager2(0xb400007c430f1a98) locale list changing from [] to [en-GB]
I/m.example.shelf( 2409): AssetManager2(0xb400007c430eeed8) locale list changing from [] to [en-GB]
I/m.example.shelf( 2409): AssetManager2(0xb400007c430eebb8) locale list changing from [] to [en-GB]
I/m.example.shelf( 2409): AssetManager2(0xb400007c430f2a38) locale list changing from [] to [en-GB]
I/ImeTracker( 2409): com.example.shelf:e66af147: onRequestShow at ORIGIN_CLIENT reason SHOW_SOFT_INPUT fromUser false
D/InsetsController( 2409): show(ime(), fromIme=false)
D/InsetsController( 2409): Setting requestedVisibleTypes to -1 (was -9)
I/ImeTracker( 2409): com.example.shelf:89bd70b: onRequestShow at ORIGIN_CLIENT reason SHOW_SOFT_INPUT fromUser false
D/InsetsController( 2409): show(ime(), fromIme=false)
I/ImeTracker( 2409): com.example.shelf:89bd70b: onCancelled at PHASE_CLIENT_REPORT_REQUESTED_VISIBLE_TYPES
I/AssistStructure( 2409): Flattened final assist data: 484 bytes, containing 1 windows, 3 views
D/InputConnectionAdaptor( 2409): The input method toggled cursor monitoring on
W/InteractionJankMonitor( 2409): Initializing without READ_DEVICE_CONFIG permission. enabled=false, interval=1, missedFrameThreshold=3, frameTimeThreshold=64, package=com.example.shelf
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
I/ImeTracker( 2409): com.example.shelf:e66af147: onShown
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
I/ImeTracker( 2409): com.example.shelf:1b1cc52: onRequestHide at ORIGIN_CLIENT reason HIDE_SOFT_INPUT fromUser false
D/InsetsController( 2409): hide(ime(), fromIme=false)
W/WindowOnBackDispatcher( 2409): sendCancelIfRunning: isInProgress=false callback=android.view.ImeBackAnimationController@bfc722f
D/InsetsController( 2409): Setting requestedVisibleTypes to -9 (was -1)
D/CompatChangeReporter( 2409): Compat change id reported: 395521150; UID 10446; state: ENABLED
W/WindowOnBackDispatcher( 2409): sendCancelIfRunning: isInProgress=false callback=io.flutter.embedding.android.FlutterActivity$1@f8bcea0
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
I/ImeTracker( 2409): system_server:ee966d2e: onCancelled at PHASE_CLIENT_ON_CONTROLS_CHANGED
I/flutter ( 2409): CREATE ROOM: started
I/ImeTracker( 2409): com.example.shelf:329bbbfe: onRequestShow at ORIGIN_CLIENT reason SHOW_SOFT_INPUT fromUser false
D/InsetsController( 2409): show(ime(), fromIme=false)
D/InsetsController( 2409): Setting requestedVisibleTypes to -1 (was -9)
I/ImeTracker( 2409): com.example.shelf:453f4c90: onRequestShow at ORIGIN_CLIENT reason SHOW_SOFT_INPUT fromUser false
D/InsetsController( 2409): show(ime(), fromIme=false)
I/ImeTracker( 2409): com.example.shelf:453f4c90: onCancelled at PHASE_CLIENT_APPLY_ANIMATION
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
I/AssistStructure( 2409): Flattened final assist data: 480 bytes, containing 1 windows, 3 views
I/ImeTracker( 2409): com.example.shelf:329bbbfe: onCancelled at PHASE_CLIENT_ON_CONTROLS_CHANGED
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/InputConnectionAdaptor( 2409): The input method toggled cursor monitoring on
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
I/ImeTracker( 2409): com.example.shelf:329bbbfe: onShown
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
I/flutter ( 2409): CREATE ROOM: cancelled
I/ImeTracker( 2409): com.example.shelf:e5024407: onRequestHide at ORIGIN_CLIENT reason HIDE_SOFT_INPUT fromUser false
D/InsetsController( 2409): hide(ime(), fromIme=false)
W/WindowOnBackDispatcher( 2409): sendCancelIfRunning: isInProgress=false callback=android.view.ImeBackAnimationController@bfc722f
D/InsetsController( 2409): Setting requestedVisibleTypes to -9 (was -1)
W/WindowOnBackDispatcher( 2409): sendCancelIfRunning: isInProgress=false callback=io.flutter.embedding.android.FlutterActivity$1@f8bcea0
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
I/ImeTracker( 2409): system_server:34c84ad7: onCancelled at PHASE_CLIENT_ON_CONTROLS_CHANGED
I/ImeTracker( 2409): com.example.shelf:3625bc24: onRequestShow at ORIGIN_CLIENT reason SHOW_SOFT_INPUT fromUser false
D/InsetsController( 2409): show(ime(), fromIme=false)
D/InsetsController( 2409): Setting requestedVisibleTypes to -1 (was -9)
I/ImeTracker( 2409): com.example.shelf:3d359eef: onRequestShow at ORIGIN_CLIENT reason SHOW_SOFT_INPUT fromUser false
D/InsetsController( 2409): show(ime(), fromIme=false)
I/ImeTracker( 2409): com.example.shelf:3d359eef: onCancelled at PHASE_CLIENT_REPORT_REQUESTED_VISIBLE_TYPES
I/AssistStructure( 2409): Flattened final assist data: 488 bytes, containing 1 windows, 3 views
D/InputConnectionAdaptor( 2409): The input method toggled cursor monitoring on
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
I/ImeTracker( 2409): com.example.shelf:3625bc24: onShown
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
I/ImeTracker( 2409): com.example.shelf:db4f27f3: onRequestHide at ORIGIN_CLIENT reason HIDE_SOFT_INPUT fromUser false
D/InsetsController( 2409): hide(ime(), fromIme=false)
W/WindowOnBackDispatcher( 2409): sendCancelIfRunning: isInProgress=false callback=android.view.ImeBackAnimationController@bfc722f
D/InsetsController( 2409): Setting requestedVisibleTypes to -9 (was -1)
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
I/ImeTracker( 2409): system_server:acfd214e: onCancelled at PHASE_CLIENT_ON_CONTROLS_CHANGED
I/flutter ( 2409): LOAD ROOMS: user = 3dbbb6d5-bfb1-4aa5-a322-2a7fbfccb681
I/flutter ( 2409): LOAD ROOMS: session exists = true
W/WindowOnBackDispatcher( 2409): sendCancelIfRunning: isInProgress=false callback=io.flutter.embedding.android.FlutterActivity$1@f8bcea0
W/WindowOnBackDispatcher( 2409): sendCancelIfRunning: isInProgress=false callback=io.flutter.embedding.android.FlutterActivity$1@f8bcea0
W/WindowOnBackDispatcher( 2409): sendCancelIfRunning: isInProgress=false callback=io.flutter.embedding.android.FlutterActivity$1@f8bcea0
I/m.example.shelf( 2409): AssetManager2(0xb400007c431337b8) locale list changing from [] to [en-GB]
I/m.example.shelf( 2409): AssetManager2(0xb400007c43134a78) locale list changing from [] to [en-GB]
I/m.example.shelf( 2409): AssetManager2(0xb400007c4313cdb8) locale list changing from [] to [en-GB]
I/m.example.shelf( 2409): AssetManager2(0xb400007c43137318) locale list changing from [] to [en-GB]
I/m.example.shelf( 2409): AssetManager2(0xb400007c430f2d58) locale list changing from [] to [en-GB]
I/ImeTracker( 2409): com.example.shelf:8e75c58e: onRequestShow at ORIGIN_CLIENT reason SHOW_SOFT_INPUT fromUser false
D/InsetsController( 2409): show(ime(), fromIme=false)
D/InsetsController( 2409): Setting requestedVisibleTypes to -1 (was -9)
I/ImeTracker( 2409): com.example.shelf:13a85219: onRequestShow at ORIGIN_CLIENT reason SHOW_SOFT_INPUT fromUser false
D/InsetsController( 2409): show(ime(), fromIme=false)
I/ImeTracker( 2409): com.example.shelf:13a85219: onCancelled at PHASE_CLIENT_REPORT_REQUESTED_VISIBLE_TYPES
I/AssistStructure( 2409): Flattened final assist data: 484 bytes, containing 1 windows, 3 views
D/InputConnectionAdaptor( 2409): The input method toggled cursor monitoring on
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
I/ImeTracker( 2409): com.example.shelf:8e75c58e: onShown
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
I/ImeTracker( 2409): com.example.shelf:a672c9ed: onRequestHide at ORIGIN_CLIENT reason HIDE_SOFT_INPUT fromUser false
D/InsetsController( 2409): hide(ime(), fromIme=false)
W/WindowOnBackDispatcher( 2409): sendCancelIfRunning: isInProgress=false callback=android.view.ImeBackAnimationController@bfc722f
D/InsetsController( 2409): Setting requestedVisibleTypes to -9 (was -1)
W/WindowOnBackDispatcher( 2409): sendCancelIfRunning: isInProgress=false callback=io.flutter.embedding.android.FlutterActivity$1@f8bcea0
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
I/ImeTracker( 2409): system_server:20fff7f8: onCancelled at PHASE_CLIENT_ON_CONTROLS_CHANGED
I/ImeTracker( 2409): com.example.shelf:1f8bb4fe: onRequestShow at ORIGIN_CLIENT reason SHOW_SOFT_INPUT fromUser false
D/InsetsController( 2409): show(ime(), fromIme=false)
D/InsetsController( 2409): Setting requestedVisibleTypes to -1 (was -9)
I/ImeTracker( 2409): com.example.shelf:62a5c8b0: onRequestShow at ORIGIN_CLIENT reason SHOW_SOFT_INPUT fromUser false
D/InsetsController( 2409): show(ime(), fromIme=false)
I/ImeTracker( 2409): com.example.shelf:62a5c8b0: onCancelled at PHASE_CLIENT_REPORT_REQUESTED_VISIBLE_TYPES
I/AssistStructure( 2409): Flattened final assist data: 488 bytes, containing 1 windows, 3 views
D/InputConnectionAdaptor( 2409): The input method toggled cursor monitoring on
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
I/ImeTracker( 2409): com.example.shelf:1f8bb4fe: onShown
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
I/ImeTracker( 2409): com.example.shelf:e0f0c213: onRequestHide at ORIGIN_CLIENT reason HIDE_SOFT_INPUT fromUser false
D/InsetsController( 2409): hide(ime(), fromIme=false)
W/WindowOnBackDispatcher( 2409): sendCancelIfRunning: isInProgress=false callback=android.view.ImeBackAnimationController@bfc722f
D/InsetsController( 2409): Setting requestedVisibleTypes to -9 (was -1)
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
D/FlutterJNI( 2409): Sending viewport metrics to the engine.
I/ImeTracker( 2409): system_server:533fa2fa: onCancelled at PHASE_CLIENT_ON_CONTROLS_CHANGED
D/NtViewRootImpl( 2409): mPopUpViewOffsets: offset=(0.0, 0.0), scale=(1.0, 1.0)
D/InsetsController( 2409): hide(ime(), fromIme=false)
I/ImeTracker( 2409): com.example.shelf:a0be6ec9: onCancelled at PHASE_CLIENT_ALREADY_HIDDEN
D/VRI[MainActivity]( 2409): visibilityChanged oldVisibility=true newVisibility=false
I/AutofillManager( 2409): onInvisibleForAutofill(): expiringResponse

crash logs:
=== 2026-09-05T13:45:42.459548 ===
Error: ListTile background color or ink splashes may be invisible.
The ListTile is wrapped in a ColoredBox that has a background color. Because ListTile paints its background and ink splashes on the nearest Material ancestor, this ColoredBox will hide those effects.
To fix this, wrap the ListTile in its own Material widget, or remove the background color from the intermediate ColoredBox.
StackTrace:
#0      main.<anonymous closure> (package:shelf/main.dart:19:73)
#1      FlutterError.reportError (package:flutter/src/foundation/assertions.dart:1193:14)
#2      ListTile._debugCheckBackgroundIsHidden.<anonymous closure> (package:flutter/src/material/list_tile.dart:1151:22)
#3      ListTile._debugCheckBackgroundIsHidden (package:flutter/src/material/list_tile.dart:1177:6)
#4      ListTile.build (package:flutter/src/material/list_tile.dart:833:14)
#5      StatelessElement.build (package:flutter/src/widgets/framework.dart:5902:49)
#6      ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5830:15)
#7      Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#8      ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
#9      ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
#10     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
#11     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
#12     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
#13     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
#14     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
#15     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
#16     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
#17     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
#18     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#19     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#20     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#21     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
#22     StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
#23     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
#24     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
#25     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
#26     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#27     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#28     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
#29     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
#30     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
#31     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
#32     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#33     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#34     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
#35     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
#36     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
#37     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
#38     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#39     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#40     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#41     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
#42     StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
#43     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
#44     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
#45     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
#46     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#47     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#48     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
#49     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
#50     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
#51     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
#52     SliverMultiBoxAdaptorElement.updateChild (package:flutter/src/widgets/sliver.dart:1092:37)
#53     SliverMultiBoxAdaptorElement.createChild.<anonymous closure> (package:flutter/src/widgets/sliver.dart:1077:20)
#54     BuildOwner.buildScope (package:flutter/src/widgets/framework.dart:3114:19)
#55     SliverMultiBoxAdaptorElement.createChild (package:flutter/src/widgets/sliver.dart:1067:12)
#56     RenderSliverMultiBoxAdaptor._createOrObtainChild.<anonymous closure> (package:flutter/src/rendering/sliver_multi_box_adaptor.dart:368:23)
#57     RenderObject.invokeLayoutCallback.<anonymous closure> (package:flutter/src/rendering/object.dart:3042:17)
#58     PipelineOwner._enableMutationsToDirtySubtrees (package:flutter/src/rendering/object.dart:1223:15)
#59     RenderObject.invokeLayoutCallback (package:flutter/src/rendering/object.dart:3041:14)
#60     RenderSliverMultiBoxAdaptor._createOrObtainChild (package:flutter/src/rendering/sliver_multi_box_adaptor.dart:357:5)
#61     RenderSliverMultiBoxAdaptor.insertAndLayoutChild (package:flutter/src/rendering/sliver_multi_box_adaptor.dart:517:5)
#62     RenderSliverList.performLayout.advance (package:flutter/src/rendering/sliver_list.dart:238:19)
#63     RenderSliverList.performLayout (package:flutter/src/rendering/sliver_list.dart:278:12)
#64     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#65     RenderSliverEdgeInsetsPadding.performLayout (package:flutter/src/rendering/sliver_padding.dart:133:12)
#66     RenderSliverPadding.performLayout (package:flutter/src/rendering/sliver_padding.dart:368:11)
#67     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#68     RenderViewportBase.layoutChildSequence (package:flutter/src/rendering/viewport.dart:821:13)
#69     RenderViewport._attemptLayout (package:flutter/src/rendering/viewport.dart:1831:12)
#70     RenderViewport.performLayout (package:flutter/src/rendering/viewport.dart:1724:20)
#71     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#72     RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#73     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#74     RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#75     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#76     RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#77     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#78     RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#79     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#80     RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#81     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#82     RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#83     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#84     RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#85     RenderCustomPaint.performLayout (package:flutter/src/rendering/custom_paint.dart:574:11)
#86     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#87     RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#88     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#89     RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#90     _RenderCustomClip.performLayout (package:flutter/src/rendering/proxy_box.dart:1549:11)
#91     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#92     RenderPadding.performLayout (package:flutter/src/rendering/shifted_box.dart:262:12)
#93     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#94     RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#95     RenderCustomPaint.performLayout (package:flutter/src/rendering/custom_paint.dart:574:11)
#96     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#97     RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#98     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#99     MultiChildLayoutDelegate.layoutChild (package:flutter/src/rendering/custom_layout.dart:180:12)
#100    _ScaffoldLayout.performLayout (package:flutter/src/material/scaffold.dart:1113:7)
#101    MultiChildLayoutDelegate._callPerformLayout (package:flutter/src/rendering/custom_layout.dart:246:7)
#102    RenderCustomMultiChildLayoutBox.performLayout (package:flutter/src/rendering/custom_layout.dart:417:14)
#103    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#104    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#105    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#106    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#107    _RenderCustomClip.performLayout (package:flutter/src/rendering/proxy_box.dart:1549:11)
#108    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#109    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#110    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#111    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#112    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#113    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#114    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#115    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#116    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#117    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#118    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#119    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#120    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#121    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#122    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#123    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#124    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#125    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#126    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#127    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#128    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#129    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#130    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#131    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#132    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#133    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#134    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#135    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#136    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#137    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#138    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#139    RenderOffstage.performLayout (package:flutter/src/rendering/proxy_box.dart:3921:14)
#140    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#141    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#142    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#143    _RenderTheaterMixin.layoutChild (package:flutter/src/widgets/overlay.dart:1124:13)
#144    _RenderTheater.performLayout (package:flutter/src/widgets/overlay.dart:1482:9)
#145    RenderObject._layoutWithoutResize (package:flutter/src/rendering/object.dart:2771:7)
#146    PipelineOwner.flushLayout (package:flutter/src/rendering/object.dart:1174:18)
#147    PipelineOwner.flushLayout (package:flutter/src/rendering/object.dart:1187:15)
#148    RendererBinding.drawFrame (package:flutter/src/rendering/binding.dart:692:23)
#149    WidgetsBinding.drawFrame (package:flutter/src/widgets/binding.dart:1573:13)
#150    RendererBinding._handlePersistentFrameCallback (package:flutter/src/rendering/binding.dart:558:5)
#151    SchedulerBinding._invokeFrameCallback (package:flutter/src/scheduler/binding.dart:1430:15)
#152    SchedulerBinding.handleDrawFrame (package:flutter/src/scheduler/binding.dart:1345:9)
#153    SchedulerBinding._handleDrawFrame (package:flutter/src/scheduler/binding.dart:1198:5)
#154    _invoke (dart:ui/hooks.dart:441:13)
#155    PlatformDispatcher._drawFrame (dart:ui/platform_dispatcher.dart:450:5)
#156    _drawFrame (dart:ui/hooks.dart:413:31)


oxy_box.dart:3921:14)
#157    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#158    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#159    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#160    _RenderTheaterMixin.layoutChild (package:flutter/src/widgets/overlay.dart:1124:13)
#161    _RenderTheater.performLayout (package:flutter/src/widgets/overlay.dart:1482:9)
#162    RenderObject._layoutWithoutResize (package:flutter/src/rendering/object.dart:2771:7)
#163    PipelineOwner.flushLayout (package:flutter/src/rendering/object.dart:1174:18)
#164    PipelineOwner.flushLayout (package:flutter/src/rendering/object.dart:1187:15)
#165    RendererBinding.drawFrame (package:flutter/src/rendering/binding.dart:692:23)
#166    WidgetsBinding.drawFrame (package:flutter/src/widgets/binding.dart:1573:13)
#167    RendererBinding._handlePersistentFrameCallback (package:flutter/src/rendering/binding.dart:558:5)
#168    SchedulerBinding._invokeFrameCallback (package:flutter/src/scheduler/binding.dart:1430:15)
#169    SchedulerBinding.handleDrawFrame (package:flutter/src/scheduler/binding.dart:1345:9)
#170    SchedulerBinding._handleDrawFrame (package:flutter/src/scheduler/binding.dart:1198:5)
#171    _invoke (dart:ui/hooks.dart:441:13)
#172    PlatformDispatcher._drawFrame (dart:ui/platform_dispatcher.dart:450:5)
#173    _drawFrame (dart:ui/hooks.dart:413:31)


=== 2026-09-05T13:45:42.593282 ===
Error: ListTile background color or ink splashes may be invisible.
The ListTile is wrapped in a ColoredBox that has a background color. Because ListTile paints its background and ink splashes on the nearest Material ancestor, this ColoredBox will hide those effects.
To fix this, wrap the ListTile in its own Material widget, or remove the background color from the intermediate ColoredBox.
StackTrace:
#0      main.<anonymous closure> (package:shelf/main.dart:19:73)
#1      FlutterError.reportError (package:flutter/src/foundation/assertions.dart:1193:14)
#2      ListTile._debugCheckBackgroundIsHidden.<anonymous closure> (package:flutter/src/material/list_tile.dart:1151:22)
#3      ListTile._debugCheckBackgroundIsHidden (package:flutter/src/material/list_tile.dart:1177:6)
#4      ListTile.build (package:flutter/src/material/list_tile.dart:833:14)
#5      StatelessElement.build (package:flutter/src/widgets/framework.dart:5902:49)
#6      ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5830:15)
#7      Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#8      StatelessElement.update (package:flutter/src/widgets/framework.dart:5908:5)
#9      Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#10     SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#11     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#12     SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#13     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#14     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#15     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#16     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#17     StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
#18     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#19     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#20     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#21     ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#22     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#23     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#24     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#25     ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#26     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#27     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#28     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#29     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#30     StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
#31     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#32     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#33     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#34     StatelessElement.update (package:flutter/src/widgets/framework.dart:5908:5)
#35     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#36     SliverMultiBoxAdaptorElement.updateChild (package:flutter/src/widgets/sliver.dart:1092:37)
#37     SliverMultiBoxAdaptorElement.performRebuild.processElement (package:flutter/src/widgets/sliver.dart:985:35)
#38     Iterable.forEach (dart:core/iterable.dart:366:35)
#39     SliverMultiBoxAdaptorElement.performRebuild (package:flutter/src/widgets/sliver.dart:1038:24)
#40     SliverMultiBoxAdaptorElement.update (package:flutter/src/widgets/sliver.dart:961:7)
#41     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#42     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#43     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#44     ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#45     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#46     SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#47     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#48     Element.updateChildren (package:flutter/src/widgets/framework.dart:4204:32)
#49     MultiChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7308:17)
#50     _ViewportElement.update (package:flutter/src/widgets/viewport.dart:293:11)
#51     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#52     SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#53     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#54     SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#55     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#56     SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#57     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#58     SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#59     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#60     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#61     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#62     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#63     StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
#64     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#65     SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#66     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#67     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#68     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#69     ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#70     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#71     SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#72     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#73     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#74     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#75     ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#76     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#77     SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#78     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#79     SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#80     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#81     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#82     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#83     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#84     StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
#85     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#86     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#87     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#88     StatelessElement.update (package:flutter/src/widgets/framework.dart:5908:5)
#89     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#90     SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#91     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#92     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#93     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#94     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#95     StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
#96     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#97     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#98     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#99     ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#100    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#101    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#102    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#103    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#104    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
#105    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#106    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#107    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#108    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#109    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
#110    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#111    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#112    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#113    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#114    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#115    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#116    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#117    StatelessElement.update (package:flutter/src/widgets/framework.dart:5908:5)
#118    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#119    SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#120    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#121    SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#122    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#123    SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#124    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#125    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#126    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#127    StatelessElement.update (package:flutter/src/widgets/framework.dart:5908:5)
#128    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#129    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#130    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#131    StatelessElement.update (package:flutter/src/widgets/framework.dart:5908:5)
#132    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#133    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#134    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#135    StatelessElement.update (package:flutter/src/widgets/framework.dart:5908:5)
#136    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#137    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#138    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#139    StatelessElement.update (package:flutter/src/widgets/framework.dart:5908:5)
#140    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#141    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#142    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#143    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#144    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#145    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#146    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#147    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#148    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#149    Element.updateChildren (package:flutter/src/widgets/framework.dart:4204:32)
#150    MultiChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7308:17)
#151    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#152    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#153    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#154    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#155    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#156    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#157    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#158    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#159    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
#160    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#161    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#162    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#163    StatelessElement.update (package:flutter/src/widgets/framework.dart:5908:5)
#164    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#165    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#166    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#167    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#168    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#169    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#170    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#171    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#172    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
#173    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#174    SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#175    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#176    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#177    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#178    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#179    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#180    SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#181    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#182    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#183    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#184    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#185    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
#186    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#187    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#188    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#189    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#190    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
#191    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#192    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#193    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#194    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#195    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#196    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#197    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#198    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#199    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#200    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#201    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#202    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#203    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#204    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#205    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#206    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#207    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
#208    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#209    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#210    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#211    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#212    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#213    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#214    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#215    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#216    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
#217    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#218    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#219    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#220    StatelessElement.update (package:flutter/src/widgets/framework.dart:5908:5)
#221    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#222    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#223    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#224    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#225    BuildScope._tryRebuild (package:flutter/src/widgets/framework.dart:2763:15)
#226    BuildScope._flushDirtyElements (package:flutter/src/widgets/framework.dart:2820:11)
#227    BuildOwner.buildScope (package:flutter/src/widgets/framework.dart:3124:18)
#228    WidgetsBinding.drawFrame (package:flutter/src/widgets/binding.dart:1571:21)
#229    RendererBinding._handlePersistentFrameCallback (package:flutter/src/rendering/binding.dart:558:5)
#230    SchedulerBinding._invokeFrameCallback (package:flutter/src/scheduler/binding.dart:1430:15)
#231    SchedulerBinding.handleDrawFrame (package:flutter/src/scheduler/binding.dart:1345:9)
#232    SchedulerBinding._handleDrawFrame (package:flutter/src/scheduler/binding.dart:1198:5)
#233    _invoke (dart:ui/hooks.dart:441:13)
#234    PlatformDispatcher._drawFrame (dart:ui/platform_dispatcher.dart:450:5)
#235    _drawFrame (dart:ui/hooks.dart:413:31)


/widgets/framework.dart:5542:7)
#236    BuildScope._tryRebuild (package:flutter/src/widgets/framework.dart:2763:15)
#237    BuildScope._flushDirtyElements (package:flutter/src/widgets/framework.dart:2820:11)
#238    BuildOwner.buildScope (package:flutter/src/widgets/framework.dart:3124:18)
#239    WidgetsBinding.drawFrame (package:flutter/src/widgets/binding.dart:1571:21)
#240    RendererBinding._handlePersistentFrameCallback (package:flutter/src/rendering/binding.dart:558:5)
#241    SchedulerBinding._invokeFrameCallback (package:flutter/src/scheduler/binding.dart:1430:15)
#242    SchedulerBinding.handleDrawFrame (package:flutter/src/scheduler/binding.dart:1345:9)
#243    SchedulerBinding._handleDrawFrame (package:flutter/src/scheduler/binding.dart:1198:5)
#244    _invoke (dart:ui/hooks.dart:441:13)
#245    PlatformDispatcher._drawFrame (dart:ui/platform_dispatcher.dart:450:5)
#246    _drawFrame (dart:ui/hooks.dart:413:31)


=== 2026-09-05T13:45:52.641277 ===
Error: ListTile background color or ink splashes may be invisible.
The ListTile is wrapped in a ColoredBox that has a background color. Because ListTile paints its background and ink splashes on the nearest Material ancestor, this ColoredBox will hide those effects.
To fix this, wrap the ListTile in its own Material widget, or remove the background color from the intermediate ColoredBox.
StackTrace:
#0      main.<anonymous closure> (package:shelf/main.dart:19:73)
#1      FlutterError.reportError (package:flutter/src/foundation/assertions.dart:1193:14)
#2      ListTile._debugCheckBackgroundIsHidden.<anonymous closure> (package:flutter/src/material/list_tile.dart:1151:22)
#3      ListTile._debugCheckBackgroundIsHidden (package:flutter/src/material/list_tile.dart:1177:6)
#4      ListTile.build (package:flutter/src/material/list_tile.dart:833:14)
#5      StatelessElement.build (package:flutter/src/widgets/framework.dart:5902:49)
#6      ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5830:15)
#7      Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#8      StatelessElement.update (package:flutter/src/widgets/framework.dart:5908:5)
#9      Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#10     SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#11     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#12     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#13     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#14     StatelessElement.update (package:flutter/src/widgets/framework.dart:5908:5)
#15     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#16     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#17     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#18     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#19     BuildScope._tryRebuild (package:flutter/src/widgets/framework.dart:2763:15)
#20     BuildScope._flushDirtyElements (package:flutter/src/widgets/framework.dart:2820:11)
#21     BuildOwner.buildScope (package:flutter/src/widgets/framework.dart:3124:18)
#22     WidgetsBinding.drawFrame (package:flutter/src/widgets/binding.dart:1571:21)
#23     RendererBinding._handlePersistentFrameCallback (package:flutter/src/rendering/binding.dart:558:5)
#24     SchedulerBinding._invokeFrameCallback (package:flutter/src/scheduler/binding.dart:1430:15)
#25     SchedulerBinding.handleDrawFrame (package:flutter/src/scheduler/binding.dart:1345:9)
#26     SchedulerBinding._handleDrawFrame (package:flutter/src/scheduler/binding.dart:1198:5)
#27     _invoke (dart:ui/hooks.dart:441:13)
#28     PlatformDispatcher._drawFrame (dart:ui/platform_dispatcher.dart:450:5)
#29     _drawFrame (dart:ui/hooks.dart:413:31)


=== 2026-09-05T13:45:54.977755 ===
Error: ListTile background color or ink splashes may be invisible.
The ListTile is wrapped in a ColoredBox that has a background color. Because ListTile paints its background and ink splashes on the nearest Material ancestor, this ColoredBox will hide those effects.
To fix this, wrap the ListTile in its own Material widget, or remove the background color from the intermediate ColoredBox.
StackTrace:
#0      main.<anonymous closure> (package:shelf/main.dart:19:73)
#1      FlutterError.reportError (package:flutter/src/foundation/assertions.dart:1193:14)
#2      ListTile._debugCheckBackgroundIsHidden.<anonymous closure> (package:flutter/src/material/list_tile.dart:1151:22)
#3      ListTile._debugCheckBackgroundIsHidden (package:flutter/src/material/list_tile.dart:1177:6)
#4      ListTile.build (package:flutter/src/material/list_tile.dart:833:14)
#5      StatelessElement.build (package:flutter/src/widgets/framework.dart:5902:49)
#6      ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5830:15)
#7      Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#8      ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
#9      ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
#10     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
#11     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
#12     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
#13     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
#14     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
#15     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
#16     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
#17     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
#18     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#19     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#20     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#21     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
#22     StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
#23     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
#24     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
#25     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
#26     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#27     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#28     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
#29     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
#30     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
#31     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
#32     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#33     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#34     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
#35     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
#36     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
#37     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
#38     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#39     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#40     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#41     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
#42     StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
#43     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
#44     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
#45     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
#46     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#47     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#48     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
#49     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
#50     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
#51     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
#52     SliverMultiBoxAdaptorElement.updateChild (package:flutter/src/widgets/sliver.dart:1092:37)
#53     SliverMultiBoxAdaptorElement.createChild.<anonymous closure> (package:flutter/src/widgets/sliver.dart:1077:20)
#54     BuildOwner.buildScope (package:flutter/src/widgets/framework.dart:3114:19)
#55     SliverMultiBoxAdaptorElement.createChild (package:flutter/src/widgets/sliver.dart:1067:12)
#56     RenderSliverMultiBoxAdaptor._createOrObtainChild.<anonymous closure> (package:flutter/src/rendering/sliver_multi_box_adaptor.dart:368:23)
#57     RenderObject.invokeLayoutCallback.<anonymous closure> (package:flutter/src/rendering/object.dart:3042:17)
#58     PipelineOwner._enableMutationsToDirtySubtrees (package:flutter/src/rendering/object.dart:1223:15)
#59     RenderObject.invokeLayoutCallback (package:flutter/src/rendering/object.dart:3041:14)
#60     RenderSliverMultiBoxAdaptor._createOrObtainChild (package:flutter/src/rendering/sliver_multi_box_adaptor.dart:357:5)
#61     RenderSliverMultiBoxAdaptor.insertAndLayoutChild (package:flutter/src/rendering/sliver_multi_box_adaptor.dart:517:5)
#62     RenderSliverList.performLayout.advance (package:flutter/src/rendering/sliver_list.dart:238:19)
#63     RenderSliverList.performLayout (package:flutter/src/rendering/sliver_list.dart:278:12)
#64     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#65     RenderSliverEdgeInsetsPadding.performLayout (package:flutter/src/rendering/sliver_padding.dart:133:12)
#66     RenderSliverPadding.performLayout (package:flutter/src/rendering/sliver_padding.dart:368:11)
#67     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#68     RenderViewportBase.layoutChildSequence (package:flutter/src/rendering/viewport.dart:821:13)
#69     RenderViewport._attemptLayout (package:flutter/src/rendering/viewport.dart:1831:12)
#70     RenderViewport.performLayout (package:flutter/src/rendering/viewport.dart:1724:20)
#71     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#72     RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#73     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#74     RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#75     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#76     RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#77     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#78     RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#79     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#80     RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#81     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#82     RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#83     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#84     RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#85     RenderCustomPaint.performLayout (package:flutter/src/rendering/custom_paint.dart:574:11)
#86     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#87     RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#88     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#89     RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#90     _RenderCustomClip.performLayout (package:flutter/src/rendering/proxy_box.dart:1549:11)
#91     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#92     RenderPadding.performLayout (package:flutter/src/rendering/shifted_box.dart:262:12)
#93     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#94     RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#95     RenderCustomPaint.performLayout (package:flutter/src/rendering/custom_paint.dart:574:11)
#96     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#97     RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#98     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#99     MultiChildLayoutDelegate.layoutChild (package:flutter/src/rendering/custom_layout.dart:180:12)
#100    _ScaffoldLayout.performLayout (package:flutter/src/material/scaffold.dart:1113:7)
#101    MultiChildLayoutDelegate._callPerformLayout (package:flutter/src/rendering/custom_layout.dart:246:7)
#102    RenderCustomMultiChildLayoutBox.performLayout (package:flutter/src/rendering/custom_layout.dart:417:14)
#103    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#104    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#105    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#106    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#107    _RenderCustomClip.performLayout (package:flutter/src/rendering/proxy_box.dart:1549:11)
#108    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#109    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#110    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#111    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#112    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#113    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#114    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#115    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#116    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#117    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#118    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#119    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#120    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#121    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#122    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#123    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#124    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#125    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#126    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#127    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#128    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#129    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#130    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#131    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#132    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#133    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#134    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#135    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#136    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#137    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#138    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#139    RenderOffstage.performLayout (package:flutter/src/rendering/proxy_box.dart:3921:14)
#140    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#141    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#142    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#143    _RenderTheaterMixin.layoutChild (package:flutter/src/widgets/overlay.dart:1124:13)
#144    _RenderTheater.performLayout (package:flutter/src/widgets/overlay.dart:1482:9)
#145    RenderObject._layoutWithoutResize (package:flutter/src/rendering/object.dart:2771:7)
#146    PipelineOwner.flushLayout (package:flutter/src/rendering/object.dart:1174:18)
#147    PipelineOwner.flushLayout (package:flutter/src/rendering/object.dart:1187:15)
#148    RendererBinding.drawFrame (package:flutter/src/rendering/binding.dart:692:23)
#149    WidgetsBinding.drawFrame (package:flutter/src/widgets/binding.dart:1573:13)
#150    RendererBinding._handlePersistentFrameCallback (package:flutter/src/rendering/binding.dart:558:5)
#151    SchedulerBinding._invokeFrameCallback (package:flutter/src/scheduler/binding.dart:1430:15)
#152    SchedulerBinding.handleDrawFrame (package:flutter/src/scheduler/binding.dart:1345:9)
#153    SchedulerBinding._handleDrawFrame (package:flutter/src/scheduler/binding.dart:1198:5)
#154    _invoke (dart:ui/hooks.dart:441:13)
#155    PlatformDispatcher._drawFrame (dart:ui/platform_dispatcher.dart:450:5)
#156    _drawFrame (dart:ui/hooks.dart:413:31)


oxy_box.dart:3921:14)
#157    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#158    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#159    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#160    _RenderTheaterMixin.layoutChild (package:flutter/src/widgets/overlay.dart:1124:13)
#161    _RenderTheater.performLayout (package:flutter/src/widgets/overlay.dart:1482:9)
#162    RenderObject._layoutWithoutResize (package:flutter/src/rendering/object.dart:2771:7)
#163    PipelineOwner.flushLayout (package:flutter/src/rendering/object.dart:1174:18)
#164    PipelineOwner.flushLayout (package:flutter/src/rendering/object.dart:1187:15)
#165    RendererBinding.drawFrame (package:flutter/src/rendering/binding.dart:692:23)
#166    WidgetsBinding.drawFrame (package:flutter/src/widgets/binding.dart:1573:13)
#167    RendererBinding._handlePersistentFrameCallback (package:flutter/src/rendering/binding.dart:558:5)
#168    SchedulerBinding._invokeFrameCallback (package:flutter/src/scheduler/binding.dart:1430:15)
#169    SchedulerBinding.handleDrawFrame (package:flutter/src/scheduler/binding.dart:1345:9)
#170    SchedulerBinding._handleDrawFrame (package:flutter/src/scheduler/binding.dart:1198:5)
#171    _invoke (dart:ui/hooks.dart:441:13)
#172    PlatformDispatcher._drawFrame (dart:ui/platform_dispatcher.dart:450:5)
#173    _drawFrame (dart:ui/hooks.dart:413:31)


=== 2026-09-05T13:45:55.022526 ===
Error: ListTile background color or ink splashes may be invisible.
The ListTile is wrapped in a ColoredBox that has a background color. Because ListTile paints its background and ink splashes on the nearest Material ancestor, this ColoredBox will hide those effects.
To fix this, wrap the ListTile in its own Material widget, or remove the background color from the intermediate ColoredBox.
StackTrace:
#0      main.<anonymous closure> (package:shelf/main.dart:19:73)
#1      FlutterError.reportError (package:flutter/src/foundation/assertions.dart:1193:14)
#2      ListTile._debugCheckBackgroundIsHidden.<anonymous closure> (package:flutter/src/material/list_tile.dart:1151:22)
#3      ListTile._debugCheckBackgroundIsHidden (package:flutter/src/material/list_tile.dart:1177:6)
#4      ListTile.build (package:flutter/src/material/list_tile.dart:833:14)
#5      StatelessElement.build (package:flutter/src/widgets/framework.dart:5902:49)
#6      ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5830:15)
#7      Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#8      StatelessElement.update (package:flutter/src/widgets/framework.dart:5908:5)
#9      Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#10     SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#11     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#12     SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#13     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#14     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#15     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#16     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#17     StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
#18     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#19     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#20     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#21     ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#22     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#23     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#24     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#25     ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#26     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#27     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#28     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#29     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#30     StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
#31     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#32     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#33     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#34     StatelessElement.update (package:flutter/src/widgets/framework.dart:5908:5)
#35     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#36     SliverMultiBoxAdaptorElement.updateChild (package:flutter/src/widgets/sliver.dart:1092:37)
#37     SliverMultiBoxAdaptorElement.performRebuild.processElement (package:flutter/src/widgets/sliver.dart:985:35)
#38     Iterable.forEach (dart:core/iterable.dart:366:35)
#39     SliverMultiBoxAdaptorElement.performRebuild (package:flutter/src/widgets/sliver.dart:1038:24)
#40     SliverMultiBoxAdaptorElement.update (package:flutter/src/widgets/sliver.dart:961:7)
#41     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#42     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#43     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#44     ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#45     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#46     SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#47     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#48     Element.updateChildren (package:flutter/src/widgets/framework.dart:4204:32)
#49     MultiChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7308:17)
#50     _ViewportElement.update (package:flutter/src/widgets/viewport.dart:293:11)
#51     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#52     SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#53     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#54     SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#55     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#56     SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#57     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#58     SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#59     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#60     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#61     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#62     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#63     StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
#64     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#65     SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#66     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#67     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#68     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#69     ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#70     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#71     SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#72     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#73     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#74     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#75     ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#76     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#77     SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#78     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#79     SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#80     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#81     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#82     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#83     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#84     StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
#85     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#86     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#87     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#88     StatelessElement.update (package:flutter/src/widgets/framework.dart:5908:5)
#89     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#90     SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#91     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#92     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#93     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#94     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#95     StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
#96     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#97     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#98     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#99     ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#100    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#101    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#102    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#103    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#104    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
#105    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#106    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#107    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#108    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#109    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
#110    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#111    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#112    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#113    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#114    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#115    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#116    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#117    StatelessElement.update (package:flutter/src/widgets/framework.dart:5908:5)
#118    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#119    SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#120    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#121    SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#122    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#123    SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#124    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#125    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#126    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#127    StatelessElement.update (package:flutter/src/widgets/framework.dart:5908:5)
#128    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#129    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#130    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#131    StatelessElement.update (package:flutter/src/widgets/framework.dart:5908:5)
#132    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#133    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#134    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#135    StatelessElement.update (package:flutter/src/widgets/framework.dart:5908:5)
#136    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#137    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#138    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#139    StatelessElement.update (package:flutter/src/widgets/framework.dart:5908:5)
#140    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#141    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#142    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#143    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#144    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#145    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#146    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#147    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#148    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#149    Element.updateChildren (package:flutter/src/widgets/framework.dart:4204:32)
#150    MultiChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7308:17)
#151    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#152    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#153    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#154    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#155    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#156    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#157    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#158    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#159    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
#160    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#161    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#162    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#163    StatelessElement.update (package:flutter/src/widgets/framework.dart:5908:5)
#164    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#165    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#166    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#167    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#168    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#169    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#170    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#171    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#172    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
#173    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#174    SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#175    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#176    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#177    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#178    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#179    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#180    SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#181    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#182    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#183    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#184    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#185    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
#186    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#187    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#188    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#189    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#190    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
#191    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#192    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#193    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#194    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#195    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#196    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#197    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#198    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#199    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#200    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#201    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#202    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#203    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#204    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#205    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#206    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#207    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
#208    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#209    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#210    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#211    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#212    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#213    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#214    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#215    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#216    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
#217    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#218    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#219    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#220    StatelessElement.update (package:flutter/src/widgets/framework.dart:5908:5)
#221    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#222    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#223    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#224    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#225    BuildScope._tryRebuild (package:flutter/src/widgets/framework.dart:2763:15)
#226    BuildScope._flushDirtyElements (package:flutter/src/widgets/framework.dart:2820:11)
#227    BuildOwner.buildScope (package:flutter/src/widgets/framework.dart:3124:18)
#228    WidgetsBinding.drawFrame (package:flutter/src/widgets/binding.dart:1571:21)
#229    RendererBinding._handlePersistentFrameCallback (package:flutter/src/rendering/binding.dart:558:5)
#230    SchedulerBinding._invokeFrameCallback (package:flutter/src/scheduler/binding.dart:1430:15)
#231    SchedulerBinding.handleDrawFrame (package:flutter/src/scheduler/binding.dart:1345:9)
#232    SchedulerBinding._handleDrawFrame (package:flutter/src/scheduler/binding.dart:1198:5)
#233    _invoke (dart:ui/hooks.dart:441:13)
#234    PlatformDispatcher._drawFrame (dart:ui/platform_dispatcher.dart:450:5)
#235    _drawFrame (dart:ui/hooks.dart:413:31)


/widgets/framework.dart:5542:7)
#236    BuildScope._tryRebuild (package:flutter/src/widgets/framework.dart:2763:15)
#237    BuildScope._flushDirtyElements (package:flutter/src/widgets/framework.dart:2820:11)
#238    BuildOwner.buildScope (package:flutter/src/widgets/framework.dart:3124:18)
#239    WidgetsBinding.drawFrame (package:flutter/src/widgets/binding.dart:1571:21)
#240    RendererBinding._handlePersistentFrameCallback (package:flutter/src/rendering/binding.dart:558:5)
#241    SchedulerBinding._invokeFrameCallback (package:flutter/src/scheduler/binding.dart:1430:15)
#242    SchedulerBinding.handleDrawFrame (package:flutter/src/scheduler/binding.dart:1345:9)
#243    SchedulerBinding._handleDrawFrame (package:flutter/src/scheduler/binding.dart:1198:5)
#244    _invoke (dart:ui/hooks.dart:441:13)
#245    PlatformDispatcher._drawFrame (dart:ui/platform_dispatcher.dart:450:5)
#246    _drawFrame (dart:ui/hooks.dart:413:31)


=== 2026-09-05T13:45:55.768797 ===
Error: ListTile background color or ink splashes may be invisible.
The ListTile is wrapped in a ColoredBox that has a background color. Because ListTile paints its background and ink splashes on the nearest Material ancestor, this ColoredBox will hide those effects.
To fix this, wrap the ListTile in its own Material widget, or remove the background color from the intermediate ColoredBox.
StackTrace:
#0      main.<anonymous closure> (package:shelf/main.dart:19:73)
#1      FlutterError.reportError (package:flutter/src/foundation/assertions.dart:1193:14)
#2      ListTile._debugCheckBackgroundIsHidden.<anonymous closure> (package:flutter/src/material/list_tile.dart:1151:22)
#3      ListTile._debugCheckBackgroundIsHidden (package:flutter/src/material/list_tile.dart:1177:6)
#4      ListTile.build (package:flutter/src/material/list_tile.dart:833:14)
#5      StatelessElement.build (package:flutter/src/widgets/framework.dart:5902:49)
#6      ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5830:15)
#7      Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#8      StatelessElement.update (package:flutter/src/widgets/framework.dart:5908:5)
#9      Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#10     SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#11     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#12     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#13     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#14     StatelessElement.update (package:flutter/src/widgets/framework.dart:5908:5)
#15     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#16     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#17     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#18     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#19     BuildScope._tryRebuild (package:flutter/src/widgets/framework.dart:2763:15)
#20     BuildScope._flushDirtyElements (package:flutter/src/widgets/framework.dart:2820:11)
#21     BuildOwner.buildScope (package:flutter/src/widgets/framework.dart:3124:18)
#22     WidgetsBinding.drawFrame (package:flutter/src/widgets/binding.dart:1571:21)
#23     RendererBinding._handlePersistentFrameCallback (package:flutter/src/rendering/binding.dart:558:5)
#24     SchedulerBinding._invokeFrameCallback (package:flutter/src/scheduler/binding.dart:1430:15)
#25     SchedulerBinding.handleDrawFrame (package:flutter/src/scheduler/binding.dart:1345:9)
#26     SchedulerBinding._handleDrawFrame (package:flutter/src/scheduler/binding.dart:1198:5)
#27     _invoke (dart:ui/hooks.dart:441:13)
#28     PlatformDispatcher._drawFrame (dart:ui/platform_dispatcher.dart:450:5)
#29     _drawFrame (dart:ui/hooks.dart:413:31)


=== 2026-09-05T13:45:56.414575 ===
Error: ListTile background color or ink splashes may be invisible.
The ListTile is wrapped in a ColoredBox that has a background color. Because ListTile paints its background and ink splashes on the nearest Material ancestor, this ColoredBox will hide those effects.
To fix this, wrap the ListTile in its own Material widget, or remove the background color from the intermediate ColoredBox.
StackTrace:
#0      main.<anonymous closure> (package:shelf/main.dart:19:73)
#1      FlutterError.reportError (package:flutter/src/foundation/assertions.dart:1193:14)
#2      ListTile._debugCheckBackgroundIsHidden.<anonymous closure> (package:flutter/src/material/list_tile.dart:1151:22)
#3      ListTile._debugCheckBackgroundIsHidden (package:flutter/src/material/list_tile.dart:1177:6)
#4      ListTile.build (package:flutter/src/material/list_tile.dart:833:14)
#5      StatelessElement.build (package:flutter/src/widgets/framework.dart:5902:49)
#6      ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5830:15)
#7      Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#8      StatelessElement.update (package:flutter/src/widgets/framework.dart:5908:5)
#9      Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#10     SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#11     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#12     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#13     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#14     StatelessElement.update (package:flutter/src/widgets/framework.dart:5908:5)
#15     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#16     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#17     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#18     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#19     BuildScope._tryRebuild (package:flutter/src/widgets/framework.dart:2763:15)
#20     BuildScope._flushDirtyElements (package:flutter/src/widgets/framework.dart:2820:11)
#21     BuildOwner.buildScope (package:flutter/src/widgets/framework.dart:3124:18)
#22     WidgetsBinding.drawFrame (package:flutter/src/widgets/binding.dart:1571:21)
#23     RendererBinding._handlePersistentFrameCallback (package:flutter/src/rendering/binding.dart:558:5)
#24     SchedulerBinding._invokeFrameCallback (package:flutter/src/scheduler/binding.dart:1430:15)
#25     SchedulerBinding.handleDrawFrame (package:flutter/src/scheduler/binding.dart:1345:9)
#26     SchedulerBinding._handleDrawFrame (package:flutter/src/scheduler/binding.dart:1198:5)
#27     _invoke (dart:ui/hooks.dart:441:13)
#28     PlatformDispatcher._drawFrame (dart:ui/platform_dispatcher.dart:450:5)
#29     _drawFrame (dart:ui/hooks.dart:413:31)


=== 2026-09-05T13:48:06.849966 ===
Error: ListTile background color or ink splashes may be invisible.
The ListTile is wrapped in a ColoredBox that has a background color. Because ListTile paints its background and ink splashes on the nearest Material ancestor, this ColoredBox will hide those effects.
To fix this, wrap the ListTile in its own Material widget, or remove the background color from the intermediate ColoredBox.
StackTrace:
#0      main.<anonymous closure> (package:shelf/main.dart:19:73)
#1      FlutterError.reportError (package:flutter/src/foundation/assertions.dart:1193:14)
#2      ListTile._debugCheckBackgroundIsHidden.<anonymous closure> (package:flutter/src/material/list_tile.dart:1151:22)
#3      ListTile._debugCheckBackgroundIsHidden (package:flutter/src/material/list_tile.dart:1177:6)
#4      ListTile.build (package:flutter/src/material/list_tile.dart:833:14)
#5      StatelessElement.build (package:flutter/src/widgets/framework.dart:5902:49)
#6      ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5830:15)
#7      Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#8      ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
#9      ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
#10     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
#11     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
#12     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
#13     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
#14     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
#15     SingleChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:7128:14)
#16     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
#17     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
#18     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#19     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#20     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#21     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
#22     StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
#23     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
#24     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
#25     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
#26     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#27     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#28     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
#29     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
#30     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
#31     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
#32     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#33     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#34     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
#35     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
#36     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
#37     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
#38     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#39     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#40     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#41     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
#42     StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5986:11)
#43     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
#44     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
#45     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
#46     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#47     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#48     ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:5812:5)
#49     ComponentElement.mount (package:flutter/src/widgets/framework.dart:5806:5)
#50     Element.inflateWidget (package:flutter/src/widgets/framework.dart:4600:20)
#51     Element.updateChild (package:flutter/src/widgets/framework.dart:4072:18)
#52     SliverMultiBoxAdaptorElement.updateChild (package:flutter/src/widgets/sliver.dart:1092:37)
#53     SliverMultiBoxAdaptorElement.createChild.<anonymous closure> (package:flutter/src/widgets/sliver.dart:1077:20)
#54     BuildOwner.buildScope (package:flutter/src/widgets/framework.dart:3114:19)
#55     SliverMultiBoxAdaptorElement.createChild (package:flutter/src/widgets/sliver.dart:1067:12)
#56     RenderSliverMultiBoxAdaptor._createOrObtainChild.<anonymous closure> (package:flutter/src/rendering/sliver_multi_box_adaptor.dart:368:23)
#57     RenderObject.invokeLayoutCallback.<anonymous closure> (package:flutter/src/rendering/object.dart:3042:17)
#58     PipelineOwner._enableMutationsToDirtySubtrees (package:flutter/src/rendering/object.dart:1223:15)
#59     RenderObject.invokeLayoutCallback (package:flutter/src/rendering/object.dart:3041:14)
#60     RenderSliverMultiBoxAdaptor._createOrObtainChild (package:flutter/src/rendering/sliver_multi_box_adaptor.dart:357:5)
#61     RenderSliverMultiBoxAdaptor.insertAndLayoutChild (package:flutter/src/rendering/sliver_multi_box_adaptor.dart:517:5)
#62     RenderSliverList.performLayout.advance (package:flutter/src/rendering/sliver_list.dart:238:19)
#63     RenderSliverList.performLayout (package:flutter/src/rendering/sliver_list.dart:278:12)
#64     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#65     RenderSliverEdgeInsetsPadding.performLayout (package:flutter/src/rendering/sliver_padding.dart:133:12)
#66     RenderSliverPadding.performLayout (package:flutter/src/rendering/sliver_padding.dart:368:11)
#67     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#68     RenderViewportBase.layoutChildSequence (package:flutter/src/rendering/viewport.dart:821:13)
#69     RenderViewport._attemptLayout (package:flutter/src/rendering/viewport.dart:1831:12)
#70     RenderViewport.performLayout (package:flutter/src/rendering/viewport.dart:1724:20)
#71     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#72     RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#73     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#74     RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#75     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#76     RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#77     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#78     RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#79     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#80     RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#81     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#82     RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#83     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#84     RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#85     RenderCustomPaint.performLayout (package:flutter/src/rendering/custom_paint.dart:574:11)
#86     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#87     RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#88     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#89     RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#90     _RenderCustomClip.performLayout (package:flutter/src/rendering/proxy_box.dart:1549:11)
#91     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#92     RenderPadding.performLayout (package:flutter/src/rendering/shifted_box.dart:262:12)
#93     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#94     RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#95     RenderCustomPaint.performLayout (package:flutter/src/rendering/custom_paint.dart:574:11)
#96     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#97     RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#98     RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#99     MultiChildLayoutDelegate.layoutChild (package:flutter/src/rendering/custom_layout.dart:180:12)
#100    _ScaffoldLayout.performLayout (package:flutter/src/material/scaffold.dart:1113:7)
#101    MultiChildLayoutDelegate._callPerformLayout (package:flutter/src/rendering/custom_layout.dart:246:7)
#102    RenderCustomMultiChildLayoutBox.performLayout (package:flutter/src/rendering/custom_layout.dart:417:14)
#103    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#104    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#105    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#106    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#107    _RenderCustomClip.performLayout (package:flutter/src/rendering/proxy_box.dart:1549:11)
#108    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#109    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#110    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#111    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#112    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#113    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#114    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#115    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#116    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#117    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#118    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#119    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#120    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#121    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#122    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#123    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#124    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#125    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#126    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#127    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#128    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#129    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#130    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#131    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#132    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#133    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#134    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#135    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#136    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#137    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#138    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#139    RenderOffstage.performLayout (package:flutter/src/rendering/proxy_box.dart:3921:14)
#140    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#141    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#142    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#143    _RenderTheaterMixin.layoutChild (package:flutter/src/widgets/overlay.dart:1124:13)
#144    _RenderTheater.performLayout (package:flutter/src/widgets/overlay.dart:1482:9)
#145    RenderObject._layoutWithoutResize (package:flutter/src/rendering/object.dart:2771:7)
#146    PipelineOwner.flushLayout (package:flutter/src/rendering/object.dart:1174:18)
#147    PipelineOwner.flushLayout (package:flutter/src/rendering/object.dart:1187:15)
#148    RendererBinding.drawFrame (package:flutter/src/rendering/binding.dart:692:23)
#149    WidgetsBinding.drawFrame (package:flutter/src/widgets/binding.dart:1573:13)
#150    RendererBinding._handlePersistentFrameCallback (package:flutter/src/rendering/binding.dart:558:5)
#151    SchedulerBinding._invokeFrameCallback (package:flutter/src/scheduler/binding.dart:1430:15)
#152    SchedulerBinding.handleDrawFrame (package:flutter/src/scheduler/binding.dart:1345:9)
#153    SchedulerBinding._handleDrawFrame (package:flutter/src/scheduler/binding.dart:1198:5)
#154    _invoke (dart:ui/hooks.dart:441:13)
#155    PlatformDispatcher._drawFrame (dart:ui/platform_dispatcher.dart:450:5)
#156    _drawFrame (dart:ui/hooks.dart:413:31)


oxy_box.dart:3921:14)
#157    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#158    RenderProxyBoxMixin.performLayout (package:flutter/src/rendering/proxy_box.dart:118:18)
#159    RenderObject.layout (package:flutter/src/rendering/object.dart:2923:7)
#160    _RenderTheaterMixin.layoutChild (package:flutter/src/widgets/overlay.dart:1124:13)
#161    _RenderTheater.performLayout (package:flutter/src/widgets/overlay.dart:1482:9)
#162    RenderObject._layoutWithoutResize (package:flutter/src/rendering/object.dart:2771:7)
#163    PipelineOwner.flushLayout (package:flutter/src/rendering/object.dart:1174:18)
#164    PipelineOwner.flushLayout (package:flutter/src/rendering/object.dart:1187:15)
#165    RendererBinding.drawFrame (package:flutter/src/rendering/binding.dart:692:23)
#166    WidgetsBinding.drawFrame (package:flutter/src/widgets/binding.dart:1573:13)
#167    RendererBinding._handlePersistentFrameCallback (package:flutter/src/rendering/binding.dart:558:5)
#168    SchedulerBinding._invokeFrameCallback (package:flutter/src/scheduler/binding.dart:1430:15)
#169    SchedulerBinding.handleDrawFrame (package:flutter/src/scheduler/binding.dart:1345:9)
#170    SchedulerBinding._handleDrawFrame (package:flutter/src/scheduler/binding.dart:1198:5)
#171    _invoke (dart:ui/hooks.dart:441:13)
#172    PlatformDispatcher._drawFrame (dart:ui/platform_dispatcher.dart:450:5)
#173    _drawFrame (dart:ui/hooks.dart:413:31)


=== 2026-09-05T13:48:06.911848 ===
Error: ListTile background color or ink splashes may be invisible.
The ListTile is wrapped in a ColoredBox that has a background color. Because ListTile paints its background and ink splashes on the nearest Material ancestor, this ColoredBox will hide those effects.
To fix this, wrap the ListTile in its own Material widget, or remove the background color from the intermediate ColoredBox.
StackTrace:
#0      main.<anonymous closure> (package:shelf/main.dart:19:73)
#1      FlutterError.reportError (package:flutter/src/foundation/assertions.dart:1193:14)
#2      ListTile._debugCheckBackgroundIsHidden.<anonymous closure> (package:flutter/src/material/list_tile.dart:1151:22)
#3      ListTile._debugCheckBackgroundIsHidden (package:flutter/src/material/list_tile.dart:1177:6)
#4      ListTile.build (package:flutter/src/material/list_tile.dart:833:14)
#5      StatelessElement.build (package:flutter/src/widgets/framework.dart:5902:49)
#6      ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5830:15)
#7      Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#8      StatelessElement.update (package:flutter/src/widgets/framework.dart:5908:5)
#9      Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#10     SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#11     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#12     SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#13     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#14     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#15     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#16     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#17     StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
#18     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#19     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#20     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#21     ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#22     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#23     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#24     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#25     ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#26     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#27     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#28     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#29     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#30     StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
#31     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#32     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#33     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#34     StatelessElement.update (package:flutter/src/widgets/framework.dart:5908:5)
#35     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#36     SliverMultiBoxAdaptorElement.updateChild (package:flutter/src/widgets/sliver.dart:1092:37)
#37     SliverMultiBoxAdaptorElement.performRebuild.processElement (package:flutter/src/widgets/sliver.dart:985:35)
#38     Iterable.forEach (dart:core/iterable.dart:366:35)
#39     SliverMultiBoxAdaptorElement.performRebuild (package:flutter/src/widgets/sliver.dart:1038:24)
#40     SliverMultiBoxAdaptorElement.update (package:flutter/src/widgets/sliver.dart:961:7)
#41     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#42     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#43     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#44     ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#45     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#46     SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#47     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#48     Element.updateChildren (package:flutter/src/widgets/framework.dart:4204:32)
#49     MultiChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7308:17)
#50     _ViewportElement.update (package:flutter/src/widgets/viewport.dart:293:11)
#51     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#52     SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#53     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#54     SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#55     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#56     SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#57     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#58     SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#59     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#60     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#61     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#62     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#63     StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
#64     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#65     SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#66     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#67     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#68     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#69     ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#70     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#71     SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#72     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#73     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#74     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#75     ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#76     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#77     SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#78     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#79     SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#80     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#81     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#82     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#83     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#84     StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
#85     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#86     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#87     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#88     StatelessElement.update (package:flutter/src/widgets/framework.dart:5908:5)
#89     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#90     SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#91     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#92     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#93     StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#94     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#95     StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
#96     Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#97     ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#98     Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#99     ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#100    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#101    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#102    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#103    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#104    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
#105    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#106    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#107    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#108    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#109    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
#110    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#111    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#112    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#113    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#114    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#115    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#116    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#117    StatelessElement.update (package:flutter/src/widgets/framework.dart:5908:5)
#118    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#119    SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#120    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#121    SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#122    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#123    SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#124    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#125    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#126    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#127    StatelessElement.update (package:flutter/src/widgets/framework.dart:5908:5)
#128    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#129    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#130    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#131    StatelessElement.update (package:flutter/src/widgets/framework.dart:5908:5)
#132    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#133    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#134    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#135    StatelessElement.update (package:flutter/src/widgets/framework.dart:5908:5)
#136    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#137    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#138    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#139    StatelessElement.update (package:flutter/src/widgets/framework.dart:5908:5)
#140    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#141    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#142    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#143    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#144    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#145    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#146    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#147    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#148    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#149    Element.updateChildren (package:flutter/src/widgets/framework.dart:4204:32)
#150    MultiChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7308:17)
#151    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#152    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#153    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#154    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#155    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#156    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#157    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#158    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#159    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
#160    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#161    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#162    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#163    StatelessElement.update (package:flutter/src/widgets/framework.dart:5908:5)
#164    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#165    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#166    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#167    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#168    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#169    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#170    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#171    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#172    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
#173    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#174    SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#175    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#176    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#177    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#178    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#179    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#180    SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:7135:14)
#181    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#182    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#183    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#184    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#185    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
#186    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#187    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#188    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#189    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#190    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
#191    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#192    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#193    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#194    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#195    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#196    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#197    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#198    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#199    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#200    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#201    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#202    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#203    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#204    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#205    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#206    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#207    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
#208    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#209    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#210    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#211    ProxyElement.update (package:flutter/src/widgets/framework.dart:6162:5)
#212    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#213    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#214    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#215    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#216    StatefulElement.update (package:flutter/src/widgets/framework.dart:6020:5)
#217    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#218    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#219    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#220    StatelessElement.update (package:flutter/src/widgets/framework.dart:5908:5)
#221    Element.updateChild (package:flutter/src/widgets/framework.dart:4050:15)
#222    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:5854:16)
#223    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5995:11)
#224    Element.rebuild (package:flutter/src/widgets/framework.dart:5542:7)
#225    BuildScope._tryRebuild (package:flutter/src/widgets/framework.dart:2763:15)
#226    BuildScope._flushDirtyElements (package:flutter/src/widgets/framework.dart:2820:11)
#227    BuildOwner.buildScope (package:flutter/src/widgets/framework.dart:3124:18)
#228    WidgetsBinding.drawFrame (package:flutter/src/widgets/binding.dart:1571:21)
#229    RendererBinding._handlePersistentFrameCallback (package:flutter/src/rendering/binding.dart:558:5)
#230    SchedulerBinding._invokeFrameCallback (package:flutter/src/scheduler/binding.dart:1430:15)
#231    SchedulerBinding.handleDrawFrame (package:flutter/src/scheduler/binding.dart:1345:9)
#232    SchedulerBinding._handleDrawFrame (package:flutter/src/scheduler/binding.dart:1198:5)
#233    _invoke (dart:ui/hooks.dart:441:13)
#234    PlatformDispatcher._drawFrame (dart:ui/platform_dispatcher.dart:450:5)
#235    _drawFrame (dart:ui/hooks.dart:413:31)


/widgets/framework.dart:5542:7)
#236    BuildScope._tryRebuild (package:flutter/src/widgets/framework.dart:2763:15)
#237    BuildScope._flushDirtyElements (package:flutter/src/widgets/framework.dart:2820:11)
#238    BuildOwner.buildScope (package:flutter/src/widgets/framework.dart:3124:18)
#239    WidgetsBinding.drawFrame (package:flutter/src/widgets/binding.dart:1571:21)
#240    RendererBinding._handlePersistentFrameCallback (package:flutter/src/rendering/binding.dart:558:5)
#241    SchedulerBinding._invokeFrameCallback (package:flutter/src/scheduler/binding.dart:1430:15)
#242    SchedulerBinding.handleDrawFrame (package:flutter/src/scheduler/binding.dart:1345:9)
#243    SchedulerBinding._handleDrawFrame (package:flutter/src/scheduler/binding.dart:1198:5)
#244    _invoke (dart:ui/hooks.dart:441:13)
#245    PlatformDispatcher._drawFrame (dart:ui/platform_dispatcher.dart:450:5)
#246    _drawFrame (dart:ui/hooks.dart:413:31)


=== 2026-09-05T13:48:09.152842 ===
Error: A RenderFlex overflowed by 23 pixels on the right.
StackTrace:
#0      main.<anonymous closure> (package:shelf/main.dart:19:73)
#1      FlutterError.reportError (package:flutter/src/foundation/assertions.dart:1193:14)
#2      DebugOverflowIndicatorMixin._reportOverflow (package:flutter/src/rendering/debug_overflow_indicator.dart:259:18)
#3      DebugOverflowIndicatorMixin.paintOverflowIndicator (package:flutter/src/rendering/debug_overflow_indicator.dart:329:7)
#4      RenderFlex.paint.<anonymous closure> (package:flutter/src/rendering/flex.dart:1449:7)
#5      RenderFlex.paint (package:flutter/src/rendering/flex.dart:1457:6)
#6      RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#7      PaintingContext.paintChild (package:flutter/src/rendering/object.dart:265:13)
#8      RenderShiftedBox.paint (package:flutter/src/rendering/shifted_box.dart:98:15)
#9      RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#10     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:265:13)
#11     RenderShiftedBox.paint (package:flutter/src/rendering/shifted_box.dart:98:15)
#12     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#13     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:265:13)
#14     RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:143:13)
#15     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#16     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:265:13)
#17     RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:143:13)
#18     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#19     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:265:13)
#20     RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:143:13)
#21     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#22     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:265:13)
#23     RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:143:13)
#24     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#25     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:265:13)
#26     RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:143:13)
#27     _RenderInkFeatures.paint (package:flutter/src/material/material.dart:634:11)
#28     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#29     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:265:13)
#30     RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:143:13)
#31     RenderCustomPaint.paint (package:flutter/src/rendering/custom_paint.dart:644:11)
#32     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#33     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:265:13)
#34     RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:143:13)
#35     RenderPhysicalShape.paint.<anonymous closure> (package:flutter/src/rendering/proxy_box.dart:2357:15)
#36     PaintingContext.pushClipPath (package:flutter/src/rendering/object.dart:727:14)
#37     RenderPhysicalShape.paint (package:flutter/src/rendering/proxy_box.dart:2344:21)
#38     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#39     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:265:13)
#40     RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:143:13)
#41     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#42     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:265:13)
#43     RenderShiftedBox.paint (package:flutter/src/rendering/shifted_box.dart:98:15)
#44     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#45     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:265:13)
#46     RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:143:13)
#47     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#48     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:265:13)
#49     RenderBoxContainerDefaultsMixin.defaultPaint (package:flutter/src/rendering/box.dart:3390:15)
#50     RenderFlex.paint (package:flutter/src/rendering/flex.dart:1402:7)
#51     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#52     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:265:13)
#53     RenderBoxContainerDefaultsMixin.defaultPaint (package:flutter/src/rendering/box.dart:3390:15)
#54     RenderStack.paintStack (package:flutter/src/rendering/stack.dart:713:5)
#55     RenderStack.paint (package:flutter/src/rendering/stack.dart:729:7)
#56     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#57     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:265:13)
#58     RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:143:13)
#59     RenderCustomPaint.paint (package:flutter/src/rendering/custom_paint.dart:644:11)
#60     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#61     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:265:13)
#62     _RenderColoredBox.paint (package:flutter/src/widgets/basic.dart:8472:15)
#63     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#64     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:265:13)
#65     RenderBoxContainerDefaultsMixin.defaultPaint (package:flutter/src/rendering/box.dart:3390:15)
#66     RenderCustomMultiChildLayoutBox.paint (package:flutter/src/rendering/custom_layout.dart:422:5)
#67     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#68     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:265:13)
#69     RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:143:13)
#70     _RenderInkFeatures.paint (package:flutter/src/material/material.dart:634:11)
#71     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#72     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:265:13)
#73     RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:143:13)
#74     RenderPhysicalModel.paint.<anonymous closure> (package:flutter/src/rendering/proxy_box.dart:2252:15)
#75     PaintingContext.pushClipRRect (package:flutter/src/rendering/object.dart:626:14)
#76     RenderPhysicalModel.paint (package:flutter/src/rendering/proxy_box.dart:2239:21)
#77     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#78     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:265:13)
#79     RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:143:13)
#80     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#81     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:265:13)
#82     RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:143:13)
#83     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#84     PaintingContext._repaintCompositedChild (package:flutter/src/rendering/object.dart:180:11)
#85     PaintingContext.repaintCompositedChild (package:flutter/src/rendering/object.dart:125:5)
#86     PaintingContext._compositeChild (package:flutter/src/rendering/object.dart:276:7)
#87     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:257:7)
#88     RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:143:13)
#89     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#90     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:265:13)
#91     RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:143:13)
#92     RenderFractionalTranslation.paint (package:flutter/src/rendering/proxy_box.dart:3138:13)
#93     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#94     PaintingContext.paintChild (package:flutter/src/rendering/object.dart:265:13)
#95     RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:143:13)
#96     RenderAnimatedOpacityMixin.paint (package:flutter/src/rendering/proxy_box.dart:1079:11)
#97     RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#98     PaintingContext._repaintCompositedChild (package:flutter/src/rendering/object.dart:180:11)
#99     PaintingContext.repaintCompositedChild (package:flutter/src/rendering/object.dart:125:5)
#100    PaintingContext._compositeChild (package:flutter/src/rendering/object.dart:276:7)
#101    PaintingContext.paintChild (package:flutter/src/rendering/object.dart:257:7)
#102    RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:143:13)
#103    RenderFractionalTranslation.paint (package:flutter/src/rendering/proxy_box.dart:3138:13)
#104    RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#105    PaintingContext.paintChild (package:flutter/src/rendering/object.dart:265:13)
#106    RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:143:13)
#107    RenderAnimatedOpacityMixin.paint (package:flutter/src/rendering/proxy_box.dart:1079:11)
#108    RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#109    PaintingContext._repaintCompositedChild (package:flutter/src/rendering/object.dart:180:11)
#110    PaintingContext.repaintCompositedChild (package:flutter/src/rendering/object.dart:125:5)
#111    PaintingContext._compositeChild (package:flutter/src/rendering/object.dart:276:7)
#112    PaintingContext.paintChild (package:flutter/src/rendering/object.dart:257:7)
#113    _RenderColoredBox.paint (package:flutter/src/widgets/basic.dart:8472:15)
#114    RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#115    PaintingContext.paintChild (package:flutter/src/rendering/object.dart:265:13)
#116    RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:143:13)
#117    RenderFractionalTranslation.paint (package:flutter/src/rendering/proxy_box.dart:3138:13)
#118    RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#119    PaintingContext.paintChild (package:flutter/src/rendering/object.dart:265:13)
#120    RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:143:13)
#121    RenderAnimatedOpacityMixin.paint (package:flutter/src/rendering/proxy_box.dart:1079:11)
#122    RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#123    PaintingContext._repaintCompositedChild (package:flutter/src/rendering/object.dart:180:11)
#124    PaintingContext.repaintCompositedChild (package:flutter/src/rendering/object.dart:125:5)
#125    PaintingContext._compositeChild (package:flutter/src/rendering/object.dart:276:7)
#126    PaintingContext.paintChild (package:flutter/src/rendering/object.dart:257:7)
#127    RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:143:13)
#128    RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#129    PaintingContext.paintChild (package:flutter/src/rendering/object.dart:265:13)
#130    RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:143:13)
#131    RenderFractionalTranslation.paint (package:flutter/src/rendering/proxy_box.dart:3138:13)
#132    RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#133    PaintingContext.paintChild (package:flutter/src/rendering/object.dart:265:13)
#134    RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:143:13)
#135    RenderAnimatedOpacityMixin.paint (package:flutter/src/rendering/proxy_box.dart:1079:11)
#136    RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#137    PaintingContext._repaintCompositedChild (package:flutter/src/rendering/object.dart:180:11)
#138    PaintingContext.repaintCompositedChild (package:flutter/src/rendering/object.dart:125:5)
#139    PaintingContext._compositeChild (package:flutter/src/rendering/object.dart:276:7)
#140    PaintingContext.paintChild (package:flutter/src/rendering/object.dart:257:7)
#141    RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:143:13)
#142    RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#143    PaintingContext._repaintCompositedChild (package:flutter/src/rendering/object.dart:180:11)
#144    PaintingContext.repaintCompositedChild (package:flutter/src/rendering/object.dart:125:5)
#145    PaintingContext._compositeChild (package:flutter/src/rendering/object.dart:276:7)
#146    PaintingContext.paintChild (package:flutter/src/rendering/object.dart:257:7)
#147    RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:143:13)
#148    RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#149    PaintingContext.paintChild (package:flutter/src/rendering/object.dart:265:13)
#150    RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:143:13)
#151    RenderOffstage.paint (package:flutter/src/rendering/proxy_box.dart:3943:11)
#152    RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#153    PaintingContext.paintChild (package:flutter/src/rendering/object.dart:265:13)
#154    RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:143:13)
#155    RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#156    PaintingContext.paintChild (package:flutter/src/rendering/object.dart:265:13)
#157    _RenderTheaterMixin.paint (package:flutter/src/widgets/overlay.dart:1159:15)
#158    _RenderTheater.paint (package:flutter/src/widgets/overlay.dart:1543:13)
#159    RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#160    PaintingContext.paintChild (package:flutter/src/rendering/object.dart:265:13)
#161    RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:143:13)
#162    RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#163    PaintingContext.paintChild (package:flutter/src/rendering/object.dart:265:13)
#164    RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:143:13)
#165    RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#166    PaintingContext.paintChild (package:flutter/src/rendering/object.dart:265:13)
#167    RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:143:13)
#168    RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#169    PaintingContext.paintChild (package:flutter/src/rendering/object.dart:265:13)
#170    RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:143:13)
#171    RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#172    PaintingContext.paintChild (package:flutter/src/rendering/object.dart:265:13)
#173    RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:143:13)
#174    RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#175    PaintingContext.paintChild (package:flutter/src/rendering/object.dart:265:13)
#176    RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:143:13)
#177    RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#178    PaintingContext.paintChild (package:flutter/src/rendering/object.dart:265:13)
#179    RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:143:13)
#180    RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#181    PaintingContext.paintChild (package:flutter/src/rendering/object.dart:265:13)
#182    RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:143:13)
#183    RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#184    PaintingContext.paintChild (package:flutter/src/rendering/object.dart:265:13)
#185    RenderProxyBoxMixin.paint (package:flutter/src/rendering/proxy_box.dart:143:13)
#186    RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#187    PaintingContext.paintChild (package:flutter/src/rendering/object.dart:265:13)
#188    RenderView.paint (package:flutter/src/rendering/view.dart:320:15)
#189    RenderObject._paintWithContext (package:flutter/src/rendering/object.dart:3580:7)
#190    PaintingContext._repaintCompositedChild (package:flutter/src/rendering/object.dart:180:11)
#191    PaintingContext.repaintCompositedChild (package:flutter/src/rendering/object.dart:125:5)
#192    PipelineOwner.flushPaint (package:flutter/src/rendering/object.dart:1325:31)
#193    PipelineOwner.flushPaint (package:flutter/src/rendering/object.dart:1335:15)
#194    RendererBinding.drawFrame (package:flutter/src/rendering/binding.dart:694:23)
#195    WidgetsBinding.drawFrame (package:flutter/src/widgets/binding.dart:1573:13)
#196    RendererBinding._handlePersistentFrameCallback (package:flutter/src/rendering/binding.dart:558:5)
#197    SchedulerBinding._invokeFrameCallback (package:flutter/src/scheduler/binding.dart:1430:15)
#198    SchedulerBinding.handleDrawFrame (package:flutter/src/scheduler/binding.dart:1345:9)
#199    SchedulerBinding._handleDrawFrame (package:flutter/src/scheduler/binding.dart:1198:5)
#200    _invoke (dart:ui/hooks.dart:441:13)
#201    PlatformDispatcher._drawFrame (dart:ui/platform_dispatcher.dart:450:5)
#202    _drawFrame (dart:ui/hooks.dart:413:31)



Issues:
Logo and icon: success
but, dark theme doesnt work.(not priority)
member list doesnt work(priority)
and i dont see any invite members section for me as a room owner. this should be at the member list tab