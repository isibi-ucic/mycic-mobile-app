import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mycic_app/core/constants/colors.dart';
// Ganti dengan path model Anda yang benar
import 'package:mycic_app/data/models/khs_response_model.dart';
import 'package:mycic_app/features/bloc/khs/khs_bloc.dart';
import 'package:mycic_app/presentation/widgets/default_app_bar.dart';

class KhsPage extends StatefulWidget {
  const KhsPage({super.key});

  @override
  State<KhsPage> createState() => _KhsPageState();
}

class _KhsPageState extends State<KhsPage> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    context.read<KhsBloc>().add(const KhsEvent.fetch());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(title: 'Kartu Hasil Studi (KHS)'),
      backgroundColor: AppColors.bgDefault,
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: BlocBuilder<KhsBloc, KhsState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading:
                  () => const Center(
                    child: SpinKitThreeBounce(
                      color: Colors.blueAccent,
                      size: 30.0,
                    ),
                  ),
              error:
                  (message) => Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text("Gagal memuat data: $message"),
                    ),
                  ),
              // Menggunakan KhsResponseModel di sini
              success: (response) {
                final khsData = response.data;
                if (khsData == null || khsData.isEmpty) {
                  return const Center(child: Text("Data KHS belum tersedia."));
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: khsData.length,
                  itemBuilder: (context, index) {
                    final semesterData = khsData[index];
                    return _buildSemesterCard(semesterData);
                  },
                );
              },
              orElse:
                  () => const Center(
                    child: Text("Tarik ke bawah untuk memuat data."),
                  ),
            );
          },
        ),
      ),
    );
  }

  // Menggunakan model 'Datum'
  Widget _buildSemesterCard(Datum semesterData) {
    return Card(
      color: Colors.white,
      elevation: 1,
      shadowColor: Colors.grey[300],
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      // Ganti ke antiAlias agar lebih rapi saat ada interaksi
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        // --- TAMBAHKAN DUA BARIS DI BAWAH INI ---
        shape: const Border(), // Menghilangkan border saat DIBUKA
        collapsedShape: const Border(), // Menghilangkan border saat DITUTUP

        title: Text(
          'Semester ${semesterData.semester ?? 'N/A'}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            children: [
              _buildInfoChip(
                "Total SKS",
                (semesterData.totalSks ?? 0).toString(),
              ),
              const SizedBox(width: 12),
              _buildInfoChip(
                "IPS",
                (semesterData.ips ?? 0.0).toStringAsFixed(2),
              ),
            ],
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: _buildGradeTable(semesterData.daftarMk ?? []),
          ),
        ],
      ),
    );
  }

  // Menggunakan model 'DaftarMk'
  Widget _buildGradeTable(List<DaftarMk> daftarMk) {
    return ClipRRect(
      child: Table(
        border: TableBorder(
          horizontalInside: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
        columnWidths: const {
          0: FlexColumnWidth(), // Kolom untuk Mata Kuliah
          1: FixedColumnWidth(70), // Kolom untuk Nilai
        },
        children: [
          // Header Tabel
          TableRow(
            decoration: BoxDecoration(color: Colors.grey[300]),
            children: const [
              Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  'Mata Kuliah',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    'Nilai',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          // Isi Tabel
          ...daftarMk.map((item) {
            return TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    item.mataKuliah ?? 'N/A',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      item.nilai ?? '-',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String label, String value) {
    return Row(
      children: [
        Text('$label: ', style: TextStyle(color: Colors.grey[600])),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
