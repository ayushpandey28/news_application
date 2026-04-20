
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_application/main.dart';

void main() {
  testWidgets('App loads and shows Splash Screen', (WidgetTester tester) async {
    await tester.pumpWidget(const NewsApp());

    // Check splash screen UI
    expect(find.text('PULSE'), findsOneWidget);
    expect(find.text('WORLD CLASS JOURNALISM'), findsOneWidget);
    expect(find.byIcon(Icons.bolt_rounded), findsOneWidget);
  });

  testWidgets('Navigate to Login Screen', (WidgetTester tester) async {
    await tester.pumpWidget(const NewsApp());

    // Wait for splash delay
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    // Check login screen
    expect(find.text('Welcome\nBack.'), findsOneWidget);
    expect(find.text('LOGIN'), findsOneWidget);
  });

  testWidgets('Login button works', (WidgetTester tester) async {
    await tester.pumpWidget(const NewsApp());

    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    // Enter text
    await tester.enterText(find.byType(TextField).first, 'test@test.com');
    await tester.enterText(find.byType(TextField).last, '123456');

    // Tap login
    await tester.tap(find.text('LOGIN'));
    await tester.pumpAndSettle();

    // Should go to home
    expect(find.text('Technology'), findsOneWidget);
  });
}