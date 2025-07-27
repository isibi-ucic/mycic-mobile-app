import 'package:flutter/material.dart';
import 'package:mycic_app/core/constants/colors.dart';

class ClassCard extends StatelessWidget {
  final String waktu;
  final String kelas;
  final String dosen;
  final String ruangan;

  const ClassCard({
    super.key,
    required this.waktu,
    required this.kelas,
    required this.dosen,
    required this.ruangan,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            kelas,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        subtitle: IntrinsicHeight(
          child: DefaultTextStyle(
            // Definisikan style satu kali untuk semua teks
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            child: Row(
              children: [
                // Bagian 1: Dosen (1/3 dari lebar)
                Expanded(
                  child: Text(
                    dosen,
                    textAlign: TextAlign.center, // Pusatkan teks
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                // Pemisah 1
                VerticalDivider(
                  color: Colors.grey[300],
                  thickness: 1,
                  width: 16, // Lebar area pemisah
                ),

                // Bagian 2: Waktu (1/3 dari lebar)
                Expanded(
                  child: Text(
                    waktu,
                    textAlign: TextAlign.center, // Pusatkan teks
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                // Pemisah 2
                VerticalDivider(
                  color: Colors.grey[300],
                  thickness: 1,
                  width: 16,
                ),

                // Bagian 3: Ruangan (1/3 dari lebar)
                Expanded(
                  child: Text(
                    ruangan,
                    textAlign: TextAlign.center, // Pusatkan teks
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        // leading: Icon(LucideIcons.clock4, size: 32),
      ),
    );
  }
}
