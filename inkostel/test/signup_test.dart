import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inkostel/pages/signup.dart';

void main() {
  testWidgets('Sign Up Screen UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SignUpScreen(),
    ));

    // Judul Sign Up muncul
    expect(find.text('Sign Up'), findsOneWidget);

    // Form Sign Up muncul
    expect(find.widgetWithText(TextField, 'Enter Username'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Enter Email'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Enter Password'), findsOneWidget);

    // Tombol Sign Up muncul
    expect(find.text('Sign Up'), findsOneWidget);
  });

  testWidgets('Sign Up with Valid Credentials', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SignUpScreen(),
    ));

    // Memasukkan Form dengan data benar
    await tester.enterText(find.widgetWithText(TextField, 'Enter Username'), 'testuser');
    await tester.enterText(find.widgetWithText(TextField, 'Enter Email'), 'test@example.com');
    await tester.enterText(find.widgetWithText(TextField, 'Enter Password'), 'password');

    // Tombol Sign Up dengan data benar
    await tester.tap(find.text('Sign Up'));

    // Trigger
    await tester.pumpAndSettle();
  });

  testWidgets('Sign Up with Invalid Credentials', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SignUpScreen(),
    ));

    // Memasukkan Form dengan data salah
    await tester.enterText(find.widgetWithText(TextField, 'Enter Username'), 'testuser');
    await tester.enterText(find.widgetWithText(TextField, 'Enter Email'), 'invalidemail');
    await tester.enterText(find.widgetWithText(TextField, 'Enter Password'), 'short');

    // Tombol Sign Up dengan data salah
    await tester.tap(find.text('Sign Up'));

    // Trigger
    await tester.pumpAndSettle();
  });
}
