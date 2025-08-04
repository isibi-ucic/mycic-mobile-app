import 'package:meta/meta.dart';
import 'dart:convert';

class KelasTodayResponseModel {
  final String message;
  final List<Datum> data;

  KelasTodayResponseModel({required this.message, required this.data});

  factory KelasTodayResponseModel.fromJson(String str) =>
      KelasTodayResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory KelasTodayResponseModel.fromMap(Map<String, dynamic> json) =>
      KelasTodayResponseModel(
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
  final String jam;
  final String ruang;
  final String mataKuliah;
  final int sks;
  final String dosen;

  Datum({
    required this.idJadwalKelas,
    required this.jam,
    required this.ruang,
    required this.mataKuliah,
    required this.sks,
    required this.dosen,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    idJadwalKelas: json["id_jadwal_kelas"],
    jam: json["jam"],
    ruang: json["ruang"],
    mataKuliah: json["mata_kuliah"],
    sks: json["sks"],
    dosen: json["dosen"],
  );

  Map<String, dynamic> toMap() => {
    "id_jadwal_kelas": idJadwalKelas,
    "jam": jam,
    "ruang": ruang,
    "mata_kuliah": mataKuliah,
    "sks": sks,
    "dosen": dosen,
  };
}
