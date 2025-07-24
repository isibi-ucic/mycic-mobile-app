import 'package:flutter/material.dart';
import 'package:myapp/core/core.dart';
import 'package:myapp/presentation/screens/mhs/class_page.dart';
import 'package:myapp/presentation/screens/mhs/informasi_page.dart';
import 'package:myapp/presentation/screens/mhs/jadwal_page.dart';
import 'package:myapp/presentation/screens/mhs/khs_page.dart';
import 'package:myapp/presentation/screens/mhs/menus_page.dart';
import 'package:myapp/presentation/screens/mhs/transkrip_page.dart';

class AllMenu extends StatelessWidget {
  AllMenu({super.key});

  final menuItems = [
    {
      'title': 'Jadwal',
      'icon': Assets.images.menu.jadwal,
      'page': JadwalPage(),
    },
    {'title': 'Kelas', 'icon': Assets.images.menu.kelas, 'page': ClassPage()},
    {
      'title': 'Transkrip',
      'icon': Assets.images.menu.transkrip,
      'page': TranskripPage(),
    },
    {'title': 'Nilai KHS', 'icon': Assets.images.menu.khs, 'page': KhsPage()},
    {'title': 'Ujian', 'icon': Assets.images.menu.ujian, 'page': JadwalPage()},
    {
      'title': 'Skripsi',
      'icon': Assets.images.menu.skripsi,
      'page': MenusPage(),
    },
    {
      'title': 'Informasi',
      'icon': Assets.images.menu.informasi,
      'page': InformasiPage(),
    },
    {'title': 'Nilai KHS', 'icon': Assets.images.menu.khs, 'page': KhsPage()},
    {'title': 'Ujian', 'icon': Assets.images.menu.ujian, 'page': JadwalPage()},
    {
      'title': 'Skripsi',
      'icon': Assets.images.menu.skripsi,
      'page': MenusPage(),
    },
    {
      'title': 'Informasi',
      'icon': Assets.images.menu.informasi,
      'page': InformasiPage(),
    },
    {'title': 'Semua', 'icon': Assets.images.menu.semua, 'page': ClassPage()},
  ];

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.4,
      minChildSize: 0.2,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                // SpaceHeight(24),
                // // Indicator kecil di atas (optional)
                // SpaceHeight(24),
                Container(
                  width: 60,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                // Isi Bottom Sheet
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Semua Menu",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: menuItems.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    final item = menuItems[index];
                    final iconMenu = item['icon'] as AssetGenImage;
                    final pageMenu = item['page'] as Widget;
                    final title = item['title'] as String;
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => pageMenu),
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(20),
                                  blurRadius: 2,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(18),
                            child: iconMenu.image(height: 28, width: 28),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            title,
                            style: const TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
