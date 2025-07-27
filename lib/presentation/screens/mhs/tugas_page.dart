import 'package:flutter/material.dart';
import 'package:mycic_app/core/constants/colors.dart';
import 'package:mycic_app/presentation/screens/mhs/jadwal_page.dart';
import 'package:mycic_app/presentation/widgets/default_app_bar.dart';
import 'package:mycic_app/presentation/widgets/tugas_card.dart';

class TugasPage extends StatelessWidget {
  TugasPage({super.key});

  final tugasItem = [
    {
      'title': 'Tugas Matematika P7',
      'date': '20 Agustus 2023',
      'dosen': 'Dosen. S.Pd., M.Si',
      'page': JadwalPage(),
    },
    {
      'title': 'Tugas Biologi P5',
      'date': '11 Agustus 2023',
      'dosen': 'Dosen. S.Pd., M.Si',
      'page': JadwalPage(),
    },
    {
      'title': 'Tugas Kalkulus Dasar P5',
      'date': '12 Agustus 2023',
      'dosen': 'Dosen. S.Pd., M.Si',
      'page': JadwalPage(),
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: 'Tugas Perkuliahan'),
      backgroundColor: AppColors.bgDefault,
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: tugasItem.length,
        itemBuilder: (context, index) {
          final item = tugasItem[index];
          return TugasCard(
            judul: item['title'] as String,
            kelas: 'Teknik Informatika - IV',
            tenggat: item['date'] as String,
            pengajar: item['dosen'] as String,
            onSubmit: () {
              // Navigasi atau aksi submit
            },
          );
        },
      ),
    );
  }
}
