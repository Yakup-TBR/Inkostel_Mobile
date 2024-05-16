import 'package:cloud_firestore/cloud_firestore.dart';

// Database Kos
class DatabaseMethods {
  Future addKosDetails(Map<String, dynamic> kosDataMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("ValidasiKos")
        .doc(id)
        .set(kosDataMap);
  }
}

// Database Users
