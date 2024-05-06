import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

// Fungsi untuk menyimpan gambar ke penyimpanan lokal
Future<String> saveImageLocally(File imageFile) async {
  final directory = await getApplicationDocumentsDirectory();
  final imagePath = '${directory.path}/kost_image.jpg';
  await imageFile.copy(imagePath);
  return imagePath;
}

// Fungsi untuk mengunggah gambar ke Firebase Storage
Future<String> uploadImageToFirebase(String imagePath, String imageName) async {
  try {
    final file = File(imagePath);
    await firebase_storage.FirebaseStorage.instance
        .ref('images/$imageName')
        .putFile(file);
    final downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref('images/$imageName')
        .getDownloadURL();
    return downloadURL;
  } catch (e) {
    // ignore: avoid_print
    print('Gagal mengupload image ke Firebase Storage: $e');
    return '';
  }
}
