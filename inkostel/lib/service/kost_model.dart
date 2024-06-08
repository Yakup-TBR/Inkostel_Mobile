import 'package:cloud_firestore/cloud_firestore.dart';

class Kost {
  final String namaKost;
  final String jarakKost;
  final int hargaPertahun;
  final List<String> imageUrl;
  final String kosId;
  final String alamatKos;
  bool isFavorite;
  final String deskripsi;
  final Map<String, bool> fasilitas;
  final String noWA;

  Kost({
    required this.namaKost,
    required this.jarakKost,
    required this.hargaPertahun,
    required this.imageUrl,
    required this.kosId,
    this.isFavorite = false,
    required this.alamatKos,
    required this.deskripsi,
    required this.fasilitas,
    required this.noWA,
  });

  factory Kost.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Kost(
      namaKost: data['Nama Kos'] ?? '',
      jarakKost: data['Jarak'] ?? '',
      hargaPertahun: _convertToInt(data['Harga Pertahun']) ?? 0,
      imageUrl: List<String>.from(data['ImageURLs'] ?? []),
      kosId: data['Kos ID'] ?? '',
      isFavorite: data['isFavorite'] ?? false,
      alamatKos: data['Alamat Kos'] ?? '',
      deskripsi: data['Deskripsi'] ?? '',
      fasilitas: _convertToFasilitas(data['Fasilitas'] ?? {}),
      noWA: data['Nomor Telepon'] ?? '',
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

// Helper function to convert dynamic map to Map<String, bool>
Map<String, bool> _convertToFasilitas(Map<String, dynamic> map) {
  Map<String, bool> result = {};
  map.forEach((key, value) {
    if (value is bool) {
      result[key] = value;
    }
  });
  return result;
}
