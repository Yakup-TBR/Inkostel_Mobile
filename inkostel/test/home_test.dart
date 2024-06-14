import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inkostel/pages/carikos.dart';
import 'package:inkostel/pages/home.dart';
import 'package:inkostel/pages/profile.dart';
import 'package:mockito/mockito.dart';

// Mock FirebaseAuth
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

// Mock User
class MockUser extends Mock implements User {
  @override
  String get uid => 'fakeUserId';
}

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    // Mock the Firebase initialization
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        appId: 'testAppId',
        apiKey: 'testApiKey',
        messagingSenderId: 'testMessagingSenderId',
        projectId: 'testProjectId',
      ),
    );
  });

  tearDownAll(() async {
    await Firebase.app().delete();
  });

  group('Home Page Tests', () {
    testWidgets('See All Recommendations Button Test',
        (WidgetTester tester) async {
      final mockFirebaseAuth = MockFirebaseAuth();
      when(mockFirebaseAuth.currentUser).thenReturn(MockUser());

      await tester.pumpWidget(MaterialApp(home: Home()));

      await tester.tap(find.byKey(const Key('seeAllRekomendasi')));
      await tester.pumpAndSettle();

      expect(find.byType(CariKos), findsOneWidget);
    });

    testWidgets('See All Nearby Button Test', (WidgetTester tester) async {
      final mockFirebaseAuth = MockFirebaseAuth();
      when(mockFirebaseAuth.currentUser).thenReturn(MockUser());

      await tester.pumpWidget(MaterialApp(home: Home()));

      await tester.tap(find.byKey(const Key('seeAllCariKosTerdekat')));
      await tester.pumpAndSettle();

      expect(find.byType(CariKos), findsOneWidget);
    });

    testWidgets('See All Cheapest Button Test', (WidgetTester tester) async {
      final mockFirebaseAuth = MockFirebaseAuth();
      when(mockFirebaseAuth.currentUser).thenReturn(MockUser());

      await tester.pumpWidget(MaterialApp(home: Home()));

      await tester.tap(find.byKey(const Key('seeAllCariKosTermurah')));
      await tester.pumpAndSettle();

      expect(find.byType(CariKos), findsOneWidget);
    });

    testWidgets('Profile Button Test', (WidgetTester tester) async {
      final mockFirebaseAuth = MockFirebaseAuth();
      when(mockFirebaseAuth.currentUser).thenReturn(MockUser());

      await tester.pumpWidget(MaterialApp(home: Home()));

      await tester.tap(find.byKey(const Key('profileButton')));
      await tester.pumpAndSettle();

      expect(find.byType(Profile), findsOneWidget);
    });

    testWidgets('Search Bar Test', (WidgetTester tester) async {
      final mockFirebaseAuth = MockFirebaseAuth();
      when(mockFirebaseAuth.currentUser).thenReturn(MockUser());

      await tester.pumpWidget(MaterialApp(home: Home()));

      await tester.tap(find.byKey(const Key('searchBar')));
      await tester.pumpAndSettle();

      expect(find.byType(CariKos), findsOneWidget);
    });

    testWidgets('Bottom Navigation Bar Test', (WidgetTester tester) async {
      final mockFirebaseAuth = MockFirebaseAuth();
      when(mockFirebaseAuth.currentUser).thenReturn(MockUser());

      await tester.pumpWidget(MaterialApp(home: Home()));

      // Assuming you have keys set for the bottom navigation bar items
      await tester.tap(find.byKey(const Key('homeNavItem')));
      await tester.pumpAndSettle();
      expect(find.byType(Home), findsOneWidget);

      await tester.tap(find.byKey(const Key('simpanNavItem')));
      await tester.pumpAndSettle();
      expect(find.byType(Profile), findsOneWidget);

      await tester.tap(find.byKey(const Key('saveNavItem')));
      await tester.pumpAndSettle();
      expect(find.byType(Profile), findsOneWidget);

      await tester.tap(find.byKey(const Key('SetNavItem')));
      await tester.pumpAndSettle();
      expect(find.byType(Profile), findsOneWidget);

      // Add additional bottom navigation bar item tests as needed
    });
  });
}
