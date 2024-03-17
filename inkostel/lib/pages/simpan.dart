          Positioned.fill(
            width: 360, // Menyesuaikan dengan lebar layar
            height: 317, // Menyesuaikan dengan tinggi layar
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/kamar.png'),
                fit: BoxFit.cover, // Sesuaikan sesuai kebutuhan Anda
              ),
            ),
            child: Stack(
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

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: 360,
              height: 420,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(
                    height: 100, // Sesuaikan tinggi SizedBox sesuai kebutuhan
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top:
                                20.0), // Sesuaikan posisi teks sesuai kebutuhan
                        child: Text(
                          'KOS PONDOK HUTAN',
                          style: TextStyle(
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
                      onPressed: () {
                        // Aksi yang diambil saat tombol ditekan
                      },
                      child: const Text('Tekan Tombol'),
                    ),
                  ),
                ],
              ),
            ),
          ),
