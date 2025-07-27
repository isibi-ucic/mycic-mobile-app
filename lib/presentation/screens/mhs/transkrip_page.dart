import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycic_app/core/components/buttons.dart';
import 'package:mycic_app/data/models/transkrip_response_model.dart';
import 'package:mycic_app/features/bloc/transkrip/transkrip_bloc.dart';
import 'package:mycic_app/presentation/widgets/default_app_bar.dart';

class TranskripPage extends StatefulWidget {
  const TranskripPage({super.key});

  @override
  State<TranskripPage> createState() => _TranskripPageState();
}

class _TranskripPageState extends State<TranskripPage> {
  @override
  void initState() {
    super.initState();
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // ... (code before this)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: BlocBuilder<TranskripBloc, TranskripState>(
                        builder: (context, state) {
                          return state.maybeWhen(
                            orElse: () {
                              // Menampilkan loading indicator saat data belum siap
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                            loading: () {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                            error: (message) {
                              return Center(child: Text(message));
                            },
                            success: (res) {
                              final List<SemuaMataKuliah>? itemMk =
                                  res.data?.semuaMataKuliah;

                              if (itemMk == null || itemMk.isEmpty) {
                                return const Center(
                                  child: Text(
                                    "Data transkrip tidak ditemukan.",
                                  ),
                                );
                              }

                              return Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Table(
                                      border: TableBorder.symmetric(
                                        inside: const BorderSide(
                                          color: Colors.grey,
                                          width: 0.3,
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
                                            color: Colors.blue[200],
                                          ),
                                          children: const [
                                            Padding(
                                              padding: EdgeInsets.all(12),
                                              child: Center(
                                                child: Text(
                                                  'No',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(12),
                                              child: Text(
                                                'Mata Kuliah',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(12),
                                              child: Center(
                                                child: Text(
                                                  'Nilai',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        // Isi (Corrected Section)
                                        ...itemMk.asMap().entries.map((entry) {
                                          final index = entry.key;
                                          final item = entry.value;

                                          return TableRow(
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                            ),
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(
                                                  12,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "${index + 1}",
                                                  ), // Corrected
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(
                                                  12,
                                                ),
                                                child: Text(
                                                  "${item.namaMk}",
                                                ), // Correct
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(
                                                  12,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "${item.nilaiHuruf}",
                                                  ), // Correct
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),

                    // ... (rest of your code)
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      const Text(
                                        'IPK',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        // ipk.toStringAsFixed(2),
                                        "de",
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        'Total SKS',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        // totalSks.toString(),
                                        "89",
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Button.filled(
                              label: 'Cetak Transkrip',
                              onPressed: () {
                                // Implement the print functionality here
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
