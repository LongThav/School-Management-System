import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_school_system/data_local/cache_auth_local.dart';
import 'package:frontend_school_system/util/handle_push_view.dart';
import 'package:frontend_school_system/util/snack_bar.dart';
import 'package:frontend_school_system/view/auth_view/welcome_view.dart';
import 'package:frontend_school_system/view/daskbaord_view/index_view.dart';
import '../../view_model/events/auth_event.dart';
import '../../constant/main_abstract/main_abstract.dart';
import '../../view_model/states/completing_state/auth_completing_state.dart';

import '../../data_handle/auth_handle.dart';
import '../events/student_event.dart';
import '../states/completing_state/student_completing_state.dart';
import '../states/condition_state/check_state.dart';

class AuthBloc extends Bloc<ApplicationEvent, ApplicationState> {
  final AuthDataHandle _authDataHandle;
  final CacheAuthLocal _cacheAuthLocal;
  AuthBloc(this._authDataHandle, this._cacheAuthLocal)
      : super(InitializeState()) {

    on<CreateAccountEvent>((event, emit) async {
      emit(CreateAccountLoadingState(isLoading: true));
      final Map<String, dynamic> data = {
        'email': event.email,
        'password': event.password,
        'role_id': event.role,
      };
      await _authDataHandle.createAccountAdmin(data).then((value) {
        pushReplaceView(event.context, const HomeView());
        _cacheAuthLocal.writeToken(value.data?.accessToken ?? "");
        emit(CreateAccountLoadingState(isLoading: false));
      }).onError((error, stackTrace) {
        emit(CreateAccountLoadingState(isLoading: false));
      });
    });

    on<LoginAccountEvent>((event, emit) async {
      emit(LoginAccountLoadingState(isLoading: true));
      final Map<String, dynamic> data = {
        'email': event.email,
        'password': event.password
      };
      await _authDataHandle.loginAccount(event.context, data).then((value) {
        _cacheAuthLocal.writeToken(value.data?.token ?? "");
        pushReplaceView(event.context, const HomeView());
        emit(LoginAccountLoadingState(isLoading: false));
      }).onError((error, stackTrace) {
        debugPrint("Error");
        emit(LoginAccountLoadingState(isLoading: false));
      });
    });

    on<ProvinceEvent>((event, emit) async {
      await _authDataHandle.readProvince().then((value) {
        emit(ProvinceState(provincModel: value));
      }).onError((error, stackTrace) {
        emit(ErrorState(error: error.toString()));
      });
    });
    on<LogoutEvent>((event, emit) async {
      emit(LogoutState(isLoading: true));
      await _authDataHandle.handleLogout().then((value) {
        snackBar(event.context, "Logout Successfully");
        // popView(event.context);
        pushReplaceView(event.context, const WelcomeView());
        emit(LogoutState(isLoading: false));
      }).onError((error, stackTrace) {
        emit(LogoutState(isLoading: false));
      });
    });
  }
}

class DropDownBloc extends Bloc<ApplicationEvent, ApplicationState> {
  final AuthDataHandle _authDataHandle;
  DropDownBloc(this._authDataHandle) : super(InitializeState()){
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
