import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mycic_app/core/constants/colors.dart';
import 'package:mycic_app/data/models/ujian_response_model.dart';
import 'package:mycic_app/features/bloc/mhs_ujian/mhs_ujian_bloc.dart';
import 'package:mycic_app/presentation/widgets/default_app_bar.dart';

class UjianPage extends StatefulWidget {
  const UjianPage({super.key});

  @override
  State<UjianPage> createState() => _UjianPageState();
}

class _UjianPageState extends State<UjianPage> {
  @override
  void initState() {
    super.initState();
    // Memuat data saat halaman pertama kali dibuka
    _loadData();
  }

  // Fungsi untuk memuat ulang data, dipanggil oleh RefreshIndicator
  Future<void> _loadData() async {
    context.read<MhsUjianBloc>().add(const MhsUjianEvent.fetch());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: 'Jadwal Ujian Kuliah'),
      backgroundColor: AppColors.bgDefault,
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: LayoutBuilder(
          builder: (context, constraints) {
            // [PENTING] SingleChildScrollView sekarang menjadi parent utama untuk scrolling
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              // [LOGIKA DIPERBARUI] Gunakan ConstrainedBox untuk memastikan child-nya
              // (yaitu BlocBuilder) memiliki tinggi minimal setinggi layar.
              // Ini adalah kunci agar scrolling selalu aktif.
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: BlocBuilder<MhsUjianBloc, MhsUjianState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        // Tampilan untuk state awal atau tak terduga
                        return const Center(
                          child: Text("Tarik ke bawah untuk memuat jadwal."),
                        );
                      },
                      loading: () {
                        // Tampilan loading
                        return const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SpinKitThreeBounce(
                                color: Colors.blueAccent,
                                size: 20.0,
                              ),
                              SizedBox(height: 8),
                              Text("Memuat Jadwal..."),
                            ],
                          ),
                        );
                      },
                      success: (res) {
                        final List<Datum>? jadwal = res.data;

                        // Tangani secara eksplisit jika data kosong atau null.
                        if (jadwal == null || jadwal.isEmpty) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.0),
                              child: Text(
                                "Tidak ada jadwal ujian dalam 7 hari ke depan.\nTarik ke bawah untuk menyegarkan.",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          );
                        }

                        // Jika data ada, ListView.builder akan dirender di dalam ConstrainedBox.
                        // Tidak perlu lagi membungkusnya secara terpisah.
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(16),
                          itemCount: jadwal.length,
                          itemBuilder: (context, index) {
                            final item = jadwal[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.hari,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ...List.generate(item.ujian.length, (
                                  kelasIndex,
                                ) {
                                  final kelas = item.ujian[kelasIndex];
                                  // [CATATAN] Logika status ini hanya contoh.
                                  final statusText =
                                      kelasIndex % 2 == 1
                                          ? const Text(
                                            'Selesai',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              color: Colors.green,
                                            ),
                                          )
                                          : const Text(
                                            'Belum dimulai',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(color: Colors.red),
                                          );

                                  return Card(
                                    color: AppColors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    margin: const EdgeInsets.only(bottom: 12),
                                    elevation: 1,
                                    child: ListTile(
                                      trailing: SizedBox(
                                        width: 100,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: statusText,
                                        ),
                                      ),
                                      title: Text(
                                        kelas.mataKuliah,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(
                                        kelas.jam,
                                        style: const TextStyle(
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                                const SizedBox(height: 16),
                              ],
                            );
                          },
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
