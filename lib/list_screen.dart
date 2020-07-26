import 'package:flutter/material.dart';
import 'dataTable.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'constants.dart';
import 'editCourse_screen.dart';
import 'models/course_model.dart';

class CourseList extends StatefulWidget {
  @override
  _CourseListState createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  var apiUrl = "https://courses-candela.herokuapp.com/api/course";
  var deleteUrl = "https://courses-candela.herokuapp.com/api/course";
  var res;
  List coursesList = new List();

  bool isLoading = false;

  getCourses(int loadedCounts) async {
    if (loadedCounts == 0) {
      setState(() {
        isLoading = true;
      });
    }

    coursesList.clear();
    res = await http.get(apiUrl);
    coursesList = jsonDecode(res.body);
    setState(() {
      isLoading = false;
    });
  }

  deleteCourse(String courseID) async {
    var response = await http.delete(deleteUrl + "/$courseID");

    if (response.statusCode == 200) {
      print(response.body);
      getCourses(1);
    } else {
      print(response.body);
    }
  }

  @override
  void initState() {
    super.initState();
    getCourses(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade800,
        title: Text('All Courses'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
              width: double.infinity,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                  ),
                  child: Text(
                    'Home',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20.0,
                      letterSpacing: -0.8,
                    ),
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
                Text(
                  'Courses',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20.0,
                    letterSpacing: -0.8,
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
                Text(
                  'About',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20.0,
                    letterSpacing: -0.8,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  'Courses',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                RaisedButton(
                  color: Colors.blue,
                  child: Text(
                    'Add Course',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/addCourse').then((value) {
                      getCourses(1);
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: isLoading == false
                  ? ListView(
                      children: <Widget>[
                        DataTable(
                          dataRowHeight: 60.0,
                          columns: [
                            DataColumn(
                              label: Padding(
                                padding: EdgeInsets.only(left: 25),
                                child: Text('Title', style: tableHeading),
                              ),
                            ),
                            DataColumn(
                                label: Text('Author', style: tableHeading)),
                            DataColumn(
                                label: Text('Category', style: tableHeading)),
                          ],
                          rows: coursesList.map(
                            (data) {
                              return DataRow(
                                cells: <DataCell>[
                                  DataCell(
                                    Container(
                                      width: 90,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          InkWell(
                                            child: Icon(
                                              Icons.cancel,
                                              color: Colors.red,
                                              size: 20,
                                            ),
                                            onTap: () {
                                              setState(() {
                                                coursesList.remove(data);
                                              });
                                              deleteCourse(data["id"]);
                                            },
                                          ),
                                          Container(
                                            width: 8,
                                          ),
                                          Expanded(
                                            child: InkWell(
                                              child: Text(
                                                '${data["title"]}',
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              onTap: () {
                                                var courseObject = CourseModel(
                                                    title: data["title"],
                                                    author: data["author"],
                                                    category: data["category"],
                                                    id: data["id"]);
                                                Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                EditCourse(
                                                                    courseObject)))
                                                    .then((value) =>
                                                        getCourses(1));
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                      Text('${data["author"]}',
                                          style: tableContent), onTap: () {
                                    var courseObject = CourseModel(
                                        title: data["title"],
                                        author: data["author"],
                                        category: data["category"],
                                        id: data["id"]);
                                    Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditCourse(courseObject)))
                                        .then((value) => getCourses(1));
                                  }),
                                  DataCell(
                                      Text('${data["category"]}',
                                          style: tableContent), onTap: () {
                                    var courseObject = CourseModel(
                                        title: data["title"],
                                        author: data["author"],
                                        category: data["category"],
                                        id: data["id"]);
                                    Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditCourse(courseObject)))
                                        .then((value) => getCourses(1));
                                  }),
                                ],
                              );
                            },
                          ).toList(),
                        ),
                      ],
                    )
                  : Center(
                      child: CircularProgressIndicator(
                          backgroundColor: Colors.white),
                    ),
            )
          ],
        ),
      ),
    );
    ;
  }
}
