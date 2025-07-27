import 'package:flutter/material.dart';
import 'package:mycic_app/core/assets/assets.gen.dart';
import 'package:mycic_app/core/constants/colors.dart';

class MenuItem {
  final String title;
  final AssetGenImage icon;

  MenuItem({required this.title, required this.icon});
}

class MenuSection extends StatelessWidget {
  final List<MenuItem> items;
  final VoidCallback onSeeAll;

  const MenuSection({super.key, required this.items, required this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header Menu
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Menu",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: onSeeAll,
                child: Row(
                  children: const [
                    Text("All", style: TextStyle(color: AppColors.black)),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: AppColors.black,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Menu Grid
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              final item = items[index];
              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha((0.1 * 255).toInt()),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(18),
                    // child: Icon(item.icon, size: 32, color: Colors.teal),
                    child: item.icon.image(height: 28, width: 28),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.title,
                    style: const TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
