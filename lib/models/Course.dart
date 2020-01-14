class Course {
  int courseId;
  var courseName;
  int teacherId;
  int institutionId;
  int parentId;
  int level;
  int categoryId;
  List<Course> childData;

  Course({
    this.courseId,
    this.courseName,
    this.teacherId,
    this.level,
    this.institutionId,
    this.parentId,
    this.categoryId
  });

  Course.fromJson(Map<String, dynamic> map) {
    courseId = map['courseId'];
    courseName = map['courseName'];
    teacherId = map['teacherId'];
    institutionId = map['institutionId'];
    parentId = map['parentId'];
    level = map['level'];
    categoryId = map['categoryId'];
  }
}