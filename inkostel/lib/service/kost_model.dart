import 'package:cloud_firestore/cloud_firestore.dart';

class Kost {
  final String namaKost;
  final String hargaPertahun;
  final String imageUrl;
  final String kosId;

  Kost({
    required this.namaKost,
    required this.hargaPertahun,
    required this.imageUrl,
    required this.kosId,
  });

  factory Kost.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Kost(
      namaKost: data['Nama Kos'] ?? '',
      hargaPertahun: data['Harga Pertahun'] ?? '',
      imageUrl: data['ImageURL'] ?? '',
      kosId: data['Kos ID'] ?? '',
    );
  }

  static fromDocumentSnapshot(QueryDocumentSnapshot<Object?> doc) {}
}
