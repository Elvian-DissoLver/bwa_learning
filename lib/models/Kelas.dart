import 'package:flutter/cupertino.dart';

class Kelas {
  String idKelas;
  String className;
  int level ;
  String teacherClass;
  String idInstitution;

  Kelas({
    @required this.idKelas,
    @required this.className,
    this.level,
    this.teacherClass,
    this.idInstitution
  });

}