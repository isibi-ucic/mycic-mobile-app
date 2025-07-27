import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myapp/core/assets/assets.dart';
import 'package:myapp/core/components/buttons.dart';
import 'package:myapp/core/constants/colors.dart';
import 'package:myapp/presentation/screens/mhs/presensi_manual_page.dart';
import 'package:myapp/presentation/screens/mhs/template_page.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage>
    with SingleTickerProviderStateMixin {
  bool isCameraPaused = false; // <-- TAMBAHKAN VARIABEL INI
  // Tambahkan mixin ini
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // Variabel untuk animasi
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller animasi
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  void dispose() {
    // Hentikan semua controller saat halaman ditutup
    controller?.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scanBoxSize = MediaQuery.of(context).size.width * 0.7;

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // QRView, Animasi Laser, dan Tombol Kembali tetap sama...
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.blueAccent,
              borderRadius: 12,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: scanBoxSize,
            ),
          ),
          Center(
            child: SizedBox(
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
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 16,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF1F1F1),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),

          // Bungkus DraggableScrollableSheet dengan NotificationListener
          NotificationListener<DraggableScrollableNotification>(
            onNotification: (notification) {
              // Tentukan ambang batas kapan kamera harus mati/hidup
              // Misalnya, saat panel ditarik lebih dari layar
              final double threshold = 0.15;

              // Jika panel ditarik ke atas melewati ambang batas & kamera sedang aktif
              if (notification.extent > threshold && !isCameraPaused) {
                setState(() {
                  controller?.pauseCamera();
                  _animationController.stop();
                  isCameraPaused = true;
                });
              }
              // Jika panel ditarik ke bawah melewati ambang batas & kamera sedang mati
              else if (notification.extent < threshold && isCameraPaused) {
                setState(() {
                  controller?.resumeCamera();
                  _animationController.repeat(reverse: true);
                  isCameraPaused = false;
                });
              }
              return true; // Mengindikasikan bahwa notifikasi sudah ditangani
            },
            child: DraggableScrollableSheet(
              initialChildSize: 0.12,
              minChildSize: 0.12,
              maxChildSize: 0.6,
              builder: (
                BuildContext context,
                ScrollController scrollController,
              ) {
                // Isi dari DraggableScrollableSheet tetap sama
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          Container(
                            width: 40,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 16.0,
                              bottom: 36,
                            ),
                            child: const Text(
                              'Atau Input Kode Manual',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),

                          TextField(
                            decoration: const InputDecoration(
                              labelText: 'Masukkan Kode Presensi',
                              border: OutlineInputBorder(),
                            ),
                            onSubmitted: (value) {
                              print('Kode yang disubmit: $value');
                              // TODO: Kirim kode 'value' ke API
                            },
                            onTap: () {
                              // Saat textfield diketuk, pastikan kamera mati
                              if (!isCameraPaused) {
                                setState(() {
                                  controller?.pauseCamera();
                                  _animationController.stop();
                                  isCameraPaused = true;
                                });
                              }
                            },
                          ),
                          const SizedBox(height: 20),
                          Button.filled(
                            label: "Submit",
                            color: AppColors.primary,
                            onPressed: () {
                              // TODO: Kirim kode 'value' ke API

                              _showSuccessDialog(context, "78324h23");
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      // Cek agar hanya memproses satu kali scan
      if (mounted && result == null) {
        // Hentikan kamera dan animasi setelah berhasil scan
        controller.pauseCamera();
        _animationController.stop();

        setState(() {
          result = scanData;
        });

        // Opsional: Jika Anda ingin kembali otomatis setelah scan berhasil
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            _showSuccessDialog(context, scanData.code!);
          }
        });
      }
    });
  }
}

// Painter untuk animasi laser (diambil dari contoh sebelumnya)
class ScannerLaserPainter extends CustomPainter {
  final double animationValue;

  ScannerLaserPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final laserY = size.height * animationValue;
    const laserHeight = 60.0; // Ketinggian gradasi laser

    final Rect rect = Rect.fromLTWH(
      0,
      laserY - laserHeight / 2,
      size.width,
      laserHeight,
    );

    final gradient = LinearGradient(
      colors: [Colors.transparent, Colors.blueAccent, Colors.transparent],
      stops: const [0.0, 0.5, 1.0],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    final paint = Paint()..shader = gradient.createShader(rect);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant ScannerLaserPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}

void _showSuccessDialog(BuildContext context, String code) {
  showDialog(
    context: context,
    barrierDismissible: false, // Pengguna harus menekan tombol untuk keluar
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 20),
              child: Assets.icons.success.svg(height: 100),
            ),
            Text(
              'Selamat!',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 8),
            Text(
              'Anda telah berhasil melakukan presensi matakuliah Algoritma $code.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              // Kembali ke TemplatePage dan hapus semua rute sebelumnya
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const TemplateMhsPage(),
                ),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      );
    },
  );
}
