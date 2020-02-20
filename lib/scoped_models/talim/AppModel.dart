import 'package:bwa_learning/scoped_models/talim/LinkTrainingMeetingTopicModel.dart';
import 'package:bwa_learning/scoped_models/talim/ScheduleModel.dart';
import 'package:bwa_learning/scoped_models/talim/SessionModel.dart';
import 'package:bwa_learning/scoped_models/talim/StudentModel.dart';
import 'package:bwa_learning/scoped_models/talim/StudentProgressModel.dart';
import 'package:bwa_learning/scoped_models/talim/TimeScheduleModel.dart';
import 'package:bwa_learning/scoped_models/talim/TopicModel.dart';
import 'package:bwa_learning/scoped_models/talim/UserModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'ClassesModel.dart';
import 'InstitutionModel.dart';
import 'InstructorModel.dart';
import 'SessionAbsenceModel.dart';
import 'TrainingClassModel.dart';


class AppModelV2 extends Model
    with
        CoreModel,
        ClassesModel,
        InstitutionModel,
        InstructorModel,
        SessionModel,
        UserModel,
        SessionAbsenceModel,
        StudentModel,
        LinkTrainingMeetingTopicModel,
        TopicModel,
        StudentProgressModel,
        TimeScheduleModel,
        ScheduleModel,
        TrainingClassModel
{}
