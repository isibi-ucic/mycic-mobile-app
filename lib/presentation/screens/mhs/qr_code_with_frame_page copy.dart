import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class QrCodeWithFramePage extends StatefulWidget {
  const QrCodeWithFramePage({super.key});

  @override
  _QrCodeWithFramePageState createState() => _QrCodeWithFramePageState();
}

class _QrCodeWithFramePageState extends State<QrCodeWithFramePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? result;

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  @override
  void dispose() {
    controller?.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (result == null) {
        setState(() {
          result = scanData;
        });
        controller.pauseCamera();
        Navigator.pop(context, scanData.code); // atau simpan hasil
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final scanBoxSize = MediaQuery.of(context).size.width * 0.7;

    return Scaffold(
      body: Stack(
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.white,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: scanBoxSize,
            ),
          ),
          // ClipPath Overlay (untuk gelap-terang)
          ClipPath(
            clipper: ScannerOverlayClip(scanBoxSize),
            child: Container(color: Colors.black),
          ),
          // Garis animasi
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, _) {
                final top =
                    (MediaQuery.of(context).size.height - scanBoxSize) / 2 +
                    (scanBoxSize * _animation.value);

                return CustomPaint(
                  painter: ScannerLinePainter(top, scanBoxSize),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ScannerOverlayClip extends CustomClipper<Path> {
  final double scanBoxSize;

  ScannerOverlayClip(this.scanBoxSize);

  @override
  Path getClip(Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final rect = Rect.fromCenter(
      center: center,
      width: scanBoxSize,
      height: scanBoxSize,
    );

    final path =
        Path()
          ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
          ..addRRect(RRect.fromRectXY(rect, 12, 12));

    return Path.combine(
      PathOperation.difference,
      path,
      Path()..addRRect(RRect.fromRectXY(rect, 12, 12)),
    );
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class ScannerLinePainter extends CustomPainter {
  final double y;
  final double width;

  ScannerLinePainter(this.y, this.width);

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.redAccent
          ..strokeWidth = 3;

    final xStart = (size.width - width) / 2 + 8;
    final xEnd = (size.width + width) / 2 - 8;

    canvas.drawLine(Offset(xStart, y), Offset(xEnd, y), paint);
  }

  @override
  bool shouldRepaint(covariant ScannerLinePainter oldDelegate) {
    return oldDelegate.y != y;
  }
}
