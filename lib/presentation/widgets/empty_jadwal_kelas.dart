// -- TAMBAHKAN WIDGET INI DI BAWAH --

import 'package:flutter/material.dart';
import 'package:mycic_app/core/assets/assets.gen.dart';
import 'package:mycic_app/core/constants/colors.dart';

class EmptyJadwalKelas extends StatelessWidget {
  const EmptyJadwalKelas({super.key});

  @override
  Widget build(BuildContext context) {
    // Container untuk memastikan tinggi widget sama dengan tinggi carousel,
    // agar layout tidak "melompat".
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      height: 175,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ganti 'assets/images/empty_calendar.svg' dengan path gambar Anda
            Assets.icons.learning.svg(height: 90, fit: BoxFit.fill),
            const SizedBox(height: 12),
            const Text(
              "Hore, tidak ada kelas!",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            const Text(
              "Nikmati waktu luangmu hari ini.",
              style: TextStyle(fontSize: 12, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
