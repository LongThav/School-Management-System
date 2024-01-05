import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_school_system/util/handle_push_view.dart';
import 'package:frontend_school_system/util/snack_bar.dart';
import 'package:frontend_school_system/view_model/bloc/auth_bloc.dart';
import 'package:frontend_school_system/view_model/bloc/logic_drop_down.dart';
import 'package:frontend_school_system/view_model/bloc/student_bloc.dart';
import 'package:frontend_school_system/view_model/cubit/class_cubit.dart';
import 'package:frontend_school_system/view_model/events/student_event.dart';
import 'package:frontend_school_system/view_model/states/completing_state/student_completing_state.dart';

import '../../../constant/main_abstract/main_abstract.dart';
import '../../../model/class_model.dart';
import '../../../view_model/cubit/cubit_condition/cubit_state.dart';
import '../../../view_model/cubit/exam_cubit.dart';

class AddStudentInforView extends StatefulWidget {
  final String sex;
  final String role;
  final String name;
  final int id;
  const AddStudentInforView(
      {super.key,
      required this.id,
      required this.name,
      required this.sex,
      required this.role});

  @override
  State<AddStudentInforView> createState() => _AddStudentInforViewState();
}

class _AddStudentInforViewState extends State<AddStudentInforView> {
  late TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _codeIDCtrl = TextEditingController();
  final TextEditingController _ageCtrl = TextEditingController();
  final TextEditingController _cityCtrl = TextEditingController();
  final TextEditingController _khanCtrl = TextEditingController();
  final TextEditingController _sangkatCtrl = TextEditingController();
  final TextEditingController _countryCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _userIdCtrl = TextEditingController();
  late TextEditingController _provinceIdCtrl = TextEditingController();
  late TextEditingController _classIdCtrl = TextEditingController();
  late TextEditingController _majorCtrl = TextEditingController();
  late TextEditingController _yearCtrl = TextEditingController();
  List<Classs> province = [];
  int provinceId = 0;
  int classid = 0;
  int _majorId = 0;
  int _yearId = 0;
  @override
  void initState() {
    context.read<AuthBloc>().add(ProvinceEvent());
    context.read<DropDownLogic>().add(ClassNameEvent());
    // context.read<MajorCubit>().readAllMajor();
    context.read<StudentCubit>().readTypeYear();
    _nameCtrl = TextEditingController(text: widget.name);
    super.initState();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _codeIDCtrl.dispose();
    _ageCtrl.dispose();
    _cityCtrl.dispose();
    _khanCtrl.dispose();
    _sangkatCtrl.dispose();
    _yearCtrl.dispose();
    _countryCtrl.dispose();
    _majorCtrl.dispose();
    _phoneCtrl.dispose();
    _userIdCtrl.dispose();
    _provinceIdCtrl.dispose();
    _classIdCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        width: width * 0.7,
        height: height * 0.8,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.014),
                    child: Text(
                      "Add Information",
                      style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        popView(context);
                      },
                      icon: const Icon(
                        Icons.clear_outlined,
                        color: Colors.grey,
                      )),
                ],
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Padding(
                padding: EdgeInsets.only(left: width * 0.014),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Text(
                        'Manually',
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        'Import CSV',
                        style: TextStyle(fontSize: 15, color: Colors.blue[700]),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.014),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 5, left: 10),
                      height: height * 0.06,
                      width: width * 0.22,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: TextField(
                          controller: _nameCtrl,
                          decoration: const InputDecoration(
                              enabled: false,
                              border: InputBorder.none,
                              hintText: 'Add Student Name'),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 5, left: 10),
                      height: height * 0.06,
                      width: width * 0.22,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: TextField(
                          controller: _codeIDCtrl,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Add Student ID'),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 5, left: 10),
                      height: height * 0.06,
                      width: width * 0.1,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: TextField(
                        controller: _ageCtrl,
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: 'Add Age'),
                      )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.014),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 5, left: 10),
                      height: height * 0.06,
                      width: width * 0.15,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: TextField(
                        controller: _khanCtrl,
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: 'Add Khan'),
                      )),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 5, left: 10),
                      height: height * 0.06,
                      width: width * 0.15,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: TextField(
                        controller: _cityCtrl,
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: 'Add City'),
                      )),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 5, left: 10),
                      height: height * 0.06,
                      width: width * 0.15,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: TextField(
                        controller: _sangkatCtrl,
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: 'Add Sangkat'),
                      )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.014),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 5, left: 10),
                      height: height * 0.06,
                      width: width * 0.22,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: TextField(
                          controller: _phoneCtrl,
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: 'Add Phone'),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 5, left: 10),
                      height: height * 0.06,
                      width: width * 0.15,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: TextField(
                        controller: _countryCtrl,
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: 'Add Country'),
                      )),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 5, left: 10),
                      height: height * 0.06,
                      width: width * 0.17,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: BlocBuilder<AuthBloc, ApplicationState>(
                          builder: (context, state) {
                        if (state is ProvinceState) {
                          // var data = state.genderModel;
                          return DropdownButtonFormField(
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(bottom: 10),
                                  border: InputBorder.none,
                                  hintText: "Select Province"),
                              items: state.provincModel.data.map((e) {
                                return DropdownMenuItem(
                                  value: e,
                                  child: Text(e.nameProvince),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                debugPrint("Hello: ${newValue?.id ?? 0}");
                                int id = newValue?.id ?? 0;
                                setState(() {
                                  provinceId = id;
                                });
                                _provinceIdCtrl = TextEditingController(
                                    text: provinceId.toString());
                              });
                        } else {
                          return DropdownButtonFormField(
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Select Province"),
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
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.014),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 5, left: 10),
                      height: height * 0.06,
                      width: width * 0.17,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: BlocBuilder<StudentCubit, CubitState>(
                          builder: (context, state) {
                        if (state is TypeYearState) {
                          // var data = state.genderModel;
                          return DropdownButtonFormField(
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(bottom: 10),
                                  border: InputBorder.none,
                                  hintText: "Select Year"),
                              items: state.typeYearModel.data.map((e) {
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
                                _yearCtrl = TextEditingController(text: _yearId.toString());
                                 context.read<ExamCubit>().readMajor(newValue?.id ?? 0);
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
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 5, left: 10),
                      height: height * 0.06,
                      width: width * 0.17,
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
                      width: width * 0.17,
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
                                });
                                _classIdCtrl = TextEditingController(
                                    text: classid.toString());
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
                    const SizedBox(
                      width: 20,
                    ),
                    // Container(
                    //   padding: const EdgeInsets.only(bottom: 5, left: 10),
                    //   height: height * 0.06,
                    //   width: width * 0.15,
                    //   decoration: BoxDecoration(
                    //       border: Border.all(width: 1, color: Colors.grey),
                    //       borderRadius: BorderRadius.circular(10)),
                    //   child: const Center(
                    //       child: TextField(
                    //     decoration: InputDecoration(
                    //         enabled: false,
                    //         border: InputBorder.none,
                    //         hintText: 'Add Other'),
                    //   )),
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              InkWell(
                onTap: () {
                  debugPrint("MjorId: ${_majorCtrl.text}");
                  debugPrint("ClassId: $classid");
                  if (_nameCtrl.text.isEmpty) {
                    snackBar(context, "Please Add Name");
                  } else if (_codeIDCtrl.text.isEmpty) {
                    snackBar(context, "Please Add CodeID");
                  } else if (_majorCtrl.text.isEmpty) {
                    snackBar(context, "Please select Major");
                  } else if (_ageCtrl.text.isEmpty) {
                    snackBar(context, "Pease Add Age");
                  } else if (_khanCtrl.text.isEmpty) {
                    snackBar(context, "Please Add Khan");
                  } else if (_cityCtrl.text.isEmpty) {
                    snackBar(context, "Please Add City");
                  } else if (_sangkatCtrl.text.isEmpty) {
                    snackBar(context, "Please Add Sangkat");
                  } else if (_phoneCtrl.text.isEmpty) {
                    snackBar(context, "Please Add Phone");
                  } else if (_countryCtrl.text.isEmpty) {
                    snackBar(context, "Please Add Country");
                  } else if (_provinceIdCtrl.text.isEmpty) {
                    snackBar(context, "Please Select Province");
                  } else if (_classIdCtrl.text.isEmpty) {
                    snackBar(context, "Please Select Class");
                  } else if (_yearCtrl.text.isEmpty) {
                    snackBar(context, "Please Select Year");
                  } else {
                    debugPrint("YearId: ${_yearCtrl.text}");
                    context.read<StudentBloc>().add(AddInforStudent(
                        name: _nameCtrl.text,
                        codeId: _codeIDCtrl.text,
                        age: _ageCtrl.text,
                        city: _cityCtrl.text,
                        context: context,
                        majorId: _majorCtrl.text,
                        khan: _khanCtrl.text,
                        sangkat: _sangkatCtrl.text,
                        yearId: _yearCtrl.text,
                        country: _countryCtrl.text,
                        phone: _phoneCtrl.text,
                        userId: widget.id.toString(),
                        provinceId: _provinceIdCtrl.text,
                        role: widget.role,
                        sex: widget.sex,
                        classId: _classIdCtrl.text));
                  }
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.014),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[200],
                      ),
                      child: Center(
                        child: BlocBuilder<StudentBloc, ApplicationState>(
                          builder: (context, state) {
                            if (state is AddStudentInforState) {
                              bool isLoading = state.isLoading;
                              return isLoading
                                  ? const CircularProgressIndicator()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.add_outlined),
                                        Text("Add Student"),
                                      ],
                                    );
                            } else {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.add_outlined),
                                  Text("Add Student"),
                                ],
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
