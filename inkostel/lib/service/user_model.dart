import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfile {
  final String userId;
  final String email;
  final String username;
  final String nama;
  final String nomorTelepon;
  final String deskripsi;
  final String photoURL;

  UserProfile({
    required this.userId,
    required this.email,
    required this.username,
    required this.nama,
    required this.nomorTelepon,
    required this.deskripsi,
    required this.photoURL,
  });

  factory UserProfile.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserProfile(
      userId: doc.id,
      email: data['Email'] ?? '',
      username: data['Username'] ?? '',
      nama: data['Nama'] ?? '',
      nomorTelepon: data['Nomor Telepon'] ?? '',
      deskripsi: data['Deskripsi'] ?? '',
      photoURL: data['PhotoURL'] ?? '',
    );
  }

  factory UserProfile.fromUser(User user, Map<String, dynamic> data) {
    String email = user.email ?? '';
    String username = email.split('@')[0];
    return UserProfile(
      userId: user.uid,
      email: email,
      username: data['Username'] ?? username,
      nama: data['Nama'] ?? user.displayName ?? '',
      nomorTelepon: data['Nomor Telepon'] ?? '',
      deskripsi: data['Deskripsi'] ?? '',
      photoURL: data['PhotoURL'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'Email': email,
      'Username': username,
      'Nama': nama,
      'Nomor Telepon': nomorTelepon,
      'Deskripsi': deskripsi,
      'PhotoURL': photoURL,
    };
  }

  bool isValid() {
    return userId.isNotEmpty && email.isNotEmpty;
  }
}

Future<UserProfile?> getUserProfile() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    throw Exception("User not logged in");
  }

  DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
  if (!userDoc.exists) {
    return null; // Return null if no user data is found
  }

  return UserProfile.fromUser(user, userDoc.data()!);
}

Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
  UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
  await createUserProfileIfNotExists(); // Ensure user profile exists
  return userCredential;
}

Future<void> createUserProfileIfNotExists() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    throw Exception("User not logged in");
  }

  DocumentReference userDocRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
  DocumentSnapshot userDoc = await userDocRef.get();

  if (!userDoc.exists) {
    String email = user.email ?? '';
    String username = email.split('@')[0];
    Map<String, dynamic> userData = {
      'Email': email,
      'Username': username,
      'Nama': user.displayName ?? '',
      'Nomor Telepon': '',
      'Deskripsi': '',
      'PhotoURL': '',
    };

    await userDocRef.set(userData);
  }
}

Future<void> updateProfileName(String newName) async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    throw Exception("User not logged in");
  }

  Map<String, dynamic> updateData = {'Nama': newName};
  await FirebaseFirestore.instance.collection('users').doc(user.uid).update(updateData);
}

Future<void> updateProfilePhoneNumber(String newPhoneNumber) async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    throw Exception("User not logged in");
  }

  Map<String, dynamic> updateData = {'Nomor Telepon': newPhoneNumber};
  await FirebaseFirestore.instance.collection('users').doc(user.uid).update(updateData);
}

Future<void> updateProfileDescription(String newDescription) async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    throw Exception("User not logged in");
  }

  Map<String, dynamic> updateData = {'Deskripsi': newDescription};
  await FirebaseFirestore.instance.collection('users').doc(user.uid).update(updateData);
}

Future<void> updateProfileImageURL(String newImageURL) async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    throw Exception("User not logged in");
  }

  Map<String, dynamic> updateData = {'PhotoURL': newImageURL};
  await FirebaseFirestore.instance.collection('users').doc(user.uid).update(updateData);
}
