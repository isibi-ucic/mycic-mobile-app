import 'package:flutter/material.dart';
import 'package:mycic_app/core/assets/assets.gen.dart';
import 'package:mycic_app/core/constants/colors.dart';
import 'package:mycic_app/core/helper/ms_route.dart';
import 'package:mycic_app/presentation/screens/mhs/class_page.dart';
import 'package:mycic_app/presentation/screens/mhs/class_detail_page.dart';

class MyKelasBanner extends StatelessWidget {
  final int mkId;
  final String title;
  final String time;
  final String dosen;
  final String ruangan;
  final bool adakelas;

  MyKelasBanner({
    super.key,
    required this.title,
    required this.time,
    required this.mkId,
    required this.dosen,
    required this.ruangan,
    this.adakelas = true,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // KIRI: Teks dan Button
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  adakelas ? 'Kelas Hari Ini' : 'Tidak ada kelas hari ini',
                  style: const TextStyle(fontSize: 16, color: AppColors.white),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                FittedBox(
                  fit: BoxFit.fill,
                  // Supaya button tidak overflow
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(0, 25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: AppColors.white,
                      foregroundColor: AppColors.black,
                    ),
                    onPressed: () {
                      adakelas
                          ? msRoute(
                            context,
                            ClassDetailPage(
                              mkId: mkId,
                              namaMatkul:
                                  title, // Memberikan nilai default jika null
                              dosen: dosen,
                              waktu: time,
                              ruangan: ruangan,
                            ),
                          )
                          : msRoute(context, const ClassPage());
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          adakelas ? 'Lihat Detail' : 'Lihat Jadwal',
                          style: const TextStyle(fontSize: 10),
                        ),
                        const SizedBox(width: 10),
                        const Icon(Icons.arrow_forward_ios, size: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // KANAN: SVG image
          Assets.icons.learning.svg(height: 100, fit: BoxFit.fill),
        ],
      ),
    );
  }
}
