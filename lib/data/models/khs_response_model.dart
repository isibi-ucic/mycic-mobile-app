import 'dart:convert';

class KhsResponseModel {
  final bool? success;
  final String? message;
  final List<Datum>? data;

  KhsResponseModel({this.success, this.message, this.data});

  factory KhsResponseModel.fromJson(String str) =>
      KhsResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory KhsResponseModel.fromMap(Map<String, dynamic> json) =>
      KhsResponseModel(
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
  final int? semester;
  final int? totalSks;
  final double? ips;
  final List<DaftarMk>? daftarMk;

  Datum({this.semester, this.totalSks, this.ips, this.daftarMk});

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    semester: json["semester"],
    totalSks: json["totalSks"],
    ips: json["ips"]?.toDouble(),
    daftarMk:
        json["daftarMk"] == null
            ? []
            : List<DaftarMk>.from(
              json["daftarMk"]!.map((x) => DaftarMk.fromMap(x)),
            ),
  );

  Map<String, dynamic> toMap() => {
    "semester": semester,
    "totalSks": totalSks,
    "ips": ips,
    "daftarMk":
        daftarMk == null
            ? []
            : List<dynamic>.from(daftarMk!.map((x) => x.toMap())),
  };
}

class DaftarMk {
  final String? no;
  final String? mataKuliah;
  final String? nilai;

  DaftarMk({this.no, this.mataKuliah, this.nilai});

  factory DaftarMk.fromJson(String str) => DaftarMk.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DaftarMk.fromMap(Map<String, dynamic> json) => DaftarMk(
    no: json["no"],
    mataKuliah: json["mataKuliah"],
    nilai: json["nilai"],
  );

  Map<String, dynamic> toMap() => {
    "no": no,
    "mataKuliah": mataKuliah,
    "nilai": nilai,
  };
}
