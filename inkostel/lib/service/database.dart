import 'package:cloud_firestore/cloud_firestore.dart';

// Database dari Iklan ke ValidasiKos
class DatabaseMethods {
  Future addKosDetails(Map<String, dynamic> kosDataMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Kos")
        .doc(id)
        .set(kosDataMap);
  }

  Stream<QuerySnapshot> getKosStream() {
    return FirebaseFirestore.instance.collection("Kos").snapshots();
  }

  //simpan
  Future addSimpanDetails(Map<String, dynamic> simpanDataMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("SimpanKos")
        .doc(id)
        .set(simpanDataMap);
  }
}

// Database Users