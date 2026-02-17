// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

List<Users> usersFromJson(String str) => List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

Users userFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(List<Users> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
    String? id;
    String email;
    String name;
    String? pass;
    String apiKey;
    bool? administrator;

    Users({
        required this.id,
        required this.email,
        required this.name,
        required this.pass,
        required this.apiKey,
        required this.administrator,
    });

    factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["_id"] == null ? null : json["_id"],
        email: json["email"],
        name: json["name"],
        pass: json["pass"] == null ? null : json["pass"],
        apiKey: json["apikey"] == null ? json["api_key"] : json["apikey"],
        administrator: json["administrator"] == null ? null : json["administrator"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "name": name,
        "pass": pass,
        "api_key": apiKey,
        "administrator": administrator,
    };
}
