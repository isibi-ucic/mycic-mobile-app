import 'package:flutter/material.dart';
import 'package:mycic_app/core/core.dart';
import 'package:mycic_app/data/datasources/auth_local_datasource.dart';
import 'package:mycic_app/presentation/screens/dosen/template_page.dart';
import 'package:mycic_app/presentation/screens/login_page.dart';
import 'package:mycic_app/presentation/screens/mhs/template_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  // Pindahkan logika ke initState agar hanya berjalan sekali saat halaman dibuka
  @override
  void initState() {
    super.initState();
    // Panggil method async kita setelah frame pertama selesai di-render
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuthStatus();
    });
  }

  // 👇 BUAT METHOD ASYNC BARU UNTUK MENGGANTIKAN .then()
  Future<void> _checkAuthStatus() async {
    // Tunggu 2 detik untuk menampilkan splash screen
    await Future.delayed(const Duration(seconds: 2));

    // Cek apakah user sudah login atau belum
    final bool isLoggedIn = await AuthLocalDatasource().isAuth();

    // Pengecekan ini penting agar tidak ada error jika widget sudah ter-dispose
    if (mounted) {
      if (isLoggedIn) {
        // Jika login, dapatkan data user
        final authData = await AuthLocalDatasource().getAuthData();
        if (authData?.user.role == 'mahasiswa') {
          context.pushReplacement(const TemplateMhsPage());
        } else {
          context.pushReplacement(const TemplateDosenPage());
        }
      } else {
        // Jika tidak login, arahkan ke LoginPage
        context.pushReplacement(const LoginPage());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // build method sekarang hanya fokus untuk menampilkan UI splash screen
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Assets.icons.logo.svg(height: 100),
              const SizedBox(height: 12),
              const Text(
                'MyCIC Mobile App',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
