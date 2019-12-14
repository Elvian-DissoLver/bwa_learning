import 'package:flutter/cupertino.dart';

class Class {
  int idClass;
  String className;
  int level ;
  String teacherClass;
  String idInstitution;

  Class({
    @required this.idClass,
    this.className,
    this.level,
    this.teacherClass,
    this.idInstitution
  });

  Class.fromJson(Map<String, dynamic> map) {
    idClass = map['idClass'];
    className = map['className'];
    level = map['level'];
    teacherClass = map['teacherClass'];
    idInstitution = map['idInstitution'];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idClass': this.idClass,
      'className': this.className,
      'level': this.level,
      'teacherClass': this.teacherClass,
      'idInstitution': this.idInstitution
    };
  }

}