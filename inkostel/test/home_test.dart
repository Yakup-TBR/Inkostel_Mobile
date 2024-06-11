import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:inkostel/pages/home.dart';
import 'package:inkostel/pages/profile.dart';

// Fungsi untuk inisialisasi Firebase
Future<void> initializeFirebase() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

void main() {
  setUpAll(() async {
    await initializeFirebase();
  });

  testWidgets('Navigates to Profile on tap', (WidgetTester tester) async {
    // Build widget Home dan trigger frame
    await tester.pumpWidget(MaterialApp(
      home: Home(),
      routes: {
        '/profile': (context) => const Profile(),
      },
    ));

    // Temukan GestureDetector yang memiliki key 'orang_image'
    final Finder orangImageFinder = find.byKey(const Key('orang_image'));

    // Pastikan widget dengan key 'orang_image' ditemukan
    expect(orangImageFinder, findsOneWidget);

    // Ketuk widget dengan key 'orang_image'
    await tester.tap(orangImageFinder);
    await tester.pumpAndSettle();

    // Verifikasi navigasi ke halaman Profile
    expect(find.byType(Profile), findsOneWidget);
  });
}
