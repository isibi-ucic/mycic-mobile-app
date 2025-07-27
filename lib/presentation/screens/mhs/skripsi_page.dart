import 'package:flutter/material.dart';
import 'package:mycic_app/presentation/widgets/default_app_bar.dart';

class SkripsiPage extends StatelessWidget {
  const SkripsiPage({super.key});

  @override
  Widget build(BuildContext context) {
    // --- DATA DUMMY (Nantinya bisa diganti dari API) ---
    const judulSkripsi =
        "Rancang Bangun Sistem Informasi Manajemen Aset Berbasis Web menggunakan Framework Laravel";
    const dosen1 = "Dr. Budi Hartono, S.T., M.Kom.";
    const bimbinganDosen1 = 8;
    const dosen2 = "Siti Aminah, S.Kom., M.T.";
    const bimbinganDosen2 = 6;
    // --- END OF DATA DUMMY ---

    return Scaffold(
      backgroundColor: Colors.grey[100], // Warna background soft
      appBar: DefaultAppBar(title: 'Informasi Skripsi'),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- KARTU JUDUL SKRIPSI ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(6),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Judul Skripsi Anda",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    judulSkripsi,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      height: 1.4, // Spasi antar baris
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // --- HEADER DOSEN PEMBIMBING ---
            const Text(
              "Dosen Pembimbing",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // --- KARTU DOSEN 1 ---
            _DosenCard(
              namaDosen: dosen1,
              statusPembimbing: "Pembimbing 1",
              jumlahBimbingan: bimbinganDosen1,
            ),
            const SizedBox(height: 12),

            // --- KARTU DOSEN 2 ---
            _DosenCard(
              namaDosen: dosen2,
              statusPembimbing: "Pembimbing 2",
              jumlahBimbingan: bimbinganDosen2,
            ),
          ],
        ),
      ),
    );
  }
}

// WIDGET KUSTOM UNTUK KARTU DOSEN
class _DosenCard extends StatelessWidget {
  final String namaDosen;
  final String statusPembimbing;
  final int jumlahBimbingan;

  const _DosenCard({
    required this.namaDosen,
    required this.statusPembimbing,
    required this.jumlahBimbingan,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Status Pembimbing ---
          Text(
            statusPembimbing,
            style: TextStyle(
              color: Colors.blueAccent[700],
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          // --- Nama Dosen ---
          Text(
            namaDosen,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: Divider(height: 1),
          ),
          // --- Jumlah Bimbingan ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Jumlah Bimbingan",
                style: TextStyle(color: Colors.grey[700]),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "$jumlahBimbingan Kali",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent[700],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
