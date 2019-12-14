import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleCourse {
  int idScheduleCourse;
  int idCourse;
  int idClass;
  String day;
  Duration startAt;
  var endAt;

  ScheduleCourse({
    @required this.idScheduleCourse,
    this.idCourse,
    this.idClass,
    this.day,
    this.startAt,
    this.endAt
  });

  ScheduleCourse.fromJson(Map<String, dynamic> map) {
    idScheduleCourse = map['idScheduleCourse'];
    idCourse = map['idCourse'];
    idClass = map['idClass'];
    day = map['day'];
    startAt = map['startAt'];
    endAt = map['endAt'];
  }

}