import 'dart:convert';

class DsnSkripsiResponseModel {
  final String message;
  final List<Datum> data;

  DsnSkripsiResponseModel({required this.message, required this.data});

  factory DsnSkripsiResponseModel.fromJson(String str) =>
      DsnSkripsiResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DsnSkripsiResponseModel.fromMap(Map<String, dynamic> json) =>
      DsnSkripsiResponseModel(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toMap())),
  };
}

class Datum {
  final int id;
  final String judul;
  final String nimMhs;
  final String namaMahasiswa;
  final int jumlahBimbingan;
  final String namaPembimbingRekan;

  Datum({
    required this.id,
    required this.judul,
    required this.nimMhs,
    required this.namaMahasiswa,
    required this.jumlahBimbingan,
    required this.namaPembimbingRekan,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    judul: json["judul"],
    nimMhs: json["nim_mhs"],
    namaMahasiswa: json["nama_mahasiswa"],
    jumlahBimbingan: json["jumlah_bimbingan"],
    namaPembimbingRekan: json["nama_pembimbing_rekan"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "judul": judul,
    "nim_mhs": nimMhs,
    "nama_mahasiswa": namaMahasiswa,
    "jumlah_bimbingan": jumlahBimbingan,
    "nama_pembimbing_rekan": namaPembimbingRekan,
  };
}
