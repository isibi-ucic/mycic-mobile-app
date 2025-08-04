import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mycic_app/core/constants/colors.dart';
import 'package:mycic_app/core/helper/ms_route.dart';
import 'package:mycic_app/data/models/pertemuan_kelas_response_model.dart';
import 'package:mycic_app/features/bloc/dsn_kelas_pertemuan/dsn_kelas_pertemuan_bloc.dart';
import 'package:mycic_app/presentation/screens/dosen/detail_pertemuan_page.dart';
import 'package:mycic_app/presentation/widgets/default_app_bar.dart';

class ClassDetailPage extends StatefulWidget {
  final int mkId;
  final String namaMatkul;
  final String dosen;
  final String waktu;
  final String ruangan;

  const ClassDetailPage({
    super.key,
    required this.mkId,
    required this.namaMatkul,
    required this.dosen,
    required this.waktu,
    required this.ruangan,
  });

  @override
  State<ClassDetailPage> createState() => _ClassDetailPageState();
}

class _ClassDetailPageState extends State<ClassDetailPage> {
  @override
  void initState() {
    super.initState();
    // Memuat data saat halaman pertama kali dibuka
    _loadData();
  }

  // Fungsi untuk memuat ulang data, dipanggil oleh RefreshIndicator
  Future<void> _loadData() async {
    context.read<DsnKelasPertemuanBloc>().add(
      DsnKelasPertemuanEvent.fetch(widget.mkId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(title: "Kelas Perkuliahan"),
      backgroundColor: AppColors.bgDefault,
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.all(16),

            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- Judul Mata Kuliah (Paling Utama) ---
                      Text(
                        widget.namaMatkul ?? 'Nama Mata Kuliah',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),

                      // --- Nama Dosen (Info Sekunder) ---
                      Text(
                        widget.dosen ?? "Nama Dosen Pengampu",
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                          fontWeight:
                              FontWeight
                                  .w500, // Sedikit tebal agar mudah dibaca
                        ),
                      ),
                      const SizedBox(height: 12),

                      // --- Detail Waktu & Ruangan dengan Ikon ---
                      Row(
                        children: [
                          // Ikon dan Waktu
                          const Icon(
                            Icons.access_time_outlined,
                            color: Colors.blueAccent,
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            widget.waktu ?? "08:00 - 09:40",
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 14,
                            ),
                          ),

                          // Pemisah berupa titik
                          Container(
                            height: 4,
                            width: 4,
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              shape: BoxShape.circle,
                            ),
                          ),

                          // Ikon dan Ruangan
                          const Icon(
                            Icons.location_on_outlined,
                            color: Colors.blueAccent,
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            widget.ruangan ?? "LAB-01",
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
                const SizedBox(height: 8),
                BlocBuilder<DsnKelasPertemuanBloc, DsnKelasPertemuanState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return Container();
                      },
                      // Tampilkan loading indicator jika statusnya loading
                      loading: () {
                        return const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SpinKitThreeBounce(
                                color: Colors.blueAccent,
                                size: 20.0,
                              ),
                              Text("Loading..."),
                            ],
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
                        final List<Datum>? dataPertemuan = response.data;

                        // Cek jika data hari kosong atau null
                        if (dataPertemuan == null || dataPertemuan.isEmpty) {
                          return const Center(
                            child: Text(
                              'Tidak ada pertemuan untuk ditampilkan.',
                            ),
                          );
                        }

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: dataPertemuan.length,
                          itemBuilder: (context, index) {
                            var urutan = index + 1;
                            final pertemuan = dataPertemuan[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  msRoute(
                                    context,
                                    DetailPertemuanPage(
                                      pertemuanId: pertemuan.id!,
                                      namaMatkul: widget.namaMatkul,
                                      ruangan: widget.ruangan,
                                      waktu: widget.waktu,
                                    ),
                                  );
                                },
                                child: Card(
                                  elevation: 1,
                                  color: AppColors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 20,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              pertemuan.materi!,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              "Pertemuan $urutan",
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 8,
                                          ),
                                          child: Divider(
                                            height: 1,
                                            color: AppColors.grey,
                                          ),
                                        ),
                                        Text(
                                          pertemuan.deskripsi ?? '',
                                          maxLines:
                                              2, // Tentukan jumlah baris maksimal yang diizinkan
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
