import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycic_app/core/components/buttons.dart';
import 'package:mycic_app/core/constants/colors.dart';
import 'package:mycic_app/core/helper/ms_route.dart';
import 'package:mycic_app/features/bloc/mhs_kelas_pertemuan_detail/mhs_kelas_pertemuan_detail_bloc.dart';
import 'package:mycic_app/presentation/screens/mhs/scanner_page.dart';
import 'package:mycic_app/presentation/widgets/default_app_bar.dart';

class DetailPertemuanPage extends StatefulWidget {
  final int pertemuanId;
  const DetailPertemuanPage({super.key, required this.pertemuanId});

  @override
  State<DetailPertemuanPage> createState() => _DetailPertemuanPageState();
}

class _DetailPertemuanPageState extends State<DetailPertemuanPage> {
  void initState() {
    super.initState();
    // Memuat data saat halaman pertama kali dibuka
    _loadData();
  }

  // Fungsi untuk memuat ulang data, dipanggil oleh RefreshIndicator
  Future<void> _loadData() async {
    context.read<MhsKelasPertemuanDetailBloc>().add(
      MhsKelasPertemuanDetailEvent.fetch(widget.pertemuanId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(title: 'Detail Pertemuan'),
      backgroundColor: AppColors.bgDefault,
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: BlocBuilder<
            MhsKelasPertemuanDetailBloc,
            MhsKelasPertemuanDetailState
          >(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const Center(child: CircularProgressIndicator());
                },
                loading: () {
                  return const Center(child: CircularProgressIndicator());
                },
                success: (response) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- BAGIAN HEADER ---
                        // Judul Utama
                        Text(
                          response.data.materi,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildInfoRow(
                          icon: Icons.calendar_month,
                          text: response.data.tanggal.toString(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Column(
                            children: [
                              // Placeholder untuk PDF Viewer
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  color: Colors.grey[400],
                                  height: 200,
                                  child: Center(
                                    child: Icon(
                                      Icons.picture_as_pdf_rounded,
                                      color: Colors.grey[500],
                                      size: 50,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              // Deskripsi Materi
                              Text(
                                response.data.deskripsi,
                                textAlign: TextAlign.justify,
                                style: const TextStyle(
                                  fontSize: 15,
                                  height: 1.5,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // --- BAGIAN TOMBOL AKSI ---
                        SizedBox(
                          width: double.infinity, // Membuat tombol full-width
                          child: Button.filled(
                            color: AppColors.primary,

                            onPressed: () {
                              msRoute(context, const ScannerPage());
                            },
                            label: 'Scan Presensi',
                            icon: const Icon(
                              Icons.qr_code_scanner,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                error: (message) {
                  return Center(child: Text(message));
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

// Helper widget untuk membuat baris info dengan ikon
Widget _buildInfoRow({required IconData icon, required String text}) {
  return Row(
    children: [
      Icon(icon, color: Colors.blueAccent, size: 20),
      const SizedBox(width: 12),
      Text(text, style: TextStyle(fontSize: 15, color: Colors.grey[700])),
    ],
  );
}
