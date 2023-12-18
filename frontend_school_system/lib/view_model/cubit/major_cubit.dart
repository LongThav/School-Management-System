import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_school_system/constant/main_abstract/main_abstract.dart';
import 'package:frontend_school_system/data_handle/major_handle.dart';
import 'package:frontend_school_system/util/handle_push_view.dart';
import 'package:frontend_school_system/view_model/cubit/cubit_condition/cubit_state.dart';

import '../../data_handle/auth_handle.dart';
import '../../data_handle/student_handle.dart';
import '../../util/snack_bar.dart';

class MajorCubit extends Cubit<CubitState> {
  final MajorHandleData _majorHandleData;
  final HandleDataStudent _handleDataStudent;
  final AuthDataHandle _authDataHandle;
  MajorCubit(
      this._majorHandleData, this._handleDataStudent, this._authDataHandle)
      : super(InitializeCubitState());

  Future<void> readMajor() async {
    emit(LoadingCubitState());
    await _majorHandleData.readMajor().then((value) {
      emit(MajorState(majorModel: value));
    }).onError((error, stackTrace) {
      emit(ErrorCubitState(error: error.toString()));
    });
  }

  Future createMajor(String majorName, int yearId, BuildContext context) async {
    emit(LoadingCreateMajoCubitrState(isLoading: true));
    final Map<String, dynamic> data = {
      'major_name': majorName,
      'year_id': yearId
    };
    await _majorHandleData.createMajor(data).then((value) {
      context.read<MajorCubit>().readMajor();
      popView(context);
      emit(LoadingCreateMajoCubitrState(isLoading: false));
    }).onError((error, stackTrace) {
      emit(LoadingCreateMajoCubitrState(isLoading: false));
    });
  }

  Future crateClass(String className, int majorId, BuildContext context) async {
    emit(AddClassLoadingCubitState(isLoading: true));
    final Map<String, dynamic> data = {
      'name_class': className,
      'major_id': majorId
    };
    await _majorHandleData.createClass(data).then((value) {
      context.read<MajorCubit>().readMajor();
      popView(context);
      snackBar(context, "Create Class successfully");
      emit(AddClassLoadingCubitState(isLoading: false));
    }).onError((error, stackTrace) {
      emit(AddClassLoadingCubitState(isLoading: false));
    });
  }

  Future<void> readAllMajor() async {
    emit(LoadingCubitState());
    await _handleDataStudent.readAllMajor().then((value) {
      emit(AllMajorModelState(allMajorModel: value));
    }).onError((error, stackTrace) {
      emit(ErrorCubitState(error: error.toString()));
    });
  }

  bool isLoading = false;
  void _setLoading(value) => isLoading = value;
  Future createRole(dynamic data, BuildContext context) async {
    _setLoading(true);
    await _authDataHandle.createRole(data).then((value) {
      popView(context);
      snackBar(context, "Role create successfully");
      _setLoading(false);
    }).onError((error, stackTrace) {
      _setLoading(false);
    });
  }

  bool provinceLoading = false;
  Future createProvince(dynamic data, BuildContext context) async {
    provinceLoading = true;
    await _authDataHandle.crateProvince(data).then((value) {
      popView(context);
      snackBar(context, "Role create successfully");
      provinceLoading = false;
    }).onError((error, stackTrace) {
      provinceLoading = false;
    });
  }

  Future<void> readClassByIdMajor(int id) async {
    emit(LoadingCubitState());
    await _majorHandleData.readClass(id).then((value) {
      emit(ClassByMajorId(classByModorIdModel: value));
    }).onError((error, stackTrace) {
      emit(ErrorCubitState(error: error.toString()));
    });
  }

  Future<void> readHistoryPayment(int id)async{
    emit(LoadingCubitState());
    await _majorHandleData.hostoryPaymentRepo(id).then((value){
      emit(HistoryPaymentState(historyPaymentModel: value));
    }).onError((error, stackTrace){
      emit(ErrorCubitState(error: error.toString()));
    });
  }
}
