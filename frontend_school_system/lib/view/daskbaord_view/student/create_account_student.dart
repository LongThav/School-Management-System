import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_school_system/constant/color.dart';
import 'package:frontend_school_system/util/snack_bar.dart';
import 'package:frontend_school_system/view_model/bloc/student_bloc.dart';
import 'package:frontend_school_system/view_model/events/student_event.dart';

import '../../../constant/main_abstract/main_abstract.dart';
import '../../../model/gender_model.dart';
import '../../../model/role_model.dart';
import '../../../view_model/bloc/logic_drop_down.dart';
import '../../../view_model/bloc/user_bloc.dart';
import '../../../view_model/events/auth_event.dart';
import '../../../view_model/states/completing_state/auth_completing_state.dart';
import '../../../view_model/states/completing_state/student_completing_state.dart';

class CreateAccountDailog extends StatefulWidget {
  const CreateAccountDailog({super.key});

  @override
  State<CreateAccountDailog> createState() => _CreateAccountDailogState();
}

class _CreateAccountDailogState extends State<CreateAccountDailog> {
  final TextEditingController _userNameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  late TextEditingController _roleCtrl = TextEditingController();
  late TextEditingController _sexCtrl = TextEditingController();
  int roleId = 0;
  int genderId = 0;
  bool secure = true;
  List<Gender> gender = [];
  List<Role> role = [];
  @override
  void initState() {
    context.read<UserBloc>().add(RoleEvent());
    context.read<DropDownLogic>().add(GenderEvent());
    super.initState();
  }

  @override
  void dispose() {
    _userNameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _sexCtrl.dispose();
    _roleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: width * 0.5,
        height: height * 0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: width,
              decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey), borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: TextField(
                  controller: _userNameCtrl,
                  decoration: const InputDecoration(border: InputBorder.none, hintText: 'Add Student Name'),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: width,
              decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey), borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: TextField(
                  controller: _emailCtrl,
                  decoration: const InputDecoration(border: InputBorder.none, hintText: 'Add Student Email'),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: width,
              decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey), borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: TextField(
                  controller: _passwordCtrl,
                  obscureText: secure,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Add Student Password',
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              secure = !secure;
                            });
                          },
                          icon: secure ? const Icon(Icons.lock_outline) : const Icon(Icons.lock_open))),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: width,
              decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey), borderRadius: BorderRadius.circular(10)),
              child: BlocBuilder<UserBloc, ApplicationState>(builder: (context, state) {
                if (state is RoleState) {
                  return DropdownButtonFormField(
                      decoration: const InputDecoration(border: InputBorder.none, hintText: "Please select user role"),
                      items: state.roleModel.role.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(e.name ?? "No-Role"),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        debugPrint("Hello: ${newValue?.id ?? 0}");
                        int id = newValue?.id ?? 0;
                        setState(() {
                          roleId = id;
                        });
                        _roleCtrl = TextEditingController(text: roleId.toString());
                      });
                } else {
                  return DropdownButtonFormField(
                      decoration: const InputDecoration(border: InputBorder.none, hintText: "Please select user role"),
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
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: width,
              decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey), borderRadius: BorderRadius.circular(10)),
              child: BlocBuilder<DropDownLogic, ApplicationState>(builder: (context, state) {
                if (state is GenderState) {
                  // var data = state.genderModel;
                  return DropdownButtonFormField(
                      decoration: const InputDecoration(border: InputBorder.none, hintText: "Please select Gender"),
                      items: state.genderModel.data.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(e.sex ?? "No-Sex"),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        debugPrint("Hello: ${newValue?.id ?? 0}");
                        int id = newValue?.id ?? 0;
                        setState(() {
                          genderId = id;
                        });
                        _sexCtrl = TextEditingController(text: genderId.toString());
                      });
                } else {
                  return DropdownButtonFormField(
                      decoration: const InputDecoration(border: InputBorder.none, hintText: "Please select Gender"),
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
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                // popView(context);
                if (_userNameCtrl.text.isEmpty) {
                  snackBar(context, "Please input student name");
                } else if (_emailCtrl.text.isEmpty) {
                  snackBar(context, "Please input student email");
                } else if (_passwordCtrl.text.isEmpty) {
                  snackBar(context, "Please input student password");
                } else if (_roleCtrl.text.isEmpty) {
                  snackBar(context, "Please select user role");
                } else if (_sexCtrl.text.isEmpty) {
                  snackBar(context, "Please select user gender");
                } else {
                  int id = int.parse(_sexCtrl.text);
                  context.read<StudentBloc>().add(CreateAccountStudentEvent(email: _emailCtrl.text, username: _userNameCtrl.text, role: _roleCtrl.text, password: _passwordCtrl.text, genderId: id, context: context));
                }
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                width: width,
                decoration: BoxDecoration(color: flex1, border: Border.all(width: 1, color: Colors.grey), borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: BlocBuilder<StudentBloc, ApplicationState>(builder: (context, state) {
                    if (state is LoadingCreateAccountStuentState) {
                      bool isLoading = state.isLoading;
                      return isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              "Create Account Student",
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            );
                    } else {
                      return const Text(
                        "Create Account Student",
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
  }
}
