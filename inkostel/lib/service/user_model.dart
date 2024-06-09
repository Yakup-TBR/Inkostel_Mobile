import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

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

// Method to upload an image to Firebase Storage and get the download URL
Future<String> uploadImageToFirebase(String imagePath, String imageName) async {
  try {
    File imageFile = File(imagePath);
    Reference storageRef = FirebaseStorage.instance.ref().child('images/$imageName');
    UploadTask uploadTask = storageRef.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  } catch (e) {
    print(e);
    throw e;
  }
}

// Method to handle image selection
Future<void> pickImage(BuildContext context, ImageSource source) async {
  final pickedFile = await ImagePicker().pickImage(source: source);
  if (pickedFile != null) {
    String imageName = 'profile_image_${randomAlphaNumeric(8)}.jpg';
    String downloadUrl = await uploadImageToFirebase(pickedFile.path, imageName);
    await updateProfileImageURL(downloadUrl);
    Fluttertoast.showToast(
      msg: "Profile image updated successfully!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }
}

// Method to upload multiple images to Firebase Storage and save URLs to Firestore
Future<void> _uploadImagesAndSaveUrls(List<File> imageFiles) async {
  List<String> imageUrls = [];
  for (int i = 0; i < imageFiles.length; i++) {
    String imageName = 'kost_image_${DateTime.now().millisecondsSinceEpoch}_$i.jpg';
    String downloadUrl = await uploadImageToFirebase(imageFiles[i].path, imageName);
    imageUrls.add(downloadUrl);
  }

  // Save image URLs to Firestore
  for (String url in imageUrls) {
    await FirebaseFirestore.instance.collection('images').add({
      'url': url,
      'uploaded_at': Timestamp.now(),
    });
  }
  Fluttertoast.showToast(
    msg: "Images uploaded and URLs saved successfully!",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    backgroundColor: Colors.green,
    textColor: Colors.white,
  );
}
