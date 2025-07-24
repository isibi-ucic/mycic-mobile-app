import 'package:flutter/material.dart';
import 'package:myapp/core/constants/colors.dart';

class SimpleUnderlineButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const SimpleUnderlineButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, color: AppColors.black),
            ),
          ),
        ),
        Container(
          height: 1, // 1px tinggi
          color: Colors.black45, // warna garis
        ),
      ],
    );
  }
}
