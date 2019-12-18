import 'package:bwa_learning/scoped_models/ClassModel.dart';
import 'package:bwa_learning/scoped_models/CourseModel.dart';
import 'package:bwa_learning/scoped_models/InstitutionModel.dart';
import 'package:bwa_learning/scoped_models/ScheduleCourseModel.dart';
import 'package:bwa_learning/scoped_models/StudentModel.dart';
import 'package:bwa_learning/scoped_models/UserModel.dart';
import 'package:scoped_model/scoped_model.dart';

import 'TeacherModel.dart';

class AppModel extends Model
    with
        CoreModel,
        ClassesModel,
        StudentModel,
        TeacherModel,
        ScheduleCourseModel,
        CourseModel,
        InstitutionModel,
        UserModel {}
