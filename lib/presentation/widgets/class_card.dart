import 'package:flutter/material.dart';
import 'package:mycic_app/core/constants/colors.dart';

class ClassCard extends StatelessWidget {
  final String waktu;
  final String kelas;
  final String? dosen;
  final String ruangan;

  const ClassCard({
    super.key,
    required this.waktu,
    required this.kelas,
    this.dosen,
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bagian 1: Dosen (1/3 dari lebar)
                if (dosen != null) ...[
                  Expanded(
                    child: Text(
                      dosen!,
                      textAlign: TextAlign.left, // Pusatkan teks
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
                if (dosen == null) ...[
                  // Tampilkan Waktu
                  Text(waktu), // Tidak perlu Expanded
                  VerticalDivider(
                    color: Colors.grey[300],
                    thickness: 1,
                    width: 16,
                  ),
                  // Tampilkan Ruangan
                  Text(ruangan), // Tidak perlu Expanded
                ],
              ],
            ),
          ),
        ),
        // leading: Icon(LucideIcons.clock4, size: 32),
      ),
    );
  }
}
