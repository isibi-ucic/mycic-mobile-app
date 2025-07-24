import 'package:flutter/material.dart';
import 'package:myapp/core/core.dart';
import 'package:myapp/data/datasources/auth_local_datasource.dart';
import 'package:myapp/presentation/screens/login_page.dart';
import 'package:myapp/presentation/screens/mhs/template_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: FutureBuilder(
        future: AuthLocalDatasource().isAuth(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Assets.icons.logo.svg(),
                ),
                const Spacer(),
                // Assets.images.logoCodeWithBahri.image(height: 70),
                const SpaceHeight(20.0),
              ],
            );
          }
          if (snapshot.hasData) {
            if (snapshot.data! == true) {
              Future.delayed(
                const Duration(seconds: 2),
                () => context.pushReplacement(const TemplateMhsPage()),
              );
            } else {
              Future.delayed(
                const Duration(seconds: 2),
                () => context.pushReplacement(const LoginPage()),
              );
            }
          }
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment
                        .center, // Aligns children vertically centered
                crossAxisAlignment:
                    CrossAxisAlignment
                        .center, // Aligns children horizontally centered
                children: [
                  Assets.icons.logo.svg(height: 100),
                  const SizedBox(height: 5),
                  const Text(
                    'MyCIC Mobile App',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'Plus Jakarta Sans',
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
