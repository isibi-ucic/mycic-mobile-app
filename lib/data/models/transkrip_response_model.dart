import 'dart:convert';

class TranskripResponseModel {
  final String? message;
  final Data? data;

  TranskripResponseModel({this.message, this.data});

  factory TranskripResponseModel.fromJson(String str) =>
      TranskripResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TranskripResponseModel.fromMap(Map<String, dynamic> json) =>
      TranskripResponseModel(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {"message": message, "data": data?.toMap()};
}

class Data {
  final double? totalIpk;
  final int? totalSks;
  final List<SemuaMataKuliah>? semuaMataKuliah;

  Data({this.totalIpk, this.totalSks, this.semuaMataKuliah});

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    totalIpk: json["total_ipk"]?.toDouble(),
    totalSks: json["total_sks"],
    semuaMataKuliah:
        json["semua_mata_kuliah"] == null
            ? []
            : List<SemuaMataKuliah>.from(
              json["semua_mata_kuliah"]!.map((x) => SemuaMataKuliah.fromMap(x)),
            ),
  );

  Map<String, dynamic> toMap() => {
    "total_ipk": totalIpk,
    "total_sks": totalSks,
    "semua_mata_kuliah":
        semuaMataKuliah == null
            ? []
            : List<dynamic>.from(semuaMataKuliah!.map((x) => x.toMap())),
  };
}

class SemuaMataKuliah {
  final int? idMk;
  final String? namaMk;
  final int? sks;
  final String? nilaiHuruf;

  SemuaMataKuliah({this.idMk, this.namaMk, this.sks, this.nilaiHuruf});

  factory SemuaMataKuliah.fromJson(String str) =>
      SemuaMataKuliah.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SemuaMataKuliah.fromMap(Map<String, dynamic> json) => SemuaMataKuliah(
    idMk: json["id_mk"],
    namaMk: json["nama_mk"],
    sks: json["sks"],
    nilaiHuruf: json["nilai_huruf"],
  );

  Map<String, dynamic> toMap() => {
    "id_mk": idMk,
    "nama_mk": namaMk,
    "sks": sks,
    "nilai_huruf": nilaiHuruf,
  };
}
