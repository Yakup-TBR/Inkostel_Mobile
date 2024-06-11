import 'package:test/test.dart';



String hargaPertahun(int amount) {
  if (amount >= 1000000) {
    double result = amount / 1000000;
    if (result % 1 == 0) {
      return 'Rp ${result.toInt()} jt/thn';
    } else {
      return 'Rp ${result.toStringAsFixed(1)} jt/thn';
    }
  } else {
    // Mengembalikan string dengan format 'Rp {amount} ribu/thn' jika amount kurang dari 1 juta
    double result = amount / 1000;
    return 'Rp ${result.toInt()} ribu/thn';
  }
}

String formatJarak(int jarak) {
  if (jarak >= 1000) {
    double km = jarak / 1000.0;
    return '${km.toStringAsFixed(1)} km';
  } else {
    return '$jarak m';
  }
}

String hargaPerbulan(int amount) {
  if (amount >= 1000000) {
    double result = amount / 1000000;
    if (result % 1 == 0) {
      return 'Rp ${result.toInt()} juta/bln';
    } else {
      return 'Rp ${result.toStringAsFixed(1)} juta/bln';
    }
  } else if (amount >= 1000) {
    double result = amount / 1000;
    if (result % 1 == 0) {
      return 'Rp ${result.toInt()} ribu/bln';
    } else {
      return 'Rp ${result.toStringAsFixed(1)} ribu/bln';
    }
  } else {
    // Mengembalikan string dengan format 'Rp {amount} ribu/bln' jika amount kurang dari 1000
    return 'Rp $amount ribu/bln';
  }
}
void main() {
  group('Harga Pertahun Tests', () {
    test('Harga lebih dari 1 juta', () {
      expect(hargaPertahun(1500000), equals('Rp 1.5 jt/thn'));
    });

    test('Harga kurang dari 1 juta', () {
      expect(hargaPertahun(750000), equals('Rp 750 ribu/thn'));
    });
  });

  group('Format Jarak Tests', () {
    test('Jarak lebih dari 1000 meter', () {
      expect(formatJarak(2000), equals('2.0 km'));
    });

    test('Jarak kurang dari 1000 meter', () {
      expect(formatJarak(500), equals('500 m'));
    });
  });

  group('Harga Perbulan Tests', () {
    test('Harga lebih dari 1 juta', () {
      expect(hargaPerbulan(1500000), equals('Rp 1.5 juta/bln'));
    });

    test('Harga lebih dari 1000 ribu', () {
      expect(hargaPerbulan(750000), equals('Rp 750 ribu/bln'));
    });

    test('Harga kurang dari 1000', () {
      expect(hargaPerbulan(500), equals('Rp 500 ribu/bln'));
    });
  });
}
