import 'package:cloud_firestore/cloud_firestore.dart';

// Database dari Iklan ke ValidasiKos
class DatabaseMethods {
  Future addKosDetails(Map<String, dynamic> kosDataMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("ValidasiKos")
        .doc(id)
        .set(kosDataMap);
  }

  // Stream<QuerySnapshot> getKosStream() {
  //   return FirebaseFirestore.instance.collection("Kos").snapshots();
  // }
}

// Database Users