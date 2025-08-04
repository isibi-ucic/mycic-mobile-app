import 'dart:convert';

class DsnTugasResponseModel {
  final bool success;
  final String message;
  final List<Datum> data;

  DsnTugasResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory DsnTugasResponseModel.fromJson(String str) =>
      DsnTugasResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DsnTugasResponseModel.fromMap(Map<String, dynamic> json) =>
      DsnTugasResponseModel(
        success: json["success"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toMap())),
  };
}

class Datum {
  final int idPertemuan;
  final String namaMk;
  final int pertemuanKe;
  final DateTime tanggal;
  final String action;
  final String deskripsiTugas;

  Datum({
    required this.idPertemuan,
    required this.namaMk,
    required this.pertemuanKe,
    required this.tanggal,
    required this.action,
    required this.deskripsiTugas,
  });

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    idPertemuan: json["id_pertemuan"],
    namaMk: json["nama_mk"],
    pertemuanKe: json["pertemuan_ke"],
    tanggal: DateTime.parse(json["tanggal"]),
    action: json["action"],
    deskripsiTugas: json["deskripsi_tugas"],
  );

  Map<String, dynamic> toMap() => {
    "id_pertemuan": idPertemuan,
    "nama_mk": namaMk,
    "pertemuan_ke": pertemuanKe,
    "tanggal":
        "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
    "action": action,
    "deskripsi_tugas": deskripsiTugas,
  };
}
