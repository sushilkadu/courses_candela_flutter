// To parse this JSON data, do
//
//     final courseModel = courseModelFromJson(jsonString);

import 'dart:convert';

CourseModel courseModelFromJson(String str) =>
    CourseModel.fromJson(json.decode(str));

String courseModelToJson(CourseModel data) => json.encode(data.toJson());

class CourseModel {

  String title;
  String author;
  String category;
  int version;
  String id;

  CourseModel({
    this.title,
    this.author,
    this.category,
    this.version,
    this.id,
  });



  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
        title: json["title"],
        author: json["author"],
        category: json["category"],
        version: json["version"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "author": author,
        "category": category,
        "version": version,
        "id": id,
      };
}
