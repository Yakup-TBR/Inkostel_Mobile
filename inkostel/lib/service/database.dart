import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addKosDetails(Map<String, dynamic> kosDataMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Kos")
        .doc(id)
        .set(kosDataMap);
  }
}
