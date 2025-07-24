import 'dart:convert';

class UserResponseModel {
  final String status;

  UserResponseModel({required this.status});

  factory UserResponseModel.fromJson(String str) =>
      UserResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserResponseModel.fromMap(Map<String, dynamic> json) =>
      UserResponseModel(status: json["status"]);

  Map<String, dynamic> toMap() => {"status": status};
}
