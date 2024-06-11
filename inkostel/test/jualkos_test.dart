import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inkostel/pages/jualkos.dart';

void main() {
  group('JualKos Widget Tests', () {
    testWidgets('should have all necessary input fields and buttons',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: JualKos()));

      expect(find.text('Daftarkan kostan Anda sekarang!'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(8));
      expect(find.text('Nama Kostan'), findsOneWidget);
      expect(find.text('Nomor Telepon'), findsOneWidget);
      expect(find.text('Alamat'), findsOneWidget);
      expect(find.text('Link Map (Optional)'), findsOneWidget);
      expect(find.text('Jarak dari Telkom University (Meter)'), findsOneWidget);
      expect(find.text('Harga Pertahun (Wajib diisi)'), findsOneWidget);
      expect(find.text('Harga Perbulan (Opsional)'), findsOneWidget);
      expect(find.text('Deskripsi Kostan'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Submit'), findsOneWidget);
    });
  });
}
