import 'dart:convert';

class AuthResponseModel {
    final String message;
    final User user;

    AuthResponseModel({
        required this.message,
        required this.user,
    });

    AuthResponseModel copyWith({
        String? message,
        User? user,
    }) => 
        AuthResponseModel(
            message: message ?? this.message,
            user: user ?? this.user,
        );

    factory AuthResponseModel.fromJson(String str) => AuthResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AuthResponseModel.fromMap(Map<String, dynamic> json) => AuthResponseModel(
        message: json["message"],
        user: User.fromMap(json["user"]),
    );

    Map<String, dynamic> toMap() => {
        "message": message,
        "user": user.toMap(),
    };
}

class User {
    final int id;
    final String nama;
    final String email;
    final String password;
    final String role;
    final String profile;
    final int userNumber;

    User({
        required this.id,
        required this.nama,
        required this.email,
        required this.password,
        required this.role,
        required this.profile,
        required this.userNumber,
    });

    User copyWith({
        int? id,
        String? nama,
        String? email,
        String? password,
        String? role,
        String? profile,
        int? userNumber,
    }) => 
        User(
            id: id ?? this.id,
            nama: nama ?? this.nama,
            email: email ?? this.email,
            password: password ?? this.password,
            role: role ?? this.role,
            profile: profile ?? this.profile,
            userNumber: userNumber ?? this.userNumber,
        );

    factory User.fromJson(String str) => User.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        nama: json["nama"],
        email: json["email"],
        password: json["password"],
        role: json["role"],
        profile: json["profile"],
        userNumber: json["user_number"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "nama": nama,
        "email": email,
        "password": password,
        "role": role,
        "profile": profile,
        "user_number": userNumber,
    };
}
