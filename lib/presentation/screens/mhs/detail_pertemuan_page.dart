import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mycic_app/core/components/buttons.dart';
import 'package:mycic_app/core/constants/colors.dart';
import 'package:mycic_app/core/helper/ms_route.dart';
import 'package:mycic_app/features/bloc/mhs_kelas_pertemuan_detail/mhs_kelas_pertemuan_detail_bloc.dart';
import 'package:mycic_app/presentation/screens/dosen/template_page.dart';
import 'package:mycic_app/presentation/screens/mhs/scanner_page.dart';
import 'package:mycic_app/presentation/widgets/default_app_bar.dart';
import 'package:screenshot/screenshot.dart';

class DetailPertemuanPage extends StatefulWidget {
  final int pertemuanId;
  String ruangan;
  String waktu;

  DetailPertemuanPage({
    super.key,
    required this.pertemuanId,
    required this.ruangan,
    required this.waktu,
  });

  @override
  State<DetailPertemuanPage> createState() => _DetailPertemuanPageState();
}

class _DetailPertemuanPageState extends State<DetailPertemuanPage> {
  @override
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
        child: BlocBuilder<
          MhsKelasPertemuanDetailBloc,
          MhsKelasPertemuanDetailState
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
                                style: const TextStyle(color: Colors.black54),
                              ),
                              const Text(
                                '|',
                                style: TextStyle(color: Colors.black26),
                              ),
                              Text(
                                widget.waktu,
                                style: const TextStyle(color: Colors.black54),
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
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(24, 0, 24, 32), // Padding untuk jarak
        child: Button.filled(
          label: "Scan Presensi",
          color: AppColors.primary,
          onPressed: () {
            msRoute(context, const ScannerPage());
          },
          height: 45,
          fontSize: 16,
        ),
      ),
    );
  }
}
