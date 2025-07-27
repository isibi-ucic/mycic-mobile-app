import 'package:flutter/material.dart';
import 'package:mycic_app/core/components/buttons.dart';
import 'package:mycic_app/presentation/widgets/app_bar_with_profile.dart';

class TranskripPage extends StatelessWidget {
  const TranskripPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> nilai = [
      {'no': '1', 'mataKuliah': 'Matematika', 'predikat': 'A'},
      {'no': '2', 'mataKuliah': 'Fisika', 'predikat': 'B'},
      {'no': '3', 'mataKuliah': 'Pemrograman', 'predikat': 'A'},
      {'no': '4', 'mataKuliah': 'Bahasa Inggris', 'predikat': 'B'},
    ];
    final double ipk = 3.75;
    final int totalSks = 120;
    return Scaffold(
      appBar: AppBarWithProfile(
        title: 'Transkrip Nilai',
        showBackButton: true,
        onBackTap: () => Navigator.pop(context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Table(
                  border: TableBorder.symmetric(
                    inside: const BorderSide(color: Colors.grey, width: 0.3),
                  ),
                  columnWidths: const {
                    0: FixedColumnWidth(50),
                    1: FlexColumnWidth(),
                    2: FixedColumnWidth(70),
                  },
                  children: [
                    // Header
                    TableRow(
                      decoration: BoxDecoration(color: Colors.blue.shade50),
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(12),
                          child: Center(
                            child: Text(
                              'No',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            'Mata Kuliah',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(12),
                          child: Center(
                            child: Text(
                              'Nilai',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Isi
                    ...nilai.map((item) {
                      return TableRow(
                        decoration: const BoxDecoration(color: Colors.white),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Center(child: Text(item['no']!)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(item['mataKuliah']!),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Center(child: Text(item['predikat']!)),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),

            const Spacer(),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text(
                        'IPK',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        ipk.toStringAsFixed(2),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        'Total SKS',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        totalSks.toString(),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),

            Button.filled(
              label: 'Cetak Transkrip',
              onPressed: () {
                // Implement the print functionality here
              },
            ),
          ],
        ),
      ),
    );
  }
}
