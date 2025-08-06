import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mycic_app/core/constants/colors.dart';
import 'package:mycic_app/features/bloc/auth/auth_bloc.dart';
import 'package:mycic_app/features/bloc/dsn_kelas/dsn_kelas_bloc.dart';
import 'package:mycic_app/features/bloc/dsn_kelas_pertemuan/dsn_kelas_pertemuan_bloc.dart';
import 'package:mycic_app/features/bloc/dsn_kelas_pertemuan_detail/dsn_kelas_pertemuan_detail_bloc.dart';
import 'package:mycic_app/features/bloc/dsn_kelas_today/dsn_kelas_today_bloc.dart';
import 'package:mycic_app/features/bloc/dsn_skripsi/dsn_skripsi_bloc.dart';
import 'package:mycic_app/features/bloc/dsn_tugas/dsn_tugas_bloc.dart';
import 'package:mycic_app/features/bloc/generate_qr/generate_qr_bloc.dart';
import 'package:mycic_app/features/bloc/info/info_bloc.dart';
import 'package:mycic_app/features/bloc/khs/khs_bloc.dart';
import 'package:mycic_app/features/bloc/mhs_kelas/mhs_kelas_bloc.dart';
import 'package:mycic_app/features/bloc/mhs_kelas_detail/mhs_kelas_detail_bloc.dart';
import 'package:mycic_app/features/bloc/mhs_kelas_pertemuan_detail/mhs_kelas_pertemuan_detail_bloc.dart';
import 'package:mycic_app/features/bloc/mhs_kelas_today/mhs_kelas_today_bloc.dart';
import 'package:mycic_app/features/bloc/mhs_presensi/mhs_presensi_bloc.dart';
import 'package:mycic_app/features/bloc/mhs_tugas/mhs_tugas_bloc.dart';
import 'package:mycic_app/features/bloc/mhs_ujian/mhs_ujian_bloc.dart';
import 'package:mycic_app/features/bloc/presensi_kelas/presensi_kelas_bloc.dart';
import 'package:mycic_app/features/bloc/presensi_rekap/presensi_rekap_bloc.dart';
import 'package:mycic_app/features/bloc/skripsi/skripsi_bloc.dart';
import 'package:mycic_app/features/bloc/submit_presensi/submit_presensi_bloc.dart';
import 'package:mycic_app/features/bloc/transkrip/transkrip_bloc.dart';
import 'package:mycic_app/presentation/screens/splash_page.dart';
import 'package:mycic_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// PENTING: Untuk handle notifikasi saat app ditutup (terminated state)
// Fungsi ini harus berada di luar kelas (top-level function)
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print("Handling a background message: ${message.messageId}");
  print("Title: ${message.notification?.title}");
  print("Body: ${message.notification?.body}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 2. Tambahkan baris ini untuk menginisialisasi data lokal Bahasa Indonesia
  await initializeDateFormatting('id_ID', null);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // 1. TAMBAHKAN BARIS INI
  // Memberitahu Firebase untuk menampilkan notifikasi di foreground
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );

  // Set background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyCicApp());
}

class MyCicApp extends StatefulWidget {
  const MyCicApp({super.key});

  @override
  State<MyCicApp> createState() => _MyCicAppState();
}

class _MyCicAppState extends State<MyCicApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    setupFirebaseMessaging();
  }

  void setupFirebaseMessaging() async {
    // 1. Meminta Izin Notifikasi (iOS & Android 13+)
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');

      // 2. Dapatkan FCM Token
      final fcmToken = await _firebaseMessaging.getToken();
      print("FCM Token: $fcmToken");
      // TODO: Kirim token ini ke server Express.js Anda untuk disimpan!

      // 3. Subscribe ke topic (cocok dengan backend)
      await _firebaseMessaging.subscribeToTopic('info-terbaru');
      print("Subscribed to topic 'info-terbaru'");

      // 2. MODIFIKASI BLOK INI
      // Handler saat aplikasi dalam keadaan Foreground (terbuka)
      // Kita tidak perlu lagi menampilkan dialog, cukup biarkan kosong atau beri log.
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');

        if (message.notification != null) {
          print(
            'Message also contained a notification: ${message.notification}',
          );
          // Kode showDialog() DIHAPUS dari sini.
        }
      });

      // Handler saat user klik notifikasi & aplikasi terbuka dari background
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('A new onMessageOpenedApp event was published!');
        // Navigasi ke halaman detail informasi berdasarkan data dari notifikasi
        // Navigator.pushNamed(context, '/detail-info', arguments: message.data);
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }

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
        BlocProvider(create: (context) => KhsBloc()),
        BlocProvider(create: (context) => MhsKelasTodayBloc()),
        BlocProvider(create: (context) => MhsKelasDetailBloc()),
        BlocProvider(create: (context) => MhsKelasPertemuanDetailBloc()),
        BlocProvider(create: (context) => MhsTugasBloc()),
        BlocProvider(create: (context) => SubmitPresensiBloc()),
        BlocProvider(create: (context) => DsnKelasTodayBloc()),
        BlocProvider(create: (context) => DsnKelasBloc()),
        BlocProvider(create: (context) => DsnKelasPertemuanBloc()),
        BlocProvider(create: (context) => DsnKelasPertemuanDetailBloc()),
        BlocProvider(create: (context) => DsnTugasBloc()),
        BlocProvider(create: (context) => DsnSkripsiBloc()),
        BlocProvider(create: (context) => SkripsiBloc()),
        BlocProvider(create: (context) => GenerateQrBloc()),
        BlocProvider(create: (context) => PresensiKelasBloc()),
        BlocProvider(create: (context) => PresensiRekapBloc()),
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
