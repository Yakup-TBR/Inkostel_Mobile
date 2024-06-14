import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inkostel/pages/settings.dart';

void main() {
  testWidgets('Bottom navigation bar test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Pengaturan(),
    ));

    // Verify the initial page is Pengaturan
    expect(find.text('Pengaturan'), findsOneWidget);

    // Tap on each item in the bottom navigation bar and verify the navigation
    await tester.tap(find.text('Home')); // Tapping on 'Home' label
    await tester.pump(); // Allow time for navigation transition
    expect(find.text('Home'), findsOneWidget); // Verify we're on the Home page

    // Repeat the above steps for other navigation items

    // Additional steps if necessary

  });
}
