import 'package:frontend_school_system/constant/main_abstract/main_abstract.dart';
import 'package:frontend_school_system/model/all_major_model.dart';
import 'package:frontend_school_system/model/exam_model.dart';
import 'package:frontend_school_system/model/major_by_id_model.dart';
import 'package:frontend_school_system/model/major_model.dart';
import 'package:frontend_school_system/model/student_model.dart';
import 'package:image_picker/image_picker.dart';

import '../../../model/class_by_id_major_model.dart';
import '../../../model/history_payment_model.dart';
import '../../../model/type_year_model.dart';
import '../../../model/year_by_id_model.dart';
import '../../../model/year_model.dart';

class InitializeCubitState extends CubitState{}
class ErrorCubitState extends CubitState{
  final String error;
  ErrorCubitState({required this.error});
}
class LoadingCubitState extends CubitState{}
class MajorState extends CubitState{
  final MajorModel majorModel;
  MajorState({required this.majorModel});
}

class LoadingCreateMajoCubitrState extends CubitState{
  bool isLoading;
  LoadingCreateMajoCubitrState({required this.isLoading});
}

class MajorByIdState extends CubitState{
  final MajorByIdModel majorByIdModel;
  MajorByIdState({required this.majorByIdModel});
}

class AddClassLoadingCubitState extends CubitState{
  bool isLoading;
  AddClassLoadingCubitState({required this.isLoading});
}

class StudentClassState extends CubitState{
  final StudentModel studentModel;
  StudentClassState({required this.studentModel});
}

class ExamState extends CubitState{
  final ExamModel examModel;
  ExamState({required this.examModel});
}

class FileImageState extends CubitState{
  final XFile? file;
  FileImageState(this.file);
}

class LoadingAddFinalExam extends CubitState{
  bool isLoading;
  LoadingAddFinalExam({required this.isLoading});
}

class AllMajorModelState extends CubitState{
  final AllMajorModel allMajorModel;
  AllMajorModelState({required this.allMajorModel});
}
class LoadingPaymentState extends CubitState{
  bool isLoading;
  LoadingPaymentState({required this.isLoading});
}

class ClassByMajorId extends CubitState{
  final ClassByModorIdModel classByModorIdModel;
  ClassByMajorId({required this.classByModorIdModel});
}

class YearState extends CubitState{
  final YearModel yearModel;
  YearState({required this.yearModel});
}

class MajorById extends CubitState{
  final YearByIdModel yearByIdModel;
  MajorById({required this.yearByIdModel});
}

class CreateYearLoading extends CubitState{
  bool isLoading;
  CreateYearLoading({required this.isLoading});
}

class TypeYearState extends CubitState{
  final TypeYearModel typeYearModel;
  TypeYearState({required this.typeYearModel});
}

class HistoryPaymentState extends CubitState{
  final HistoryPaymentModel historyPaymentModel;
  HistoryPaymentState({required this.historyPaymentModel});
}