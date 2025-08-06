import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mycic_app/presentation/widgets/default_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycic_app/features/bloc/dsn_skripsi/dsn_skripsi_bloc.dart';
import 'package:mycic_app/presentation/widgets/mahasiswa_bimbingan_widget.dart';

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
    context.read<DsnSkripsiBloc>().add(const DsnSkripsiEvent.fetch());
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Warna background soft
      appBar: const DefaultAppBar(title: 'Informasi Skripsi'),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: BlocBuilder<DsnSkripsiBloc, DsnSkripsiState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () {
                // Gunakan LayoutBuilder untuk memastikan loading berada di tengah viewport
                return LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: const Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SpinKitThreeBounce(
                                color: Colors.blueAccent,
                                size: 20.0,
                              ),
                              SizedBox(height: 8),
                              Text("Loading..."),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              error:
                  (message) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("Gagal memuat data: $message")],
                    ),
                  ),
              success: (response) {
                final daftarBimbingan = response.data;
                if (daftarBimbingan.isEmpty) {
                  return const Center(
                    child: Text('Anda belum memiliki mahasiswa bimbingan.'),
                  );
                }

                // --- PERBAIKAN UTAMA DI SINI ---
                // Langsung gunakan ListView.builder tanpa Column/Expanded
                return ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  itemCount: daftarBimbingan.length,
                  itemBuilder: (context, index) {
                    final bimbingan = daftarBimbingan[index];
                    return MahasiswaBimbinganWidget(
                      namaMhs: bimbingan.namaMahasiswa,
                      nim: bimbingan.nimMhs,
                      judulSkripsi: bimbingan.judul,
                      jumlahBimbingan: bimbingan.jumlahBimbingan.toString(),
                    );
                  },
                );
              },
              orElse: () {
                return const Center(
                  child: Text("Tarik ke bawah untuk memuat data."),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
