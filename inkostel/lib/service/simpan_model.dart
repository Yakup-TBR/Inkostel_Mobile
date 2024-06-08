import 'package:cloud_firestore/cloud_firestore.dart';

class Simpan {
  final String namaKost;
  final String jarakKost;
  final String hargaPertahun;
  final List<String> imageUrl;
  final String kosId;
  final String userId;

  Simpan({
    required this.namaKost,
    required this.jarakKost,
    required this.hargaPertahun,
    required this.imageUrl,
    required this.kosId,
    required this.userId,
  });

  factory Simpan.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Simpan(
      namaKost: data['Nama Kos'] ?? '',
      jarakKost: data['Jarak'] ?? '',
      hargaPertahun: data['Harga Pertahun'] ?? '',
      imageUrl: List<String>.from(data['ImageURLs'] ?? []),
      kosId: data['Kos ID'] ?? '',
      userId: data['User ID'] ?? '',
    );
  }

  static Simpan fromDocumentSnapshot(QueryDocumentSnapshot<Object?> doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Simpan(
      namaKost: data['Nama Kos'] ?? '',
      jarakKost: data['Jarak'] ?? '',
      hargaPertahun: data['Harga Pertahun'] ?? '',
      imageUrl: List<String>.from(data['ImageURLs'] ?? []),
      kosId: data['Kos ID'] ?? '',
      userId: data['User ID'] ?? '',
    );
  }
}
