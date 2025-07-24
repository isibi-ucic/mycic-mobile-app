import 'package:intl/intl.dart';

class FormatDate {
  // Variabel formatter yang bersifat statis
  static final DateFormat dateFormatterVar = DateFormat('yyyy-MM-dd');

  // Fungsi dateFormatter menerima format yang dapat dikustomisasi, default-nya adalah dateFormatterVar
  static String dateFormatter(DateTime date, {String? format}) {
    DateFormat dateFormatter =
        format != null ? DateFormat(format) : dateFormatterVar;
    return dateFormatter.format(date);
  }
}
