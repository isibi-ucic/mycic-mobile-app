import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:myapp/core/core.dart';
import 'package:myapp/core/helper/ms_route.dart';
import 'package:myapp/presentation/screens/mhs/absensi_page.dart';
import 'package:myapp/presentation/screens/mhs/informasi_page.dart';
import 'package:myapp/presentation/screens/mhs/jadwal_page.dart';
import 'package:myapp/presentation/screens/mhs/khs_page.dart';
import 'package:myapp/presentation/screens/mhs/skripsi_page.dart';
import 'package:myapp/presentation/screens/mhs/transkrip_page.dart';
import 'package:myapp/presentation/screens/mhs/class_page.dart';
import 'package:myapp/presentation/screens/mhs/tugas_page.dart';
import 'package:myapp/presentation/screens/mhs/ujian_page.dart';
import 'package:myapp/presentation/widgets/header_widget.dart';
import 'package:myapp/presentation/widgets/my_kelas_banner.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    int current = 0; // di dalam StatefulWidget
    final List<Widget> bannerItems = [
      // Salin isi Container kamu di sini 3x, atau generate dinamis
      MyKelasBanner(title: 'Pemrograman Internet', time: '14:00'),
      MyKelasBanner(title: 'Struktur Data', time: '09:00'),
      MyKelasBanner(title: 'Basis Data', time: '11:00'),
    ];

    final menuItems = [
      {
        'title': 'Kelas',
        'icon': Assets.images.menu.jadwal,
        'page': ClassPage(),
      },
      {
        'title': 'Kehadiran',
        'icon': Assets.images.menu.kelas,
        'page': AbsensiPage(),
      },
      {
        'title': 'Transkrip',
        'icon': Assets.images.menu.transkrip,
        'page': TranskripPage(),
      },
      {'title': 'Nilai KHS', 'icon': Assets.images.menu.khs, 'page': KhsPage()},
      {'title': 'Ujian', 'icon': Assets.images.menu.ujian, 'page': UjianPage()},
      {
        'title': 'Skripsi',
        'icon': Assets.images.menu.skripsi,
        'page': SkripsiPage(),
      },
      {
        'title': 'Informasi',
        'icon': Assets.images.menu.informasi,
        'page': InformasiPage(),
      },
      {'title': 'Semua', 'icon': Assets.images.menu.semua, 'page': ClassPage()},
    ];

    final tugasItem = [
      {
        'title': 'Tugas Matematika P7',
        'date': '20 Agustus 2023',
        'page': JadwalPage(),
      },
      {
        'title': 'Tugas Biologi P5',
        'date': '11 Agustus 2023',
        'page': JadwalPage(),
      },
      {
        'title': 'Tugas Kalkulus Dasar P5',
        'date': '12 Agustus 2023',
        'page': JadwalPage(),
      },
    ];
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            HeaderWidget(profileImageUrl: 'https://via.placeholder.com/150'),
            const Text(
              'Halo, Mas Sahal 👋',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Teknik Informatika - IV',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),

            // Banner
            Column(
              children: [
                CarouselSlider(
                  items: bannerItems,
                  options: CarouselOptions(
                    height: 150, // sesuaikan
                    enlargeCenterPage: true,
                    autoPlay: true,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        current = index;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(bannerItems.length, (index) {
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            current == index
                                ? AppColors.primary
                                : Colors.grey[300],
                      ),
                    );
                  }),
                ),
              ],
            ),

            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Tugas Terdekat",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      msRoute(context, TugasPage());
                    },
                    child: Row(
                      children: const [
                        Text(
                          "Lihat Semua",
                          style: TextStyle(color: AppColors.black),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward,
                          size: 14,
                          color: AppColors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: tugasItem.length,
              itemBuilder: (context, index) {
                final tugas = tugasItem[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      msRoute(context, TugasPage());
                    },
                    child: Card(
                      elevation: 1,
                      color: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tugas['title'] as String,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Due date : ${tugas['date']}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
