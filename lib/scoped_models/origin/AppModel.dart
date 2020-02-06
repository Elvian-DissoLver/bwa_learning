
import 'package:scoped_model/scoped_model.dart';
import 'CategoryModel.dart';
import 'CourseModel.dart';
import 'CourseStateModel.dart';
import 'InstitutionModel.dart';
import 'RoomModel.dart';
import 'ScheduleCourseModel.dart';
import 'StudentModel.dart';
import 'TeacherModel.dart';
import 'UserModel.dart';

class AppModel extends Model
    with
        CoreModel,
        ClassesModel,
        StudentModel,
        TeacherModel,
        ScheduleCourseModel,
        CourseModel,
        InstitutionModel,
        UserModel,
        CategoryModel,
        CourseStateModel
{}
