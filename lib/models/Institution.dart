import 'package:bwa_learning/models/LevelClass.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';

class Institution {
  int institutionId;
  String institutionName;
  School level ;
  String regional;

  Institution({
    @required this.institutionId,
    this.institutionName,
    this.level,
    this.regional  });

  factory Institution.fromJson(Map<String, dynamic> map) {
    return Institution(
      institutionId: map['institutionId'],
      institutionName: map['institutionName'],
      level: EnumToString.fromString(School.values, map['level']),
      regional: map['regional'],
    );
  }
}