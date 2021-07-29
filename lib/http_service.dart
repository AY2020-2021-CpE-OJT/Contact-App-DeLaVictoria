import 'dart:convert';
import 'package:flutter_http/post_model.dart';
import 'package:http/http.dart';

class HttpService {
  final String postsUrl =
      "https://whispering-escarpment-77804.herokuapp.com/contacts";

  Future<void> deletepost(String id) async {
    Response response = await delete(
        Uri.parse(
            'https://whispering-escarpment-77804.herokuapp.com/contacts/$id'),
        headers: {
          'authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxLCJ1c2VybmFtZSI6InJheW11bmQiLCJlbWFpbCI6InJheW11bmRkbHZAZ21haWwuY29tIn0sImlhdCI6MTYyNjc5MTM5Mn0.r0oAL9nH9Vb8uLklrbumQiZRHvUkI-tW6md1QzsuXYE'
        });

    if (response.statusCode == 200) {
      print("Deleted!");
    }
  }

  Future<List<Post>> getPosts() async {
    Response response = await get(Uri.parse(postsUrl), headers: {
      'authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxLCJ1c2VybmFtZSI6InJheW11bmQiLCJlbWFpbCI6InJheW11bmRkbHZAZ21haWwuY29tIn0sImlhdCI6MTYyNjc5MTM5Mn0.r0oAL9nH9Vb8uLklrbumQiZRHvUkI-tW6md1QzsuXYE'
    });

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      List<Post> posts =
          body.map((dynamic item) => Post.fromJson(item)).toList();

      return posts;
    } else {
      throw "Can't get posts.";
    }
  }
}
