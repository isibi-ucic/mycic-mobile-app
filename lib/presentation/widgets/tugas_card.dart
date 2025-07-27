// Suggested code may be subject to a license. Learn more: ~LicenseLog:4239444231.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:2081660647.
import 'package:flutter/material.dart';
import 'package:mycic_app/core/constants/colors.dart';

class TugasCard extends StatelessWidget {
  final String judul;
  final String kelas;
  final String tenggat;
  final String pengajar;
  final VoidCallback onSubmit;

  const TugasCard({
    super.key,
    required this.judul,
    required this.kelas,
    required this.tenggat,
    required this.pengajar,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: AppColors.white,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              judul,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const Divider(height: 24),
            const Text(
              'Tenggat waktu',
              style: TextStyle(color: Colors.black45, fontSize: 12),
            ),
            Text(tenggat, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 12),
            const Text(
              'Pengajar',
              style: TextStyle(color: Colors.black45, fontSize: 12),
            ),
            Text(pengajar, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.bottomRight,
              child: OutlinedButton.icon(
                onPressed: onSubmit,
                icon: const Icon(Icons.arrow_forward, size: 18),
                label: const Text('Submit'),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  side: const BorderSide(color: Colors.blueAccent),
                  foregroundColor: Colors.blueAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
