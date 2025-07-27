import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mycic_app/core/components/buttons.dart';
import 'package:mycic_app/core/services/external_url.dart';
import 'package:mycic_app/features/bloc/transkrip/transkrip_bloc.dart';
import 'package:mycic_app/presentation/widgets/default_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class TranskripPage extends StatefulWidget {
  const TranskripPage({super.key});

  @override
  State<TranskripPage> createState() => _TranskripPageState();
}

class _TranskripPageState extends State<TranskripPage> {
  @override
  void initState() {
    super.initState();
    // Memuat data saat halaman pertama kali dibuka
    _loadData();
  }

  // Fungsi untuk memuat ulang data, dipanggil oleh RefreshIndicator
  Future<void> _loadData() async {
    context.read<TranskripBloc>().add(const TranskripEvent.fetch());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: 'Transkrip Nilai'),
      // Gunakan RefreshIndicator sebagai parent dari body
      body: RefreshIndicator(
        onRefresh: _loadData,
        // [STRUKTUR BARU] Jadikan BlocBuilder sebagai widget utama di body.
        // Ini adalah cara paling benar untuk memastikan seluruh UI bereaksi
        // terhadap perubahan state dari BLoC.
        child: BlocBuilder<TranskripBloc, TranskripState>(
          builder: (context, state) {
            // Gunakan .when() untuk menangani semua kemungkinan state
            return state.when(
              // --- State Awal / Loading ---
              initial: () {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SpinKitThreeBounce(color: Colors.blueAccent, size: 20.0),
                      Text("Loading..."),
                    ],
                  ),
                );
              },
              loading: () {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SpinKitThreeBounce(color: Colors.blueAccent, size: 20.0),
                      Text("Loading..."),
                    ],
                  ),
                );
              },

              // --- State Error ---
              error: (message) {
                // Agar RefreshIndicator tetap berfungsi di halaman error,
                // bungkus konten dengan SingleChildScrollView.
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Center(child: Text(message)),
                  ),
                );
              },

              // --- State Success (Data Berhasil Dimuat) ---
              success: (response) {
                final transkripData = response.data;
                final listMataKuliah = transkripData?.semuaMataKuliah;

                if (transkripData == null ||
                    listMataKuliah == null ||
                    listMataKuliah.isEmpty) {
                  return const Center(
                    child: Text("Data transkrip tidak ditemukan."),
                  );
                }

                // Gunakan SingleChildScrollView untuk membuat konten bisa di-scroll
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // --- Tabel Nilai ---
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Table(
                            border: TableBorder.symmetric(
                              inside: BorderSide(
                                color: Colors.grey.shade300,
                                width: 1,
                              ),
                            ),
                            columnWidths: const {
                              0: FixedColumnWidth(50),
                              1: FlexColumnWidth(),
                              2: FixedColumnWidth(70),
                            },
                            children: [
                              // Header
                              TableRow(
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                ),
                                children: [
                                  _buildHeaderCell('No'),
                                  _buildHeaderCell(
                                    'Mata Kuliah',
                                    isCentered: false,
                                  ),
                                  _buildHeaderCell('Nilai'),
                                ],
                              ),
                              // Body Tabel
                              ...listMataKuliah.asMap().entries.map((entry) {
                                final index = entry.key;
                                final item = entry.value;
                                return TableRow(
                                  children: [
                                    _buildTableCell((index + 1).toString()),
                                    _buildTableCell(
                                      "${item.namaMk}",
                                      isCentered: false,
                                    ),
                                    _buildTableCell(item.nilaiHuruf ?? 'N/A'),
                                  ],
                                );
                              }),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // --- Box IPK dan Total SKS ---
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 24.0,
                          horizontal: 16.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildInfoColumn(
                                  label: 'IPK',
                                  // [FIXED] Mengambil data IPK dari server
                                  value:
                                      transkripData.totalIpk?.toStringAsFixed(
                                        2,
                                      ) ??
                                      '0.00',
                                  color: Colors.blue.shade700,
                                ),
                                _buildInfoColumn(
                                  label: 'Total SKS',
                                  // [FIXED] Mengambil data SKS dari server
                                  value:
                                      transkripData.totalSks?.toString() ?? '0',
                                  color: Colors.green.shade700,
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Button.filled(
                              label: 'Cetak Transkrip',
                              onPressed: () async {
                                // Implementasi fungsi cetak eksternal url

                                externalUrl(context, 'https://flutter.dev');
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  // Helper widget untuk membuat sel header tabel
  Widget _buildHeaderCell(String text, {bool isCentered = true}) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        text,
        textAlign: isCentered ? TextAlign.center : TextAlign.left,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  // Helper widget untuk membuat sel body tabel
  Widget _buildTableCell(String text, {bool isCentered = true}) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        text,
        textAlign: isCentered ? TextAlign.center : TextAlign.left,
      ),
    );
  }

  // Helper widget untuk membuat kolom info (IPK/SKS)
  Widget _buildInfoColumn({
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
