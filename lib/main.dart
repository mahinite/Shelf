import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/auth/screens/login_screen.dart';
import 'features/home/screens/home_screen.dart';
import 'core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    publishableKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  // Initialize Google Sign-In
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

  runApp(const ShelfApp());
}

class ShelfApp extends StatelessWidget {
  const ShelfApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shelf',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const AuthGate(),
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