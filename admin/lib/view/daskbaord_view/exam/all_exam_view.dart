import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_school_system/constant/main_abstract/main_abstract.dart';
import 'package:frontend_school_system/constant/url_base.dart';
import 'package:frontend_school_system/model/exam_model.dart';
import 'package:frontend_school_system/view_model/cubit/cubit_condition/cubit_state.dart';
import 'package:frontend_school_system/view_model/cubit/exam_cubit.dart';

class AllExamView extends StatefulWidget {
  const AllExamView({super.key});

  @override
  State<AllExamView> createState() => _AllExamViewState();
}

class _AllExamViewState extends State<AllExamView> {
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
        if (state.examModel.data.allExam.finalExam.isEmpty) {
          return const Center(
            child: Text("No Final Task"),
          );
        } else {
          return _buildListAllTask(state.examModel);
        }
      } else {
        return const SizedBox.shrink();
      }
    });
  }

  Widget _buildListAllTask(ExamModel examModel) {
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
                    alignment: Alignment.centerLeft, child: Text("Final Exam")),
                Column(
                  children: List.generate(
                      examModel.data.allExam.finalExam.length, (index) {
                    var data = examModel.data.allExam.finalExam[index];
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
                              // SizedBox(
                              //   child: data.image == null
                              //       ? null
                              //       : Container(
                              //           width: width,
                              //           margin: const EdgeInsets.symmetric(
                              //               vertical: 5),
                              //           padding: const EdgeInsets.all(10),
                              //           decoration: BoxDecoration(
                              //               borderRadius:
                              //                   BorderRadius.circular(8),
                              //               image: DecorationImage(
                              //                   image: NetworkImage(hostImage +
                              //                       data.image.toString()))),
                              //         ),
                              // )
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
          _buildMidterExam(examModel),
          _buildQuiz(examModel),
          _buildAssignment(examModel),
        ],
      ),
    );
  }

  Widget _buildMidterExam(ExamModel examModel) {
    if (examModel.data.allExam.midtermExam.isEmpty) {
      return const SizedBox.shrink();
    } else {
      examModel;
    }
    double width = MediaQuery.of(context).size.width;
    return Container(
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
          const Align(alignment: Alignment.centerLeft, child: Text("Midterm")),
          Column(
            children: List.generate(examModel.data.allExam.midtermExam.length,
                (index) {
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
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
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
    );
  }

  Widget _buildQuiz(ExamModel examModel) {
    double width = MediaQuery.of(context).size.width;
    if (examModel.data.allExam.quiz.isEmpty) {
      return const SizedBox.shrink();
    } else {
      examModel;
    }
    return Container(
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
          const Align(alignment: Alignment.centerLeft, child: Text("Quiz")),
          Column(
            children:
                List.generate(examModel.data.allExam.quiz.length, (index) {
              var data = examModel.data.allExam.quiz[index];
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
                        // SizedBox(
                        //   child: data.image == null
                        //       ? null
                        //       : Container(
                        //           width: width,
                        //           margin:
                        //               const EdgeInsets.symmetric(vertical: 5),
                        //           padding: const EdgeInsets.all(10),
                        //           decoration: BoxDecoration(
                        //               borderRadius: BorderRadius.circular(8),
                        //               image: DecorationImage(
                        //                   image: NetworkImage(hostImage +
                        //                       data.image.toString()))),
                        //         ),
                        // )
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildAssignment(ExamModel examModel) {
    double width = MediaQuery.of(context).size.width;
    if (examModel.data.allExam.assignment.isEmpty) {
      return const SizedBox.shrink();
    } else {
      examModel;
    }
    return Container(
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
              alignment: Alignment.centerLeft, child: Text("Assignment")),
          Column(
            children: List.generate(examModel.data.allExam.assignment.length,
                (index) {
              var data = examModel.data.allExam.assignment[index];
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
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
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
    );
  }
}
