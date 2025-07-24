// file_helper.dart
import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;

class FileHelper {
  // Fungsi untuk mengonversi Uint8List ke XFile dengan nama file otomatis
  static Future<XFile> convertUint8ListToXFile(Uint8List data) async {
    // Dapatkan direktori sementara
    final directory = await getTemporaryDirectory();

    // Buat nama file unik dengan timestamp
    final fileName = 'face_image_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final path = '${directory.path}/$fileName';

    // Buat file di path tersebut dan tulis data ke file
    final file = File(path);
    await file.writeAsBytes(data);

    // Kembalikan sebagai XFile
    return XFile(file.path);
  }

  // Fungsi untuk mengonversi Uint8List ke File dengan nama file otomatis
  static Future<File> convertUint8ListToFile(Uint8List data) async {
    // Dapatkan direktori sementara
    final directory = await getTemporaryDirectory();

    // Buat nama file unik dengan timestamp
    final fileName = 'face_image_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final path = '${directory.path}/$fileName';

    // Buat file di path tersebut dan tulis data ke file
    final file = File(path);
    await file.writeAsBytes(data);

    // Kembalikan sebagai File
    return file;
  }

  static Future<File> convertImageToFile(img.Image image) async {
    // Encode image to PNG or JPEG (choose based on your needs)
    final Uint8List imageBytes = Uint8List.fromList(img.encodeJpg(image));

    // Get the temporary directory of the device
    final directory = await getTemporaryDirectory();

    // Generate a unique file name using the current timestamp
    final filePath =
        '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

    // Save the bytes to a file
    final file = File(filePath);
    await file.writeAsBytes(imageBytes);

    return file;
  }
}
