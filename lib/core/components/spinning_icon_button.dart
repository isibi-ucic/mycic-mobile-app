import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SpinningIconButton extends StatefulWidget {
  final IconData icon;
  final Color color;
  final double size;
  final VoidCallback? onPressed;

  const SpinningIconButton({
    super.key,
    this.icon = Icons.autorenew,
    this.color = Colors.blue,
    this.size = 24.0,
    this.onPressed,
  });

  @override
  _SpinningIconButtonState createState() => _SpinningIconButtonState();
}

class _SpinningIconButtonState extends State<SpinningIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1), // Kecepatan putaran
      vsync: this,
    )..repeat(); // Ulangi animasi terus-menerus
  }

  @override
  void dispose() {
    _controller.dispose(); // Hentikan animasi saat widget tidak aktif
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: IconButton(
        icon: Icon(widget.icon),
        color: widget.color,
        iconSize: widget.size,
        onPressed: () {
          HapticFeedback.heavyImpact();
          widget.onPressed;
        },
      ),
    );
  }
}
