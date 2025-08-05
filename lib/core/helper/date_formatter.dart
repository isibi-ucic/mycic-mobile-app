// lib/core/helpers/date_formatter.dart

import 'package:intl/intl.dart';

class DateFormatter {
  // Jadikan sebagai method statis agar bisa dipanggil langsung
  static String formatHariTanggal(String tanggal) {
    try {
      final DateTime dateTime = DateTime.parse(tanggal);
      return DateFormat('EEEE, d MM yyyy', 'id_ID').format(dateTime);
    } catch (e) {
      return tanggal; // Fallback jika format salah
    }
  }
}
