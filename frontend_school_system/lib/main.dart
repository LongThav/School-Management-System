import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_school_system/data_handle/major_handle.dart';
import 'package:frontend_school_system/data_handle/student_handle.dart';
import 'package:frontend_school_system/data_handle/teacher_handle.dart';
import 'package:frontend_school_system/view/daskbaord_view/index_view.dart';
import 'package:frontend_school_system/view_model/bloc/logic_drop_down.dart';
import 'package:frontend_school_system/view_model/bloc/student_bloc.dart';
import 'package:frontend_school_system/view_model/bloc/teacher_bloc.dart';
import 'package:frontend_school_system/view_model/cubit/class_cubit.dart';
import 'package:frontend_school_system/view_model/cubit/exam_cubit.dart';
import 'package:frontend_school_system/view_model/cubit/final_exam_cubit.dart';
import 'package:frontend_school_system/view_model/cubit/major_cubit.dart';
import 'package:window_size/window_size.dart';

import '../../data_local/cache_auth_local.dart';
import '../../data_handle/auth_handle.dart';
import '../../view_model/bloc/auth_bloc.dart';
import '../../view/auth_view/welcome_view.dart';
import 'data_handle/exam_handle.dart';
import 'data_handle/subject_handle.dart';
import 'view_model/bloc/user_bloc.dart';
import 'view_model/cubit/subject_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    setWindowTitle("School Management System");
    setWindowMinSize(const Size(1500, 1000));
    setWindowMaxSize(Size.infinite);
  }
  CacheAuthLocal cacheAuthLocal = CacheAuthLocal();
  String token = await cacheAuthLocal.readToken();
  debugPrint("Token User: $token");
  AuthDataHandle authhandle = AuthDataHandle();
  HandleDataUser handleDataUser = HandleDataUser();
  HandleDataStudent handleDataStudent = HandleDataStudent();
  ExamHandleData examHandleData = ExamHandleData();
  MajorHandleData majorHandleData = MajorHandleData();
  MajorHandleData finalExamCubit = MajorHandleData();
  SubjectHandle subjectHandle = SubjectHandle();
  if (token == cacheAuthLocal.noToken) {
    runApp(MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthBloc(authhandle, cacheAuthLocal)),
          BlocProvider(create: (context) => UserBloc(handleDataUser, authhandle)),
          BlocProvider(create: (context) => StudentBloc(handleDataStudent)),
          BlocProvider(create: (context) => DropDownLogic(handleDataStudent)),
          BlocProvider(create: (context) => TeacherBloc(handleDataStudent)),
          BlocProvider(create: (context) => MajorCubit(majorHandleData, handleDataStudent, authhandle)),
          BlocProvider(create: (context) => ClassCubit(majorHandleData)),
          BlocProvider(create: (context) => StudentCubit(handleDataStudent)),
          BlocProvider(create: (context) => DropDownBloc(authhandle)),
          BlocProvider(create: (context) => ExamCubit(majorHandleData, examHandleData)),
          BlocProvider(create: (context) => ExamByIdClass(examHandleData)),
          BlocProvider(create: (context) => StudentByIdBloc(handleDataStudent)),
          BlocProvider(create: (context) => FinalExamCubit(finalExamCubit, handleDataStudent, examHandleData)),
          BlocProvider(create: (context) => SubjectCubit(subjectHandle)),
          BlocProvider(create: (context) => SubjectByIdCubit(subjectHandle)),
          BlocProvider(create: (context) => SubjectAdded(subjectHandle))
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: WelcomeView(),
        )));
  } else {
    runApp(MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthBloc(authhandle, cacheAuthLocal)),
          BlocProvider(create: (context) => UserBloc(handleDataUser, authhandle)),
          BlocProvider(create: (context) => StudentBloc(handleDataStudent)),
          BlocProvider(create: (context) => DropDownLogic(handleDataStudent)),
          BlocProvider(create: (context) => TeacherBloc(handleDataStudent)),
          BlocProvider(create: (context) => MajorCubit(majorHandleData, handleDataStudent, authhandle)),
          BlocProvider(create: (context) => ClassCubit(majorHandleData)),
          BlocProvider(create: (context) => StudentCubit(handleDataStudent)),
          BlocProvider(create: (context) => DropDownBloc(authhandle)),
          BlocProvider(create: (context) => ExamCubit(majorHandleData, examHandleData)),
          BlocProvider(create: (context) => ExamByIdClass(examHandleData)),
          BlocProvider(create: (context) => StudentByIdBloc(handleDataStudent)),
          BlocProvider(create: (context) => FinalExamCubit(finalExamCubit, handleDataStudent, examHandleData)),
          BlocProvider(create: (context) => SubjectCubit(subjectHandle)),
          BlocProvider(create: (context) => SubjectByIdCubit(subjectHandle)),
          BlocProvider(create: (context) => SubjectAdded(subjectHandle))
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeView(),
        )));
  }
}
