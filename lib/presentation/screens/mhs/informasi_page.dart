import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mycic_app/core/constants/colors.dart';
import 'package:mycic_app/data/models/info_response_model.dart';
import 'package:mycic_app/features/bloc/info/info_bloc.dart';
import 'package:mycic_app/presentation/widgets/default_app_bar.dart';
import 'package:mycic_app/presentation/widgets/informasi_card.dart';

class InformasiPage extends StatefulWidget {
  const InformasiPage({super.key});

  @override
  State<InformasiPage> createState() => _InformasiPageState();
}

class _InformasiPageState extends State<InformasiPage> {
  @override
  void initState() {
    super.initState();
    // Memuat data saat halaman pertama kali dibuka
    _loadData();
  }

  // Fungsi untuk memuat ulang data, dipanggil oleh RefreshIndicator
  Future<void> _loadData() async {
    context.read<InfoBloc>().add(const InfoEvent.fetch());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: "Informasi"),
      backgroundColor: AppColors.bgDefault,
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: BlocBuilder<InfoBloc, InfoState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () => const SizedBox.shrink(),

              loading: () {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SpinKitThreeBounce(color: Colors.blueAccent, size: 20.0),
                      Text("Loading..."),
                    ],
                  ),
                );
              },

              success: (res) {
                debugPrint(res.data.toString());
                final List<Datum>? dataInfo = res.data;
                // Cek apakah listnya null atau kosong
                if (dataInfo == null || dataInfo.isEmpty) {
                  return const Center(
                    child: Text('Tidak ada informasi untuk ditampilkan.'),
                  );
                }

                return ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  itemCount: dataInfo.length,
                  itemBuilder: (context, index) {
                    final info = dataInfo[index];
                    return InformasiCard(
                      title: info.title ?? '',
                      description: info.deskripsi ?? '',
                      date: info.createdAt ?? '',
                      isImportant: true,
                    );
                  },
                );
              },

              error: (message) {
                return Center(child: Text(message));
              },
            );
          },
        ),
      ),
    );
  }
}
