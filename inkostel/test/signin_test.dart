import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inkostel/pages/signin.dart';

void main() {
  testWidgets('Sign In Screen UI Test', (WidgetTester tester) async {
    // Build our SignInScreen widget and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
      home: SignInScreen(),
    ));

    // Test Muncul Logo
    expect(find.byType(Image), findsOneWidget);

    // Test Field Username dan Password Muncul
    expect(find.widgetWithText(TextField, "Enter Email"), findsOneWidget);
    expect(find.widgetWithText(TextField, "Enter Password"), findsOneWidget);

    // Test Tombol Log In Muncul
    expect(find.text('LOG IN'), findsOneWidget);

    // Test tulisan "Dont have account?" dan Sign Up muncul
    expect(find.text("Don't have account?"), findsOneWidget);
    expect(find.text("Sign Up"), findsOneWidget);
  });

  testWidgets('Sign In with Invalid Credentials', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SignInScreen(),
    ));

    // Test Field Username dan Password Muncul
    expect(find.widgetWithText(TextField, "Enter Email"), findsOneWidget);
    expect(find.widgetWithText(TextField, "Enter Password"), findsOneWidget);

    // Memasukkan Username dan Password salah
    await tester.enterText(find.widgetWithText(TextField, "Enter Email"),
        'invalidemail@example.com');
    await tester.enterText(
        find.widgetWithText(TextField, "Enter Password"), 'invalidpassword');

    // Tombol Sign-In dengan ID salah
    await tester.tap(find.text('LOG IN'));

    // Trigger Error
    await tester.pumpAndSettle();
  });
}
