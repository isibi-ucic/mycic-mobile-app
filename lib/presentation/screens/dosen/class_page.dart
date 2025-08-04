import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mycic_app/core/constants/colors.dart';
import 'package:mycic_app/core/helper/ms_route.dart';
import 'package:mycic_app/data/models/kelas_response_model.dart';
import 'package:mycic_app/features/bloc/dsn_kelas/dsn_kelas_bloc.dart';
import 'package:mycic_app/presentation/screens/dosen/class_detail_page.dart';
import 'package:mycic_app/presentation/screens/dosen/template_page.dart';
import 'package:mycic_app/presentation/widgets/class_card.dart';
import 'package:mycic_app/presentation/widgets/default_app_bar.dart';

class ClassPage extends StatefulWidget {
  const ClassPage({super.key});

  @override
  State<ClassPage> createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  @override
  void initState() {
    super.initState();
    // Memuat data saat halaman pertama kali dibuka
    _loadData();
  }

  // Fungsi untuk memuat ulang data, dipanggil oleh RefreshIndicator
  Future<void> _loadData() async {
    context.read<DsnKelasBloc>().add(const DsnKelasEvent.fetch());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: "Daftar Kelas",
        onTapBack: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TemplateDosenPage()),
          );
        },
      ),
      backgroundColor: AppColors.bgDefault,
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: BlocBuilder<DsnKelasBloc, DsnKelasState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse:
                  () => const Center(
                    child: Text("Silakan mulai dengan mengambil data kelas."),
                  ),
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
              error:
                  (message) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("Gagal memuat data: $message")],
                    ),
                  ),
              success: (response) {
                final List<Datum>? dataHari = response.data;

                // Cek jika data hari kosong atau null
                if (dataHari == null || dataHari.isEmpty) {
                  return const Center(
                    child: Text('Tidak ada jadwal kelas untuk ditampilkan.'),
                  );
                }

                return ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  itemCount:
                      dataHari.length, // ✅ Menggunakan panjang dari List<Datum>
                  itemBuilder: (context, index) {
                    final Datum hariItem = dataHari[index];

                    final List<Kela> kelasPerHari =
                        hariItem.kelas ?? []; // Daftar kelas untuk hari ini

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hariItem.hari ??
                              "Hari Tidak Diketahui", // ✅ Akses properti 'hari'
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Cek jika tidak ada kelas untuk hari ini
                        if (kelasPerHari.isEmpty)
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text('Tidak ada kelas untuk hari ini.'),
                          )
                        else
                          // Loop melalui daftar kelas di setiap hari
                          ...List.generate(kelasPerHari.length, (kelasIndex) {
                            final Kela kelasData =
                                kelasPerHari[kelasIndex]; // Objek Kela (data per kelas)

                            return GestureDetector(
                              onTap: () {
                                // Pastikan ClassDetailPage menerima parameter yang non-null
                                msRoute(
                                  context,
                                  ClassDetailPage(
                                    mkId: kelasData.mkId!,
                                    namaMatkul:
                                        kelasData.kelas ??
                                        'N/A', // Memberikan nilai default jika null
                                    dosen: kelasData.dosen ?? 'N/A',
                                    waktu: kelasData.waktu ?? 'N/A',
                                    ruangan: kelasData.ruangan ?? 'N/A',
                                  ),
                                );
                              },
                              child: ClassCard(
                                waktu: kelasData.waktu ?? 'N/A',
                                kelas:
                                    kelasData.kelas ??
                                    'N/A', // Ini adalah nama mata kuliah
                                dosen: null,
                                ruangan: kelasData.ruangan ?? 'N/A',
                              ),
                            );
                          }),
                        const SizedBox(height: 16), // Spasi antar hari
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
  }
}
