import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:myapp/core/core.dart';
import 'package:myapp/presentation/screens/mhs/class_page.dart';
import 'package:myapp/presentation/screens/mhs/home_page.dart';
import 'package:myapp/presentation/screens/mhs/scanner_page.dart';

class TemplatePage extends StatefulWidget {
  const TemplatePage({super.key});

  @override
  State<TemplatePage> createState() => _TemplatePageState();
}

class _TemplatePageState extends State<TemplatePage> {
  int _selectedIndex = 0;

  final _widgets = const [HomePage(), ScannerPage(), ClassPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _widgets),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.06),
              blurRadius: 16,
              offset: const Offset(0, -8),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: GNav(
          gap: 8,
          backgroundColor: Colors.white,
          color: AppColors.grey,
          activeColor: AppColors.primary,
          tabBackgroundColor: AppColors.primary.withOpacity(0.1),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            HapticFeedback.mediumImpact();
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ScannerPage()),
              );
              return;
            }
            setState(() => _selectedIndex = index);
          },
          tabs: [
            GButton(
              iconActiveColor: AppColors.primary,
              leading: Assets.icons.nav.home.svg(
                height: 24,
                width: 24,
                color: _selectedIndex == 0 ? AppColors.primary : AppColors.grey,
              ),
              text: 'Home',
              icon: Icons.translate_outlined,
            ),

            GButton(
              iconActiveColor: AppColors.primary,
              iconColor: AppColors.grey,
              icon: Icons.qr_code_scanner_outlined,
              text: 'Scan Absen',
            ),
            GButton(icon: Icons.class_outlined, text: 'Kelas'),
          ],
        ),
      ),
    );
  }
}
