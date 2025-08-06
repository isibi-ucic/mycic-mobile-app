import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mycic_app/core/constants/colors.dart';

class KelasPresensiWidget extends StatelessWidget {
  final String namaMatkul;
  final String jumlahMahasiswa;
  final String jumlahPertemuan;
  final VoidCallback onTap;

  const KelasPresensiWidget({
    super.key,
    required this.namaMatkul,
    required this.jumlahMahasiswa,
    required this.jumlahPertemuan,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shadowColor: Colors.grey[200],
      color: AppColors.white,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Judul Mata Kuliah
                    Text(
                      namaMatkul,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    // Informasi Statistik
                    Row(
                      children: [
                        _InfoChip(
                          icon: LucideIcons.listChecks,
                          text: '$jumlahPertemuan Pertemuan',
                        ),
                        const SizedBox(width: 16),
                        _InfoChip(
                          icon: LucideIcons.users,
                          text: '$jumlahMahasiswa Mahasiswa',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.grey),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget private untuk menampilkan info dengan ikon
class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoChip({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.blueAccent),
        const SizedBox(width: 6),
        Text(text, style: TextStyle(fontSize: 13, color: Colors.grey[700])),
      ],
    );
  }
}
