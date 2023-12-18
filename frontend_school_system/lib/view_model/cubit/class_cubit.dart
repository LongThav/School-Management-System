import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_school_system/constant/main_abstract/main_abstract.dart';
import 'package:frontend_school_system/data_handle/major_handle.dart';
import 'package:frontend_school_system/util/snack_bar.dart';
import 'package:frontend_school_system/view_model/cubit/cubit_condition/cubit_state.dart';
import 'package:image_picker/image_picker.dart';

import '../../data_handle/student_handle.dart';

class ClassCubit extends Cubit<CubitState> {
  final MajorHandleData _majorHandleData;
  ClassCubit(this._majorHandleData) : super(InitializeCubitState());

  Future<void> readMajorById(int id) async {
    emit(LoadingCubitState());
    await _majorHandleData.readMajorById(id).then((value) {
      emit(MajorByIdState(majorByIdModel: value));
    }).onError((error, stackTrace) {
      emit(ErrorCubitState(error: error.toString()));
    });
  }

  Future<void> pickImage(BuildContext context) async {
    try {
      XFile? pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return;
      emit(FileImageState(pickedFile));
    } catch (err) {
      snackBar(context, "Fails Pick File");
      emit(ErrorCubitState(error: err.toString()));
    }
  }
}

class StudentCubit extends Cubit<CubitState> {
  final HandleDataStudent _handleDataStudent;
  StudentCubit(this._handleDataStudent) : super(InitializeCubitState());

  Future<void> readStudent(int id) async {
    emit(LoadingCubitState());
    await _handleDataStudent.readStudent(id).then((value) {
      emit(StudentClassState(studentModel: value));
    }).onError((error, stackTrace) {
      emit(ErrorCubitState(error: error.toString()));
    });
  }

  Future<void> readTypeYear() async {
    emit(LoadingCubitState());
    await _handleDataStudent.readTypeYear().then((value) {
      emit(TypeYearState(typeYearModel: value));
    }).onError((error, stackTrace) {
      emit(ErrorCubitState(error: error.toString()));
    });
  }

  Future<void> readYear() async {
    emit(LoadingCubitState());
    await _handleDataStudent.readYear().then((value) {
      emit(YearState(yearModel: value));
    }).onError((error, stackTrace) {
      emit(ErrorCubitState(error: error.toString()));
    });
  }
}
