import 'package:flutter/material.dart';
import 'package:myapp/core/constants/colors.dart';
import 'package:myapp/core/helper/ms_route.dart';
import 'package:myapp/presentation/screens/dosen/class_detail_page.dart';
import 'package:myapp/presentation/screens/dosen/template_page.dart';
import 'package:myapp/presentation/widgets/class_card.dart';
import 'package:myapp/presentation/widgets/default_app_bar.dart';

class ClassPage extends StatefulWidget {
  const ClassPage({super.key});

  @override
  State<ClassPage> createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  Future<void> _loadData() async {
    print("Hello");
  }

  final List<Map<String, dynamic>> kelasList = [
    {
      "hari": "Senin",
      "kelas": [
        {
          'waktu': '09:00 - 11.30',
          'kelas': 'Matematika',
          'dosen': 'Bapak Ahmad',
          'ruangan': 'Ruang 101',
        },
      ],
    },
    {
      "hari": "Selasa",
      "kelas": [
        {
          'waktu': '09:00 - 11.30',
          'kelas': 'Algoritma',
          'dosen': 'Bapak Ahmad',
          'ruangan': 'Ruang 101',
        },
        {
          'waktu': '13:00 - 15.30',
          'kelas': 'Algoritma',
          'dosen': 'Bapak Ahmad',
          'ruangan': 'Ruang 101',
        },
      ],
    },
    {
      "hari": "Rabu",
      "kelas": [
        {
          'waktu': '09:00 - 11.30',
          'kelas': 'Algoritma',
          'dosen': 'Bapak Ahmad',
          'ruangan': 'Ruang 101',
        },
        {
          'waktu': '13:00 - 15.30',
          'kelas': 'Algoritma',
          'dosen': 'Bapak Ahmad',
          'ruangan': 'Ruang 101',
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: "Daftar Kelas",
        onTapBack: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TemplateDosenPage()),
          );
        },
      ),
      backgroundColor: AppColors.bgDefault,
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: kelasList.length,
        itemBuilder: (context, index) {
          final item = kelasList[index];
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
                return GestureDetector(
                  onTap: () {
                    msRoute(
                      context,
                      ClassDetailPage(
                        namaMatkul: kelas['kelas']!,
                        dosen: kelas['dosen']!,
                        waktu: kelas['waktu']!,
                        ruangan: kelas['ruangan']!,
                      ),
                    );
                  },
                  child: ClassCard(
                    waktu: kelas['waktu']!,
                    kelas: kelas['kelas']!,
                    dosen: kelas['dosen']!,
                    ruangan: kelas['ruangan']!,
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
