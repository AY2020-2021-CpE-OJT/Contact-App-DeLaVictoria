import 'package:flutter/foundation.dart';

class Post {
  final String id;
  final String first_name;
  final String last_name;
  final String phone_number;

  Post(
      {required this.id,
      required this.first_name,
      required this.last_name,
      required this.phone_number});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      phone_number: json['phone_number'],
    );
  }
}
