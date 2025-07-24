import 'package:flutter/material.dart';
import 'package:myapp/core/constants/colors.dart';
import 'package:myapp/core/helper/ms_route.dart';
import 'package:myapp/presentation/screens/mhs/template_page.dart';
import 'package:myapp/presentation/widgets/default_app_bar.dart';

class SkripsiPage extends StatefulWidget {
  const SkripsiPage({super.key});

  @override
  State<SkripsiPage> createState() => _SkripsiPageState();
}

class _SkripsiPageState extends State<SkripsiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: "Skripsi"),
      backgroundColor: AppColors.bgDefault,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Judul: Sistem Informasi Akademik",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "Deskripsi: Sistem informasi yang dirancang untuk memudahkan proses administrasi akademik.",
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      msRoute(context, TemplateMhsPage());
                    },
                    child: Text("Bimbingan Dosen A"),
                  ),
                  Text("Bimbingan: 3x"),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Bimbingan Dosen B"),
                  ),
                  Text("Bimbingan: 1x"),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
