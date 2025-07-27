import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/presentation/screens/mhs/class_page.dart';
import 'package:myapp/presentation/screens/mhs/home_page.dart';
import 'package:myapp/presentation/screens/mhs/scanner_page.dart';
// import 'package:myapp/presentation/screens/scanner_page.dart';

import '../../../../core/core.dart';

class TemplateMhsPage extends StatefulWidget {
  const TemplateMhsPage({super.key});

  @override
  State<TemplateMhsPage> createState() => _TemplateMhsPageState();
}

class _TemplateMhsPageState extends State<TemplateMhsPage> {
  int _selectedIndex = 0;
  final _widgets = [
    // const HomePage(),
    const HomePage(),
    const ScannerPage(),
    const ClassPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _widgets),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          boxShadow: [
            BoxShadow(color: AppColors.white, offset: const Offset(0, -12)),
            BoxShadow(
              blurRadius: 4.0,
              blurStyle: BlurStyle.outer,
              offset: const Offset(0, -10),
              spreadRadius: 1,
              color: AppColors.grey,
            ),
          ],
        ),
        child: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            useLegacyColorScheme: true,
            currentIndex: _selectedIndex,
            onTap: (value) {
              HapticFeedback.mediumImpact();

              if (value == 1) {
                // Pindah halaman ke scanner (push)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ScannerPage()),
                );
                return; // Jangan update _selectedIndex
              }

              setState(() => _selectedIndex = value);
            },

            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.white,
            selectedLabelStyle: const TextStyle(color: AppColors.primary),
            selectedIconTheme: const IconThemeData(color: AppColors.primary),
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: Assets.icons.nav.home.svg(
                  colorFilter: ColorFilter.mode(
                    _selectedIndex == 0 ? AppColors.primary : AppColors.grey,
                    BlendMode.srcIn,
                  ),
                ),

                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Assets.icons.nav.scan.svg(
                  colorFilter: ColorFilter.mode(
                    _selectedIndex == 1 ? AppColors.primary : AppColors.grey,
                    BlendMode.srcIn,
                  ),
                ),

                label: 'Scan Absen',
              ),
              BottomNavigationBarItem(
                icon: Assets.icons.nav.myclass.svg(
                  colorFilter: ColorFilter.mode(
                    _selectedIndex == 2 ? AppColors.primary : AppColors.grey,
                    BlendMode.srcIn,
                  ),
                ),

                label: 'Kelas',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
