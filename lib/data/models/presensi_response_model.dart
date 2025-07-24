import 'dart:convert';

class PresensiResponseModel {
  final String? message;
  final List<Datum>? data;

  PresensiResponseModel({this.message, this.data});

  factory PresensiResponseModel.fromJson(String str) =>
      PresensiResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PresensiResponseModel.fromMap(Map<String, dynamic> json) =>
      PresensiResponseModel(
        message: json["message"],
        data:
            json["data"] == null
                ? []
                : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class Datum {
  final String? mataKuliah;
  final List<bool>? kehadiran;

  Datum({this.mataKuliah, this.kehadiran});

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    mataKuliah: json["mata_kuliah"],
    kehadiran:
        json["kehadiran"] == null
            ? []
            : List<bool>.from(json["kehadiran"]!.map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "mata_kuliah": mataKuliah,
    "kehadiran":
        kehadiran == null ? [] : List<dynamic>.from(kehadiran!.map((x) => x)),
  };
}
