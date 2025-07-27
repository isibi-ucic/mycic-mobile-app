import 'package:flutter/material.dart';
import 'package:mycic_app/core/constants/colors.dart';
import 'package:mycic_app/presentation/widgets/default_app_bar.dart';

class DetailPertemuanPage extends StatelessWidget {
  const DetailPertemuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: 'Detail Pertemuan'),
      backgroundColor: AppColors.bgDefault,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- BAGIAN HEADER ---
              // Judul Utama
              const Text(
                "Materi Perkuliahan disini",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // // Info Detail dengan Ikon
              // _buildInfoRow(
              //   icon: Icons.person_outline,
              //   text: "Dosen CIC, M.Kom",
              // ),
              // const SizedBox(height: 8),
              // _buildInfoRow(
              //   icon: Icons.access_time_outlined,
              //   text: "Rabu, 9:00 - 11:00",
              // ),
              // const SizedBox(height: 8),
              // _buildInfoRow(
              //   icon: Icons.location_on_outlined,
              //   text: "Ruang 201",
              // ),
              // const SizedBox(height: 24),

              // --- BAGIAN KONTEN DALAM CARD ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    // Placeholder untuk PDF Viewer
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        color: Colors.grey[400],
                        height: 200,
                        child: Center(
                          child: Icon(
                            Icons.picture_as_pdf_rounded,
                            color: Colors.grey[500],
                            size: 50,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Deskripsi Materi
                    const Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.5,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // --- BAGIAN TOMBOL AKSI ---
              SizedBox(
                width: double.infinity, // Membuat tombol full-width
                child: FilledButton.icon(
                  icon: const Icon(Icons.qr_code_scanner),
                  label: const Text("Scan Absensi"),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    // Ganti dengan navigasi Anda
                    // msRoute(context, const ScannerPage());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Helper widget untuk membuat baris info dengan ikon
Widget _buildInfoRow({required IconData icon, required String text}) {
  return Row(
    children: [
      Icon(icon, color: Colors.blueAccent, size: 20),
      const SizedBox(width: 12),
      Text(text, style: TextStyle(fontSize: 15, color: Colors.grey[700])),
    ],
  );
}
