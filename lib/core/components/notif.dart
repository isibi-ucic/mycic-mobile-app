import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class Notif {
  static void show(
    BuildContext context, {
    required String title,
    String? description,
    ToastificationType type = ToastificationType.warning,
    ToastificationStyle style = ToastificationStyle.flatColored,
    bool showProgressBar = false,
    EdgeInsets margin = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    Duration autoCloseDuration = const Duration(seconds: 4),
    Alignment alignment = Alignment.topCenter,
    Curve animationCurve = Curves.easeInOut,
  }) {
    toastification.show(
      context: context,
      title: Text(title),
      description: description != null ? Text(description) : null,
      type: type,
      style: style,
      showProgressBar: showProgressBar,
      margin: margin,
      autoCloseDuration: autoCloseDuration,
      alignment: alignment,
      // animationBuilder: (context, animation, alignment, child) {
      //   return SlideTransition(
      //     position: Tween<Offset>(
      //       begin: const Offset(0, -1), // Mulai dari atas
      //       end: Offset.zero, // Berhenti di posisi normal
      //     ).animate(animation),
      //     child: child,
      //   );
      // },
      closeButtonShowType: CloseButtonShowType.none,
    );
  }
}
