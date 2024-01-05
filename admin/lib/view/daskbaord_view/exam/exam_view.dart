import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_school_system/constant/url_base.dart';
import 'package:frontend_school_system/util/snack_bar.dart';
import 'package:frontend_school_system/view/daskbaord_view/exam/assignment_view.dart';
import 'package:frontend_school_system/view/daskbaord_view/exam/quiz_view.dart';
import 'package:frontend_school_system/view_model/cubit/class_cubit.dart';
import 'package:frontend_school_system/view_model/cubit/cubit_condition/cubit_state.dart';

import '../../../constant/main_abstract/main_abstract.dart';
import '../../../model/year_by_id_model.dart';
import '../../../model/year_model.dart';
import '../../../view_model/cubit/exam_cubit.dart';
import '../../../view_model/cubit/final_exam_cubit.dart';
import '../../../view_model/cubit/major_cubit.dart';
import 'all_exam_view.dart';
import 'attendance_view.dart';
import 'final_exam_view.dart';
import 'midterm_view.dart';

class ExameView extends StatefulWidget {
  const ExameView({super.key});

  @override
  State<ExameView> createState() => _ExameViewState();
}

class _ExameViewState extends State<ExameView> {
  final PageController _pageController = PageController();
  late final TextEditingController _majorCtrl = TextEditingController();
  late final TextEditingController _classCtrl = TextEditingController();
  late final TextEditingController _titleCtrl = TextEditingController();
  late final TextEditingController _imageCtrl = TextEditingController();
  late final TextEditingController _yearCtrl = TextEditingController();
  final TextEditingController _dateTimeCtrl = TextEditingController();

  String _majorName = '';
  int _majorId = 0;
  String _className = '';
  int classId = 0;
  bool selectBtnSearch = false;
  String _year = '';
  int _yearId = 0;
  int _selectTaskModul = 0;

  List<String> taskModul = [
    'All Task',
    'Final Exam',
    'Midterm',
    'Quiz',
    'Assigment',
    'Attendance',
  ];

  @override
  void initState() {
    context.read<StudentCubit>().readYear();
    context.read<MajorCubit>().readMajor();
    if (_majorId == 0) {
      return;
    } else {
      context.read<ClassCubit>().readMajorById(_majorId);
    }
    super.initState();
  }

  @override
  void dispose() {
    _majorCtrl.dispose();
    _classCtrl.dispose();
    _pageController.dispose();
    _dateTimeCtrl.dispose();
    _titleCtrl.dispose();
    _imageCtrl.dispose();
    _yearCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildView(),
    );
  }

  Widget _buildView() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: SizedBox(
            width: width,
            height: height,
            child: _buildYear(),
          ),
        ),
        Container(
          width: 1,
          height: height,
          color: Colors.grey[200],
        ),
        Expanded(
          flex: 1,
          child: SizedBox(
            width: width,
            height: height,
            child: _buildMajor(),
          ),
        ),
        Container(
          width: 1,
          height: height,
          color: Colors.grey[200],
        ),
        Expanded(
          flex: 1,
          child: SizedBox(
            width: width,
            height: height,
            child: _buildClass(),
          ),
        ),
        Container(
          width: 1,
          height: height,
          color: Colors.grey[200],
        ),
        Expanded(
          flex: 3,
          child: SizedBox(
            width: width,
            height: height,
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_className),
                        selectBtnSearch
                            ? Container(
                                padding: const EdgeInsets.only(bottom: 5, left: 0, right: 15),
                                height: 30,
                                width: width * 0.3,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Search Task",
                                      hintStyle: const TextStyle(fontSize: 15),
                                      prefixIcon: IconButton(
                                        padding: const EdgeInsets.only(top: 2, left: 0),
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.search,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    selectBtnSearch = !selectBtnSearch;
                                  });
                                },
                                icon: const Icon(
                                  Icons.search_outlined,
                                  color: Colors.grey,
                                )),
                            SizedBox(
                              child: _selectTaskModul == 1
                                  ? IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Dialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: SizedBox(
                                                  width: width * 0.4,
                                                  height: height * 0.3,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      const Text(
                                                        "Create final exam",
                                                        style: TextStyle(fontSize: 18),
                                                      ),
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets.symmetric(horizontal: 15),
                                                        width: width,
                                                        height: height * 0.05,
                                                        decoration: BoxDecoration(
                                                          border: Border.all(color: Colors.grey),
                                                          borderRadius: BorderRadius.circular(8),
                                                        ),
                                                        child: Center(
                                                          child: TextField(
                                                            controller: _titleCtrl,
                                                            decoration: const InputDecoration(
                                                              border: InputBorder.none,
                                                              contentPadding: EdgeInsets.only(bottom: 18, left: 10),
                                                              hintText: "Time",
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets.symmetric(horizontal: 15),
                                                        width: width,
                                                        height: height * 0.05,
                                                        decoration: BoxDecoration(
                                                          border: Border.all(color: Colors.grey),
                                                          borderRadius: BorderRadius.circular(8),
                                                        ),
                                                        child: Center(
                                                          child: TextField(
                                                            controller: _titleCtrl,
                                                            decoration: const InputDecoration(
                                                              border: InputBorder.none,
                                                              contentPadding: EdgeInsets.only(bottom: 18, left: 10),
                                                              hintText: "Add Link Exam",
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          // debugPrint("SubjectId: $subJectById");
                                                          // if (_titleCtrl.text.isEmpty) {
                                                          //   snackBar(context, "Please write something...");
                                                          // } else if (classId == 0) {
                                                          //   snackBar(context, "Please select className");
                                                          // } else {
                                                          //   context.read<FinalExamCubit>().addFinalExam(_titleCtrl.text, classId, context);
                                                          //   context.read<ExamByIdClass>().readExam(classId);
                                                          // }
                                                          // Future.delayed(const Duration(milliseconds: 600), () {
                                                          //   _titleCtrl.text = "";
                                                          // });
                                                        },
                                                        child: Container(
                                                          margin: const EdgeInsets.symmetric(horizontal: 15),
                                                          width: width,
                                                          height: height * 0.05,
                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: const Color(0XFF33b6ff)),
                                                          child: Center(
                                                            child: BlocBuilder<FinalExamCubit, CubitState>(builder: (context, state) {
                                                              if (state is LoadingAddFinalExam) {
                                                                bool isLoading = state.isLoading;
                                                                return isLoading
                                                                    ? const CircularProgressIndicator(
                                                                        color: Colors.white,
                                                                      )
                                                                    : const Text(
                                                                        "Upload Final Exam",
                                                                        style: TextStyle(color: Colors.white, fontSize: 18),
                                                                      );
                                                              } else {
                                                                return const Text(
                                                                  "Upload Final Exam",
                                                                  style: TextStyle(color: Colors.white, fontSize: 18),
                                                                );
                                                              }
                                                            }),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                      },
                                      icon: const Icon(
                                        Icons.add,
                                        color: Colors.grey,
                                      ))
                                  : null,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  BlocBuilder<ExamByIdClass, CubitState>(builder: (context, state) {
                    if (state is ExamState) {
                      return Container(alignment: Alignment.center, width: width, height: 40, child: _buildListTask());
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
                  SizedBox(
                    width: width,
                    height: height * 0.85,
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (value) {
                        setState(() {
                          _selectTaskModul == value;
                        });
                      },
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(
                          width: width,
                          height: height,
                          child: const AllExamView(),
                        ),
                        SizedBox(
                          width: width,
                          height: height,
                          child: FinalExamView(
                            classId: classId,
                          ),
                        ),
                        SizedBox(
                          width: width,
                          height: height,
                          child: const MidtermView(),
                        ),
                        SizedBox(
                          width: width,
                          height: height,
                          child: const QuizeView(),
                        ),
                        SizedBox(
                          width: width,
                          height: height,
                          child: const AssignmentView(),
                        ),
                        SizedBox(
                          width: width,
                          height: height,
                          child: const AttendanceView(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMajor() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_year),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: SizedBox(
                            width: width * 0.3,
                            height: height * 0.3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Create Major",
                                  style: TextStyle(fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 15),
                                  width: width,
                                  height: height * 0.05,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: TextField(
                                      controller: _majorCtrl,
                                      decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.only(bottom: 18, left: 10), hintText: "Add Major"),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                InkWell(
                                  onTap: () {
                                    if (_majorCtrl.text.isEmpty) {
                                      snackBar(context, "Please Create Major");
                                    } else if (_yearId == 0) {
                                      snackBar(context, "Please Selct Major");
                                    } else {
                                      context.read<MajorCubit>().createMajor(_majorCtrl.text, _yearId, context);
                                    }
                                    context.read<ExamCubit>().readMajor(_yearId);
                                    _majorCtrl.text = "";
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 15),
                                    width: width,
                                    height: height * 0.05,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: const Color(0XFF33b6ff)),
                                    child: Center(
                                      child: BlocBuilder<MajorCubit, CubitState>(
                                        builder: (context, state) {
                                          if (state is LoadingCreateMajoCubitrState) {
                                            bool isLoading = state.isLoading;
                                            return isLoading
                                                ? const CircularProgressIndicator(
                                                    color: Colors.white,
                                                  )
                                                : const Text(
                                                    "Create Major",
                                                    style: TextStyle(fontSize: 18, color: Colors.white),
                                                  );
                                          } else {
                                            return const Text(
                                              "Create Major",
                                              style: TextStyle(fontSize: 18, color: Colors.white),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },
                child: const Icon(
                  Icons.add_outlined,
                  color: Color(0XFF33b6ff),
                ),
              ),
            ],
          ),
          BlocBuilder<ExamCubit, CubitState>(builder: (context, state) {
            if (state is LoadingCubitState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * 0.4,
                  ),
                  const CircularProgressIndicator(),
                ],
              );
            } else if (state is ErrorCubitState) {
              String err = state.error;
              return Center(
                child: Text(err),
              );
            } else if (state is MajorById) {
              if (state.yearByIdModel.data.major.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height * 0.4,
                    ),
                    const Text("No Major")
                  ],
                );
              } else {
                return _buildTable(state.yearByIdModel);
              }
            } else {
              return const SizedBox.shrink();
            }
          }),
        ],
      ),
    );
  }

  Widget _buildTable(YearByIdModel yearByIdModel) {
    return FittedBox(
      child: DataTable(
          dataRowColor: MaterialStateProperty.resolveWith(_getDataRowColor),
          columns: [
            DataColumn(
                label: Expanded(
                    child: Text(
              "Numers",
              style: TextStyle(fontSize: 18, color: Colors.grey[700], fontWeight: FontWeight.bold),
            ))),
            DataColumn(
                label: Expanded(
                    child: Text(
              "Majors",
              style: TextStyle(fontSize: 18, color: Colors.grey[700], fontWeight: FontWeight.bold),
            ))),
          ],
          showCheckboxColumn: false,
          rows: List.generate(yearByIdModel.data.major.length, (index) {
            var data = yearByIdModel.data.major[index];
            return DataRow(
              onSelectChanged: (bool? value) {
                setState(() {
                  _majorName = data.majorName;
                  _majorId = data.id;
                });
                context.read<ClassCubit>().readMajorById(data.id);
              },
              cells: [
                DataCell(Text('${index + 1}')),
                DataCell(Text(data.majorName)),
              ],
            );
          })),
    );
  }

  Color _getDataRowColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue.withOpacity(0.5);
    }
    return Colors.transparent;
  }

  Widget _buildClass() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  child: Text(
                _majorName,
              )),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: SizedBox(
                              width: width * 0.3,
                              height: height * 0.3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Create Class",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 15),
                                    width: width,
                                    height: height * 0.05,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: TextField(
                                        controller: _classCtrl,
                                        decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.only(bottom: 18, left: 10), hintText: "Add Class"),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        if (_majorId == 0) {
                                          snackBar(context, "Please select your major");
                                        } else if (_classCtrl.text.isEmpty) {
                                          snackBar(context, "Please create class");
                                        } else {
                                          context.read<MajorCubit>().crateClass(_classCtrl.text, _majorId, context);
                                        }
                                        Future.delayed(const Duration(milliseconds: 500), () {
                                          _classCtrl.text = "";
                                        });
                                        context.read<ClassCubit>().readMajorById(_majorId);
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 15),
                                        width: width,
                                        height: height * 0.05,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: const Color(0XFF33b6ff)),
                                        child: Center(
                                          child: BlocBuilder<MajorCubit, CubitState>(
                                            builder: (context, state) {
                                              if (state is AddClassLoadingCubitState) {
                                                bool isLoading = state.isLoading;
                                                return isLoading
                                                    ? const CircularProgressIndicator()
                                                    : const Text(
                                                        "Create Class",
                                                        style: TextStyle(color: Colors.white, fontSize: 18),
                                                      );
                                              } else {
                                                return const Text(
                                                  "Create Class",
                                                  style: TextStyle(fontSize: 18, color: Colors.white),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: const Icon(
                    Icons.add_outlined,
                    color: Color(0XFF33b6ff),
                  ),
                ),
              ),
            ],
          ),
          BlocBuilder<ClassCubit, CubitState>(builder: (context, state) {
            if (state is LoadingCubitState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * 0.4,
                  ),
                  const CircularProgressIndicator(),
                ],
              );
            } else if (state is ErrorCubitState) {
              return Center(
                child: Text(state.error),
              );
            } else if (state is MajorByIdState) {
              if (state.majorByIdModel.data.allClass.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height * 0.4,
                    ),
                    const Text("No Class")
                  ],
                );
              }
              return FittedBox(
                child: DataTable(
                  dataRowColor: MaterialStateProperty.resolveWith(_getDataRowColor),
                  columns: [
                    DataColumn(
                        label: Expanded(
                            child: Text(
                      "Numers",
                      style: TextStyle(fontSize: 18, color: Colors.grey[700], fontWeight: FontWeight.bold),
                    ))),
                    DataColumn(
                        label: Expanded(
                            child: Text(
                      "Classs",
                      style: TextStyle(fontSize: 18, color: Colors.grey[700], fontWeight: FontWeight.bold),
                    ))),
                  ],
                  showCheckboxColumn: false,
                  rows: List.generate(state.majorByIdModel.data.allClass.length, (index) {
                    return DataRow(
                      onSelectChanged: (bool? value) {
                        setState(() {
                          _className = state.majorByIdModel.data.allClass[index].nameClass ?? "";
                          classId = state.majorByIdModel.data.allClass[index].id;
                        });
                        context.read<ExamByIdClass>().readExam(state.majorByIdModel.data.allClass[index].id);
                      },
                      cells: [
                        DataCell(Text('${index + 1}')),
                        DataCell(Text(state.majorByIdModel.data.allClass[index].nameClass ?? "")),
                      ],
                    );
                  }),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          })
        ],
      ),
    );
  }

  Widget _buildListTask() {
    return ListView.builder(
        itemCount: taskModul.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              setState(() {
                _selectTaskModul = index;
              });
              _pageController.jumpToPage(index);
            },
            child: Container(
              margin: const EdgeInsets.only(
                left: 15,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: _selectTaskModul == index ? const Color(0XFF33b6ff) : null),
              child: Center(
                child: Text(
                  taskModul[index],
                  style: TextStyle(color: _selectTaskModul == index ? Colors.white : null),
                ),
              ),
            ),
          );
        });
  }

  Widget _buildYear() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: SizedBox(
                          width: width * 0.3,
                          height: height * 0.3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Create Year",
                                style: TextStyle(fontSize: 18),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 15),
                                width: width,
                                height: height * 0.05,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: TextField(
                                    controller: _yearCtrl,
                                    decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.only(bottom: 18, left: 10), hintText: "Add Year"),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              InkWell(
                                onTap: () {
                                  if (_yearCtrl.text.isEmpty) {
                                    snackBar(context, "Please Create Year");
                                  } else {
                                    final Map<String, dynamic> data = {
                                      'year': _yearCtrl.text
                                    };
                                    context.read<FinalExamCubit>().createYear(data, context);
                                    context.read<ExamByIdClass>().readYear();
                                  }
                                  _yearCtrl.text = "";
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 15),
                                  width: width,
                                  height: height * 0.05,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: const Color(0XFF33b6ff)),
                                  child: Center(
                                    child: BlocBuilder<FinalExamCubit, CubitState>(
                                      builder: (context, state) {
                                        if (state is CreateYearLoading) {
                                          bool isLoading = state.isLoading;
                                          return isLoading
                                              ? const CircularProgressIndicator(
                                                  color: Colors.white,
                                                )
                                              : const Text(
                                                  "Create Year",
                                                  style: TextStyle(fontSize: 18, color: Colors.white),
                                                );
                                        } else {
                                          return const Text(
                                            "Create Year",
                                            style: TextStyle(fontSize: 18, color: Colors.white),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
              child: const Icon(
                Icons.add_outlined,
                color: Color(0XFF33b6ff),
              ),
            ),
          ),
          BlocBuilder<StudentCubit, CubitState>(builder: (context, state) {
            if (state is InitializeCubitState || state is LoadingCubitState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * 0.4,
                  ),
                  const CircularProgressIndicator(),
                ],
              );
            } else if (state is ErrorCubitState) {
              String err = state.error;
              return Center(
                child: Text(err),
              );
            } else if (state is YearState) {
              return _buildTableYear(state.yearModel);
            } else {
              return const SizedBox.shrink();
            }
          }),
        ],
      ),
    );
  }

  Widget _buildTableYear(YearModel yearModel) {
    return FittedBox(
      child: DataTable(
          dataRowColor: MaterialStateProperty.resolveWith(_getDataRowColor),
          columns: [
            DataColumn(
                label: Expanded(
                    child: Text(
              "Numers",
              style: TextStyle(fontSize: 18, color: Colors.grey[700], fontWeight: FontWeight.bold),
            ))),
            DataColumn(
                label: Expanded(
                    child: Text(
              "Years",
              style: TextStyle(fontSize: 18, color: Colors.grey[700], fontWeight: FontWeight.bold),
            ))),
          ],
          showCheckboxColumn: false,
          rows: List.generate(yearModel.data.length, (index) {
            return DataRow(
              onSelectChanged: (bool? value) {
                setState(() {
                  _year = yearModel.data[index].year;
                  _yearId = yearModel.data[index].id;
                });
                context.read<ExamCubit>().readMajor(yearModel.data[index].id);
              },
              cells: [
                DataCell(Text('${index + 1}')),
                DataCell(Text(yearModel.data[index].year)),
              ],
            );
          })),
    );
  }
}
