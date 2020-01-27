import 'package:bwa_learning/models/origin/Course.dart';
import 'package:bwa_learning/scoped_models/origin/AppModel.dart';
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
  List<Course> listCourses;

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
              listCourses = new List();
            });

            switch (newValue) {
              case 'Kelas X':
                model.courses.forEach((f) {
                  if (f.level == 0) {
                    listCourses.add(f);
                  }
                });
                break;
              case 'Kelas XI':
                model.courses.forEach((f) {
                  if (f.level == 1) {
                    listCourses.add(f);
                  }
                });
                break;
              case 'Kelas XII':
                model.courses.forEach((f) {
                  if (f.level == 2) {
                    listCourses.add(f);
                  }
                });
                break;
            }
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
    List<Course> parent = new List();
    List<Course> member = new List();

    childDocuments.forEach((f) {
      if (f.parentId == parentId) {
        print(f.courseName);
        parent.add(f);
      }
    });

    return parent.map((p) {
      widget.model.courses.forEach((c) {
        if (c.parentId == p.courseId) {
          member.add(c);
        }
      });

      return Parent(
          parent: _getCourse(course: p, tap: tab),
          childList: ChildList(
              children: _buildCourseParentList(member, p.courseId, tab + 15)));
    }).toList();
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
      parentList: _buildCourseParentList(listCourses, 0, 5),
    );
  }

  CourseCard _getCourse({@required Course course, double tap}) =>
      CourseCard(fileName: course.courseName.toString(), left: tap);

  Widget _buildPageContent(AppModel model) {
    return Scaffold(
        appBar: _buildAppBar(model),
        resizeToAvoidBottomPadding: false,
        floatingActionButton:
            listCourses != null ? _buildFloatingActionButton(model) : Text(''),
        body: Container(
          child: Column(
            children: <Widget>[
              _buildDropDownClassLevel(model),
              Expanded(
                child:
                    listCourses != null ? _buildCourseList(model) : Container(),
              )
            ],
          ),
        ));
  }

  Widget _buildFloatingActionButton(AppModel model) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {},
    );
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
