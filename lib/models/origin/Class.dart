import 'package:flutter/cupertino.dart';

class Class {
  int classId;
  String className;
  int level ;
  String teacherClass;
  int institutionId;

  Class({
    @required this.classId,
    this.className,
    this.level,
    this.teacherClass,
    this.institutionId
  });

  factory Class.fromJson(Map<String, dynamic> map) {
    return Class(
      classId : map['classId'],
      className : map['className'],
      level : map['level'],
      teacherClass : map['teacherClass'],
      institutionId : map['institutionId'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'classId': this.classId,
      'className': this.className,
      'level': this.level,
      'teacherClass': this.teacherClass,
      'institutionId': this.institutionId
    };
  }

}