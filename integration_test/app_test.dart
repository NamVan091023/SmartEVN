import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:pollution_environment/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  group('Login screen', () {
    app.main();
    testWidgets('Email input', (tester) async {
      await tester.pumpAndSettle(const Duration(seconds: 10));

      final Finder userText = find.byKey(const ValueKey('email'));

      expect(userText, findsOneWidget);
    });

    testWidgets('Password input', (tester) async {
      await tester.pumpAndSettle(const Duration(seconds: 10));

      final Finder passText = find.byKey(const ValueKey('password'));
      expect(passText, findsOneWidget);
    });

    testWidgets('Login button', (tester) async {
      await tester.pumpAndSettle(const Duration(seconds: 10));

      final Finder loginBtn = find.byKey(const ValueKey('btn.login'));

      expect(loginBtn, findsOneWidget);
    });
  });
}
