import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UjianCard extends StatelessWidget {
  final Ujian ujian;

  const UjianCard({super.key, required this.ujian});

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'terjadwal':
        return Colors.grey;
      case 'selesai':
        return Colors.green;
      case 'batal':
        return Colors.red;
      default:
        return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormatted = DateFormat(
      'dd MMM yyyy, HH:mm',
      'id_ID',
    ).format(ujian.waktu);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(blurRadius: 6, offset: Offset(0, 2), color: Colors.black12),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Mata kuliah + status
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.menu_book_outlined, size: 24),
              const SizedBox(width: 8),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      const TextSpan(
                        text: 'Mata kuliah: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: ujian.mataKuliah),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Row(
                children: [
                  // Icon(
                  //   Icons.circle,
                  //   size: 10,
                  //   color: getStatusColor(ujian.status),
                  // ),
                  // const SizedBox(width: 4),
                  // Text(
                  //   ujian.status,
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.bold,
                  //     color: getStatusColor(ujian.status),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Waktu
          Row(
            children: [
              const Icon(Icons.calendar_month, size: 22),
              const SizedBox(width: 8),
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    const TextSpan(
                      text: 'Waktu: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: dateFormatted),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Ujian {
  final String mataKuliah;
  final DateTime waktu;
  final String status; // contoh: 'Terjadwal', 'Selesai'

  Ujian({required this.mataKuliah, required this.waktu, required this.status});
}
