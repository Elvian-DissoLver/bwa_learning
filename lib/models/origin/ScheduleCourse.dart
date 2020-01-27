import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ScheduleCourse{
  int scheduleCourseId;
  int courseId;
  int classId;
  String day;
  Duration startAt;
  var endAt;
  int courseStateId;

  ScheduleCourse({
    @required this.scheduleCourseId,
    this.courseId,
    this.classId,
    this.day,
    this.startAt,
    this.endAt,
    this.courseStateId
  });

  ScheduleCourse.fromJson(Map<String, dynamic> map) {
    scheduleCourseId =  map['scheduleCourseId'] as int;
    courseId = map['courseId'] as int;
    classId = map['classId'] as int;
    day = map['day'] as String;

    startAt = map['startAt'] == null
        ? null
        : map['startAt'];
    endAt = map['endAt'];
    courseStateId = map['courseStateId'];
  }


}
