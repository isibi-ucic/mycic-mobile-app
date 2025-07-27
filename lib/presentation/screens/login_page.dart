import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycic_app/core/core.dart';
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

  // inisial show passwrod
  bool isShowPassword = false;

  @override
  void initState() {
    nimController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  // jika page tidak tampil, proses dihentikan
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
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpaceHeight(80),
                Assets.icons.logo.svg(
                  width: MediaQuery.of(context).size.width,
                  height: 120,
                  fit: BoxFit.contain, // optional, tergantung kebutuhan
                ),
                const SpaceHeight(10),
                const Text(
                  'MyCIC Mobile App',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SpaceHeight(40),
                CustomTextField(
                  controller: nimController,
                  placeholder: 'Masukkan NIM...',
                  showLabel: false,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      Assets.icons.user.path,
                      height: 20,
                      width: 10,
                    ),
                  ),
                ),
                const SpaceHeight(20),
                CustomTextField(
                  controller: passwordController,
                  placeholder: 'Masukkan Password...',
                  showLabel: false,
                  obscureText: !isShowPassword,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      Assets.icons.password.path,
                      height: 20,
                      width: 10,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isShowPassword ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        isShowPassword = !isShowPassword;
                      });
                    },
                  ),
                ),
                const SpaceHeight(80),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      orElse: () {},
                      success: (data) {
                        // simpan data login ke local source
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
                          label: '', // kosongin label
                          icon: SpinKitThreeBounce(
                            color: Colors.white,
                            size: 20.0,
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
