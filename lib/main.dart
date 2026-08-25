import 'package:flutter/material.dart';
import 'features/auth/screens/login_screen.dart';
import 'core/theme/app_theme.dart';

void main() {
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
      // No named routes / route table — the hierarchy is a simple
      // linear push stack (Login -> Home -> Room -> Subject -> Chapter
      // -> Notes), so plain Navigator.push with constructor arguments
      // is enough. A router package would be over-engineering for this.
      home: const LoginScreen(),
    );
  }
}
