import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mycic_app/features/bloc/presensi_rekap/presensi_rekap_bloc.dart';
import 'package:mycic_app/presentation/widgets/default_app_bar.dart';
import 'package:mycic_app/presentation/widgets/mahasiswa_rekap_row.dart';

class PresensiDetailPage extends StatefulWidget {
  final int kelasId;
  final String namaMatkul;

  const PresensiDetailPage({
    super.key,
    required this.kelasId,
    required this.namaMatkul,
  });

  @override
  State<PresensiDetailPage> createState() => _PresensiDetailPageState();
}

class _PresensiDetailPageState extends State<PresensiDetailPage> {
  @override
  void initState() {
    super.initState();
    // Panggil event untuk mengambil data saat halaman dibuka
    _loadData();
  }

  // Fungsi untuk memuat ulang data, dipanggil oleh RefreshIndicator
  Future<void> _loadData() async {
    context.read<PresensiRekapBloc>().add(
      PresensiRekapEvent.fetch(widget.kelasId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: "Rekap Presensi"),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: BlocBuilder<PresensiRekapBloc, PresensiRekapState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading:
                  () => const Center(
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
              error: (message) => Center(child: Text(message)),
              success: (response) {
                final mahasiswa = response.data;
                final infoKelas = response.infoKelas;

                if (mahasiswa.isEmpty) {
                  return const Center(
                    child: Text('Belum ada mahasiswa di kelas ini.'),
                  );
                }

                // 1. Gunakan Column sebagai dasar layout utama
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Header Informasi Kelas ---
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            infoKelas.namaMk,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            infoKelas.namaDosen,
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(
                                LucideIcons.listChecks,
                                color: Colors.blueAccent,
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${infoKelas.totalPertemuan.toString()} Pertemuan',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 14,
                                ),
                              ),
                              Container(
                                height: 4,
                                width: 4,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const Icon(
                                LucideIcons.users,
                                color: Colors.blueAccent,
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${mahasiswa.length} Mahasiswa',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // --- Header Tabel ---
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      color: Colors.grey[100],
                      child: const Row(
                        children: [
                          SizedBox(
                            width: 30,
                            child: Text(
                              'No.',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Nama Mahasiswa',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            'Kehadiran',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),

                    // 2. Bungkus ListView.builder dengan Expanded
                    Expanded(
                      child: ListView.builder(
                        itemCount: mahasiswa.length,
                        itemBuilder: (context, index) {
                          final student = mahasiswa[index];
                          return MahasiswaRekapRow(
                            index: index,
                            rekap: student.rekap,
                            nama: student.nama,
                            nim: student.nim,
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
              orElse:
                  () =>
                      const Center(child: Text('Silakan muat ulang halaman.')),
            );
          },
        ),
      ),
    );
  }
}
