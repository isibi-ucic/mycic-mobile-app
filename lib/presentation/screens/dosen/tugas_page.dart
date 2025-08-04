import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycic_app/core/constants/colors.dart';
// import 'package:mycic_app/features/bloc/dsn_tugas/dsn_tugas_bloc.dart';
// import 'package:mycic_app/presentation/screens/dsn/jadwal_page.dart';
import 'package:mycic_app/presentation/widgets/default_app_bar.dart';
import 'package:mycic_app/presentation/widgets/tugas_card.dart';
// import 'package:mycic_app/data/models/dsn_tugas_response_model.dart';

class TugasPage extends StatefulWidget {
  const TugasPage({super.key});

  @override
  State<TugasPage> createState() => _TugasPageState();
}

class _TugasPageState extends State<TugasPage> {
  @override
  void initState() {
    super.initState();
    // Panggil fungsi untuk mengambil data saat widget pertama kali dibuat
    _loadData();
  }

  // Buat fungsi untuk handle aksi refresh
  Future<void> _loadData() async {
    // context.read<MhsTugasBloc>().add(const MhsTugasEvent.fetch());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: 'Tugas Perkuliahan'),
      backgroundColor: AppColors.bgDefault,
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(height: MediaQuery.of(context).size.height),
          // child: BlocBuilder<MhsTugasBloc, MhsTugasState>(
          //   builder: (context, state) {
          //     debugPrint('state: $state');
          //     return state.when(
          //       initial: () => const Center(child: CircularProgressIndicator()),
          //       loading: () => const Center(child: CircularProgressIndicator()),

          //       // PERBAIKI TAMPILAN ERROR
          //       error:
          //           (message) => Padding(
          //             padding: const EdgeInsets.symmetric(
          //               vertical: 64,
          //               horizontal: 16,
          //             ),
          //             child: Center(child: Text(message)),
          //           ),

          //       success: (res) {
          //         final List<Datum> tugas = res.data ?? [];

          //         if (tugas.isEmpty) {
          //           // Anda bisa menambahkan widget empty state di sini jika mau
          //           return const Center(
          //             child: Padding(
          //               padding: EdgeInsets.all(32.0),
          //               child: Text('Tidak ada tugas saat ini.'),
          //             ),
          //           );
          //         }

          //         // PERBAIKI LISTVIEW
          //         return ListView.builder(
          //           padding: const EdgeInsets.all(16),
          //           // WAJIB TAMBAHKAN DUA PROPERTI INI
          //           shrinkWrap: true,
          //           physics: const NeverScrollableScrollPhysics(),
          //           itemCount: tugas.length,
          //           itemBuilder: (context, index) {
          //             final item = tugas[index];
          //             return TugasCard(
          //               // GUNAKAN ?? UNTUK NULL SAFETY
          //               judul: item.judulTugas ?? 'Tanpa Judul',
          //               tenggat: item.batasWaktu.toString(),
          //               // GANTI DENGAN PROPERTI YANG BENAR DARI MODEL ANDA
          //               pengajar: 'Tanpa Nama Pengajar',
          //               onSubmit: () {
          //                 showModalBottomSheet(
          //                   context: context,
          //                   isScrollControlled: true,
          //                   shape: const RoundedRectangleBorder(
          //                     borderRadius: BorderRadius.vertical(
          //                       top: Radius.circular(20),
          //                     ),
          //                   ),
          //                   builder:
          //                       (ctx) => _SubmissionSheet(
          //                         judulTugas: item.judulTugas ?? 'Tanpa Judul',
          //                       ),
          //                 );
          //               },
          //             );
          //           },
          //         );
          //       },
          //     );
          //   },
          // ),
        ),
      ),
    );
  }
}

// class TugasPage extends StatelessWidget {
//   TugasPage({super.key});

//   // final tugasItem = [
//   //   {
//   //     'title': 'Tugas Matematika P7',
//   //     'date': '20 Agustus 2023',
//   //     'dosen': 'Dosen. S.Pd., M.Si',
//   //     'page': JadwalPage(),
//   //   },
//   //   {
//   //     'title': 'Tugas Biologi P5',
//   //     'date': '11 Agustus 2023',
//   //     'dosen': 'Dosen. S.Pd., M.Si',
//   //     'page': JadwalPage(),
//   //   },
//   //   {
//   //     'title': 'Tugas Kalkulus Dasar P5',
//   //     'date': '12 Agustus 2023',
//   //     'dosen': 'Dosen. S.Pd., M.Si',
//   //     'page': JadwalPage(),
//   //   },
//   // ];
//   @override

// }

// Widget untuk konten di dalam Bottom Sheet
class _SubmissionSheet extends StatefulWidget {
  final String judulTugas;

  const _SubmissionSheet({required this.judulTugas});

  @override
  State<_SubmissionSheet> createState() => _SubmissionSheetState();
}

class _SubmissionSheetState extends State<_SubmissionSheet> {
  String? _fileName;
  File? _selectedFile; // Jika Anda perlu objek File-nya
  final _commentController = TextEditingController();

  // Fungsi untuk memilih file
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Padding ini penting agar UI tidak tertutup keyboard
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 24,
        left: 24,
        right: 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            widget.judulTugas,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Divider(height: 24),

          // Tombol Pilih File
          const Text(
            'Upload File Tugas',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            icon: const Icon(Icons.upload_file),
            label: const Text('Pilih File'),
            onPressed: _pickFile,
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 45),
              foregroundColor: Colors.blueAccent,
              side: BorderSide(color: Colors.blueAccent.shade400),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          // Menampilkan nama file yang dipilih
          if (_fileName != null)
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Chip(
                avatar: const Icon(Icons.attach_file, size: 16),
                label: Text(_fileName!),
                onDeleted: () {
                  setState(() {
                    _fileName = null;
                    _selectedFile = null;
                  });
                },
              ),
            ),
          const SizedBox(height: 16),

          // Kolom Komentar
          const Text(
            'Komentar (Opsional)',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _commentController,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'Tambahkan komentar...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Tombol Submit
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              // Tombol disable jika file belum dipilih
              onPressed:
                  _fileName == null
                      ? null
                      : () {
                        // TODO: Logika untuk mengirim file dan komentar ke API
                        print('File: $_fileName');
                        print('Komentar: ${_commentController.text}');

                        Navigator.pop(context); // Tutup bottom sheet

                        // Tampilkan notifikasi sukses
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Tugas berhasil disubmit!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Colors.blueAccent,
              ),
              child: const Text('Kirim'),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
