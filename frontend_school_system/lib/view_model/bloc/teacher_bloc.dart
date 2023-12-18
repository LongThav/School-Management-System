import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_school_system/constant/main_abstract/main_abstract.dart';
import 'package:frontend_school_system/view_model/events/teacher_event.dart';
import 'package:frontend_school_system/view_model/states/completing_state/student_completing_state.dart';
import 'package:frontend_school_system/view_model/states/condition_state/check_state.dart';

import '../../data_handle/student_handle.dart';

class TeacherBloc extends Bloc<ApplicationEvent, ApplicationState>{
  final HandleDataStudent _dataStudent; 
  TeacherBloc(this._dataStudent) : super(InitializeState()){
    on<TeacherEvent>((event, emit)async{
      emit(LoaddingState());
      await _dataStudent.readUserById(event.id).then((value){
        emit(TeacherByIDState(userByIdModel: value));
      }).onError((error, stackTrace){
        emit(ErrorState(error: error.toString()));
      });
    });
  }
}