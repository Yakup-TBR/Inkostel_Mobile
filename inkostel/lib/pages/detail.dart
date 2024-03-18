import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(detail());
}

class detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: constraints
              .maxWidth, // Menggunakan maxWidth untuk membuat lebar responsif
          child: Stack(
            children: [
              Positioned(
                width: constraints
                    .maxWidth, // Menggunakan maxWidth untuk membuat lebar responsif
                height: 317, // Tetapkan tinggi sesuai kebutuhan Anda
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/kamar.png'),
                      fit: BoxFit.cover, // Sesuaikan sesuai kebutuhan Anda
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      Positioned(
                        top: 30,
                        left: 20,
                        child: GestureDetector(
                          onTap: () {
                            // Tambahkan fungsi untuk kembali ke halaman sebelumnya
                          },
                          child: Container(
                            width:
                                40, // Sesuaikan lebar dan tinggi sesuai dengan kebutuhan
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.25),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.arrow_back,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      // Isi lainnya jika ada
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: 360,
                  height: 460,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(24.0)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(
                        height:
                            100, // Sesuaikan tinggi SizedBox sesuai kebutuhan
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top:
                                    20.0), // Sesuaikan posisi teks sesuai kebutuhan
                            child: Text(
                              'KOS PONDOK HUTAN',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize:
                                    20, // Sesuaikan ukuran font sesuai kebutuhan
                                fontWeight: FontWeight
                                    .bold, // Sesuaikan gaya tebal sesuai kebutuhan
                                color: Color.fromRGBO(67, 104, 80,
                                    1), // Sesuaikan warna teks sesuai kebutuhan
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(285,
                                  53), // Atur ukuran minimum tombol (lebar, tinggi)
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 20), // Atur padding di dalam tombol
                              backgroundColor: Color.fromRGBO(67, 104, 80, 1)),
                          child: const Text(
                            'Tekan Tombol',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          onPressed: () {
                            null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
