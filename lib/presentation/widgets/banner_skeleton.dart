// -- TAMBAHKAN --
// Widget placeholder untuk banner saat loading
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BannerSkeleton extends StatelessWidget {
  const BannerSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ],
      options: CarouselOptions(
        height: 155,
        enlargeCenterPage: true,
        viewportFraction: 0.92,
      ),
    );
  }
}
