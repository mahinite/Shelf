import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

import 'features/auth/screens/login_screen.dart';
import 'features/home/screens/home_screen.dart';
import 'core/theme/app_theme.dart';
import 'core/services/crash_logger.dart';
import 'core/services/theme_notifier.dart';
import 'core/services/update_service.dart';
import 'core/platform/platform_support.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Windows-only window setup before runApp
  if (PlatformSupport.isWindows) {
    await windowManager.ensureInitialized();
    const windowOptions = WindowOptions(
      title: 'Shelf',
      minimumSize: Size(420, 640),
      size: Size(1100, 760),
      center: true,
      titleBarStyle: TitleBarStyle.normal,
      windowButtonVisibility: true,
      skipTaskbar: false,
    );
    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      final prefs = await SharedPreferences.getInstance();
      final savedWidth = prefs.getDouble('window_width');
      final savedHeight = prefs.getDouble('window_height');
      final savedMaximized = prefs.getBool('window_maximized') ?? false;

      if (savedWidth != null && savedHeight != null) {
        final clampedWidth = savedWidth.clamp(420.0, double.infinity);
        final clampedHeight = savedHeight.clamp(640.0, double.infinity);
        await windowManager.setSize(Size(clampedWidth, clampedHeight));
        await windowManager.center();
      }

      if (savedMaximized) {
        await windowManager.maximize();
      } else {
        await windowManager.show();
      }
    });

    // Debounced persistence of window size and maximized state
    windowManager.addListener(_WindowSizeListener());
  }

  // Set up crash logging before runApp
  FlutterError.onError = (details) {
    CrashLogger.logError(details.exception, details.stack ?? StackTrace.current);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    CrashLogger.logError(error, stack);
    return true;
  };

  await dotenv.load(fileName: '.env');

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    publishableKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  // Initialize Google Sign-In only on platforms that support native flow.
  // On Windows (and other non-Android platforms) the env keys must not be read.
  if (PlatformSupport.supportsNativeGoogleSignIn) {
    final webClientId = dotenv.env['GOOGLE_WEB_CLIENT_ID']!;
    final androidClientId = dotenv.env['GOOGLE_ANDROID_CLIENT_ID']!;
    // iOS client ID (optional, if targeting iOS):
    // final iosClientId = dotenv.env['GOOGLE_IOS_CLIENT_ID'];

    await GoogleSignIn.instance.initialize(
      serverClientId: webClientId,
      clientId: androidClientId,
      // iOS client ID is optional — omit if not targeting iOS
      // If iOS is added later, uncomment and add GOOGLE_IOS_CLIENT_ID to .env:
      // clientId: iosClientId!,
    );
  }

  // Load the persisted theme mode before runApp so MaterialApp's first
  // frame already uses the saved mode.
  await ThemeModeNotifier.instance.load();

  runApp(const ShelfApp());
}

class _WindowSizeListener with WindowListener {
  static const _debounceMs = 300;
  Timer? _debounceTimer;

  @override
  void onWindowResize() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: _debounceMs), () async {
      final prefs = await SharedPreferences.getInstance();
      final size = await windowManager.getSize();
      await prefs.setDouble('window_width', size.width);
      await prefs.setDouble('window_height', size.height);
    });
  }

  @override
  void onWindowMaximize() {
    _saveMaximized(true);
  }

  @override
  void onWindowUnmaximize() {
    _saveMaximized(false);
  }

  Future<void> _saveMaximized(bool maximized) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('window_maximized', maximized);
  }
}

class ShelfApp extends StatefulWidget {
  const ShelfApp({super.key});

  @override
  State<ShelfApp> createState() => _ShelfAppState();
}

class _ShelfAppState extends State<ShelfApp> {
  final ThemeModeNotifier _themeNotifier = ThemeModeNotifier.instance;

  @override
  void initState() {
    super.initState();
    // Check for updates after the first frame is rendered.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // We need a BuildContext to show a dialog.
      // We can use the context from this state if it's mounted.
      if (mounted) {
        UpdateService.checkForUpdate(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _themeNotifier,
      builder: (context, themeMode, _) {
        return MaterialApp(
          title: 'Shelf',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.theme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,
home: const AuthGate(),
        );
      },
    );
  }
}

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  Session? _session;
  StreamSubscription<AuthState>? _authStateSubscription;

  @override
  void initState() {
    super.initState();
    try {
      final client = Supabase.instance.client;
      _session = client.auth.currentSession;
      debugPrint('[auth] AuthGate init. currentSession before listener == null? ${_session == null}');
      _authStateSubscription = client.auth.onAuthStateChange.listen((data) {
        debugPrint('[auth] onAuthStateChange event=${data.event} sessionBefore=${_session == null ? 'null' : 'non-null'} sessionAfter=${data.session == null ? 'null' : 'non-null'}');
        if (mounted) {
          setState(() {
            _session = data.session;
          });
        }
      });
    } catch (e) {
      debugPrint('Supabase not initialized in AuthGate (likely in test environment): $e');
    }
  }

  @override
  void dispose() {
    _authStateSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_session != null) {
      return const HomeScreen();
    }
    return const LoginScreen();
  }
}