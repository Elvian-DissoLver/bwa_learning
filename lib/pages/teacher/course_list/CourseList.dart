import 'package:bwa_learning/models/Course.dart';
import 'package:bwa_learning/scoped_models/AppModel.dart';
import 'package:bwa_learning/widgets/loading/loading_modal.dart';
import 'package:bwa_learning/widgets/teacher/course_list/CourseCard.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tree_view/tree_view.dart';

class TeacherCourseList extends StatefulWidget {
  final AppModel model;

  TeacherCourseList(this.model);

  @override
  State<StatefulWidget> createState() {
    return _TeacherCourseListState();
  }
}

class _TeacherCourseListState extends State<TeacherCourseList> {
  String selectLevelClass;

  @override
  void initState() {
    widget.model.fetchCourseByInstitutionIdAndTeacherId(
        widget.model.currentInstitution.institutionId,
        widget.model.currentTeacher.teacherId);

    super.initState();
  }

  Widget _buildAppBar(AppModel model) {
    return AppBar(
      title: Text(
        'Daftar Pelajaran',
      ),
    );
  }

  Widget _buildDropDownClassLevel(AppModel model) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        padding: EdgeInsets.all(10),
        width: 190,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              spreadRadius: 2,
              color: Colors.black.withOpacity(0.3),
            ),
          ],
        ),
        child: DropdownButton<String>(
          value: selectLevelClass,
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.deepPurple),
          onChanged: (newValue) {
            setState(() {
              selectLevelClass = newValue;
            });
          },
          hint: Text(
            "Pilih tingkat pelajaran!",
          ),
          items: ['Kelas X', 'Kelas XI', 'Kelas XII'].map((value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  List<Widget> _buildCourseParentList(
      List<Course> childDocuments, int parentId, double tab) {
    print('parentId: $parentId');
    List<Course> parent = new List();
    List<Course> member = new List();

    Course course = Course(
        courseId: 99,
        courseName: null,
        teacherId: null,
        level: 0,
        institutionId: 1234,
        parentId: parentId,
        categoryId: 1);

    childDocuments.forEach((f) {
      if (f.parentId == parentId) {
        print(f.courseName);
        parent.add(f);
      }
    });
    parent.add(course);

    if (parent.length > 0) {
    return parent.map((p) {
      widget.model.courses.forEach((c) {
        if (c.parentId == p.courseId) {
          member.add(c);
        }
      });

      print('member length $member.length');

      return Parent(
          parent: p.courseName != null
              ? _getCourse(course: p, tap: tab)
              : addParentCourse(tab),
          childList: member.length > 0
              ? ChildList(
                  children:
                      _buildCourseParentList(member, p.courseId, tab + 10))
              : ChildList(children: [addParentCourse(tab + 10)]));
    }).toList();
    }
  }

  Widget addParentCourse(double tab) {
    return Container(
      margin: EdgeInsets.fromLTRB(tab, 4, 4, 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            spreadRadius: 2,
            color: Colors.black.withOpacity(0.3),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(Icons.add_circle_outline),
        title: Text('Tambah Pelajaran'),
      ),
    );
  }

  Widget _buildCourseList(AppModel model) {
    return TreeView(
      parentList: _buildCourseParentList(model.courses, 0, 5),
    );
  }

  CourseCard _getCourse({@required Course course, double tap}) =>
      CourseCard(fileName: course.courseName, left: tap);

  Widget _buildPageContent(AppModel model) {
    return Scaffold(
        appBar: _buildAppBar(model),
        resizeToAvoidBottomPadding: false,
        body: Container(
          child: Column(
            children: <Widget>[
              _buildDropDownClassLevel(model),
              Expanded(
                child: _buildCourseList(model),
              )
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (BuildContext context, Widget child, AppModel model) {
        Stack stack = Stack(
          children: <Widget>[
            _buildPageContent(model),
          ],
        );

        if (model.isLoading) {
          stack.children.add(LoadingModal());
        }

        return stack;
      },
    );
  }
}
