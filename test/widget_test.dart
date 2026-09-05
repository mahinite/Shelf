import 'package:flutter_test/flutter_test.dart';
import 'package:shelf/main.dart';
import 'package:shelf/core/services/theme_notifier.dart';

void main() {
  testWidgets('Smoke test - verifies login screen loads', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(ShelfApp(themeNotifier: ThemeModeNotifier()));

    // Verify that the login screen title is present.
    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.text('Sign in to your Shelf'), findsOneWidget);
  });
}
