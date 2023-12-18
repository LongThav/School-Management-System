import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_school_system/constant/main_abstract/main_abstract.dart';
import 'package:frontend_school_system/data_handle/student_handle.dart';
import 'package:frontend_school_system/view_model/states/condition_state/check_state.dart';

import '../events/student_event.dart';
import '../states/completing_state/student_completing_state.dart';

class DropDownLogic extends Bloc<ApplicationEvent, ApplicationState> {
  final HandleDataStudent handleDataStudent;
  DropDownLogic(this.handleDataStudent) : super(InitializeState()) {
    on<ClassNameEvent>((event, emit) async {
      await handleDataStudent.readClass().then((value) {
        emit(ClassState(classModel: value));
      }).onError((error, stackTrace) {
        emit(ErrorState(error: error.toString()));
      });
    });

    on<GenderEvent>((event, emit) async {
      emit(LoaddingState());
      await handleDataStudent.readGender().then((value) {
        emit(GenderState(genderModel: value));
      }).onError((error, stackTrace) {
        emit(ErrorState(error: error.toString()));
      });
    });
  }
}
