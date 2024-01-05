import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_school_system/constant/color.dart';
import 'package:frontend_school_system/util/snack_bar.dart';

import '../../../constant/main_abstract/main_abstract.dart';
import '../../../constant/url_base.dart';
import '../../../model/class_model.dart';
import '../../../model/student_model.dart';
import '../../../view_model/cubit/class_cubit.dart';
import '../../../view_model/cubit/cubit_condition/cubit_state.dart';
import '../../../view_model/cubit/exam_cubit.dart';
import '../../../view_model/cubit/final_exam_cubit.dart';
import '../../../view_model/cubit/major_cubit.dart';

class BillingView extends StatefulWidget {
  const BillingView({super.key});

  @override
  State<BillingView> createState() => _BillingViewState();
}

class _BillingViewState extends State<BillingView> {
  late TextEditingController _classIdCtrl = TextEditingController();
  late TextEditingController _majorCtrl = TextEditingController();
  final TextEditingController _paymentCtrl = TextEditingController();
  late TextEditingController _yearCtrl = TextEditingController();
  List<Student> _student = [];
  List<Classs> province = [];
  int classid = 0;
  int _majorId = 0;
  String _className = '';
  int _yearId = 0;
  String _majorName = '';
  int _studentId = 0;
  String _name = "";
  String _codeId = "";

  double sumUsingLoop(List<double> numbers) {
    double sum = 0;
    for (double number in numbers) {
      sum += number;
    }
    return sum;
  }

  @override
  void initState() {
    // context.read<StudentCubit>().readTypeYear();
    context.read<ExamByIdClass>().readYear();
    super.initState();
  }

  @override
  void dispose() {
    _classIdCtrl.dispose();
    _majorCtrl.dispose();
    _paymentCtrl.dispose();
    _yearCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.01),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "Payment Method",
                    style: TextStyle(
                        fontSize: 20, decoration: TextDecoration.underline),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 5, left: 10),
                    height: height * 0.06,
                    width: width * 0.17,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: BlocBuilder<ExamByIdClass, CubitState>(
                        builder: (context, state) {
                      if (state is YearState) {
                        // var data = state.genderModel;
                        return DropdownButtonFormField(
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 10),
                                border: InputBorder.none,
                                hintText: "Select Year"),
                            items: state.yearModel.data.map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text(e.year.toString()),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              debugPrint("Hello: ${newValue?.id ?? 0}");
                              int id = newValue?.id ?? 0;
                              setState(() {
                                _yearId = id;
                              });
                              _yearCtrl = TextEditingController(
                                  text: _yearId.toString());
                              context
                                  .read<ExamCubit>()
                                  .readMajor(newValue?.id ?? 0);
                            });
                      } else {
                        return DropdownButtonFormField(
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Select Year"),
                            items: province.map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: const Text("No-Year"),
                              );
                            }).toList(),
                            onChanged: (newValue) {});
                      }
                    }),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 5, left: 10),
                      height: height * 0.06,
                      width: width * 0.3,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: BlocBuilder<ExamCubit, CubitState>(
                          builder: (context, state) {
                        if (state is MajorById) {
                          // var data = state.genderModel;
                          return DropdownButtonFormField(
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(bottom: 10),
                                  border: InputBorder.none,
                                  hintText: "Select Major"),
                              items: state.yearByIdModel.data.major.map((e) {
                                return DropdownMenuItem(
                                  value: e,
                                  child: Text(e.majorName.toString()),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                debugPrint("Hello: ${newValue?.id ?? 0}");
                                int id = newValue?.id ?? 0;
                                setState(() {
                                  _majorId = id;
                                  _majorName = newValue?.majorName ?? "";
                                });
                                context
                                    .read<ClassCubit>()
                                    .readMajorById(_majorId);
                                _majorCtrl = TextEditingController(
                                    text: _majorId.toString());
                              });
                        } else {
                          return DropdownButtonFormField(
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Select Major"),
                              items: province.map((e) {
                                return DropdownMenuItem(
                                  value: e,
                                  child: const Text("No-Major"),
                                );
                              }).toList(),
                              onChanged: (newValue) {});
                        }
                      }),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 5, left: 10),
                      height: height * 0.06,
                      width: width * 0.3,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: BlocBuilder<ClassCubit, CubitState>(
                          builder: (context, state) {
                        if (state is MajorByIdState) {
                          // var data = state.genderModel;
                          return DropdownButtonFormField(
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(bottom: 10),
                                  border: InputBorder.none,
                                  hintText: "Select Class"),
                              items:
                                  state.majorByIdModel.data.allClass.map((e) {
                                return DropdownMenuItem(
                                  value: e,
                                  child: Text(e.nameClass.toString()),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                debugPrint("Hello: ${newValue?.id ?? 0}");
                                int id = newValue?.id ?? 0;
                                setState(() {
                                  classid = id;
                                  _className = newValue?.nameClass ?? "";
                                });
                                _classIdCtrl = TextEditingController(
                                    text: classid.toString());
                                context
                                    .read<StudentCubit>()
                                    .readStudent(classid);
                              });
                        } else {
                          return DropdownButtonFormField(
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Select Class"),
                              items: province.map((e) {
                                return DropdownMenuItem(
                                  value: e,
                                  child: const Text("No-province"),
                                );
                              }).toList(),
                              onChanged: (newValue) {});
                        }
                      }),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Major: $_majorName",
                      style: const TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      width: width * 0.05,
                    ),
                    Text(
                      "Class: $_className",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 5, left: 10),
                      height: 30,
                      width: width * 0.1,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: TextField(
                          enabled: false,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Filter",
                              hintStyle: const TextStyle(fontSize: 15),
                              suffixIcon: IconButton(
                                padding: const EdgeInsets.only(top: 2),
                                onPressed: () {},
                                icon: const Icon(Icons.expand_more),
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(bottom: 5, left: 0, right: 15),
                      height: 30,
                      width: width * 0.3,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
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
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                BlocBuilder<StudentCubit, CubitState>(
                    builder: (context, state) {
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
                    var data = state.studentModel.data;
                    return _buildClassWithStudent(data.students);
                  } else {
                    return const SizedBox.shrink();
                  }
                })
              ],
            ),
          ),
        ),
        Container(
          width: 1,
          height: height,
          color: Colors.grey[200],
        ),
        Expanded(
          flex: 1,
          child: Container(
            width: width,
            height: height,
            child: BlocBuilder<MajorCubit, CubitState>(
              builder: (context, state) {
                if (state is LoadingCubitState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ErrorCubitState) {
                  return Center(
                    child: Text(state.error),
                  );
                } else if (state is HistoryPaymentState) {
                  // var payment = state.historyPaymentModel.data!.payments;
                  // sumUsingLoop(payment);
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                  child: Text(
                                "Name: ${_name}",
                                style: TextStyle(fontSize: 14),
                              )),
                              Flexible(child: Text("ID: ${_codeId}")),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "History Payments",
                                style: TextStyle(fontSize: 18),
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                bottom: 15),
                                            width: width * 0.3,
                                            height: height * 0.35,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[100],
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Text('Add Payment'),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 15),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Flexible(
                                                          child: Text(
                                                              'Name: ${_name}')),
                                                      Flexible(
                                                          child: Text(
                                                              'ID: ${_codeId}'))
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin:
                                                      const EdgeInsets.all(15),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  width: width,
                                                  height: height * 0.06,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: Center(
                                                    child: TextField(
                                                      controller: _paymentCtrl,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          const InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText: 'Payment',
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                bottom: 15),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    //add total Payment
                                                    String payment =
                                                        '${_paymentCtrl.text}\$';
                                                    if (payment.isEmpty) {
                                                      snackBar(context,
                                                          "Please Add Payment");
                                                    } else {
                                                      context
                                                          .read<
                                                              FinalExamCubit>()
                                                          .paymentViewModel(
                                                              payment,
                                                              _studentId,
                                                              context);
                                                      context
                                                          .read<StudentCubit>()
                                                          .readStudent(classid);
                                                      context
                                                          .read<MajorCubit>()
                                                          .readHistoryPayment(
                                                              _studentId);
                                                    }
                                                    Future.delayed(
                                                        const Duration(
                                                            milliseconds: 600),
                                                        () {
                                                      _paymentCtrl.text = '';
                                                      payment = '';
                                                    });
                                                  },
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.all(
                                                            15),
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10),
                                                    width: width,
                                                    height: height * 0.06,
                                                    decoration: BoxDecoration(
                                                        color: flex1,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12)),
                                                    child: Center(
                                                      child: BlocBuilder<
                                                              FinalExamCubit,
                                                              CubitState>(
                                                          builder:
                                                              (context, state) {
                                                        if (state
                                                            is LoadingPaymentState) {
                                                          bool isLoading =
                                                              state.isLoading;
                                                          return isLoading
                                                              ? const CircularProgressIndicator(
                                                                  color: Colors
                                                                      .white,
                                                                )
                                                              : const Text(
                                                                  "Payment",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      color: Colors
                                                                          .white),
                                                                );
                                                        } else {
                                                          return const Text(
                                                            "Payment",
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .white),
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
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.green[400],
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Center(
                                    child: Text(
                                      "Add Payment",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: FittedBox(
                            child: DataTable(
                                columns: [
                                  DataColumn(
                                      label: Expanded(
                                          child: Text(
                                    "Number",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.bold),
                                  ))),
                                  DataColumn(
                                      label: Expanded(
                                          child: Text(
                                    "Payment",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.bold),
                                  ))),
                                ],
                                rows: List.generate(
                                    state.historyPaymentModel.data!.payments
                                        .length, (index) {
                                  var data = state.historyPaymentModel.data!
                                      .payments[index];
                                  // double _payment = double.parse(data.totalPayment);
                                  return DataRow(cells: [
                                    DataCell(
                                      Text(
                                        '${index + 1}',
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        data.totalPayment,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ]);
                                })),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _buildClassWithStudent(List<Student> data) {
    _student = [];
    for (var student in data) {
      if (student.role == 'Student' ||
          student.role?.toLowerCase() == 'student') {
        _student.add(student);
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
            style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
                fontWeight: FontWeight.bold),
          ))),
          DataColumn(
              label: Expanded(
                  child: Text(
            "UserName",
            style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
                fontWeight: FontWeight.bold),
          ))),
          DataColumn(
              label: Expanded(
                  child: Text(
            "StudentID",
            style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
                fontWeight: FontWeight.bold),
          ))),
          DataColumn(
              label: Expanded(
                  child: Text(
            "Phone",
            style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
                fontWeight: FontWeight.bold),
          ))),
          DataColumn(
              label: Expanded(
                  child: Text(
            "Image",
            style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
                fontWeight: FontWeight.bold),
          ))),
          DataColumn(
              label: Expanded(
                  child: Text(
            "Gender",
            style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
                fontWeight: FontWeight.bold),
          ))),
          DataColumn(
              label: Expanded(
                  child: Text(
            "Payment Count",
            style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
                fontWeight: FontWeight.bold),
          ))),
        ],
        showCheckboxColumn: false,
        rows: List.generate(_student.length, (index) {
          var students = _student[index];
          return DataRow(
              onSelectChanged: (bool? value) {
                setState(() {
                  _name = _student[index].name ?? "";
                  _codeId = _student[index].codeId ?? "";
                  _studentId = _student[index].id;
                });
                context.read<MajorCubit>().readHistoryPayment(students.id);
              },
              cells: [
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
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: students.image == null
                          ? const DecorationImage(
                              image: AssetImage('assets/imgs/no-profile.png'))
                          : DecorationImage(
                              image: NetworkImage(
                                  hostImage + students.image.toString()),
                              fit: BoxFit.fill)),
                )),
                DataCell(Text(
                  students.sex ?? "",
                  style: const TextStyle(fontSize: 18),
                )),
                DataCell(Text(
                  students.payment ?? "",
                  style: const TextStyle(fontSize: 18),
                ))
              ]);
        }),
      ),
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
}
