import 'package:flutter/material.dart';
import 'package:mycic_app/core/assets/assets.gen.dart';

class MenuItemTile extends StatelessWidget {
  final String title;
  final AssetGenImage iconData;
  final VoidCallback onTap;

  const MenuItemTile({
    super.key,
    required this.title,
    required this.iconData,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(16),
            ),
            child: iconData.image(height: 28, width: 28),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
