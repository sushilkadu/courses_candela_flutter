import 'package:flutter/material.dart';
import 'list_screen.dart';
import 'addCourse_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => CourseList(),
        '/addCourse': (context) => AddCourse(),
      },
    );
  }
}
