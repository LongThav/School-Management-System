import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_school_system/data_handle/exam_handle.dart';

import '../../constant/main_abstract/main_abstract.dart';
import '../../data_handle/major_handle.dart';
import 'cubit_condition/cubit_state.dart';

class ExamCubit extends Cubit<CubitState> {
  final MajorHandleData _majorHandleData;
  final ExamHandleData _examHandleData;
  ExamCubit(this._majorHandleData, this._examHandleData)
      : super(InitializeCubitState());

  Future<void> readMajorById(int id) async {
    emit(LoadingCubitState());
    await _majorHandleData.readMajorById(id).then((value) {
      emit(MajorByIdState(majorByIdModel: value));
    }).onError((error, stackTrace) {
      emit(ErrorCubitState(error: error.toString()));
    });
  }

  Future<void> readMajor(int id) async {
    emit(LoadingCubitState());
    await _examHandleData.readYearById(id).then((value) {
      emit(MajorById(yearByIdModel: value));
    }).onError((error, stackTrace) {
      emit(ErrorCubitState(error: error.toString()));
    });
  }
}

class ExamByIdClass extends Cubit<CubitState> {
  final ExamHandleData _examHandleData;
  ExamByIdClass(this._examHandleData) : super(InitializeCubitState());

  Future<void> readExam(int id) async {
    emit(LoadingCubitState());
    await _examHandleData.readExam(id).then((value) {
      emit(ExamState(examModel: value));
    }).onError((error, stackTrace) {
      emit(ErrorCubitState(error: error.toString()));
    });
  }

  Future<void> readYear() async {
    emit(LoadingCubitState());
    await _examHandleData.readYear().then((value) {
      emit(YearState(yearModel: value));
    }).onError((error, stackTrace) {
      emit(ErrorCubitState(error: error.toString()));
    });
  }
}
