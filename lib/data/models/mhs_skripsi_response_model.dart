import 'dart:convert';

class MhsSkripsiResponseModel {
  final String message;
  final Data data;

  MhsSkripsiResponseModel({required this.message, required this.data});

  factory MhsSkripsiResponseModel.fromJson(String str) =>
      MhsSkripsiResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MhsSkripsiResponseModel.fromMap(Map<String, dynamic> json) =>
      MhsSkripsiResponseModel(
        message: json["message"],
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {"message": message, "data": data.toMap()};
}

class Data {
  final int id;
  final String judul;
  final String nimMhs;
  final String namaMahasiswa;
  final String nidnPembimbing1;
  final String nidnPembimbing2;
  final int totalBimbingan1;
  final int totalBimbingan2;
  final String namaPembimbing1;
  final String namaPembimbing2;

  Data({
    required this.id,
    required this.judul,
    required this.nimMhs,
    required this.namaMahasiswa,
    required this.nidnPembimbing1,
    required this.nidnPembimbing2,
    required this.totalBimbingan1,
    required this.totalBimbingan2,
    required this.namaPembimbing1,
    required this.namaPembimbing2,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    id: json["id"],
    judul: json["judul"],
    nimMhs: json["nim_mhs"],
    namaMahasiswa: json["nama_mahasiswa"],
    nidnPembimbing1: json["nidn_pembimbing_1"],
    nidnPembimbing2: json["nidn_pembimbing_2"],
    totalBimbingan1: json["total_bimbingan_1"],
    totalBimbingan2: json["total_bimbingan_2"],
    namaPembimbing1: json["nama_pembimbing_1"],
    namaPembimbing2: json["nama_pembimbing_2"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "judul": judul,
    "nim_mhs": nimMhs,
    "nama_mahasiswa": namaMahasiswa,
    "nidn_pembimbing_1": nidnPembimbing1,
    "nidn_pembimbing_2": nidnPembimbing2,
    "total_bimbingan_1": totalBimbingan1,
    "total_bimbingan_2": totalBimbingan2,
    "nama_pembimbing_1": namaPembimbing1,
    "nama_pembimbing_2": namaPembimbing2,
  };
}
