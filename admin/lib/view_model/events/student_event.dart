import 'package:flutter/cupertino.dart';
import 'package:frontend_school_system/constant/main_abstract/main_abstract.dart';

class StudentEvent extends ApplicationEvent {
  final int id;
  StudentEvent({required this.id});
}

class CreateAccountStudentEvent extends ApplicationEvent {
  final String email;
  final String role;
  final String username;
  final String password;
  final int genderId;
  final BuildContext context;
  CreateAccountStudentEvent(
      {required this.email,
      required this.username,
      required this.role,
      required this.password,
      required this.genderId,
      required this.context});
}

class GenderEvent extends ApplicationEvent {}

class AddInforStudent extends ApplicationEvent {
  final String name;
  final String codeId;
  final String age;
  final String city;
  final String khan;
  final String sangkat;
  final String country;
  final String phone;
  final String userId;
  final String sex;
  final String role;
  final String provinceId;
  final String classId;
  final String majorId;
  final String yearId;
  final BuildContext context;
  AddInforStudent(
      {required this.name,
      required this.codeId,
      required this.age,
      required this.city,
      required this.majorId,
      required this.khan,
      required this.sangkat,
      required this.yearId,
      required this.country,
      required this.phone,
      required this.userId,
      required this.provinceId,
      required this.context,
      required this.sex,
      required this.role,
      required this.classId});
}

class ProvinceEvent extends ApplicationEvent {}

class ClassNameEvent extends ApplicationEvent {}

class DeleteStudentEvent extends ApplicationEvent {
  final int id;
  final BuildContext context;
  DeleteStudentEvent({required this.id, required this.context});
}

class LogoutEvent extends ApplicationEvent {
  final BuildContext context;
  LogoutEvent({required this.context});
}

class UpdateuserInforEvent extends ApplicationEvent {
  final int id;
  final String age;
  final String city;
  final String khan;
  final String sangkat;
  final String country;
  final String phone;
  final String role;
  final String sex;
  final String userId;
  final String provinceId;
  final String yearId;
  final String classId;
  final String majorId;
  final BuildContext context;
  UpdateuserInforEvent(
      {required this.age,
      required this.id,
      required this.city,
      required this.sex,
      required this.role,
      required this.khan,
      required this.majorId,
      required this.sangkat,
      required this.country,
      required this.phone,
      required this.yearId,
      required this.userId,
      required this.provinceId,
      required this.context,
      required this.classId});
}
