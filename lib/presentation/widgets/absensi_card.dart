import 'package:flutter/material.dart';

class AbsensiCard extends StatelessWidget {
  final String mataKuliah;
  final List<bool?> kehadiran;

  const AbsensiCard({
    super.key,
    required this.mataKuliah,
    required this.kehadiran,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            mataKuliah,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 4),
          Text(
            "Pertemuan 1 - ${kehadiran.length}",
            style: const TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(kehadiran.length, (i) {
              final status = kehadiran[i];
              Color bgColor;
              if (status == true) {
                bgColor = Colors.green;
              } else if (status == false) {
                bgColor = Colors.red;
              } else {
                bgColor = Colors.grey;
              }

              return Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "P${i + 1}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
