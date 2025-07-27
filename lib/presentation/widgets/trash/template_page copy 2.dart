// import 'package:flutter/material.dart';
// import 'package:mycic_app/core/core.dart';
// import 'package:mycic_app/presentation/screens/class_page.dart';
// import 'package:mycic_app/presentation/screens/home_page.dart';
// import 'package:mycic_app/presentation/screens/scanner_page.dart';

// class TemplatePage extends StatefulWidget {
//   const TemplatePage({super.key});

//   @override
//   State<TemplatePage> createState() => _TemplatePageState();
// }

// class _TemplatePageState extends State<TemplatePage> {
//   int _selectedIndex = 0; // set default page to 0
//   final _widgets = [
//     // const HomePage(),
//     const HomePage(),
//     const ScannerPage(),
//     const ClassPage(),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(index: _selectedIndex, children: _widgets),
//       bottomNavigationBar: Container(
//         padding: const EdgeInsets.only(bottom: 10.0),
//         decoration: BoxDecoration(
//           borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
//           boxShadow: [
//             BoxShadow(
//               color: AppColors.black,
//               blurRadius: 16.0,
//               blurStyle: BlurStyle.outer,
//               offset: const Offset(0, -8),
//               spreadRadius: 0,
//             ),
//           ],
//         ),
//         child: Theme(
//           data: ThemeData(
//             splashColor: Colors.transparent,
//             highlightColor: Colors.transparent,
//           ),
//           child: BottomNavigationBar(
//             useLegacyColorScheme: false,
//             currentIndex: _selectedIndex,
//             onTap: (index) {
//               if (index == 1) {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => const ScannerPage()),
//                 );
//                 return;
//               }
//               setState(() => _selectedIndex = index);
//             },
//             type: BottomNavigationBarType.fixed,
//             backgroundColor: Colors.white,
//             selectedLabelStyle: const TextStyle(color: AppColors.primary),
//             selectedIconTheme: const IconThemeData(color: AppColors.primary),
//             elevation: 0,
//             items: [
//               BottomNavigationBarItem(
//                 icon: Assets.icons.nav.home.svg(
//                   height: 24,
//                   width: 24,
//                   color:
//                       _selectedIndex == 0 ? AppColors.primary : AppColors.grey,
//                 ),
//                 label: 'Home',
//               ),
//               BottomNavigationBarItem(
//                 icon: Assets.icons.nav.scan.svg(height: 24, width: 24),
//                 label: 'Absensi',
//               ),
//               BottomNavigationBarItem(
//                 icon: Assets.icons.nav.myclass.svg(height: 24, width: 24),
//                 label: 'Kelas',
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
