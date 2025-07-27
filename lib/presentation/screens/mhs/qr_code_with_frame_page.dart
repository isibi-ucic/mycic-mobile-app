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
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true); // <-- PERUBAHAN 1: Animasi bolak-balik

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
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
      if (mounted && result == null) {
        // Hentikan animasi dan kamera setelah kode ditemukan
        _animationController.stop();
        controller.pauseCamera();

        setState(() {
          result = scanData;
        });

        // Tampilkan dialog atau kembali ke halaman sebelumnya dengan hasil
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text('QR Code Ditemukan!'),
                content: Text('Data: ${scanData.code}'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Tutup dialog
                      Navigator.pop(
                        context,
                        scanData.code,
                      ); // Kembali ke halaman sebelumnya
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final scanBoxSize = MediaQuery.of(context).size.width * 0.7;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.white,
              borderRadius: 12,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: scanBoxSize,
            ),
          ),
          // Frame animasi laser
          SizedBox(
            width: scanBoxSize,
            height: scanBoxSize,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return CustomPaint(
                  painter: ScannerLaserPainter(
                    animationValue: _animation.value,
                  ),
                );
              },
            ),
          ),
          // Tambahkan teks petunjuk
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.15,
            child: const Text(
              'Arahkan kamera ke QR Code',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

// PERUBAHAN 2: CustomPainter baru untuk efek laser
class ScannerLaserPainter extends CustomPainter {
  final double animationValue;

  ScannerLaserPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final laserY = size.height * animationValue;
    const laserHeight = 60.0; // Ketinggian gradasi laser

    // Definisikan area untuk gradasi
    final Rect rect = Rect.fromLTWH(
      0,
      laserY - laserHeight / 2,
      size.width,
      laserHeight,
    );

    // Buat gradasi linear
    final gradient = LinearGradient(
      colors: [
        Colors.transparent,
        Colors.red.withOpacity(0.8),
        Colors.transparent,
      ],
      stops: const [0.0, 0.5, 1.0], // Tengah terang, tepi transparan
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    // Buat Paint dengan shader dari gradasi
    final paint = Paint()..shader = gradient.createShader(rect);

    // Gambar persegi panjang dengan gradasi tersebut
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant ScannerLaserPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
