import 'package:frontend_school_system/constant/main_abstract/main_abstract.dart';
import 'package:frontend_school_system/model/class_model.dart';
import 'package:frontend_school_system/model/province_model.dart';
import 'package:frontend_school_system/model/user_by_id_model.dart';

import '../../../model/gender_model.dart';

class StudentByIdState extends ApplicationState {
  final UserByIdModel userByIdModel;
  StudentByIdState({required this.userByIdModel});
}

class LoadingCreateAccountStuentState extends ApplicationState {
  bool isLoading;
  LoadingCreateAccountStuentState({required this.isLoading});
}

class GenderState extends ApplicationState {
  final GenderModel genderModel;
  GenderState({required this.genderModel});
}

class AddStudentInforState extends ApplicationState {
  bool isLoading;
  AddStudentInforState({required this.isLoading});
}

class ProvinceState extends ApplicationState {
  final ProvincModel provincModel;
  ProvinceState({required this.provincModel});
}

class ClassState extends ApplicationState {
  final ClassModel classModel;
  ClassState({required this.classModel});
}

class DeleteLoadingState extends ApplicationState {
  bool isLoading;
  DeleteLoadingState({required this.isLoading});
}

class LogoutState extends ApplicationState {
  bool isLoading;
  LogoutState({required this.isLoading});
}

class LoadingUpdateState extends ApplicationState {
  bool isLoading;
  LoadingUpdateState({required this.isLoading});
}

class TeacherByIDState extends ApplicationState {
  final UserByIdModel userByIdModel;
  TeacherByIDState({required this.userByIdModel});
}
