import 'package:flutter/material.dart';
import 'package:myapp/core/constants/colors.dart';

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
        title: Text(kelas, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Row(
          children: [
            Flexible(
              // Gunakan Flexible agar tidak overflow di Row
              child: SizedBox(
                // Beri batas ukuran untuk efek running text
                width:
                    250, // Estimasi lebar yang cukup untuk nama dosen. Sesuaikan!
                child: Text(
                  dosen,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                  maxLines: 1,
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Text('|'),
            const SizedBox(width: 8),
            Text(
              waktu,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(width: 8),
            const Text('|'),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                ruangan,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
                maxLines: 1,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
        // leading: Icon(LucideIcons.clock4, size: 32),
      ),
    );
  }
}
