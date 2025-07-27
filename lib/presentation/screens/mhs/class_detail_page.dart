import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:myapp/core/constants/colors.dart';
import 'package:myapp/core/helper/ms_route.dart';
import 'package:myapp/data/models/pertemuan_kelas_response_model.dart';
import 'package:myapp/features/bloc/mhs_kelas/mhs_kelas_bloc.dart';
import 'package:myapp/presentation/screens/mhs/detail_pertemuan_page.dart';
import 'package:myapp/presentation/widgets/default_app_bar.dart';

class ClassDetailPage extends StatefulWidget {
  final int mkId;
  final String? namaMatkul;
  final String? dosen;
  final String? waktu;
  final String? ruangan;

  const ClassDetailPage({
    super.key,
    required this.mkId,
    this.namaMatkul,
    this.dosen,
    this.waktu,
    this.ruangan,
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
    context.read<MhsKelasBloc>().add(
      MhsKelasEvent.getKelasPertemuan(widget.mkId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: "Kelas Perkuliahan"),
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
                    vertical: 20,
                    horizontal: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.namaMatkul ?? '',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.dosen ?? "",
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Text(
                            widget.waktu ?? "",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Text('|'),
                          const SizedBox(width: 16),
                          Text(
                            widget.ruangan ?? '',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: const Divider(height: 1),
                ),

                BlocBuilder<MhsKelasBloc, MhsKelasState>(
                  builder: (context, state) {
                    // Tampilkan loading indicator jika statusnya loading
                    if (state.status == MhsKelasStatus.loading &&
                        state.pertemuan == null) {
                      // Loading awal saat belum ada data sama sekali
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
                    }

                    // Tampilkan error jika ada
                    if (state.status == MhsKelasStatus.error) {
                      return Center(
                        child: Text(state.errorMessage ?? 'Terjadi kesalahan'),
                      );
                    }

                    // Jika sudah ada data kelas, tampilkan
                    if (state.pertemuan != null) {
                      final List<Datum>? dataPertemuan =
                          state.pertemuan!.data; // List pertemuan

                      // Cek jika data hari kosong atau null
                      if (dataPertemuan == null || dataPertemuan.isEmpty) {
                        return const Center(
                          child: Text('Tidak ada pertemuan untuk ditampilkan.'),
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
                                msRoute(context, DetailPertemuanPage());
                              },
                              child: Card(
                                elevation: 1,
                                color: AppColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
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
                                            "Pertemuan Ke-$urutan",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Tap untuk detail',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 8,
                                        ),
                                        child: Divider(
                                          height: 1,
                                          color: AppColors.grey,
                                        ),
                                      ),
                                      Text(
                                        pertemuan.materi ?? '',
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
                    }

                    // State awal, sebelum ada data
                    return const Center(
                      child: Text("Silakan mulai dengan mengambil data kelas."),
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
