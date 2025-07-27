import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycic_app/core/core.dart';
import 'package:mycic_app/core/services/external_url.dart';
import 'package:mycic_app/data/datasources/auth_local_datasource.dart';
import 'package:mycic_app/features/bloc/auth/auth_bloc.dart';
import 'package:mycic_app/presentation/screens/dosen/template_page.dart';
import 'package:mycic_app/presentation/screens/mhs/template_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController nimController;
  late final TextEditingController passwordController;

  bool isShowPassword = false;

  @override
  void initState() {
    nimController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nimController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Scaffold(
        // Menghindari keyboard menutupi text field
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          // SingleChildScrollView wajib ada agar bisa di-scroll saat keyboard muncul
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 32.0,
              ),
              child: Column(
                // Rata tengah secara horizontal
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Spasi dari atas
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),

                  // --- KELOMPOK LOGO & JUDUL ---
                  Assets.icons.logo.svg(
                    width: MediaQuery.of(context).size.width * 0.5,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'MyCIC Mobile App',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 48),

                  // --- KELOMPOK INPUT FIELDS ---
                  CustomTextField(
                    controller: nimController,
                    placeholder: 'Masukkan NIM...',
                    showLabel: false,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        Assets.icons.user.path,
                        height: 20,
                        width: 10,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: passwordController,
                    placeholder: 'Masukkan Password...',
                    showLabel: false,
                    obscureText: !isShowPassword,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        Assets.icons.password.path,
                        height: 20,
                        width: 10,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isShowPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppColors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          isShowPassword = !isShowPassword;
                        });
                      },
                    ),
                  ),

                  // text button lupa password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Ubah nomor telepon pusdatin
                        const numberPhone = "6285795567332";

                        String msg =
                            "Halo, saya butuh bantuan untuk ubah password. Berikut adalah informasi akun saya:\n\nNama: \nNIM: \n\nTerima kasih.";

                        // convert ke url
                        var encodedMsg = Uri.encodeComponent(msg);

                        // handle aksi ubah password minta ke whatsapp
                        externalUrl(
                          context,
                          'https://wa.me/$numberPhone?text=$encodedMsg',
                        );
                      },
                      child: const Text(
                        'Lupa Password',
                        style: TextStyle(color: AppColors.primary),
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),

                  // --- KELOMPOK TOMBOL LOGIN ---
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      state.maybeWhen(
                        orElse: () {},
                        success: (data) {
                          AuthLocalDatasource().saveAuthData(data);
                          if (data.user.role == 'mahasiswa') {
                            context.pushReplacement(const TemplateMhsPage());
                          } else {
                            context.pushReplacement(const TemplateDosenPage());
                          }
                        },
                        error: (message) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(message),
                              backgroundColor: AppColors.red,
                            ),
                          );
                        },
                      );
                    },
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () {
                          return Button.filled(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              context.read<AuthBloc>().add(
                                AuthEvent.login(
                                  nimController.text,
                                  passwordController.text,
                                ),
                              );
                            },
                            label: 'Login',
                          );
                        },
                        loading: () {
                          return Button.filled(
                            color: AppColors.primary.withAlpha(10),
                            onPressed: null,
                            label: '',
                            icon: const SpinKitThreeBounce(
                              color: Colors.white,
                              size: 20.0,
                            ),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
