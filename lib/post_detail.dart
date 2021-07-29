import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_http/http_service.dart';
import 'package:flutter_http/post_model.dart';
import 'package:flutter_http/post_update.dart';
import 'package:flutter_http/posts.dart';

class PostDetail extends StatelessWidget {
  final Post post;
  final HttpService httpService = HttpService();

  PostDetail({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${post.first_name}" + " ${post.last_name}"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit), //mini: true,
            onPressed: () {
              String id = post.id;
              String first_name = post.first_name;
              String last_name = post.last_name;
              String phone_number = post.phone_number;
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyUpdatePage(
                          title: 'Update Contact',
                          post: post,
                          first_name: first_name,
                          id: id,
                          last_name: last_name,
                          phone_number: phone_number,
                        )),
              );
              // Respond to button press
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete_outline),
        onPressed: () {
          httpService.deletepost(post.id);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PostsPage()));
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Card(
            child: Column(children: <Widget>[
              ListTile(
                  title: Text("Name"),
                  subtitle: Text("${post.first_name}" + " ${post.last_name}")),
              ListTile(
                title: Text("Phone Number"),
                subtitle: Text("${post.phone_number}"),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
