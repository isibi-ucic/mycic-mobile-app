import 'package:flutter/material.dart';
import 'package:myapp/core/components/buttons.dart';
import 'package:myapp/core/constants/colors.dart';
import 'package:myapp/data/datasources/auth_local_datasource.dart';
import 'package:myapp/data/models/auth_response_model.dart';
import 'package:myapp/presentation/screens/login_page.dart';
import 'package:myapp/presentation/widgets/default_app_bar.dart';
import 'package:myapp/presentation/widgets/simple_underline_button.dart';

// Perubahan 1: Mengubah StatelessWidget menjadi StatefulWidget
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Buat state untuk menampung Future dari data profil
  late Future<AuthResponseModel?> _profileFuture;

  @override
  void initState() {
    super.initState();
    // Panggil fungsi untuk mengambil data saat widget pertama kali dibuat
    _profileFuture = _fetchProfileData();
  }

  // Buat fungsi terpisah untuk mengambil data
  Future<AuthResponseModel?> _fetchProfileData() {
    return AuthLocalDatasource().getAuthData();
  }

  // Buat fungsi untuk handle aksi refresh
  Future<void> _onRefresh() async {
    // Panggil setState untuk memberitahu Flutter agar membangun ulang widget
    // dengan Future yang baru (memuat ulang data)
    setState(() {
      _profileFuture = _fetchProfileData();
    });
  }

  // Perbaikan Logout: Membuat fungsi logout lebih robust
  Future<void> _logout() async {
    // Hapus data sesi dari local storage
    await AuthLocalDatasource().removeAuthData();
    // Navigasi ke LoginPage dan hapus semua halaman sebelumnya dari stack
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: 'Profil'),
      backgroundColor: AppColors.bgDefault,
      body: SafeArea(
        // Hapus SafeArea ganda yang tidak perlu
        child: RefreshIndicator(
          // Perubahan 6: Hubungkan fungsi _onRefresh ke RefreshIndicator
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
            // Pastikan SingleChildScrollView selalu bisa di-scroll agar RefreshIndicator aktif
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 24),

                // Avatar
                // Perubahan 7: Gunakan state _profileFuture untuk FutureBuilder
                FutureBuilder<AuthResponseModel?>(
                  future: _profileFuture,
                  builder: (context, snapshot) {
                    // • Waiting → placeholder
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError ||
                        !snapshot.hasData ||
                        snapshot.data == null) {
                      return const Center(child: Text('Gagal memuat data.'));
                    }

                    // • Ambil nama jika ada
                    final user = snapshot.data!.user;
                    final nama = user.nama ?? 'Nama Pengguna';
                    final profil = user.profile ?? '';
                    final numberId = user.userNumber ?? 'NIM/NIDN';

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: AppColors.grey, // Warna fallback
                          backgroundImage:
                              profil.isNotEmpty ? NetworkImage(profil) : null,
                          child:
                              profil.isEmpty
                                  ? const Icon(
                                    Icons.person,
                                    size: 60,
                                    color: Colors.white,
                                  )
                                  : null,
                        ),

                        const SizedBox(height: 24),
                        Text(
                          nama,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                        // Nama
                        const SizedBox(height: 8),

                        // NIM
                        Text(
                          numberId.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 4),

                // Jurusan
                const Text(
                  "Teknik Informatika - VIII",
                  style: TextStyle(fontSize: 16, color: AppColors.black),
                ),
                const SizedBox(height: 32),

                SimpleUnderlineButton(
                  title: "Ubah Password",
                  onTap: () {
                    // handle aksi ubah password
                  },
                ),
                SimpleUnderlineButton(
                  title: "Hubungi Pusdatin",
                  onTap: () {
                    // handle aksi hubungi pusdatin
                  },
                ),

                const SizedBox(
                  height: 50,
                ), // Beri jarak agar tidak terhalang tombol logout
                // Versi aplikasi
                const Text(
                  "Versi Aplikasi 1.0.10",
                  style: TextStyle(fontSize: 12, color: Colors.black45),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),

      // Tombol Logout
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Button.filled(
          label: "Logout",
          color: AppColors.primary,
          // Perbaikan Logout: Panggil fungsi _logout
          onPressed: _logout,
          height: 44,
          fontSize: 16,
        ),
      ),
    );
  }
}
