import 'package:bwa_learning/scoped_models/KelasesModel.dart';
import 'package:bwa_learning/scoped_models/StudentModel.dart';
import 'package:scoped_model/scoped_model.dart';

class AppModel extends Model with CoreModel, KelasesModel, StudentModel {}
