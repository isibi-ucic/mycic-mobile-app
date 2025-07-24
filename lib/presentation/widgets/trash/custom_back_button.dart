import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final Color iconColor;
  final String? title;
  final Color backgroundColor;
  final VoidCallback? onPressed;

  const CustomBackButton({
    super.key,
    this.title,
    this.iconColor = Colors.black,
    this.backgroundColor = const Color(0xFFF1F1F1),
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16),
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: iconColor),
            onPressed: onPressed ?? () => Navigator.of(context).pop(),
          ),
        ),
        if (title != null) ...[
          const SizedBox(width: 8),
          Text(
            title!,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ],
    );
  }
}
