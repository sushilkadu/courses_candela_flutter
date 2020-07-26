import 'dart:convert';

import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:http/http.dart' as http;

import 'dart:async';

import 'models/course_model.dart';

// ignore: must_be_immutable
class AddCourse extends StatefulWidget {
  @override
  _AddCourseState createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  bool isLoading = false;

  Future createCourse(String title, String author, String category) async {
    setState(() {
      isLoading = true;
    });

    final String apiUrl = "https://courses-candela.herokuapp.com/api/course";
    final response = await http.post(
      apiUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "title": title,
        "author": author,
        "category": category
      }),
    );

    if (response.statusCode == 201) {
      setState(() {
        isLoading = false;
      });
      Navigator.pop(context);
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade800,
        title: Text(
          'Add Course',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                  ),
                  child: Text(
                    'Home',
                    style: tabsTextSize,
                  ),
                ),
                Text(
                  ' | ',
                  style: TextStyle(
                    color: Colors.blueGrey.shade600,
                    fontSize: 25.0,
                    letterSpacing: -0.8,
                  ),
                ),
                Text('Courses', style: tabsTextSize),
                Text(
                  ' | ',
                  style: TextStyle(
                    color: Colors.blueGrey.shade600,
                    fontSize: 25.0,
                    letterSpacing: -0.8,
                  ),
                ),
                Text('About', style: tabsTextSize),
              ],
            ),
            SizedBox(height: 15.0),
            Text(
              'Manage Courses',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15.0),
            Padding(
              padding: const EdgeInsets.only(
                  top: 15.0, right: 20, left: 20, bottom: 20.0),
              child: TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 15.0, right: 20, left: 20, bottom: 20.0),
              child: TextFormField(
                controller: authorController,
                decoration: InputDecoration(
                  labelText: 'Author',
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 15.0, right: 20, left: 20, bottom: 20.0),
              child: TextFormField(
                controller: categoryController,
                decoration: InputDecoration(
                  labelText: 'Category',
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RaisedButton(
                    onPressed: () async {
                      final String title = titleController.text;
                      final String author = authorController.text;
                      final String category = categoryController.text;

                      createCourse(title, author, category);
                    },
                    color: Colors.blue,
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
