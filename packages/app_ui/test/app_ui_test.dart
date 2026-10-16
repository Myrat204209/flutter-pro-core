import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppTheme', () {
    test('lightTheme has Material 3 enabled and valid primary color', () {
      final theme = AppTheme.lightTheme;
      expect(theme.useMaterial3, true);
      expect(theme.colorScheme.primary, AppColors.primary);
      expect(theme.brightness, Brightness.light);
    });

    test('darkTheme has Material 3 enabled and dark brightness', () {
      final theme = AppTheme.darkTheme;
      expect(theme.useMaterial3, true);
      expect(theme.brightness, Brightness.dark);
    });
  });

  group('AppButton', () {
    testWidgets('renders button text and triggers onPressed callback', (tester) async {
      var pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: AppButton(
                text: 'Submit',
                onPressed: () => pressed = true,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Submit'), findsOneWidget);
      await tester.tap(find.byType(AppButton));
      expect(pressed, true);
    });

    testWidgets('shows CircularProgressIndicator when isLoading is true', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: AppButton(
                text: 'Loading',
                isLoading: true,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
