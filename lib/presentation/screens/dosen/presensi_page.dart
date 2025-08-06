import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mycic_app/core/constants/colors.dart';
import 'package:mycic_app/core/helper/ms_route.dart';
import 'package:mycic_app/data/models/presensi_kelas_response_model.dart';
import 'package:mycic_app/features/bloc/presensi_kelas/presensi_kelas_bloc.dart';
import 'package:mycic_app/presentation/screens/dosen/presensi_detail_page.dart';
import 'package:mycic_app/presentation/screens/dosen/template_page.dart';
import 'package:mycic_app/presentation/widgets/default_app_bar.dart';
import 'package:mycic_app/presentation/widgets/kelas_presensi_widget.dart';

class PresensiPage extends StatefulWidget {
  const PresensiPage({super.key});

  @override
  State<PresensiPage> createState() => _PresensiPageState();
}

class _PresensiPageState extends State<PresensiPage> {
  @override
  void initState() {
    super.initState();
    // Memuat data saat halaman pertama kali dibuka
    _loadData();
  }

  // Fungsi untuk memuat ulang data, dipanggil oleh RefreshIndicator
  Future<void> _loadData() async {
    context.read<PresensiKelasBloc>().add(const PresensiKelasEvent.fetch());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: "Daftar Kehadiran",
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
        child: BlocBuilder<PresensiKelasBloc, PresensiKelasState>(
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
                final List<Datum> kelas = response.data;

                // Cek jika data hari kosong atau null
                if (kelas.isEmpty) {
                  return const Center(
                    child: Text('Tidak ada kelas untuk ditampilkan.'),
                  );
                }

                final daftarKelas = response.data;

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: daftarKelas.length,
                  itemBuilder: (context, index) {
                    final kelas = daftarKelas[index];
                    return KelasPresensiWidget(
                      namaMatkul: kelas.namaMk,
                      jumlahMahasiswa: kelas.jumlahMahasiswa,
                      jumlahPertemuan: kelas.totalPertemuan,
                      onTap: () {
                        // Navigasi ke halaman detail rekap presensi
                        msRoute(
                          context,
                          PresensiDetailPage(
                            kelasId: kelas.idJadwalKelas,
                            namaMatkul: kelas.namaMk,
                          ),
                        );
                      },
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
