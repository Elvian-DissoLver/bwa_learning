class Course {
  int courseId;
  String courseName;
  int teacherId;
  int institutionId;
  int level;
  int categoryId;

  Course({
    this.courseId,
    this.courseName,
    this.teacherId,
    this.level,
    this.institutionId,
    this.categoryId
  });

  Course.fromJson(Map<String, dynamic> map) {
    courseId = map['courseId'];
    courseName = map['courseName'];
    teacherId = map['teacherId'];
    institutionId = map['institutionId'];
    level = map['level'];
    categoryId = map['categoryId'];
  }
}