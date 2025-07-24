import 'package:flutter/material.dart';

class InformasiCard extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final bool isImportant;

  const InformasiCard({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    this.isImportant = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (isImportant)
                    const Padding(
                      padding: EdgeInsets.only(left: 6),
                      child: Icon(
                        Icons.circle,
                        size: 8,
                        color: Colors.red,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(color: Colors.black87),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  date,
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                ),
              )
            ],
          ),
        ),
        const Divider(height: 1, thickness: 0.8),
      ],
    );
  }
}
