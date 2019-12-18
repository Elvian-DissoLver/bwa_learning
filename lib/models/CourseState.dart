import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CourseState {
  int courseId;
  String startAt;
  String endAt;
  bool isDone;

  CourseState({
    this.courseId,
    this.startAt,
    this.endAt,
    this.isDone
  });

  @override
  String toString() {
    return 'CourseState{endAt: $endAt}';
  }

  CourseState.fromJson(Map<String, dynamic> json) {
    endAt= json['endAt'] as String;
  }

}