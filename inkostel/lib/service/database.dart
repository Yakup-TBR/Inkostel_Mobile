import 'package:cloud_firestore/cloud_firestore.dart';

// Database dari Iklan ke ValidasiKos
class DatabaseMethods {
  Future addKosDetails(Map<String, dynamic> kosDataMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("ValidasiKos")
        .doc(id)
        .set(kosDataMap);
  }

  Stream<QuerySnapshot> getKosStream() {
    return FirebaseFirestore.instance.collection("Kos").snapshots();
  }

  //Database Simpan
  // Fungsi untuk menambahkan data ke tabel Simpan dengan idUser
  Future addSimpanDetails(Map<String, dynamic> simpanDataMap, String idUser) async {
    return await FirebaseFirestore.instance
        .collection("Simpan_Kos")
        .doc(idUser)  
        .set(simpanDataMap);
  }

  // Fungsi untuk mendapatkan data dari tabel Simpan
  Stream<QuerySnapshot> getSimpanStream() {
    return FirebaseFirestore.instance.collection("Simpan_Kos").snapshots();
  }
}

// Database Users