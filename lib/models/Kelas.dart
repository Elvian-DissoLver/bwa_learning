import 'package:flutter/cupertino.dart';

class Kelas {
  String idKelas;
  String className;
  int level ;
  String teacherClass;
  String idInstitution;

  Kelas({
    @required this.idKelas,
    this.className,
    this.level,
    this.teacherClass,
    this.idInstitution
  });

  Kelas.fromJson(Map<String, dynamic> map, String id) {
    this.idKelas = id;
    className = map['className'];
    level = map['level'];
    teacherClass = map['teacherClass'];
    idInstitution = map['idInstitution'];
  }

}