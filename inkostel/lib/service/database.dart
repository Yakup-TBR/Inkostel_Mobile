import 'package:cloud_firestore/cloud_firestore.dart';

// Database Kos
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
}

// Database Users
