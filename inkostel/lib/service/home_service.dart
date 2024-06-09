import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inkostel/service/kost_model.dart';

// Fetch Semua Data
Future<List<Kost>> fetchData() async {
  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection("Kos").get();
  return querySnapshot.docs.map((doc) => Kost.fromFirestore(doc)).toList();
}

// Fetch urutan termurah
Future<List<Kost>> fetchDataTermurah() async {
  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection("Kos").get();
  List<Kost> kostList =
      querySnapshot.docs.map((doc) => Kost.fromFirestore(doc)).toList();

  // Urutkan berdasarkan HargaPertahun
  kostList.sort((a, b) => a.hargaPertahun.compareTo(b.hargaPertahun));

  return kostList;
}

// Fetch urutan terdekat
Future<List<Kost>> fetchDataTerdekat() async {
  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection("Kos").get();
  List<Kost> kostList =
      querySnapshot.docs.map((doc) => Kost.fromFirestore(doc)).toList();

  // Urutkan berdasarkan jarak terdekat
  kostList.sort((a, b) => a.jarakKost.compareTo(b.jarakKost));

  return kostList;
}