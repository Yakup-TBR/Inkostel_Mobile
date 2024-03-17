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
        return SizedBox(
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
                  child: const Stack(
                    children: [
                      Positioned(
                        top: 40,
                        left: 30,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage('images/hapid.jpg'),
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
                                color: Colors
                                    .black, // Sesuaikan warna teks sesuai kebutuhan
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
                              backgroundColor: Color(0xFF436850)),
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
