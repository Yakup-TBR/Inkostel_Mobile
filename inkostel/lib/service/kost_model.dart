import 'package:cloud_firestore/cloud_firestore.dart';

class Kost {
  final String namaKost;
  final String jarakKost;
  final int hargaPertahun;
  final String imageUrl;
  final String kosId;
  final String alamatKos;
  bool isFavorite;

  Kost({
    required this.namaKost,
    required this.jarakKost,
    required this.hargaPertahun,
    required this.imageUrl,
    required this.kosId,
    this.isFavorite = false,
    required this.alamatKos,
  });

  factory Kost.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Kost(
      namaKost: data['Nama Kos'] ?? '',
      jarakKost: data['Jarak'] ?? '',
      hargaPertahun: _convertToInt(data['Harga Pertahun']) ?? 0,
      imageUrl: data['ImageURL'] ?? '',
      kosId: data['Kos ID'] ?? '',
      isFavorite: data['isFavorite'] ?? false,
      alamatKos: data['Alamat Kos'] ?? '',
    );
  }
 
  static int? _convertToInt(dynamic value) {
    if (value is int) {
      return value;
    } else if (value is String) {
      return int.tryParse(value);
    } else if (value is double) {
      return value.toInt();
    } else {
      return null;
    }
  }

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
  }

  Map<String, dynamic> toFirestore() {
    return {
      // 'Nama Kos': namaKost,
      // 'Harga Pertahun': hargaPertahun,
      // 'ImageURL': imageUrl,
      // 'Kos ID': kosId,
      'isFavorite': isFavorite,
    };
  }
}
