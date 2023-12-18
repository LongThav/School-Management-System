import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_school_system/constant/url_base.dart';
import 'package:frontend_school_system/model/student_model.dart';
import 'package:frontend_school_system/model/year_by_id_model.dart';
import 'package:frontend_school_system/model/year_model.dart';
import 'package:frontend_school_system/util/snack_bar.dart';
import 'package:frontend_school_system/view_model/cubit/class_cubit.dart';
import 'package:frontend_school_system/view_model/cubit/cubit_condition/cubit_state.dart';
import 'package:frontend_school_system/view_model/cubit/final_exam_cubit.dart';

import '../../../constant/main_abstract/main_abstract.dart';
import '../../../view_model/cubit/exam_cubit.dart';
import '../../../view_model/cubit/major_cubit.dart';

class MajorView extends StatefulWidget {
  const MajorView({super.key});

  @override
  State<MajorView> createState() => _MajorViewState();
}

class _MajorViewState extends State<MajorView> {
  late final TextEditingController _majorCtrl = TextEditingController();
  late final TextEditingController _classCtrl = TextEditingController();
  late final TextEditingController _yearCtrl = TextEditingController();
  String _majorName = '';
  int _majorId = 0;
  int _yearId = 0;
  String _className = '';
  int classId = 0;
  bool selectBtnSearch = false;
  List<Student> _student = [];
  String _year = '';
  @override
  void initState() {
    // context.read<MajorCubit>().readMajor();
    context.read<ExamByIdClass>().readYear();
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
              height: height,
              width: width,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _className,
                        ),
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
                                      hintText: "Search for a student by name or email",
                                      hintStyle: const TextStyle(fontSize: 15),
                                      prefixIcon: IconButton(
                                        padding: const EdgeInsets.only(top: 2, left: 0),
                                        onPressed: () {},
                                        icon: const Icon(Icons.search),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                selectBtnSearch = !selectBtnSearch;
                              });
                            },
                            icon: const Icon(
                              Icons.search_outlined,
                              color: Colors.grey,
                            ))
                      ],
                    ),
                    BlocBuilder<StudentCubit, CubitState>(builder: (context, state) {
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
                      } else if (state is StudentClassState) {
                        if (state.studentModel.data.students.isEmpty) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: height * 0.4,
                              ),
                              const Text("No Student"),
                            ],
                          );
                        }
                        var data = state.studentModel.data.students;
                        return _buildClassWithStudent(data);
                      } else {
                        return const SizedBox.shrink();
                      }
                    })
                  ],
                ),
              ),
            )),
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
                        context.read<StudentCubit>().readStudent(state.majorByIdModel.data.allClass[index].id);
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

  Widget _buildClassWithStudent(List<Student> student) {
    double height = MediaQuery.of(context).size.height;
    _student = [];
    for (var data in student) {
      if (data.payment != null) {
        _student.add(data);
        if (_student.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.4,
              ),
              const Text(
                "No Student",
                style: TextStyle(fontSize: 18),
              ),
            ],
          );
        } else {
          _student;
        }
      }
    }
    return FittedBox(
      child: DataTable(
        dataRowColor: MaterialStateProperty.resolveWith(_getDataRowColor),
        dataRowHeight: 100,
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
            "UserName",
            style: TextStyle(fontSize: 18, color: Colors.grey[700], fontWeight: FontWeight.bold),
          ))),
          DataColumn(
              label: Expanded(
                  child: Text(
            "StudentID",
            style: TextStyle(fontSize: 18, color: Colors.grey[700], fontWeight: FontWeight.bold),
          ))),
          DataColumn(
              label: Expanded(
                  child: Text(
            "Phone",
            style: TextStyle(fontSize: 18, color: Colors.grey[700], fontWeight: FontWeight.bold),
          ))),
          DataColumn(
              label: Expanded(
                  child: Text(
            "Image",
            style: TextStyle(fontSize: 18, color: Colors.grey[700], fontWeight: FontWeight.bold),
          ))),
          DataColumn(
              label: Expanded(
                  child: Text(
            "Gender",
            style: TextStyle(fontSize: 18, color: Colors.grey[700], fontWeight: FontWeight.bold),
          ))),
          DataColumn(
              label: Expanded(
                  child: Text(
            "Role",
            style: TextStyle(fontSize: 18, color: Colors.grey[700], fontWeight: FontWeight.bold),
          ))),
        ],
        showCheckboxColumn: false,
        rows: List.generate(student.length, (index) {
          var students = student[index];
          return DataRow(onSelectChanged: (bool? value) {}, cells: [
            DataCell(
              Text(
                '${index + 1}',
                style: const TextStyle(fontSize: 18),
              ),
            ),
            DataCell(Text(
              students.name ?? "",
              style: const TextStyle(fontSize: 18),
            )),
            DataCell(Text(
              students.codeId ?? "",
              style: const TextStyle(fontSize: 18),
            )),
            DataCell(Text(
              students.phone ?? "",
              style: const TextStyle(fontSize: 18),
            )),
            DataCell(Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), image: students.image == null ? const DecorationImage(image: AssetImage('assets/imgs/no-profile.png')) : DecorationImage(image: NetworkImage(hostImage + students.image.toString()), fit: BoxFit.fill)),
            )),
            DataCell(Text(
              students.sex ?? "",
              style: const TextStyle(fontSize: 18),
            )),
            DataCell(Text(
              students.role ?? "",
              style: const TextStyle(fontSize: 18),
            ))
          ]);
        }),
      ),
    );
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
          BlocBuilder<ExamByIdClass, CubitState>(builder: (context, state) {
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
