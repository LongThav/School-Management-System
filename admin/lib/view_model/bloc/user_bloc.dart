import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_school_system/constant/main_abstract/main_abstract.dart';
import 'package:frontend_school_system/view_model/events/user_event.dart';
import 'package:frontend_school_system/view_model/states/completing_state/user_completing.dart';
import 'package:frontend_school_system/view_model/states/condition_state/check_state.dart';

import '../../data_handle/auth_handle.dart';
import '../../data_handle/teacher_handle.dart';
import '../events/auth_event.dart';
import '../states/completing_state/auth_completing_state.dart';

class UserBloc extends Bloc<ApplicationEvent, ApplicationState>{
  final HandleDataUser _handleDataUser; 
  final AuthDataHandle _authDataHandle;
  UserBloc(this._handleDataUser, this._authDataHandle) : super(InitializeState()){
    on<UserEvent>((event, emit)async{
      emit(LoaddingState());
      await _handleDataUser.readUser(search: event.search).then((value){
        emit(UserState(userModel: value));
      }).onError((error, stackTrace){
        emit(ErrorState(error: error.toString()));
      });
    });

      on<RoleEvent>((event, emit) async {
      emit(LoaddingState());
      await _authDataHandle.readRole().then((value) {
        emit(RoleState(roleModel: value));
      }).onError((error, stackTrace) {
        emit(ErrorState(error: error.toString()));
      });
    });
  }
}