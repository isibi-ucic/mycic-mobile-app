import 'package:flutter/material.dart';
import 'package:mycic_app/core/constants/colors.dart';
import 'package:mycic_app/presentation/widgets/absensi_card.dart';
import 'package:mycic_app/presentation/widgets/default_app_bar.dart';

class AbsensiPage extends StatelessWidget {
  AbsensiPage({super.key});

  final List<Map<String, dynamic>> itemData = [
    {
      "mata_kuliah": "Pemrograman",
      "kehadiran": [true, true, false, false, true, true],
    },
    {
      "mata_kuliah": "Matematika",
      "kehadiran": [true, false, false, true, true, true, true, true, false],
    },
    {
      "mata_kuliah": "Algoritma Dasar",
      "kehadiran": [true, true, true, false, true, true, false],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: 'Daftar Kehadiran'),
      backgroundColor: AppColors.bgDefault,
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: itemData.length,
        itemBuilder: (context, index) {
          final item = itemData[index];
          return AbsensiCard(
            mataKuliah: item["mata_kuliah"],
            kehadiran: item["kehadiran"],
          );
        },
      ),
    );
  }
}
