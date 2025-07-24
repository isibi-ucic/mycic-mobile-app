import 'package:flutter/material.dart';
import 'package:myapp/core/components/buttons.dart';
import 'package:myapp/core/constants/colors.dart';
import 'package:myapp/core/helper/ms_route.dart';
import 'package:myapp/presentation/screens/mhs/template_page.dart';
import 'package:myapp/presentation/widgets/default_app_bar.dart';

class DetailPertemuanPage extends StatelessWidget {
  const DetailPertemuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: 'Detail Pertemuan'),
      backgroundColor: AppColors.bgDefault,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Materi Perkuliahan disini",
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  Text(
                    "Dosen CIC, M.Kom",
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const Text('|', style: TextStyle(color: Colors.black26)),
                  Text(
                    "Rabu, 9:00 - 11:00",
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const Text('|', style: TextStyle(color: Colors.black26)),
                  Text("201", style: const TextStyle(color: Colors.black54)),
                ],
              ),
              SizedBox(height: 16),
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(12),
              //   child: Container(
              //     color: Colors.grey[300], // background saat loading/error
              //     height: 200, // Atur sesuai kebutuhan tampilan
              //     width: double.infinity,
              //     child: const PDF().cachedFromUrl(
              //       "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf",
              //       placeholder:
              //           (progress) => Center(
              //             child: CircularProgressIndicator(value: progress / 100),
              //           ),
              //       errorWidget:
              //           (error) => Center(child: Text('Gagal memuat PDF')),
              //     ),
              //   ),
              // ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  color: Colors.grey[300],
                  child: const SizedBox(
                    height: 200,
                    child: Center(child: Text('PDF View')),
                  ),
                ),
              ),

              // SizedBox(height: 200, child: Center(child: Text('PDF View'))),
              SizedBox(height: 16),
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Button.filled(
                label: "Scan Absensi",
                color: AppColors.primary,
                onPressed: () {
                  msRoute(context, const TemplateMhsPage());
                },
                height: 45,
                fontSize: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
