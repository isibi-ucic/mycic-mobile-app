import 'package:flutter/material.dart';
import 'package:mycic_app/core/assets/assets.gen.dart';
import 'package:mycic_app/core/components/buttons.dart';
import 'package:mycic_app/core/constants/colors.dart';
import 'package:mycic_app/core/helper/ms_route.dart';
import 'package:mycic_app/presentation/screens/dosen/template_page.dart';
import 'package:mycic_app/presentation/widgets/default_app_bar.dart';

class DetailPertemuanPage extends StatelessWidget {
  const DetailPertemuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: 'Detail Pertemuan'),
      backgroundColor: AppColors.bgDefault,
      body: SafeArea(
        child: SingleChildScrollView(
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
                      "Ruangan 201",
                      style: const TextStyle(color: Colors.black54),
                    ),
                    const Text('|', style: TextStyle(color: Colors.black26)),
                    Text(
                      "Rabu, 9:00 - 11:00",
                      style: const TextStyle(color: Colors.black54),
                    ),
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

                SizedBox(height: 16),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 16),
                ),

                SizedBox(height: 16),
                Align(
                  alignment: Alignment.center,
                  child: Assets.images.qrPresensi.image(
                    height:
                        MediaQueryData.fromView(View.of(context)).size.width /
                        2,
                  ),
                ),
                SizedBox(height: 16),

                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Assets.icons.download.svg(
                                  colorFilter: ColorFilter.mode(
                                    AppColors.grey,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text("Download"),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Assets.icons.share.svg(
                                  colorFilter: ColorFilter.mode(
                                    AppColors.grey,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text("Share"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Button.filled(
                  label: "Buat QR Presensi",
                  color: AppColors.primary,
                  onPressed: () {
                    msRoute(context, const TemplateDosenPage());
                  },
                  height: 45,
                  fontSize: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
