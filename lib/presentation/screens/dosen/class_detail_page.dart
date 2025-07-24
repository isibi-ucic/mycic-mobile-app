import 'package:flutter/material.dart';
import 'package:myapp/core/constants/colors.dart';
import 'package:myapp/core/helper/ms_route.dart';
import 'package:myapp/presentation/screens/dosen/detail_pertemuan_page.dart';
import 'package:myapp/presentation/widgets/default_app_bar.dart';

class ClassDetailPage extends StatelessWidget {
  final String? namaMatkul;
  final String? dosen;
  final String? waktu;
  final String? ruangan;

  ClassDetailPage({
    super.key,
    this.namaMatkul,
    this.dosen,
    this.waktu,
    this.ruangan,
  });

  final itemPertemuan = [
    {'title': 'Pertemuan 1'},
    {'title': 'Pertemuan 2'},
    {'title': 'Pertemuan 3'},
    {'title': 'Pertemuan 4'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: "Detail Kelas"),
      backgroundColor: AppColors.bgDefault,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),

          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      namaMatkul ?? '',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Dosen: ${dosen ?? ""}',
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text(
                          waktu ?? "",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Text('|'),
                        const SizedBox(width: 16),
                        Text(
                          'Ruangan: ${ruangan ?? ''}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: const Divider(height: 1),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: itemPertemuan.length,
                itemBuilder: (context, index) {
                  final tugas = itemPertemuan[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        msRoute(context, DetailPertemuanPage());
                      },
                      child: Card(
                        elevation: 1,
                        color: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 20,
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    tugas['title'] as String,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Tap untuk detail',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Divider(
                                  height: 1,
                                  color: AppColors.grey,
                                ),
                              ),
                              Text(
                                "Pertemuan ini membahas bagaimana cara coding tanpa software, consectetur adipiscing elit...",
                                textAlign: TextAlign.justify,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              // Tambahan informasi lain jika perlu
            ],
          ),
        ),
      ),
    );
  }
}
