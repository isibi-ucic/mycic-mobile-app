import 'dart:convert';

class UjianResponseModel {
  final String? message;
  final List<Datum>? data;

  UjianResponseModel({this.message, this.data});

  factory UjianResponseModel.fromJson(String str) =>
      UjianResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UjianResponseModel.fromMap(Map<String, dynamic> json) =>
      UjianResponseModel(
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
  final List<Ujian>? ujian;

  Datum({this.hari, this.ujian});

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    hari: json["hari"],
    ujian:
        json["ujian"] == null
            ? []
            : List<Ujian>.from(json["ujian"]!.map((x) => Ujian.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "hari": hari,
    "ujian":
        ujian == null ? [] : List<dynamic>.from(ujian!.map((x) => x.toMap())),
  };
}

class Ujian {
  final JenisUjian? jenisUjian;
  final DateTime? tanggal;
  final String? jam;
  final String? ruang;
  final String? mataKuliah;
  final String? dosenPengajar;

  Ujian({
    this.jenisUjian,
    this.tanggal,
    this.jam,
    this.ruang,
    this.mataKuliah,
    this.dosenPengajar,
  });

  factory Ujian.fromJson(String str) => Ujian.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Ujian.fromMap(Map<String, dynamic> json) => Ujian(
    jenisUjian: jenisUjianValues.map[json["jenis_ujian"]]!,
    tanggal: json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
    jam: json["jam"],
    ruang: json["ruang"],
    mataKuliah: json["mata_kuliah"],
    dosenPengajar: json["dosen_pengajar"],
  );

  Map<String, dynamic> toMap() => {
    "jenis_ujian": jenisUjianValues.reverse[jenisUjian],
    "tanggal":
        "${tanggal!.year.toString().padLeft(4, '0')}-${tanggal!.month.toString().padLeft(2, '0')}-${tanggal!.day.toString().padLeft(2, '0')}",
    "jam": jam,
    "ruang": ruang,
    "mata_kuliah": mataKuliah,
    "dosen_pengajar": dosenPengajar,
  };
}

enum JenisUjian { UAS, UTS }

final jenisUjianValues = EnumValues({
  "UAS": JenisUjian.UAS,
  "UTS": JenisUjian.UTS,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
