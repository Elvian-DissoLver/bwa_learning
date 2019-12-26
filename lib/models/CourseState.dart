import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CourseState {
  int courseStateId;
  int courseId;
  String startAt;
  String endAt;
  int isDone;
  int classId;

  CourseState({
    this.courseStateId,
    this.courseId,
    this.startAt,
    this.endAt,
    this.isDone,
    this.classId
  });

  @override
  String toString() {
    return 'CourseState{endAt: $endAt}';
  }

  CourseState.fromJson(Map<String, dynamic> map) {
    courseStateId = map['courseStateId'];
    courseId = map['courseId'];
    startAt = map['startAt'];
    endAt = map['endAt'];
    isDone = map['isDone'];
    classId = map['classId'];
  }

}