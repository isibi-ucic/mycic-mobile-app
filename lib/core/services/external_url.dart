import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import untuk PlatformException
import 'package:url_launcher/url_launcher.dart';

Future<void> externalUrl(BuildContext context, String url) async {
  final Uri uri = Uri.parse(url);
  try {
    // Coba luncurkan URL
    if (!await launchUrl(uri)) {
      // Tampilkan pesan jika launchUrl mengembalikan false
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Tidak dapat membuka $url')));
    }
  } on PlatformException catch (e) {
    // Tangani error spesifik jika channel gagal (seperti pada error Anda)
    print('Gagal membuka URL: ${e.message}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Gagal membuka URL: Aplikasi tidak ditemukan.')),
    );
  } catch (e) {
    // Tangani error lainnya
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Terjadi kesalahan: $e')));
  }
}
