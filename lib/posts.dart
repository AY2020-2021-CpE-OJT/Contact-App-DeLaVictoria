import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_http/http_service.dart';
import 'package:flutter_http/post_detail.dart';
import 'package:flutter_http/post_input.dart';
import 'package:flutter_http/post_model.dart';
import 'package:flutter_http/post_update.dart';

class PostsPage extends StatelessWidget {
  final HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Contacts"),
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: Icon(Icons.add), //mini: true,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyInputPage(
                            title: 'Input Contact',
                          )),
                );
                // Respond to button press
              },
            )
          ],
        ),
        body: FutureBuilder(
          future: httpService.getPosts(),
          builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
            if (snapshot.hasData) {
              List<Post>? posts = snapshot.data;

              return ListView(
                children: posts!
                    .map((Post post) => Card(
                            child: ListTile(
                          title:
                              Text("${post.first_name}" + " ${post.last_name}"),
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PostDetail(
                                        post: post,
                                      ))),
                          leading: CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/Circle-Avatar.png')),
                          trailing: IconButton(
                              icon: Icon(Icons.edit, size: 18),
                              onPressed: () {
                                print(post.id);

                                String id = post.id;
                                String first_name = post.first_name;
                                String last_name = post.last_name;
                                String phone_number = post.phone_number;

                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => MyUpdatePage(
                                          post: post,
                                          title: 'UpdateContact',
                                          first_name: first_name,
                                          id: id,
                                          last_name: last_name,
                                          phone_number: phone_number,
                                        )));
                              }),
                        )))
                    .toList(),
              );
            }
            return Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
            ));
          },
        ));
  }
}
