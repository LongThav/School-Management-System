import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_school_system/model/user_by_id_model.dart';
import 'package:frontend_school_system/util/handle_push_view.dart';
import 'package:frontend_school_system/view_model/bloc/auth_bloc.dart';
import 'package:frontend_school_system/view_model/bloc/logic_drop_down.dart';
import 'package:frontend_school_system/view_model/bloc/student_bloc.dart';
import 'package:frontend_school_system/view_model/events/student_event.dart';
import 'package:frontend_school_system/view_model/states/completing_state/student_completing_state.dart';

import '../../../constant/main_abstract/main_abstract.dart';
import '../../../model/class_model.dart';
import '../../../util/snack_bar.dart';
import '../../../view_model/bloc/user_bloc.dart';
import '../../../view_model/cubit/class_cubit.dart';
import '../../../view_model/cubit/cubit_condition/cubit_state.dart';
import '../../../view_model/cubit/exam_cubit.dart';
import '../../../view_model/cubit/major_cubit.dart';
import '../../../view_model/events/auth_event.dart';
import '../../../view_model/events/user_event.dart';
import '../../../view_model/states/completing_state/auth_completing_state.dart';

// ignore: must_be_immutable
class UpdateStudentInforView extends StatefulWidget {
  final int id;
  final UserByIdModel userByIdModel;
  final String name;
  String role;
  String sex;
  UpdateStudentInforView(
      {super.key,
      required this.id,
      required this.userByIdModel,
      required this.name,
      required this.role,
      required this.sex});

  @override
  State<UpdateStudentInforView> createState() => _UpdateStudentInforViewState();
}

class _UpdateStudentInforViewState extends State<UpdateStudentInforView> {
  late TextEditingController _nameCtrl = TextEditingController();
  late TextEditingController _codeIDCtrl = TextEditingController();
  late TextEditingController _ageCtrl = TextEditingController();
  late TextEditingController _cityCtrl = TextEditingController();
  late TextEditingController _khanCtrl = TextEditingController();
  late TextEditingController _sangkatCtrl = TextEditingController();
  late TextEditingController _countryCtrl = TextEditingController();
  late TextEditingController _phoneCtrl = TextEditingController();
  late TextEditingController _userIdCtrl = TextEditingController();
  late TextEditingController _provinceIdCtrl = TextEditingController();
  late TextEditingController _classIdCtrl = TextEditingController();
  late TextEditingController _majorCtrl = TextEditingController();
  late TextEditingController _yearCtrl = TextEditingController();

  List<Classs> province = [];
  List<dynamic> gender = [];
  int provinceId = 0;
  int classid = 0;
  bool selectProvince = false;
  bool selectClass = false;
  int _yearId = 0;
  int _majorId = 0;
  List<dynamic> role = [];
  @override
  void initState() {
    context.read<AuthBloc>().add(ProvinceEvent());
    context.read<StudentBloc>().add(GenderEvent());
    context.read<MajorCubit>().readAllMajor();
    context.read<DropDownBloc>().add(RoleEvent());
    context.read<StudentCubit>().readTypeYear();
    context.read<DropDownLogic>().add(ClassNameEvent());
    _nameCtrl = TextEditingController(text: widget.name);
    _codeIDCtrl = TextEditingController(
        text: widget.userByIdModel.data.userInfor?.codeId ?? " ");
    _ageCtrl = TextEditingController(
        text: widget.userByIdModel.data.userInfor?.age ?? "");
    _cityCtrl = TextEditingController(
        text: widget.userByIdModel.data.userInfor?.city ?? "");
    _khanCtrl = TextEditingController(
        text: widget.userByIdModel.data.userInfor?.khan ?? "");
    _sangkatCtrl = TextEditingController(
        text: widget.userByIdModel.data.userInfor?.sangkat ?? "");
    _countryCtrl = TextEditingController(
        text: widget.userByIdModel.data.userInfor?.country ?? "");
    _phoneCtrl = TextEditingController(
        text: widget.userByIdModel.data.userInfor?.phone ?? "");
    _userIdCtrl = TextEditingController(text: widget.id.toString());
    _provinceIdCtrl = TextEditingController(
        text: widget.userByIdModel.data.provinceId.toString());
    _classIdCtrl = TextEditingController(
        text: widget.userByIdModel.data.classId.toString());
    super.initState();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _codeIDCtrl.dispose();
    _ageCtrl.dispose();
    _cityCtrl.dispose();
    _khanCtrl.dispose();
    _yearCtrl.dispose();
    _sangkatCtrl.dispose();
    _countryCtrl.dispose();
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
                      "Update Information",
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
                              enabled: false,
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
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.only(bottom: 10),
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    color:
                                        selectProvince ? null : Colors.black),
                                hintText: selectProvince
                                    ? "Select Province"
                                    : widget.userByIdModel.data.province
                                        ?.nameProvince,
                              ),
                              items: state.provincModel.data.map((e) {
                                return DropdownMenuItem(
                                  onTap: () {
                                    selectProvince = !selectProvince;
                                  },
                                  value: e,
                                  child: Text(e.nameProvince),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                debugPrint(
                                    "Hello: ${newValue?.id ?? widget.userByIdModel.data.provinceId}");
                                int id = newValue?.id ?? 0;
                                setState(() {
                                  provinceId = id;
                                });
                                if (provinceId == 0) {
                                  _provinceIdCtrl;
                                } else {
                                  _provinceIdCtrl = TextEditingController(
                                      text: provinceId.toString());
                                }
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
                      width: width * 0.15,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: BlocBuilder<DropDownBloc, ApplicationState>(
                          builder: (context, state) {
                        if (state is RoleState) {
                          return DropdownButtonFormField(
                              decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.only(bottom: 10),
                                  border: InputBorder.none,
                                  hintText: widget.role.isEmpty
                                      ? "Please select user role"
                                      : widget.role,
                                  hintStyle: widget.role.isEmpty
                                      ? const TextStyle()
                                      : const TextStyle(color: Colors.black)),
                              items: state.roleModel.role.map((e) {
                                return DropdownMenuItem(
                                  value: e,
                                  child: Text(e.name ?? "No-Role"),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                debugPrint("Hello: ${newValue?.id ?? 0}");
                                String role = newValue?.name ?? "";
                                setState(() {
                                  widget.role = role;
                                });
                              });
                        } else {
                          return DropdownButtonFormField(
                              decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.only(bottom: 10),
                                  border: InputBorder.none,
                                  hintText: widget.role.isEmpty
                                      ? "Please select user role"
                                      : widget.role,
                                  hintStyle: widget.role.isEmpty
                                      ? const TextStyle()
                                      : const TextStyle(color: Colors.black)),
                              items: role.map((e) {
                                return DropdownMenuItem(
                                  value: e,
                                  child: Text(e.name ?? "No-Role"),
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
                      width: width * 0.15,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: BlocBuilder<StudentBloc, ApplicationState>(
                          builder: (context, state) {
                        if (state is GenderState) {
                          // var data = state.genderModel;
                          return DropdownButtonFormField(
                              decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.only(bottom: 10),
                                  border: InputBorder.none,
                                  hintStyle: widget.sex.isEmpty
                                      ? const TextStyle()
                                      : const TextStyle(color: Colors.black),
                                  hintText: widget.sex.isEmpty
                                      ? "No Gender"
                                      : widget.sex),
                              items: state.genderModel.data.map((e) {
                                return DropdownMenuItem(
                                  value: e,
                                  child: Text(e.sex ?? "No-Sex"),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                debugPrint("Hello: ${newValue?.id ?? 0}");
                                setState(() {
                                  widget.sex = newValue?.sex ?? "";
                                });
                              });
                        } else {
                          return DropdownButtonFormField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                      const EdgeInsets.only(bottom: 10),
                                  hintStyle: widget.sex.isEmpty
                                      ? const TextStyle()
                                      : const TextStyle(color: Colors.black),
                                  hintText: widget.sex.isEmpty
                                      ? "Please select Gender"
                                      : widget.sex),
                              items: gender.map((e) {
                                return DropdownMenuItem(
                                  value: e,
                                  child: Text(e.sex ?? "No-Gender"),
                                );
                              }).toList(),
                              onChanged: (newValue) {});
                        }
                      }),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
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
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              InkWell(
                onTap: () {
                  debugPrint("Role: ${widget.role}");
                  debugPrint("Sex: ${widget.sex}");
                  if (_ageCtrl.text.isEmpty) {
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
                  } else {
                    context.read<StudentBloc>().add(UpdateuserInforEvent(
                        id: widget.userByIdModel.data.userInfor?.id ?? 0,
                        age: _ageCtrl.text,
                        city: _cityCtrl.text,
                        context: context,
                        khan: _khanCtrl.text,
                        sangkat: _sangkatCtrl.text,
                        sex: widget.sex,
                        majorId: _majorCtrl.text,
                        role: widget.role,
                        country: _countryCtrl.text,
                        yearId: _yearCtrl.text,
                        phone: _phoneCtrl.text,
                        userId: widget.id.toString(),
                        provinceId: _provinceIdCtrl.text,
                        classId: _classIdCtrl.text));
                    context.read<UserBloc>().add(UserEvent());
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
                            if (state is LoadingUpdateState) {
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
