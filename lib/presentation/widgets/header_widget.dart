// Suggested code may be subject to a license. Learn more: ~LicenseLog:959956025.
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mycic_app/core/constants/colors.dart';
import 'package:mycic_app/presentation/screens/informasi_page.dart';
import 'package:mycic_app/presentation/screens/mhs/profile_page.dart';

class HeaderWidget extends StatelessWidget {
  final String profileImageUrl;

  const HeaderWidget({super.key, required this.profileImageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 28, 0, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Kiri: MYCIC
          const Text(
            '',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          // Kanan: Notifikasi & Profil
          Row(
            children: [
              IconButton(
                icon: const Icon(LucideIcons.bellDot),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InformasiPage()),
                  );
                },
              ),

              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CachedNetworkImage(
                    imageUrl: profileImageUrl,
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                    placeholder:
                        (context, url) => Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.black,
                              width: 1,
                            ),
                          ),
                          child: const CircleAvatar(
                            radius: 18,
                            backgroundColor: AppColors.grey,
                            child: Icon(LucideIcons.user, color: Colors.white),
                          ),
                        ),
                    errorWidget:
                        (context, url, error) => const CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.deepOrangeAccent,
                          child: Icon(LucideIcons.user, color: Colors.white),
                        ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
