import 'dart:convert';

class PertemuanKelasResponseModel {
    final String? message;
    final List<Datum>? data;

    PertemuanKelasResponseModel({
        this.message,
        this.data,
    });

    factory PertemuanKelasResponseModel.fromJson(String str) => PertemuanKelasResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PertemuanKelasResponseModel.fromMap(Map<String, dynamic> json) => PertemuanKelasResponseModel(
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    };
}

class Datum {
    final int? id;
    final int? pertemuanKe;
    final String? qrCode;
    final String? materi;
    final String? file;

    Datum({
        this.id,
        this.pertemuanKe,
        this.qrCode,
        this.materi,
        this.file,
    });

    factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        pertemuanKe: json["pertemuan_ke"],
        qrCode: json["qr_code"],
        materi: json["materi"],
        file: json["file"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "pertemuan_ke": pertemuanKe,
        "qr_code": qrCode,
        "materi": materi,
        "file": file,
    };
}
