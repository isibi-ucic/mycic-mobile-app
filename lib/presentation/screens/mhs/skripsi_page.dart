import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mycic_app/presentation/widgets/default_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycic_app/features/bloc/skripsi/skripsi_bloc.dart';

class SkripsiPage extends StatefulWidget {
  const SkripsiPage({super.key});

  @override
  State<SkripsiPage> createState() => _SkripsiPageState();
}

class _SkripsiPageState extends State<SkripsiPage> {
  @override
  void initState() {
    super.initState();
    // Memuat data saat halaman pertama kali dibuka
    _loadData();
  }

  // Fungsi untuk memuat ulang data, dipanggil oleh RefreshIndicator
  Future<void> _loadData() async {
    context.read<SkripsiBloc>().add(const SkripsiEvent.fetch());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Warna background soft
      appBar: const DefaultAppBar(title: 'Informasi Skripsi'),

      body: RefreshIndicator(
        onRefresh: _loadData,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: BlocBuilder<SkripsiBloc, SkripsiState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return const Center(
                          child: Text("Tarik ke bawah untuk memuat data."),
                        );
                      },
                      // Tampilkan loading indicator jika statusnya loading
                      loading: () {
                        // Gunakan Container untuk membatasi tinggi widget
                        return Container(
                          // Hitung tinggi viewport: tinggi layar - tinggi AppBar - tinggi status bar
                          height:
                              MediaQuery.of(context).size.height -
                              kToolbarHeight -
                              MediaQuery.of(context).padding.top,
                          child: const Center(
                            child: Column(
                              // Ganti ke MainAxisSize.min agar Column tidak mencoba mengisi seluruh Container
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SpinKitThreeBounce(
                                  color: Colors.blueAccent,
                                  size: 20.0,
                                ),
                                SizedBox(height: 8), // Beri sedikit jarak
                                Text("Loading..."),
                              ],
                            ),
                          ),
                        );
                      },
                      // Tampilkan error jika ada
                      error:
                          (message) => Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text("Gagal memuat data: $message")],
                            ),
                          ),
                      success: (response) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // --- KARTU JUDUL SKRIPSI ---
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withAlpha(6),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Judul Skripsi",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    response.data.judul,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      height: 1.4, // Spasi antar baris
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),

                            // --- HEADER DOSEN PEMBIMBING ---
                            const Text(
                              "Dosen Pembimbing",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // --- KARTU DOSEN 1 ---
                            _DosenCard(
                              namaDosen: response.data.namaPembimbing1,
                              statusPembimbing: "Pembimbing 1",
                              jumlahBimbingan: response.data.totalBimbingan1,
                            ),
                            const SizedBox(height: 12),

                            // --- KARTU DOSEN 2 ---
                            _DosenCard(
                              namaDosen: response.data.namaPembimbing2,
                              statusPembimbing: "Pembimbing 2",
                              jumlahBimbingan: response.data.totalBimbingan2,
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// WIDGET KUSTOM UNTUK KARTU DOSEN
class _DosenCard extends StatelessWidget {
  final String namaDosen;
  final String statusPembimbing;
  final int jumlahBimbingan;

  const _DosenCard({
    required this.namaDosen,
    required this.statusPembimbing,
    required this.jumlahBimbingan,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(5),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Status Pembimbing ---
          Text(
            statusPembimbing,
            style: TextStyle(
              color: Colors.blueAccent[700],
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          // --- Nama Dosen ---
          Text(
            namaDosen,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: Divider(height: 1),
          ),
          // --- Jumlah Bimbingan ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Jumlah Bimbingan",
                style: TextStyle(color: Colors.grey[700]),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "$jumlahBimbingan Kali",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent[700],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
