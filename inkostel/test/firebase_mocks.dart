import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseApp extends Mock implements FirebaseApp {}

void setupFirebaseMocks() {
  final auth = MockFirebaseAuth();
  when(auth.currentUser).thenReturn(null);
}
