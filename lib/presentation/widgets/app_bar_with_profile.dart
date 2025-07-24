import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AppBarWithProfile extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final VoidCallback? onBackTap;

  const AppBarWithProfile({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.onBackTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 16); // tinggi AppBar lebih lega

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (showBackButton) ...[
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                onPressed: onBackTap ?? () => Navigator.of(context).pop(),
              ),
              const SizedBox(width: 8),
            ],
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            // Kanan: Notifikasi & Profil
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications_none),
                  onPressed: () {},
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {},
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CachedNetworkImage(
                      imageUrl: 'https://via.placeholder.com/150',
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                      placeholder:
                          (context, url) => const CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.grey,
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                      errorWidget:
                          (context, url, error) => const CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.red,
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
