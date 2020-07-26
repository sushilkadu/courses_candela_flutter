import 'package:course_app/editCourse_screen.dart';
import 'package:course_app/models/course_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'constants.dart';

class DummyList extends StatefulWidget {
  @override
  _DummyListState createState() => _DummyListState();
}

class _DummyListState extends State<DummyList> {
  var apiUrl = "https://courses-candela.herokuapp.com/api/course";
  var deleteUrl = "https://courses-candela.herokuapp.com/api/course";
  var res;
  List coursesList = new List();

  getCourses() async {
    coursesList.clear();
    res = await http.get(apiUrl);
    coursesList = jsonDecode(res.body);
    setState(() {});
  }

  deleteCourse(String courseID) async {
    var response = await http.delete(deleteUrl + "/$courseID");

    if (response.statusCode == 200) {
      print(response.body);
      setState(() {});
      getCourses();
    } else {
      print(response.body);
    }
  }

  @override
  void initState() {
    super.initState();
    getCourses();
  }

  Widget build(BuildContext context) {
    return Center(
      child: res != null
          ? ListView(
              children: <Widget>[
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    dataRowHeight: 60.0,
                    columns: [
                      DataColumn(
                        label: Text('Title', style: tableHeading),
                      ),
                      DataColumn(label: Text('Author', style: tableHeading)),
                      DataColumn(label: Text('Category', style: tableHeading)),
                      DataColumn(label: Text('Action', style: tableHeading)),
                    ],
                    rows: coursesList.map(
                      (data) {
                        return DataRow(
                          cells: <DataCell>[
                            DataCell(
                              Text('${data["title"]}', style: tableContent),
                            ),
                            DataCell(
                              Text('${data["author"]}', style: tableContent),
                            ),
                            DataCell(
                              Text('${data["category"]}', style: tableContent),
                            ),
                            DataCell(Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(
                                    Icons.mode_edit,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () {
                                    var courseObject = CourseModel(
                                        title: data["title"],
                                        author: data["author"],
                                        category: data["category"],
                                        id: data["id"]);

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditCourse(courseObject)));
                                  },
                                ),
                                Container(
                                  width: 10,
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    deleteCourse(data["id"]);
                                  },
                                ),
                              ],
                            )),
                          ],
                        );
                      },
                    ).toList(),
                  ),
                ),
              ],
            )
          : CircularProgressIndicator(backgroundColor: Colors.white),
    );
  }
}
