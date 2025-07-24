import 'package:flutter/material.dart';
import 'package:myapp/core/constants/colors.dart';
import 'package:myapp/presentation/widgets/default_app_bar.dart';

class UjianPage extends StatelessWidget {
  UjianPage({super.key});

  final List<Map<String, dynamic>> jadwal = [
    {
      'hari': 'Senin, 24 Maret 2023',
      'kelas': [
        {
          'nama': 'Matematika',
          'jam': '08:00 - 09:30',
          'status': 'selesai',
          'hasSubmit': true,
        },
        {
          'nama': 'Fisika',
          'jam': '10:00 - 11:30',
          'status': 'selesai',
          'hasSubmit': false,
        },
      ],
    },
    {
      'hari': 'Selasa, 25 Maret 2023',
      'kelas': [
        {
          'nama': 'Kimia',
          'jam': '09:00 - 10:30',
          'status': null,
          'hasSubmit': false,
        },
      ],
    },
    {
      'hari': 'Rabu, 26 Maret 2023',
      'kelas': [
        {
          'nama': 'Biologi',
          'jam': '07:30 - 09:00',
          'status': null,
          'hasSubmit': false,
        },
        {
          'nama': 'Bahasa Inggris',
          'jam': '09:30 - 11:00',
          'status': null,
          'hasSubmit': false,
        },
        {
          'nama': 'Sejarah',
          'jam': '11:30 - 13:00',
          'status': null,
          'hasSubmit': false,
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: 'Jadwal Ujian'),
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
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              ...List.generate(item['kelas'].length, (kelasIndex) {
                final kelas = item['kelas'][kelasIndex];

                return Card(
                  color: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 1,
                  child: ListTile(
                    trailing: SizedBox(
                      width: 100,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child:
                            kelas['status'] == 'selesai'
                                ? const Text(
                                  'Selesai',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(color: Colors.green),
                                )
                                : const Text(
                                  'Belum dimulai',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(color: Colors.red),
                                ),
                      ),
                    ),
                    title: Text(
                      kelas['nama'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('${kelas['jam']}'),
                    // leading: Icon(LucideIcons.clock4, size: 32),
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
