import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mycic_app/core/constants/colors.dart';
import 'package:mycic_app/core/helper/date_formatter.dart';

class TugasCard extends StatelessWidget {
  final String judul;
  final String mataKuliah;
  final String tenggat;
  final String pengajar;
  final VoidCallback onSubmit;

  const TugasCard({
    super.key,
    required this.judul,
    required this.mataKuliah,
    required this.tenggat,
    required this.pengajar,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shadowColor: Colors.grey[200],
      color: AppColors.white,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Judul Tugas
            Text(
              judul,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),

            // 2. Mata Kuliah (langsung di bawah judul)
            const SizedBox(height: 4),
            Text(
              "${mataKuliah} - ${pengajar}",
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
            ),
            const Divider(height: 24),

            // 4. Area Aksi (Tenggat dan Tombol)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Sejajarkan secara vertikal
              children: [
                // 5. Tenggat Waktu (lebih menonjol)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tenggat:',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      DateFormatter.formatHariTanggal(tenggat.toString()),
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),

                // 6. Tombol Submit
                FilledButton(
                  onPressed: onSubmit,
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Submit Tugas'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
