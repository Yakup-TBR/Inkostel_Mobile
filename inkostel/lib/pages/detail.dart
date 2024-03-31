import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

void main() {
  runApp(detail());
}

class detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            width: constraints
                .maxWidth, // Menggunakan maxWidth untuk membuat lebar responsif
            child: Stack(
              children: [
                Positioned(
                  width: constraints.maxWidth,
                  height: 317,
                  child: Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 317,
                          viewportFraction: 1.0,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          scrollDirection: Axis.horizontal,
                        ),
                        items: [
                          'images/kamar.png',
                          'images/hapid.jpg',
                          'images/contoh.jpg',
                          // Tambahkan gambar-gambar lainnya di sini
                        ].map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(i),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                      Positioned(
                        top: 30,
                        left: 20,
                        child: GestureDetector(
                          onTap: () {
                            // Tambahkan fungsi untuk kembali ke halaman sebelumnya
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              size: 20,
                              color: Color.fromRGBO(100, 204, 197, 1),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 30,
                        right: 20, // Mengatur posisi untuk tombol Simpan
                        child: GestureDetector(
                          onTap: () {
                            // Tambahkan fungsi untuk menyimpan
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.data_saver_on,
                              size: 30,
                              color: Color.fromRGBO(128, 128, 128, 1),
                            ),
                          ),
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
                  child: SlidingUpPanel(
                    minHeight: 460,
                    maxHeight: 600,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(24.0)),
                    renderPanelSheet: false,
                    panel: Container(
                      width: 360,
                      height: 460,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(24.0)),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 50, left: 22.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'KOS PONDOK HUTAN',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 50, right: 15.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: Icon(
                                          Icons.star_rate,
                                          color:
                                              Color.fromRGBO(242, 255, 60, 1),
                                          size: 20,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          '( 4,5 )',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 16,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 10, left: 22.0, right: 22.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Color.fromRGBO(72, 255, 249, 1),
                                      size: 20,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      'Jln.Sukapura',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                // Anda dapat menambahkan icon lain di sini jika diperlukan
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10, left: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.kitchen, // Ikon untuk "DAPUR"
                                      color: Color.fromRGBO(72, 255, 249, 1),
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width:
                                          5, // Memberikan jarak antara ikon dan teks
                                    ),
                                    Text(
                                      'DAPUR',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(72, 255, 249, 1),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 20, // Memberikan jarak antara dua teks
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.wifi, // Ikon untuk "WIFI"
                                      color: Color.fromRGBO(72, 255, 249, 1),
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width:
                                          10, // Memberikan jarak antara ikon dan teks
                                    ),
                                    Text(
                                      'WIFI',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(72, 255, 249, 1),
                                      ),
                                    ),
                                  ],
                                ),
                                // Anda dapat menambahkan teks kamar yang lain di sini
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20, left: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start, // Menyusun children dari Column ke kiri
                              children: [
                                Text(
                                  'Deskripsi',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 25,
                                    fontWeight: FontWeight.normal,
                                    color: Color.fromRGBO(67, 104, 80, 1),
                                  ),
                                ),
                                SizedBox(
                                    height:
                                        10), // Memberikan jarak antara dua teks
                                Text(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed faucibus tortor nec sapien bibendum, vitae ullamcorper nisi porta. Quisque in purus nunc. Phasellus vel diam luctus, fermentum justo et, congue leo. Sed a felis in ante eleifend rhoncus sed eu augue. Ut vitae nulla vel sem placerat venenatis vitae et nisl. Curabitur non massa vitae tellus luctus facilisis. Maecenas non justo vel quam accumsan bibendum sit amet nec nisi. Morbi id posuere eros. Fusce eu erat ac tortor congue vehicula. Vestibulum posuere ipsum a libero finibus tincidunt. Sed convallis convallis lacus, quis vehicula nisl feugiat quis. Curabitur dapibus quam et augue scelerisque, in tristique nulla tempor. Vestibulum cursus mauris non metus tristique, sed egestas elit aliquet. Vivamus ac lacus eget leo vehicula convallis. Vivamus nec tellus nec purus sagittis sodales.',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey,
                                  ),
                                  maxLines: null,
                                  overflow: TextOverflow.clip,
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color:
                        Colors.white, // Memberikan latar belakang warna putih
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 15.0, left: 30),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start, // Mengatur penempatan horizontal ke kiri
                              children: [
                                Text(
                                  'Harga Sewa:',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                SizedBox(height: 5), // Jarak antara dua teks
                                Text(
                                  '1 Juta/Bulan',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 20.0, right: 30),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(30,
                                    50), // Menyesuaikan ukuran agar lebih lebar
                                backgroundColor:
                                    const Color.fromARGB(255, 71, 228, 243),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize
                                    .min, // Menyusun widget secara horizontal
                                children: [
                                  Icon(
                                    Icons.phone,
                                    color: Colors.white,
                                    size: 18, // Ukuran ikon telepon
                                  ),
                                  SizedBox(
                                      width: 10), // Jarak antara ikon dan teks
                                  Text(
                                    'whatsapp',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: () {},
                            ),
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
      ),
    );
  }
}
