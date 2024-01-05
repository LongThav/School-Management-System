import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_school_system/constant/main_abstract/main_abstract.dart';
import 'package:frontend_school_system/data_handle/student_handle.dart';
import 'package:frontend_school_system/util/handle_push_view.dart';
import 'package:frontend_school_system/util/snack_bar.dart';
import 'package:frontend_school_system/view_model/events/student_event.dart';
import 'package:frontend_school_system/view_model/states/completing_state/student_completing_state.dart';
import 'package:frontend_school_system/view_model/states/condition_state/check_state.dart';

class StudentBloc extends Bloc<ApplicationEvent, ApplicationState> {
  final HandleDataStudent _dataStudent;
  StudentBloc(this._dataStudent) : super(InitializeState()) {
    on<CreateAccountStudentEvent>((event, emit) async {
      emit(LoadingCreateAccountStuentState(isLoading: true));
      final Map<String, dynamic> data = {
        'email': event.email,
        'password': event.password,
        'username': event.username,
        'role_id': event.role,
        'gender_id': event.genderId,
      };
      await _dataStudent.createUser(data).then((value) {
        popView(event.context);
        emit(LoadingCreateAccountStuentState(isLoading: false));
      }).onError((error, stackTrace) {
        emit(LoadingCreateAccountStuentState(isLoading: false));
      });
    });
    on<GenderEvent>((event, emit) async {
      // emit(LoaddingState());
      await _dataStudent.readGender().then((value) {
        emit(GenderState(genderModel: value));
      }).onError((error, stackTrace) {
        emit(ErrorState(error: error.toString()));
      });
    });
    on<AddInforStudent>((event, emit) async {
      emit(AddStudentInforState(isLoading: true));
      final Map<String, dynamic> data = {
        'name': event.name,
        'codeId': event.codeId,
        'sex': event.sex,
        'role': event.role,
        'age': event.age,
        'year_id': event.yearId,
        'major_id': event.majorId,
        'city': event.city,
        'khan': event.khan,
        'sangkat': event.sangkat,
        'country': event.country,
        'phone': event.phone,
        'user_id': event.userId,
        'person_id': event.provinceId,
        'id_class': event.classId
      };
      await _dataStudent.addUserInfor(data).then((value) {
        Future.delayed(const Duration(microseconds: 600), () {
          popView(event.context);
        });
        emit(AddStudentInforState(isLoading: false));
      }).onError((error, stackTrace) {
        {
          emit(AddStudentInforState(isLoading: false));
        }
      });
    });
    on<DeleteStudentEvent>((event, emit) async {
      emit(DeleteLoadingState(isLoading: true));
      await _dataStudent.deleteStudent(event.id).then((value) {
        popView(event.context);
        snackBar(event.context, "Delete Student Successfully");
        emit(DeleteLoadingState(isLoading: false));
      }).onError((error, stackTrace) {
        emit(DeleteLoadingState(isLoading: false));
      });
    });
    on<UpdateuserInforEvent>((event, emit) async {
      emit(LoadingUpdateState(isLoading: true));
      final Map<String, dynamic> data = {
        'id': event.id,
        'age': event.age,
        'city': event.city,
        'khan': event.khan,
        'role': event.role,
        'sex': event.sex,
        'major_id': event.majorId,
        'sangkat': event.sangkat,
        'country': event.country,
        'year_id': event.yearId,
        'phone': event.phone,
        'user_id': event.userId,
        'person_id': event.provinceId,
        'id_class': event.classId
      };
      await _dataStudent.updateUserInfor(data).then((value) {
        popView(event.context);
        snackBar(event.context, "Update user information successfully!");
        emit(LoadingUpdateState(isLoading: false));
      }).onError((error, stackTrace) {
        emit(LoadingUpdateState(isLoading: false));
      });
    });
  }
}

class StudentByIdBloc extends Bloc<ApplicationEvent, ApplicationState>{
  final HandleDataStudent _dataStudent;
  StudentByIdBloc(this._dataStudent) : super(InitializeState()){
    on<StudentEvent>((event, emit) async {
      emit(LoaddingState());
      await _dataStudent.readUserById(event.id).then((value) {
        emit(StudentByIdState(userByIdModel: value));
      }).onError((error, stackTrace) {
        emit(ErrorState(error: error.toString()));
      });
    });
  }
}