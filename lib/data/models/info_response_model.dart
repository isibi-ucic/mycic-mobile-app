import 'dart:convert';

class InfoResponseModel {
  final String? message;
  final int? totalItems;
  final List<Datum>? data;

  InfoResponseModel({this.message, this.totalItems, this.data});

  factory InfoResponseModel.fromJson(String str) =>
      InfoResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InfoResponseModel.fromMap(Map<String, dynamic> json) =>
      InfoResponseModel(
        message: json["message"],
        totalItems: json["totalItems"],
        data:
            json["data"] == null
                ? []
                : List<Datum>.from(json["data"]!.map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
    "message": message,
    "totalItems": totalItems,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
  };
}

class Datum {
  final int? id;
  final String? title;
  final String? deskripsi;
  final String? createdAt;

  Datum({this.id, this.title, this.deskripsi, this.createdAt});

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    deskripsi: json["deskripsi"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "deskripsi": deskripsi,
    "created_at": createdAt,
  };
}
