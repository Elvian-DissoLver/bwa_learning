import 'package:bwa_learning/scoped_models/talim/SessionModel.dart';
import 'package:bwa_learning/scoped_models/talim/StudentModel.dart';
import 'package:bwa_learning/scoped_models/talim/UserModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'ClassModel.dart';
import 'InstitutionModel.dart';
import 'InstructorModel.dart';
import 'SessionAbsenceModel.dart';


class AppModelV2 extends Model
    with
        CoreModel,
        ClassesModel,
        InstitutionModel,
        InstructorModel,
        SessionModel,
        UserModel,
        SessionAbsenceModel,
        StudentModel
{}
