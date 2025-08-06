import 'dart:convert';

class PresensiRekapResponseModel {
    final String message;
    final InfoKelas infoKelas;
    final List<Datum> data;

    PresensiRekapResponseModel({
        required this.message,
        required this.infoKelas,
        required this.data,
    });

    factory PresensiRekapResponseModel.fromJson(String str) => PresensiRekapResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PresensiRekapResponseModel.fromMap(Map<String, dynamic> json) => PresensiRekapResponseModel(
        message: json["message"],
        infoKelas: InfoKelas.fromMap(json["info_kelas"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "message": message,
        "info_kelas": infoKelas.toMap(),
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
    };
}

class Datum {
    final String nim;
    final String nama;
    final String rekap;

    Datum({
        required this.nim,
        required this.nama,
        required this.rekap,
    });

    factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        nim: json["nim"],
        nama: json["nama"],
        rekap: json["rekap"],
    );

    Map<String, dynamic> toMap() => {
        "nim": nim,
        "nama": nama,
        "rekap": rekap,
    };
}

class InfoKelas {
    final String namaMk;
    final String namaDosen;
    final String totalPertemuan;

    InfoKelas({
        required this.namaMk,
        required this.namaDosen,
        required this.totalPertemuan,
    });

    factory InfoKelas.fromJson(String str) => InfoKelas.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory InfoKelas.fromMap(Map<String, dynamic> json) => InfoKelas(
        namaMk: json["nama_mk"],
        namaDosen: json["nama_dosen"],
        totalPertemuan: json["total_pertemuan"],
    );

    Map<String, dynamic> toMap() => {
        "nama_mk": namaMk,
        "nama_dosen": namaDosen,
        "total_pertemuan": totalPertemuan,
    };
}
