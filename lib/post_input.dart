import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_http/posts.dart';
import 'package:http/http.dart' as http;
import 'contact_model.dart';

class MyInputPage extends StatefulWidget {
  MyInputPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyInputPageState createState() => _MyInputPageState();
}

Future<ContactModel?> submitContact(
    String first_name, String last_name, String phone_number) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json;charset=UTF-8',
    'Charset': 'utf-8',
    'authorization':
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxLCJ1c2VybmFtZSI6InJheW11bmQiLCJlbWFpbCI6InJheW11bmRkbHZAZ21haWwuY29tIn0sImlhdCI6MTYyNjc4Njc5NX0.soP5TVMPDzAl9VkT5riFNQgtzpn1Q2VaTes6eizAdH0'
  };
  final msg = jsonEncode({
    "first_name": first_name,
    "last_name": last_name,
    "phone_number": phone_number
  });

  var response = await http.post(
      Uri.https('whispering-escarpment-77804.herokuapp.com', 'contacts'),
      headers: headers,
      body: msg);

  var data = response.body;
  print(data);

  if (response.statusCode == 201) {
    String responseString = response.body;
    contactModelFromJson(responseString);
  } else {
    return (null);
  }
}

class _MyInputPageState extends State<MyInputPage> {
  TextEditingController first_nameController = TextEditingController();
  TextEditingController last_nameController = TextEditingController();
  TextEditingController phone_numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Enter Contact"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Container(
                child: TextField(
                  decoration: InputDecoration(
                      //isDense: true,
                      filled: true,
                      fillColor: Colors.grey[730],
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      labelText: 'First Name',
                      hintText: 'Enter First name',
                      prefixIcon: Icon(
                        Icons.face_outlined,
                        color: Colors.teal[200],
                      ),
                      labelStyle: TextStyle(color: Colors.grey[400])),
                  controller: first_nameController,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: TextField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[730],
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      labelText: 'Last Name',
                      hintText: 'Enter last name',
                      prefixIcon:
                          Icon(Icons.family_restroom, color: Colors.teal[200]),
                      labelStyle: TextStyle(color: Colors.grey[400])),
                  controller: last_nameController,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: TextField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[730],
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      labelText: 'Phone Number',
                      hintText: 'Enter phone number',
                      prefixIcon: Icon(Icons.call, color: Colors.teal[200]),
                      labelStyle: TextStyle(color: Colors.grey[400])),
                  controller: phone_numberController,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () async {
                  String first_name = first_nameController.text;
                  String last_name = last_nameController.text;
                  String phone_number = phone_numberController.text;

                  ContactModel? contact =
                      await submitContact(first_name, last_name, phone_number);

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PostsPage()));
                },
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.grey[850]),
                ),
                style: ElevatedButton.styleFrom(primary: Colors.grey[500]),
              ),
            ],
          ),
        ));
  }
}
