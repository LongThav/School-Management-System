import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constant/main_abstract/main_abstract.dart';
import '../../../constant/url_base.dart';
import '../../../model/exam_model.dart';
import '../../../view_model/cubit/cubit_condition/cubit_state.dart';
import '../../../view_model/cubit/exam_cubit.dart';

class MidtermView extends StatefulWidget {
  const MidtermView({super.key});

  @override
  State<MidtermView> createState() => _MidtermViewState();
}

class _MidtermViewState extends State<MidtermView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExamByIdClass, CubitState>(builder: (context, state) {
      if (state is LoadingCubitState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is ErrorCubitState) {
        return Center(
          child: Text(state.error),
        );
      } else if (state is ExamState) {
        if (state.examModel.data.allExam.midtermExam.isEmpty) {
          return const Center(
            child: Text("No Midterm"),
          );
        } else {
          return _buildFinalExam(state.examModel);
        }
      } else {
        return const SizedBox.shrink();
      }
    });
  }

  Widget _buildFinalExam(ExamModel examModel) {
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: width,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                    color: Color(0XFF33b6ff),
                    blurRadius: 4,
                    spreadRadius: 4,
                    offset: Offset(1, 3)),
                BoxShadow(color: Colors.white)
              ],
              border: Border.all(color: const Color(0XFF33b6ff)),
            ),
            child: Column(
              children: [
                const Align(
                    alignment: Alignment.centerLeft, child: Text("Midterm")),
                Column(
                  children: List.generate(
                      examModel.data.allExam.midtermExam.length, (index) {
                    var data = examModel.data.allExam.midtermExam[index];
                    return Container(
                      margin: const EdgeInsets.all(15),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0XFF33b6ff)),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                              color: Color(0XFF33b6ff),
                              blurRadius: 1,
                              spreadRadius: 1,
                              offset: Offset(1, 2)),
                          BoxShadow(color: Colors.white)
                        ],
                      ),
                      child: Row(
                        children: [
                          Text('${index + 1}.'),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              Text(data.title),
                              SizedBox(
                                child: data.image == null
                                    ? null
                                    : Container(
                                        width: width,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            image: DecorationImage(
                                                image: NetworkImage(hostImage +
                                                    data.image.toString()))),
                                      ),
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
