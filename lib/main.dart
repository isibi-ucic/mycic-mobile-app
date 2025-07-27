import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycic_app/core/constants/colors.dart';
import 'package:mycic_app/features/bloc/auth/auth_bloc.dart';
import 'package:mycic_app/features/bloc/info/info_bloc.dart';
import 'package:mycic_app/features/bloc/mhs_kelas/mhs_kelas_bloc.dart';
import 'package:mycic_app/features/bloc/mhs_presensi/mhs_presensi_bloc.dart';
import 'package:mycic_app/features/bloc/mhs_ujian/mhs_ujian_bloc.dart';
import 'package:mycic_app/features/bloc/transkrip/transkrip_bloc.dart';
import 'package:mycic_app/presentation/screens/splash_page.dart';

/// The main entry point of the application.
///
/// This function initializes the app by calling `runApp` with `MyCicApp` as
/// the root widget, which sets up the widget tree and starts the Flutter framework.

void main() {
  runApp(const MyCicApp());
}

class MyCicApp extends StatefulWidget {
  const MyCicApp({super.key});

  @override
  State<MyCicApp> createState() => _MyCicAppState();
}

class _MyCicAppState extends State<MyCicApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => MhsKelasBloc()),
        BlocProvider(create: (context) => InfoBloc()),
        BlocProvider(create: (context) => MhsPresensiBloc()),
        BlocProvider(create: (context) => TranskripBloc()),
        BlocProvider(create: (context) => MhsUjianBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyCIC Mobile App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          dialogTheme: const DialogThemeData(elevation: 0),
          dividerTheme: DividerThemeData(
            color: AppColors.light,
            thickness: 0.5,
          ),
          textTheme: GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme),
          appBarTheme: AppBarTheme(
            centerTitle: true,
            color: AppColors.white,
            elevation: 0,
            titleTextStyle: GoogleFonts.nunito(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          useMaterial3: true,
        ),
        home: const SplashPage(),
      ),
    );
  }
}
