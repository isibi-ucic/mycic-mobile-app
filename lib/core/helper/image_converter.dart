// lib/image_converter.dart

import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';

class ImageConverter {
  /// Mengonversi [Uint8List] menjadi [XFile] secara langsung menggunakan [XFile.fromData]
  static XFile convertUint8ListToXFile(Uint8List imageBytes,
      {String mimeType = 'image/bmp'}) {
    return XFile.fromData(imageBytes, mimeType: mimeType);
  }

  /// Mengonversi [Uint8List] menjadi [XFile] dengan menyimpan sementara ke filesystem
  static Future<XFile> saveUint8ListAsTempFile(Uint8List imageBytes,
      {String fileName = 'temp_image.bmp'}) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/$fileName');

      // Tulis byte ke file sementara
      await file.writeAsBytes(imageBytes);

      // Kembalikan file sebagai XFile
      return XFile(file.path);
    } catch (e) {
      throw Exception("Error while saving Uint8List as XFile: $e");
    }
  }
}
