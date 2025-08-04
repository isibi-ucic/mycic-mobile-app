import 'dart:convert';

class DetailPertemuanKelasResponseModel {
  final String message;
  final Data data;

  DetailPertemuanKelasResponseModel({
    required this.message,
    required this.data,
  });

  factory DetailPertemuanKelasResponseModel.fromJson(String str) =>
      DetailPertemuanKelasResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DetailPertemuanKelasResponseModel.fromMap(
    Map<String, dynamic> json,
  ) => DetailPertemuanKelasResponseModel(
    message: json["message"],
    data: Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {"message": message, "data": data.toMap()};
}

class Data {
  final int id;
  final int pertemuanKe;
  final DateTime tanggal;
  final String materi;
  final String deskripsi;
  final dynamic file;
  final dynamic qrPresensi;
  final dynamic batasWaktuPresensi;
  final dynamic idTugas;
  final dynamic judulTugas;
  final dynamic deskripsiTugas;
  final dynamic fileTugas;
  final dynamic batasWaktuTugas;
  final String namaMk;
  final String namaDosen;

  Data({
    required this.id,
    required this.pertemuanKe,
    required this.tanggal,
    required this.materi,
    required this.deskripsi,
    required this.file,
    required this.qrPresensi,
    required this.batasWaktuPresensi,
    required this.idTugas,
    required this.judulTugas,
    required this.deskripsiTugas,
    required this.fileTugas,
    required this.batasWaktuTugas,
    required this.namaMk,
    required this.namaDosen,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    id: json["id"],
    pertemuanKe: json["pertemuan_ke"],
    tanggal: DateTime.parse(json["tanggal"]),
    materi: json["materi"],
    deskripsi: json["deskripsi"],
    file: json["file"],
    qrPresensi: json["qr_presensi"],
    batasWaktuPresensi: json["batas_waktu_presensi"],
    idTugas: json["id_tugas"],
    judulTugas: json["judul_tugas"],
    deskripsiTugas: json["deskripsi_tugas"],
    fileTugas: json["file_tugas"],
    batasWaktuTugas: json["batas_waktu_tugas"],
    namaMk: json["nama_mk"],
    namaDosen: json["nama_dosen"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "pertemuan_ke": pertemuanKe,
    "tanggal":
        "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
    "materi": materi,
    "deskripsi": deskripsi,
    "file": file,
    "qr_presensi": qrPresensi,
    "batas_waktu_presensi": batasWaktuPresensi,
    "id_tugas": idTugas,
    "judul_tugas": judulTugas,
    "deskripsi_tugas": deskripsiTugas,
    "file_tugas": fileTugas,
    "batas_waktu_tugas": batasWaktuTugas,
    "nama_mk": namaMk,
    "nama_dosen": namaDosen,
  };
}
