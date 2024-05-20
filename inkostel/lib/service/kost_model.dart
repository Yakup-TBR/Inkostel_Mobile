import 'package:cloud_firestore/cloud_firestore.dart';

class Kost {
  final String namaKost;
  final String hargaPertahun;
  final String imageUrl;
  final String kosId;
  bool isFavorite;

  Kost({
    required this.namaKost,
    required this.hargaPertahun,
    required this.imageUrl,
    required this.kosId,
    this.isFavorite = false,
  });

  factory Kost.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Kost(
      namaKost: data['Nama Kos'] ?? '',
      hargaPertahun: data['Harga Pertahun'] ?? '',
      imageUrl: data['ImageURL'] ?? '',
      kosId: data['Kos ID'] ?? '',
      isFavorite: data['isFavorite'] ?? false,
    );
  }

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
  }

  Map<String, dynamic> toFirestore() {
    return {
      'Nama Kos': namaKost,
      'Harga Pertahun': hargaPertahun,
      'ImageURL': imageUrl,
      'Kos ID': kosId,
      'isFavorite': isFavorite,
    };
  }
}
