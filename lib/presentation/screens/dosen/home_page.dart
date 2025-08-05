import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycic_app/core/core.dart';
import 'package:mycic_app/core/helper/ms_route.dart';
import 'package:mycic_app/data/datasources/auth_local_datasource.dart';
import 'package:mycic_app/data/models/auth_response_model.dart';
import 'package:mycic_app/features/bloc/dsn_kelas_today/dsn_kelas_today_bloc.dart';
import 'package:mycic_app/features/bloc/dsn_tugas/dsn_tugas_bloc.dart';
import 'package:mycic_app/presentation/screens/dosen/absensi_page.dart';
import 'package:mycic_app/presentation/screens/dosen/class_page.dart';
import 'package:mycic_app/presentation/screens/dosen/ujian_page.dart';
import 'package:mycic_app/presentation/screens/informasi_page.dart';
import 'package:mycic_app/presentation/screens/mhs/tugas_page.dart';
import 'package:mycic_app/presentation/widgets/all_menu.dart';
import 'package:mycic_app/presentation/widgets/banner_skeleton.dart';
import 'package:mycic_app/presentation/widgets/header_widget.dart';
import 'package:mycic_app/presentation/widgets/my_kelas_banner.dart';
import 'package:mycic_app/presentation/widgets/tugas_list_skeleton.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Buat state untuk menampung Future dari data profil
  late Future<AuthResponseModel?> _profileFuture;
  late String global_name;

  @override
  void initState() {
    super.initState();
    // Panggil fungsi untuk mengambil data saat widget pertama kali dibuat
    _loadData();
  }

  // Buat fungsi terpisah untuk mengambil data
  Future<AuthResponseModel?> _fetchProfileData() {
    return AuthLocalDatasource().getAuthData();
  }

  // Buat fungsi untuk handle aksi refresh
  Future<void> _loadData() async {
    // Pemicu event BLoC ditambahkan di sini agar ikut refresh
    context.read<DsnKelasTodayBloc>().add(const DsnKelasTodayEvent.fetch());
    context.read<DsnTugasBloc>().add(const DsnTugasEvent.fetch());
    // Panggil setState untuk memberitahu Flutter agar membangun ulang widget
    // dengan Future yang baru (memuat ulang data)
    setState(() {
      _profileFuture = _fetchProfileData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      {
        'title': 'Kelas',
        'icon': Assets.images.menu.jadwal,
        'page': ClassPage(),
      },
      {
        'title': 'Presensi MK',
        'icon': Assets.images.menu.kelas,
        'page': AbsensiPage(),
      },
      {
        'title': 'Informasi',
        'icon': Assets.images.menu.informasi,
        'page': InformasiPage(),
      },
      {'title': 'Ujian', 'icon': Assets.images.menu.ujian, 'page': UjianPage()},
    ];

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: FutureBuilder<AuthResponseModel?>(
                  future: _profileFuture,
                  builder: (context, snapshot) {
                    // • Waiting → placeholder
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox(
                        height: 24,
                        child: LinearProgressIndicator(),
                      );
                    }

                    // • Ambil nama jika ada
                    global_name = snapshot.data?.user.nama ?? '';
                    // user info
                    final userInfo = snapshot.data?.user.userInfo ?? '';

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeaderWidget(
                          profileImageUrl: snapshot.data?.user.profile ?? '',
                        ),
                        Text(
                          'Halo, $global_name 👋',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(userInfo, style: TextStyle(fontSize: 16)),
                      ],
                    );
                  },
                ),
              ),
              // Banner
              // -- UBAH BAGIAN BANNER --
              BlocBuilder<DsnKelasTodayBloc, DsnKelasTodayState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const BannerSkeleton(),
                    loading: () => const BannerSkeleton(),
                    error:
                        (message) => SizedBox(
                          height: 155,
                          child: Center(child: Text(message)),
                        ),
                    success: (res) {
                      debugPrint('Banner: $res');
                      // Ubah data model menjadi list widget
                      if (res.data.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: MyKelasBanner(
                            mkId: 0,
                            title: 'Rehat sejenak',
                            time: '--',
                            ruangan: '',
                            dosen: '',
                            adakelas: false,
                          ),
                        );
                      }

                      final bannerItems =
                          res.data.map((kelas) {
                            return MyKelasBanner(
                              mkId: kelas.idJadwalKelas,
                              title: kelas.mataKuliah,
                              time: kelas.jam,
                              ruangan: kelas.ruang,
                              dosen: global_name,
                            );
                          }).toList();

                      return CarouselSlider(
                        items: bannerItems,
                        options: CarouselOptions(
                          height: 155,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          viewportFraction: 0.92,
                          scrollPhysics: const BouncingScrollPhysics(),
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: menuItems.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    final item = menuItems[index];
                    final iconMenu = item['icon'] as AssetGenImage;
                    final pageMenu = item['page'] as Widget;
                    final title = item['title'] as String;
                    return GestureDetector(
                      onTap: () {
                        if (item['title'] == 'Semua') {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return AllMenu();
                            },
                          );
                        } else {
                          msRoute(context, pageMenu);
                        }
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(40),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(18),
                            child: iconMenu.image(height: 28, width: 28),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            title,
                            style: const TextStyle(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Tugas Terdekat",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            msRoute(context, TugasPage());
                          },
                          child: const Row(
                            children: [
                              Text(
                                "Lihat Semua",
                                style: TextStyle(color: AppColors.black),
                              ),
                              SizedBox(width: 4),
                              Icon(
                                Icons.arrow_forward,
                                size: 14,
                                color: AppColors.black,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    BlocBuilder<DsnTugasBloc, DsnTugasState>(
                      builder: (context, state) {
                        debugPrint('state: $state');
                        return state.when(
                          initial: () => const TugasListSkeleton(),
                          loading: () => const TugasListSkeleton(),
                          error:
                              (message) => SizedBox(
                                height: 155,
                                child: Center(child: Text(message)),
                              ),
                          success: (res) {
                            final tugas = (res.data).take(5).toList();
                            return ListView.builder(
                              padding: const EdgeInsets.only(top: 12),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: tugas.length,
                              itemBuilder: (context, index) {
                                final item = tugas[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      msRoute(context, TugasPage());
                                    },
                                    child: Card(
                                      elevation: 1,
                                      color: AppColors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.deskripsiTugas,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              'Mata Kuliah : ${item.namaMk}',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                    SizedBox(height: 24),
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
