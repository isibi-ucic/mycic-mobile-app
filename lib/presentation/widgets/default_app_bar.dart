import 'package:flutter/material.dart';
import 'package:myapp/core/constants/colors.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function()? onTapBack;

  const DefaultAppBar({super.key, required this.title, this.onTapBack});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      shadowColor: Colors.grey[100],
      scrolledUnderElevation: 2.0,

      backgroundColor: Colors.white,
      titleSpacing: 12, // agar sejajar dengan leading
      title: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black54,
            ),
            onPressed: () {
              if (onTapBack == null) {
                Navigator.of(context).pop();
              }else{
                onTapBack!();
              }
            },
          ),

          SizedBox(width: 16),

          Text(title, style: TextStyle(color: AppColors.black, fontSize: 22)),
        ],
      ),
      surfaceTintColor: AppColors.white,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
