import 'dart:convert';

class NilaiResponseModel {
  final String? message;
  final List<Datum>? data;

  NilaiResponseModel({this.message, this.data});

  factory NilaiResponseModel.fromJson(String str) =>
      NilaiResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NilaiResponseModel.fromMap(Map<String, dynamic> json) =>
      NilaiResponseModel(
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
  final String? hari;
  final List<Kela>? kelas;

  Datum({this.hari, this.kelas});

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    hari: json["hari"],
    kelas:
        json["kelas"] == null
            ? []
            : List<Kela>.from(json["kelas"]!.map((x) => Kela.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "hari": hari,
    "kelas":
        kelas == null ? [] : List<dynamic>.from(kelas!.map((x) => x.toMap())),
  };
}

class Kela {
  final int? id;
  final int? mkId;
  final String? waktu;
  final String? kelas;
  final String? dosen;
  final String? ruangan;

  Kela({this.id, this.mkId, this.waktu, this.kelas, this.dosen, this.ruangan});

  factory Kela.fromJson(String str) => Kela.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Kela.fromMap(Map<String, dynamic> json) => Kela(
    id: json["id"],
    mkId: json["mkId"],
    waktu: json["waktu"],
    kelas: json["kelas"],
    dosen: json["dosen"],
    ruangan: json["ruangan"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "mkId": mkId,
    "waktu": waktu,
    "kelas": kelas,
    "dosen": dosen,
    "ruangan": ruangan,
  };
}
