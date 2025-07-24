import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:myapp/core/constants/colors.dart';
import 'package:myapp/data/models/presensi_response_model.dart';
import 'package:myapp/features/bloc/mhs_presensi/mhs_presensi_bloc.dart';
import 'package:myapp/presentation/widgets/absensi_card.dart';
import 'package:myapp/presentation/widgets/default_app_bar.dart';

class AbsensiPage extends StatefulWidget {
  const AbsensiPage({super.key});

  @override
  State<AbsensiPage> createState() => _AbsensiPageState();
}

class _AbsensiPageState extends State<AbsensiPage> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Fungsi untuk memuat ulang data, dipanggil oleh RefreshIndicator
  Future<void> _loadData() async {
    context.read<MhsPresensiBloc>().add(const MhsPresensiEvent.fetch());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: 'Daftar Kehadiran'),
      backgroundColor: AppColors.bgDefault,
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: BlocBuilder<MhsPresensiBloc, MhsPresensiState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return Container();
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
              success: (res) {
                final List<Datum>? itemData = res.data;
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: itemData?.length,
                  itemBuilder: (context, index) {
                    final item = itemData?[index];
                    return AbsensiCard(
                      mataKuliah: item!.mataKuliah ?? '',
                      kehadiran: item.kehadiran ?? [],
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
