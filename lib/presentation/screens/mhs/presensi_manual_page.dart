// manual_presence_page.dart
import 'package:flutter/material.dart';
import 'package:mycic_app/core/components/components.dart';
import 'package:mycic_app/core/constants/colors.dart';
import 'package:mycic_app/presentation/widgets/default_app_bar.dart';

class PresensiManualPage extends StatefulWidget {
  const PresensiManualPage({super.key});

  @override
  State<PresensiManualPage> createState() => _PresensiManualPageState();
}

class _PresensiManualPageState extends State<PresensiManualPage> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submitPresence() {
    if (_formKey.currentState!.validate()) {
      final String code = _controller.text;
      print('Kode yang disubmit: $code');
      // TODO: Kirim kode ke endpoint API Anda
      // Setelah berhasil, tampilkan dialog sukses dan kembali ke home
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(title: 'Presensi Manual'),
      backgroundColor: AppColors.bgDefault,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                controller: _controller,
                placeholder: 'Masukkan Kode Presensi',
                showLabel: false,
                prefixIcon: Icon(Icons.qr_code),
              ),

              const SizedBox(height: 24),
              Button.filled(
                width: double.infinity,
                color: AppColors.primary,
                onPressed: null,
                label: 'Submit', // kosongin label
              ),
            ],
          ),
        ),
      ),
    );
  }
}
