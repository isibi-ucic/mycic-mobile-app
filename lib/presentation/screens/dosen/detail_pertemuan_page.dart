import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_gallery_saver/flutter_image_gallery_saver.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:mycic_app/core/assets/assets.gen.dart';
import 'package:mycic_app/core/components/buttons.dart';
import 'package:mycic_app/core/constants/colors.dart';
import 'package:mycic_app/core/helper/ms_route.dart';
import 'package:mycic_app/features/bloc/dsn_kelas_pertemuan_detail/dsn_kelas_pertemuan_detail_bloc.dart';
import 'package:mycic_app/features/bloc/generate_qr/generate_qr_bloc.dart';
import 'package:mycic_app/presentation/screens/dosen/template_page.dart';
import 'package:mycic_app/presentation/widgets/default_app_bar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class DetailPertemuanPage extends StatefulWidget {
  final int pertemuanId;

  String namaMatkul;
  String ruangan;
  String waktu;

  DetailPertemuanPage({
    super.key,
    required this.pertemuanId,
    required this.namaMatkul,
    required this.ruangan,
    required this.waktu,
  });

  @override
  State<DetailPertemuanPage> createState() => _DetailPertemuanPageState();
}

class _DetailPertemuanPageState extends State<DetailPertemuanPage> {
  // 1. Buat ScreenshotController dan GlobalKey
  final ScreenshotController _screenshotController = ScreenshotController();
  // --- STATE BARU UNTUK MENYIMPAN DATETIME DARI FORM ---
  DateTime? _selectedDateTime;

  @override
  void initState() {
    super.initState();
    // Memuat data saat halaman pertama kali dibuka
    _loadData();
  }

  // Fungsi untuk memuat ulang data, dipanggil oleh RefreshIndicator
  Future<void> _loadData() async {
    context.read<DsnKelasPertemuanDetailBloc>().add(
      DsnKelasPertemuanDetailEvent.fetch(widget.pertemuanId),
    );
  }

  // --- FUNGSI BARU UNTUK MEMBUKA DATE & TIME PICKER ---
  Future<void> _pickDateTime() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (date == null || !mounted) return;

    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDateTime ?? DateTime.now()),
    );

    if (time == null) return;

    setState(() {
      _selectedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  // 2. Perbaiki fungsi untuk Share QR Code
  // 1. BUAT FUNGSI INTERNAL BARU
  // Fungsi ini bertugas menangkap gambar QR dan mengembalikannya sebagai File
  Future<File?> _captureAndGetQrFile() async {
    // Ambil data QR dari state BLoC
    final state = context.read<DsnKelasPertemuanDetailBloc>().state;
    final qrCodeData = state.maybeWhen(
      success: (response) => response,
      orElse: () => null,
    );

    if (qrCodeData == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal mendapatkan data QR Code.')),
        );
      }
      return null;
    }

    try {
      // 1. Buat widget QR yang akan di-capture (dengan background putih)
      final qrWidgetToCapture = Container(
        // buat agar fit lebarnya
        width: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              QrImageView(
                data: qrCodeData.data.qrPresensi!,
                version: QrVersions.auto,
                size: MediaQuery.of(context).size.width / 2,
                gapless: false,
              ),
              const SizedBox(height: 4),
              Text(
                "KODE UNIK : ${qrCodeData.data.qrPresensi!.substring(0, 8)}",
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 4),
              Text(
                "QR CODE ABSENSI PERTEMUAN ${qrCodeData.data.pertemuanKe}",
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 4),
              Text(
                "MATA KULIAH ${widget.namaMatkul.toUpperCase()}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 4),
              Text(
                "Tanggal Pertemuan Sabtu, ${qrCodeData.data.tanggal.toString().substring(0, 10)}",
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 4),
              Text(
                "Jam Kelas Mulai ${widget.waktu.substring(0, 5)}",
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      );

      // 2. Capture widget tersebut dan dapatkan hasilnya sebagai byte
      final imageBytes = await _screenshotController.captureFromWidget(
        qrWidgetToCapture,
        delay: const Duration(milliseconds: 10),
      );

      // 3. Simpan byte ke file temporer
      final directory = await getTemporaryDirectory();
      final imagePath = '${directory.path}/qr_presensi.png';
      final file = await File(imagePath).create();
      await file.writeAsBytes(imageBytes);
      return file;
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Gagal membuat file QR: $e')));
      }
      return null;
    }
  }

  // 2. MODIFIKASI FUNGSI SHARE
  // Sekarang fungsi ini hanya memanggil fungsi internal dan membagikan hasilnya
  Future<void> _shareQrCode() async {
    final imageFile = await _captureAndGetQrFile();
    if (imageFile == null) return;

    await Share.shareXFiles([
      XFile(imageFile.path),
    ], text: 'Silakan pindai QR Code ini untuk presensi.');
  }

  // 3. MODIFIKASI FUNGSI DOWNLOAD
  // Fungsi ini juga memanggil fungsi internal dan menyimpan hasilnya ke galeri
  Future<void> _downloadQrCode() async {
    final imageFile = await _captureAndGetQrFile();
    if (imageFile == null) return;

    await FlutterImageGallerySaver.saveFile(imageFile.path);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('QR Code berhasil disimpan di galeri.'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(title: 'Detail Pertemuan'),
      backgroundColor: AppColors.bgDefault,
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: BlocBuilder<
          DsnKelasPertemuanDetailBloc,
          DsnKelasPertemuanDetailState
        >(
          builder: (context, state) {
            // Gunakan maybeMap untuk mendapatkan data atau state lainnya dengan mudah
            return state.maybeMap(
              loading:
                  (_) => const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SpinKitThreeBounce(
                          color: Colors.blueAccent,
                          size: 20.0,
                        ),
                        Text("Loading..."),
                      ],
                    ),
                  ),
              success:
                  (successState) => SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        24,
                        20,
                        24,
                        100,
                      ), // Beri padding bawah
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pertemuan ${successState.data.data.pertemuanKe} - ${successState.data.data.materi}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // ... (Widget Wrap dan PDF View Anda tetap sama di sini)
                          Wrap(
                            spacing: 8,
                            children: [
                              Text(
                                widget.ruangan,
                                style: TextStyle(color: Colors.black54),
                              ),
                              Text(
                                '|',
                                style: TextStyle(color: Colors.black26),
                              ),
                              Text(
                                widget.waktu,
                                style: TextStyle(color: Colors.black54),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              color: Colors.grey[300],
                              child: const SizedBox(
                                height: 200,
                                child: Center(child: Text('PDF View')),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            successState.data.data.deskripsi,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 16),

                          // Bagian QR Code (jika ada)
                          if (successState.data.data.qrPresensi != null) ...[
                            const Divider(height: 32),
                            Container(
                              // buat agar fit lebarnya
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Center(
                                  child: QrImageView(
                                    data: successState.data.data.qrPresensi!,
                                    version: QrVersions.auto,
                                    size: MediaQuery.of(context).size.width / 2,
                                    gapless: false,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // --- Tombol Download ---
                                Material(
                                  color:
                                      Colors
                                          .transparent, // Buat Material transparan
                                  child: InkWell(
                                    onTap: _downloadQrCode,
                                    borderRadius: BorderRadius.circular(
                                      12,
                                    ), // Bentuk ripple sesuai border
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        children: [
                                          Assets.icons.download.svg(
                                            colorFilter: const ColorFilter.mode(
                                              AppColors.grey,
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          const Text("Download"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),

                                // --- Tombol Share ---
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: _shareQrCode,
                                    borderRadius: BorderRadius.circular(12),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        children: [
                                          Assets.icons.share.svg(
                                            colorFilter: const ColorFilter.mode(
                                              AppColors.grey,
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          const Text("Share"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
              // Tampilkan CircularProgressIndicator untuk state lainnya
              orElse: () => const Center(child: CircularProgressIndicator()),
            );
          },
        ),
      ),
      // 1. Gunakan bottomNavigationBar untuk tombol yang menempel di bawah
      bottomNavigationBar: _buildBottomSection(),
    );
  }

  // --- WIDGET BAGIAN BAWAH YANG BARU DAN LEBIH TERSTRUKTUR ---
  Widget _buildBottomSection() {
    // Gunakan BlocBuilder dari DetailPertemuan untuk menentukan apakah form atau QR yang ditampilkan
    return BlocBuilder<
      DsnKelasPertemuanDetailBloc,
      DsnKelasPertemuanDetailState
    >(
      builder: (context, state) {
        return state.maybeWhen(
          success: (response) {
            // JIKA QR BELUM ADA, tampilkan form generator
            if (response.data.qrPresensi == null) {
              return _buildQrGeneratorForm();
            }
            // Jika QR sudah ada, kembalikan widget kosong
            return const SizedBox.shrink();
          },
          // Kembalikan widget kosong untuk state lain (misal: loading awal)
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }

  // --- WIDGET BARU UNTUK FORM GENERATOR QR ---
  Widget _buildQrGeneratorForm() {
    // Listener untuk BLoC generate QR
    return BlocListener<GenerateQrBloc, GenerateQrState>(
      listener: (context, state) {
        state.whenOrNull(
          // Jika berhasil, tampilkan notifikasi dan muat ulang data halaman
          success: (qrData) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('QR Presensi berhasil dibuat!'),
                  backgroundColor: Colors.green,
                ),
              );
            // Panggil _loadData() untuk refresh halaman dan menampilkan QR
            _loadData();
          },
          // Jika gagal, tampilkan pesan error
          error: (errorMessage) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text('Gagal membuat QR: $errorMessage'),
                  backgroundColor: Colors.red,
                ),
              );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Pilih Waktu Mulai Presensi',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            // Input DateTime
            InkWell(
              onTap: _pickDateTime,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedDateTime == null
                          ? 'Ketuk untuk memilih...'
                          : DateFormat(
                            'd MMM yyyy, HH:mm',
                            'id_ID',
                          ).format(_selectedDateTime!),
                      style: TextStyle(
                        fontSize: 16,
                        color:
                            _selectedDateTime == null
                                ? AppColors.grey
                                : Colors.black,
                      ),
                    ),
                    const Icon(Icons.calendar_month, color: AppColors.grey),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Tombol Generate QR
            // Builder ini digunakan agar tombol bisa menampilkan state loading-nya sendiri
            BlocBuilder<GenerateQrBloc, GenerateQrState>(
              builder: (context, qrState) {
                final isLoading = qrState.maybeWhen(
                  loading: () => true,
                  orElse: () => false,
                );

                return Button.filled(
                  label: isLoading ? "Memproses..." : "Buat QR Presensi",
                  color: AppColors.primary,
                  onPressed:
                      (_selectedDateTime == null || isLoading)
                          ? null // Tombol non-aktif jika waktu belum dipilih atau sedang loading
                          : () {
                            // Memicu BLoC Generate QR
                            context.read<GenerateQrBloc>().add(
                              GenerateQrEvent.generateQr(
                                widget.pertemuanId,
                                _selectedDateTime!,
                              ),
                            );
                          },
                  height: 45,
                  fontSize: 16,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
