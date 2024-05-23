import 'package:cloud_firestore/cloud_firestore.dart';

class Simpan {
  final String namaKost;
  final String hargaPertahun;
  final String imageUrl;
  final String kosId;
  final String userId;

  Simpan({
    required this.namaKost,
    required this.hargaPertahun,
    required this.imageUrl,
    required this.kosId,
    required this.userId,
  });

  factory Simpan.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Simpan(
      namaKost: data['Nama Kos'] ?? '',
      hargaPertahun: data['Harga Pertahun'] ?? '',
      imageUrl: data['ImageURL'] ?? '',
      kosId: data['Kos ID'] ?? '',
      userId: data['User ID'] ?? '',
    );
  }

  static fromDocumentSnapshot(QueryDocumentSnapshot<Object?> doc) {}
}