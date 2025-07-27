import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mycic_app/core/constants/colors.dart';

class TugasCard extends StatelessWidget {
  final String judul;
  final String tenggat;
  final String pengajar;
  final VoidCallback onSubmit;

  const TugasCard({
    super.key,
    required this.judul,
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
            // --- Judul Tugas ---
            Text(
              judul,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 32),

            // --- Detail dengan Ikon ---
            _buildInfoRow(
              icon: LucideIcons.calendar,
              text: tenggat,
              label: 'Tenggat',
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              icon: LucideIcons.user,
              text: pengajar,
              label: 'Pengajar',
            ),
            const SizedBox(height: 16),

            // --- Tombol Aksi ---
            Align(
              alignment: Alignment.bottomRight,
              child: FilledButton(
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
            ),
          ],
        ),
      ),
    );
  }

  // Widget bantuan untuk membuat baris info
  Widget _buildInfoRow({
    required IconData icon,
    required String text,
    required String label,
  }) {
    return Row(
      children: [
        Icon(icon, color: Colors.blueAccent, size: 20),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
            const SizedBox(height: 2),
            Text(
              text,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }
}
