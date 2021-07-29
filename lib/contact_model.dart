// To parse this JSON data, do
//
//     final contactModel = contactModelFromJson(jsonString);

import 'dart:convert';

ContactModel contactModelFromJson(String str) =>
    ContactModel.fromJson(json.decode(str));

String contactModelToJson(ContactModel data) => json.encode(data.toJson());

class ContactModel {
  ContactModel({
    required this.id,
    required this.first_name,
    required this.last_name,
    required this.phone_number,
  });

  String id;
  String first_name;
  String last_name;
  String phone_number;

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
        id: json["id"],
        first_name: json["first_name"],
        last_name: json["last_name"],
        phone_number: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": first_name,
        "last_name": last_name,
        "phone_number": phone_number,
      };
}
