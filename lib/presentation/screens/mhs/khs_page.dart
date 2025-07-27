import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mycic_app/core/constants/colors.dart';
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
    // Memuat data saat halaman pertama kali dibuka
    _loadData();
  }

  // Fungsi untuk memuat ulang data, dipanggil oleh RefreshIndicator
  Future<void> _loadData() async {
    context.read<KhsBloc>().add(const KhsEvent.fetch());
  }

  final List<Map<String, dynamic>> khsData = [
    {
      'semester': 1,
      'totalSks': 20,
      'ips': 3.50,
      'daftarMk': [
        {'no': 'MK101', 'mataKuliah': 'Matematika Dasar', 'nilai': 'B'},
        {'no': 'MK102', 'mataKuliah': 'Fisika Dasar', 'nilai': 'B'},
        {'no': 'MK103', 'mataKuliah': 'Pengantar Pemrograman', 'nilai': 'A'},
      ],
    },
    {
      'semester': 2,
      'totalSks': 22,
      'ips': 3.75,
      'daftarMk': [
        {'no': 'MK201', 'mataKuliah': 'Kalkulus Lanjut', 'nilai': 'A'},
        {'no': 'MK202', 'mataKuliah': 'Kimia Dasar', 'nilai': 'B+'},
        {'no': 'MK203', 'mataKuliah': 'Struktur Data', 'nilai': 'A'},
      ],
    },
    {
      'semester': 3,
      'totalSks': 24,
      'ips': 3.90,
      'daftarMk': [
        {'no': 'MK301', 'mataKuliah': 'Aljabar Linear', 'nilai': 'A'},
        {'no': 'MK302', 'mataKuliah': 'Fisika Modern', 'nilai': 'A'},
        {'no': 'MK303', 'mataKuliah': 'Basis Data', 'nilai': 'A'},
      ],
    },
    {
      'semester': 4,
      'totalSks': 23,
      'ips': 3.85,
      'daftarMk': [
        {'no': 'MK401', 'mataKuliah': 'Analisis Numerik', 'nilai': 'A'},
        {'no': 'MK402', 'mataKuliah': 'Sistem Operasi', 'nilai': 'A'},
        {'no': 'MK403', 'mataKuliah': 'Jaringan Komputer', 'nilai': 'B+'},
      ],
    },
    {
      'semester': 5,
      'totalSks': 21,
      'ips': 3.65,
      'daftarMk': [
        {'no': 'MK501', 'mataKuliah': 'Kecerdasan Buatan', 'nilai': 'B+'},
        {'no': 'MK502', 'mataKuliah': 'Rekayasa Perangkat Lunak', 'nilai': 'A'},
        {'no': 'MK503', 'mataKuliah': 'Pemrograman Berbasis Web', 'nilai': 'B'},
      ],
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(title: 'Kartu Hasil Studi (KHS)'),
      backgroundColor: AppColors.bgDefault,
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: LayoutBuilder(
          builder: (context, constraints) {
            // [PENTING] SingleChildScrollView sekarang menjadi parent utama untuk scrolling
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              // Gunakan ConstrainedBox untuk memastikan child-nya
              // (yaitu BlocBuilder) memiliki tinggi minimal setinggi layar.
              // Ini adalah kunci agar scrolling selalu aktif.
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: BlocBuilder<KhsBloc, KhsState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return const Center(
                          child: Text("Tarik ke bawah untuk memuat data."),
                        );
                      },

                      success: (res) {
                        return ListView.builder(
                          itemCount: khsData.length,
                          itemBuilder: (context, index) {
                            final semesterData = khsData[index];
                            return _buildSemesterCard(semesterData);
                          },
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
                              Text("Memuat Data KHS..."),
                            ],
                          ),
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

  Widget _buildSemesterCard(Map<String, dynamic> semesterData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        color: AppColors.white,
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Semester ${semesterData['semester']}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total SKS: ${semesterData['totalSks']}'),
                  Text('IPS: ${semesterData['ips'].toStringAsFixed(2)}'),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
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
                            decoration: BoxDecoration(color: Colors.blue[200]),
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
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
                          // Isi
                          ...semesterData['daftarMk'].map<TableRow>((item) {
                            return TableRow(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey,
                                    width: 0.3,
                                  ),
                                ),
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Center(
                                    child: Text(item['no'] as String),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    item['mataKuliah'] as String,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Center(child: Text(item['nilai']!)),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
