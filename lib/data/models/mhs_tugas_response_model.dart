import 'dart:convert';

class MhsTugasResponseModel {
  final bool? success;
  final String? message;
  final List<Datum>? data;

  MhsTugasResponseModel({this.success, this.message, this.data});

  factory MhsTugasResponseModel.fromJson(String str) =>
      MhsTugasResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MhsTugasResponseModel.fromMap(Map<String, dynamic> json) =>
      MhsTugasResponseModel(
        success: json["success"],
        message: json["message"],
        data:
            json["data"] == null
                ? []
                : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class Datum {
  final int? idTugas;
  final String? judulTugas;
  final String? deskripsi;
  final String? batasWaktu;
  final String? mataKuliah;
  final int? pertemuanKe;

  Datum({
    this.idTugas,
    this.judulTugas,
    this.deskripsi,
    this.batasWaktu,
    this.mataKuliah,
    this.pertemuanKe,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    idTugas: json["id_tugas"],
    judulTugas: json["judul_tugas"],
    deskripsi: json["deskripsi"],
    batasWaktu: json["batas_waktu"],
    mataKuliah: json["mata_kuliah"],
    pertemuanKe: json["pertemuan_ke"],
  );

  Map<String, dynamic> toMap() => {
    "id_tugas": idTugas,
    "judul_tugas": judulTugas,
    "deskripsi": deskripsi,
    "batas_waktu": batasWaktu,
    "mata_kuliah": mataKuliah,
    "pertemuan_ke": pertemuanKe,
  };
}
