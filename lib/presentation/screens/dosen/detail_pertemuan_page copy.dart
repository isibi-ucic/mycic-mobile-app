import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mycic_app/core/assets/assets.gen.dart';
import 'package:mycic_app/core/components/buttons.dart';
import 'package:mycic_app/core/constants/colors.dart';
import 'package:mycic_app/core/helper/ms_route.dart';
import 'package:mycic_app/features/bloc/dsn_kelas_pertemuan_detail/dsn_kelas_pertemuan_detail_bloc.dart';
import 'package:mycic_app/presentation/screens/dosen/template_page.dart';
import 'package:mycic_app/presentation/widgets/default_app_bar.dart';

class DetailPertemuanPage extends StatefulWidget {
  final int pertemuanId;
  const DetailPertemuanPage({super.key, required this.pertemuanId});

  @override
  State<DetailPertemuanPage> createState() => _DetailPertemuanPageState();
}

class _DetailPertemuanPageState extends State<DetailPertemuanPage> {
  @override
  void initState() {
    super.initState();
    // Memuat data saat halaman pertama kali dibuka
    _loadData();
  }

  // Fungsi untuk memuat ulang data, dipanggil oleh RefreshIndicator
  Future<void> _loadData() async {
    context.read<DsnKelasPertemuanDetailBloc>().add(
      DsnKelasPertemuanDetailEvent.fetch(widget.pertemuanId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(title: 'Detail Pertemuan'),
      backgroundColor: AppColors.bgDefault,
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: BlocBuilder<
              DsnKelasPertemuanDetailBloc,
              DsnKelasPertemuanDetailState
            >(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse:
                      () => const Center(child: CircularProgressIndicator()),
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
                  success: (response) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pertemuan ${response.data.pertemuanKe} - ${response.data.materi}",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Wrap(
                          spacing: 8,
                          children: [
                            Text(
                              "Ruangan 201",
                              style: TextStyle(color: Colors.black54),
                            ),
                            Text('|', style: TextStyle(color: Colors.black26)),
                            Text(
                              "Rabu, 9:00 - 11:00",
                              style: TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            color: Colors.grey[300],
                            child: const SizedBox(
                              height: 200,
                              child: Center(child: Text('PDF View')),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),
                        const Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 16),

                        if (response.data.qrPresensi != null) ...[
                          Align(
                            alignment: Alignment.center,
                            child: Assets.images.qrPresensi.image(
                              height:
                                  MediaQueryData.fromView(
                                    View.of(context),
                                  ).size.width /
                                  2,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        children: [
                                          Assets.icons.download.svg(
                                            colorFilter: const ColorFilter.mode(
                                              AppColors.grey,
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          const Text("Download"),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        children: [
                                          Assets.icons.share.svg(
                                            colorFilter: const ColorFilter.mode(
                                              AppColors.grey,
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          const Text("Share"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ],
                        if (response.data.qrPresensi == null) ...[
                          Button.filled(
                            label: "Buat QR Presensi",
                            color: AppColors.primary,
                            onPressed: () {
                              msRoute(context, const TemplateDosenPage());
                            },
                            height: 45,
                            fontSize: 16,
                          ),
                        ],
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
