import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycic_app/core/assets/assets.dart';
import 'package:mycic_app/core/components/buttons.dart';
import 'package:mycic_app/core/constants/colors.dart';
import 'package:mycic_app/features/bloc/submit_presensi/submit_presensi_bloc.dart';
import 'package:mycic_app/presentation/screens/mhs/presensi_manual_page.dart';
import 'package:mycic_app/presentation/screens/mhs/template_page.dart';
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

  // --- Tambahkan controller untuk TextField ---
  final TextEditingController _manualCodeController = TextEditingController();

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
    _animationController.dispose();
    super.dispose();
  }

  // --- Fungsi untuk memicu event BLoC ---
  void _submitCode(String rawCode) {
    if (rawCode.isNotEmpty) {
      final String finalCode =
          rawCode.length > 8 ? rawCode.substring(0, 8) : rawCode;
      context.read<SubmitPresensiBloc>().add(
        SubmitPresensiEvent.submitPresensi(finalCode),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final scanBoxSize = MediaQuery.of(context).size.width * 0.7;

    return BlocListener<SubmitPresensiBloc, SubmitPresensiState>(
      listener: (context, state) {
        // Tangani state di sini
        state.maybeWhen(
          loading: () {
            // Opsional: Tampilkan loading indicator
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Memproses presensi...')),
            );
          },
          success: (message) {
            // Jika sukses, tampilkan dialog
            _showSuccessDialog(context, message);
          },
          error: (message) {
            // Jika error, tampilkan pesan error
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message), backgroundColor: Colors.red),
            );
            // Hidupkan lagi kamera jika error
            controller?.resumeCamera();
            _animationController.repeat(reverse: true);
          },
          orElse: () {},
        );
      },
      child: Scaffold(
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
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),

            // Bungkus DraggableScrollableSheet dengan NotificationListener
            NotificationListener<DraggableScrollableNotification>(
              onNotification: (notification) {
                // Tentukan ambang batas kapan kamera harus mati/hidup
                // Misalnya, saat panel ditarik lebih dari layar
                const double threshold = 0.15;

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
                            const Padding(
                              padding: EdgeInsets.only(top: 16.0, bottom: 36),
                              child: Text(
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
                                _submitCode(value); // Panggil fungsi submit
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
                            // --- Modifikasi Button ---
                            BlocBuilder<
                              SubmitPresensiBloc,
                              SubmitPresensiState
                            >(
                              builder: (context, state) {
                                // Tampilkan loading di tombol jika state loading
                                final isLoading = state.maybeWhen(
                                  loading: () => true,
                                  orElse: () => false,
                                );

                                return Button.filled(
                                  label: isLoading ? "Loading..." : "Submit",
                                  color: AppColors.primary,
                                  onPressed:
                                      isLoading
                                          ? null // Nonaktifkan tombol saat loading
                                          : () {
                                            _submitCode(
                                              _manualCodeController.text,
                                            );
                                          },
                                );
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
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (mounted) {
        // Hentikan kamera segera setelah data diterima
        controller.pauseCamera();
        _animationController.stop();

        // Langsung panggil fungsi submit tanpa menunggu
        _submitCode(scanData.code!);
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

void _showSuccessDialog(BuildContext context, String message) {
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
            const Text(
              'Presensi Berhasil!',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 8),
            Text(
              message,
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
