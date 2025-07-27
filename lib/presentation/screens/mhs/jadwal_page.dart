import 'package:flutter/material.dart';
import 'package:mycic_app/core/constants/colors.dart';
import 'package:mycic_app/presentation/widgets/default_app_bar.dart';

class JadwalPage extends StatelessWidget {
  JadwalPage({super.key});

  final List<Map<String, dynamic>> jadwal = [
    {
      'hari': 'Senin',
      'kelas': [
        {'nama': 'Matematika', 'jam': '08:00 - 09:30', 'ruangan': 'Ruang 101'},
        {'nama': 'Fisika', 'jam': '10:00 - 11:30', 'ruangan': 'Ruang 102'},
      ],
    },
    {
      'hari': 'Selasa',
      'kelas': [
        {'nama': 'Kimia', 'jam': '09:00 - 10:30', 'ruangan': 'Ruang 201'},
      ],
    },
    {
      'hari': 'Rabu',
      'kelas': [
        {'nama': 'Biologi', 'jam': '07:30 - 09:00', 'ruangan': 'Ruang 301'},
        {
          'nama': 'Bahasa Inggris',
          'jam': '09:30 - 11:00',
          'ruangan': 'Ruang 302',
        },
        {'nama': 'Sejarah', 'jam': '11:30 - 13:00', 'ruangan': 'Ruang 303'},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: 'Jadwal Kuliah'),
      backgroundColor: AppColors.bgDefault,
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: jadwal.length,
        itemBuilder: (context, index) {
          final item = jadwal[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item['hari'],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              ...List.generate(item['kelas'].length, (kelasIndex) {
                final kelas = item['kelas'][kelasIndex];
                return Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),

                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 0,
                  child: ListTile(
                    title: Text(kelas['nama']),
                    subtitle: Text('${kelas['jam']} - ${kelas['ruangan']}'),
                    leading: const Icon(Icons.school),
                  ),
                );
              }),
              const SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }
}
