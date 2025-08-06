import 'package:flutter/material.dart';

class MahasiswaRekapRow extends StatelessWidget {
  final int index;
  final String nama;
  final String nim;
  final String rekap;

  const MahasiswaRekapRow({
    super.key,
    required this.index,
    required this.nama,
    required this.nim,
    required this.rekap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        children: [
          // Nomor Urut
          SizedBox(
            width: 30,
            child: Text(
              '${index + 1}.',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          // Nama dan NIM
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(nama, style: const TextStyle(fontWeight: FontWeight.w500)),
                Text(
                  nim,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          // Rekap Kehadiran
          Text(rekap, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
