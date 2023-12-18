import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constant/main_abstract/main_abstract.dart';
import '../../../view_model/cubit/cubit_condition/cubit_state.dart';
import '../../../view_model/cubit/exam_cubit.dart';

class AttendanceView extends StatefulWidget {
  const AttendanceView({super.key});

  @override
  State<AttendanceView> createState() => _AttendanceViewState();
}

class _AttendanceViewState extends State<AttendanceView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamByIdClass, CubitState>(
      builder: (context, state){
        if(state is LoadingCubitState){
          return const Center(child: CircularProgressIndicator(),);
        }else if(state is ErrorCubitState){
          return Center(child: Text(state.error),);
        }else if(state is ExamState){
          return const Center(child: Text("Attendance"),);
        }else{
          return const SizedBox.shrink();
        }
      }
    );
  }
}