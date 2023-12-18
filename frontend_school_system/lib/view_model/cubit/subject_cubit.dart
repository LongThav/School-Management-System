import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_school_system/util/handle_push_view.dart';
import 'package:frontend_school_system/util/snack_bar.dart';

import '../../data_handle/subject_handle.dart';
import '../../model/subject_by_id_model.dart';
import '../../model/subject_model.dart';

abstract class SubjectCubitState {}

class LoadingSubjectState extends SubjectCubitState {}

class InitializeSubjectState extends SubjectCubitState {}

class ErrorSubjectState extends SubjectCubitState {
  final String error;
  ErrorSubjectState({required this.error});
}

class SubjectState extends SubjectCubitState {
  final SubjectModel subjectModel;
  SubjectState({required this.subjectModel});
}

class SubjectByIdState extends SubjectCubitState {
  final SubjectByIdModel subjectByIdModel;
  SubjectByIdState({required this.subjectByIdModel});
}

class CreateSubjectCubit extends SubjectCubitState {
  bool isLoading;
  CreateSubjectCubit({required this.isLoading});
}

class AddPersonLoading extends SubjectCubitState {
  bool isLoading;
  AddPersonLoading({required this.isLoading});
}

class SubjectCubit extends Cubit<SubjectCubitState> {
  final SubjectHandle _subjectHandle;
  SubjectCubit(this._subjectHandle) : super(InitializeSubjectState());

  Future createSubject(
      String classId, String title, BuildContext context) async {
    emit(CreateSubjectCubit(isLoading: true));
    final Map<String, dynamic> data = {
      'class_id': classId,
      'title': title,
    };
    await _subjectHandle.createSubject(data).then((value) {
      popView(context);
      snackBar(context, "Subject create successfully");
      emit(CreateSubjectCubit(isLoading: false));
    }).onError((error, stackTrace) {
      emit(CreateSubjectCubit(isLoading: false));
    });
  }

  Future<void> readSubject(int id) async {
    emit(LoadingSubjectState());
    await _subjectHandle.readSubject(id).then((value) {
      emit(SubjectState(subjectModel: value));
    }).onError((error, stackTrace) {
      emit(ErrorSubjectState(error: error.toString()));
    });
  }
}

class SubjectByIdCubit extends Cubit<SubjectCubitState> {
  final SubjectHandle _subjectHandle;
  SubjectByIdCubit(this._subjectHandle) : super(InitializeSubjectState());
  Future<void> readSubjectById(int id) async {
    emit(LoadingSubjectState());
    await _subjectHandle.readPersonInSubject(id).then((value) {
      emit(SubjectByIdState(subjectByIdModel: value));
    }).onError((error, stackTrace) {
      emit(ErrorSubjectState(error: error.toString()));
    });
  }

  Future addPerson(int id, String subjectId, BuildContext context) async {
    emit(AddPersonLoading(isLoading: true));
    await _subjectHandle.addStudentIntoSubject(id, subjectId).then((value) {
      snackBar(context, "Added successfully");
      emit(AddPersonLoading(isLoading: false));
    }).onError((error, stackTrace) {
      emit(AddPersonLoading(isLoading: false));
    });
  }
}


class SubjectAdded extends Cubit<SubjectCubitState> {
  final SubjectHandle _subjectHandle;
  SubjectAdded(this._subjectHandle) : super(InitializeSubjectState());
  Future<void> readSubjectById(int id) async {
    emit(LoadingSubjectState());
    await _subjectHandle.readPersonInSubject(id).then((value) {
      emit(SubjectByIdState(subjectByIdModel: value));
    }).onError((error, stackTrace) {
      emit(ErrorSubjectState(error: error.toString()));
    });
  }

  Future addPerson(int id, String subjectId, BuildContext context) async {
    emit(AddPersonLoading(isLoading: true));
    await _subjectHandle.addStudentIntoSubject(id, subjectId).then((value) {
      snackBar(context, "Added successfully");
      emit(AddPersonLoading(isLoading: false));
    }).onError((error, stackTrace) {
      emit(AddPersonLoading(isLoading: false));
    });
  }
}
