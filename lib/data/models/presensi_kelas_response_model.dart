import 'dart:convert';

class PresensiKelasResponseModel {
  final String message;
  final List<Datum> data;

  PresensiKelasResponseModel({required this.message, required this.data});

  factory PresensiKelasResponseModel.fromJson(String str) =>
      PresensiKelasResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PresensiKelasResponseModel.fromMap(Map<String, dynamic> json) =>
      PresensiKelasResponseModel(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toMap())),
  };
}

class Datum {
  final int idJadwalKelas;
  final String namaMk;
  final String hari;
  final String jam;
  final String ruang;
  final String jumlahMahasiswa;
  final String totalPertemuan;
  final String persentaseKehadiran;

  Datum({
    required this.idJadwalKelas,
    required this.namaMk,
    required this.hari,
    required this.jam,
    required this.ruang,
    required this.jumlahMahasiswa,
    required this.totalPertemuan,
    required this.persentaseKehadiran,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    idJadwalKelas: json["id_jadwal_kelas"],
    namaMk: json["nama_mk"],
    hari: json["hari"],
    jam: json["jam"],
    ruang: json["ruang"],
    jumlahMahasiswa: json["jumlah_mahasiswa"],
    totalPertemuan: json["total_pertemuan"],
    persentaseKehadiran: json["persentase_kehadiran"],
  );

  Map<String, dynamic> toMap() => {
    "id_jadwal_kelas": idJadwalKelas,
    "nama_mk": namaMk,
    "hari": hari,
    "jam": jam,
    "ruang": ruang,
    "jumlah_mahasiswa": jumlahMahasiswa,
    "total_pertemuan": totalPertemuan,
    "persentase_kehadiran": persentaseKehadiran,
  };
}
