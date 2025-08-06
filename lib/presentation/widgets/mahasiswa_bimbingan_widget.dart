import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mycic_app/core/constants/colors.dart'; // Sesuaikan dengan path Anda

class MahasiswaBimbinganWidget extends StatelessWidget {
  final String namaMhs;
  final String nim;
  final String judulSkripsi;
  final String jumlahBimbingan;

  const MahasiswaBimbinganWidget({
    super.key,
    required this.namaMhs,
    required this.nim,
    required this.judulSkripsi,
    required this.jumlahBimbingan,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: AppColors.white,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Bagian Nama dan NIM ---
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  namaMhs,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  nim,
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // --- Judul Skripsi ---
            Text(
              judulSkripsi,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[800],
                height: 1.4,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Divider(height: 1),
            ),

            // --- PERBAIKAN DI SINI ---
            // Gunakan Row dengan spaceBetween untuk perataan
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Label di kiri
                Text(
                  "Jumlah Bimbingan",
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                // Nilai di kanan
                Text(
                  "$jumlahBimbingan Kali",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
