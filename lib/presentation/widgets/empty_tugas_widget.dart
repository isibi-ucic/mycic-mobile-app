// WIDGET UNTUK MENAMPILKAN JIKA TIDAK ADA TUGAS
import 'package:flutter/material.dart';

class EmptyTugasWidget extends StatelessWidget {
  const EmptyTugasWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
      child: Center(
        child: Column(
          children: [
            // Ganti dengan gambar/ilustrasi Anda jika ada
            Icon(Icons.check_circle_outline, size: 80, color: Colors.green),
            SizedBox(height: 16),
            Text(
              'Tidak Ada Tugas!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              'Semua tugas sudah selesai. Kerja bagus!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
