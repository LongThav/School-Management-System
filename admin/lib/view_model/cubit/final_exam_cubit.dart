import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_school_system/constant/main_abstract/main_abstract.dart';
import 'package:frontend_school_system/util/snack_bar.dart';
import 'package:frontend_school_system/view_model/cubit/cubit_condition/cubit_state.dart';

import '../../data_handle/exam_handle.dart';
import '../../data_handle/major_handle.dart';
import '../../data_handle/student_handle.dart';
import '../../util/handle_push_view.dart';

class FinalExamCubit extends Cubit<CubitState> {
  final MajorHandleData _data;
  final HandleDataStudent _dataStudent;
  final ExamHandleData _examHandleData;
  FinalExamCubit(this._data, this._dataStudent, this._examHandleData)
      : super(InitializeCubitState());

  Future addFinalExam(String title, String classId,String subjectId, String times,BuildContext context) async {
    LoadingAddFinalExam(isLoading: true);
    final Map<String, dynamic> data = {
      'class_id': classId,
      'title': title,
      'subject_id': subjectId,
      'date_time': times
    };
    await _data.createFinalExam(data).then((value) {
      LoadingAddFinalExam(isLoading: false);
      snackBar(context, "Add final exam successfully...!");
        popView(context);

    }).onError((error, stackTrace) {
      snackBar(context, "Upload final Exam fail... try again");
      LoadingAddFinalExam(isLoading: false);
    });
  }

  Future addPayment(int id, String payment, BuildContext context) async {
    emit(LoadingPaymentState(isLoading: true));
    final Map<String, dynamic> data = {'payment': payment};
    await _dataStudent.paymentHandle(data, id).then((value) {
      popView(context);
      snackBar(context, "Payment successfully");
      emit(LoadingPaymentState(isLoading: false));
    }).onError((error, stackTrace) {
      snackBar(context, "Payment fails");
      emit(LoadingPaymentState(isLoading: false));
    });
  }

  Future paymentViewModel(
      String payment, int personId, BuildContext context) async {
    emit(LoadingPaymentState(isLoading: true));
    final Map<String, dynamic> data = {
      'total_payment': payment,
      'person_id': personId
    };
    await _dataStudent.paymentRepo(data).then((value) {
      popView(context);
      snackBar(context, "Payment successfully");
      emit(LoadingPaymentState(isLoading: false));
    }).onError((error, stackTrace) {
      snackBar(context, "Payment fails");
      emit(LoadingPaymentState(isLoading: false));
    });
  }

  Future createYear(dynamic data, BuildContext context) async {
    emit(CreateYearLoading(isLoading: true));
    await _examHandleData.createYear(data).then((value) {
      popView(context);
      snackBar(context, "Create year successfully");
      emit(CreateYearLoading(isLoading: false));
    }).onError((error, stackTrace) {
      emit(CreateYearLoading(isLoading: false));
    });
  }
}
