import 'package:flutter/cupertino.dart';

class Kelas {
  String idKelas;
  String className;
  int level ;
  String idInstitution;

  Kelas({
    @required this.idKelas,
    @required this.className,
    this.level,
    this.idInstitution
  });

}