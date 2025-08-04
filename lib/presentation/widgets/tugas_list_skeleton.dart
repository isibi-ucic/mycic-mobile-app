// WIDGET SKELETON UNTUK DAFTAR TUGAS
import 'package:flutter/material.dart';

class TugasListSkeleton extends StatelessWidget {
  const TugasListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3, // Tampilkan 3 item placeholder
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 12),
      itemBuilder:
          (context, index) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 16,
                      width: double.infinity,
                      color: Colors.black12,
                    ),
                    const SizedBox(height: 8),
                    Container(height: 12, width: 150, color: Colors.black12),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
