import 'package:flutter/material.dart';
import 'package:myapp/core/assets/assets.gen.dart';
import 'package:myapp/core/constants/colors.dart';

class MyKelasBanner extends StatelessWidget {
  final String title;
  final String time;

  const MyKelasBanner({super.key, required this.title, required this.time});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // KIRI: Teks dan Button
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Kelas Hari Ini',
                  style: TextStyle(fontSize: 16, color: AppColors.white),
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
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
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
                    onPressed: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text('Lihat Detail', style: TextStyle(fontSize: 8)),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward_ios, size: 8),
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
