import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_school_system/constant/main_abstract/main_abstract.dart';
import 'package:frontend_school_system/model/user_model.dart';
import 'package:frontend_school_system/util/handle_push_view.dart';
import 'package:frontend_school_system/util/snack_bar.dart';
import 'package:frontend_school_system/view/daskbaord_view/student/add_student_infor_view.dart';
import 'package:frontend_school_system/view_model/bloc/student_bloc.dart';
import 'package:frontend_school_system/view_model/events/user_event.dart';
import 'package:frontend_school_system/view_model/states/completing_state/student_completing_state.dart';
import 'package:frontend_school_system/view_model/states/completing_state/user_completing.dart';
import 'package:frontend_school_system/view_model/states/condition_state/check_state.dart';

import '../../../constant/color.dart';
import '../../../constant/url_base.dart';
import '../../../view_model/bloc/user_bloc.dart';
import '../../../view_model/events/student_event.dart';
import 'create_account_student.dart';
import 'update_student_infor_view.dart';

class StudentView extends StatefulWidget {
  const StudentView({super.key});

  @override
  State<StudentView> createState() => _StudentViewState();
}

class _StudentViewState extends State<StudentView> {
  bool? isSelect;
  String studentName = '';
  List<User> users = [];
  List<User> students = [];
  String _studentSex = '';
  String _studentRole = '';

  @override
  void initState() {
    context.read<UserBloc>().add(UserEvent());
    super.initState();
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
            flex: 3,
            child: Column(
              children: [
                SizedBox(
                  height: height,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: height * 0.04),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "Export CSV",
                                    style: TextStyle(
                                      color: flex1,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.02,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      await showDialog(
                                          context: context,
                                          builder: (context) {
                                            return const CreateAccountDailog();
                                          });
                                      Future.delayed(const Duration(microseconds: 400), () {
                                        context.read<UserBloc>().add(UserEvent());
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                      decoration: BoxDecoration(color: const Color(0XFF33b6ff), borderRadius: BorderRadius.circular(10)),
                                      child: const Center(
                                        child: Text(
                                          "Create Account",
                                          style: TextStyle(color: Colors.white, fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // SizedBox(
                              //   width: width * 0.02,
                              // ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.notifications_outlined,
                                    color: Colors.grey,
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                          child: Row(
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
                                padding: const EdgeInsets.only(bottom: 5, left: 0, right: 15),
                                height: 30,
                                width: width * 0.3,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: TextField(
                                    onChanged: (value) {
                                      context.read<UserBloc>().add(UserEvent(search: value));
                                    },
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
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        BlocBuilder<UserBloc, ApplicationState>(builder: (context, state) {
                          if (state is InitializeState || state is LoaddingState) {
                            return Column(
                              children: [
                                Container(margin: EdgeInsets.only(top: height * 0.36), child: const CircularProgressIndicator())
                              ],
                            );
                          } else if (state is ErrorState) {
                            String err = state.error;
                            return Center(
                              child: Text(err),
                            );
                          } else if (state is UserState) {
                            var data = state.userModel;
                            if (data.data.isEmpty) {
                              // return const CommonLoadingStudent();
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: height * 0.3,
                                  ),
                                  const Text(
                                    "No Student",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              );
                            } else {
                              return LayoutBuilder(builder: (context, contraint) {
                                if (contraint.maxWidth < 1500) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                                    child: _listStudent(data.data, width, height),
                                  );
                                } else {
                                  return _listStudent(data.data, width, height);
                                }
                              });
                            }
                          } else {
                            return const SizedBox.shrink();
                          }
                        })
                      ],
                    ),
                  ),
                ),
              ],
            )),
        Expanded(
          flex: 1,
          child: Container(
            width: width,
            height: height,
            color: Colors.white,
            child: _buildProfileStudent(),
          ),
        ),
      ],
    );
  }

  Widget _listStudent(List<User> user, double width, double height) {
    students = [];
    for (var student in user) {
      if (student.role?.role == "Student" || student.role?.role.toLowerCase() == "student") {
        students.add(student);
      }
    }
    return FittedBox(
      alignment: Alignment.topCenter,
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
            "Email Address",
            style: TextStyle(fontSize: 18, color: Colors.grey[700], fontWeight: FontWeight.bold),
          ))),
          DataColumn(
              label: Expanded(
                  child: Text(
            "Class",
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
        rows: List.generate(students.length, (index) {
          return DataRow(
              onSelectChanged: (bool? value) {
                setState(() {
                  _studentRole = students[index].role?.role ?? "";
                  _studentSex = students[index].gender?.sex ?? "";
                });
                context.read<StudentByIdBloc>().add(StudentEvent(id: students[index].id));
                studentName = students[index].username ?? "";
              },
              cells: [
                DataCell(Text('${index + 1}')),
                DataCell(Text(students[index].username ?? "")),
                DataCell(Text(students[index].userInfor?.codeId ?? "")),
                DataCell(Text(students[index].email)),
                DataCell(Text(students[index].className?.nameClass ?? "")),
                DataCell(Text(students[index].gender?.sex ?? "")),
                DataCell(Text(students[index].role?.role ?? "")),
              ]);
        }),
      ),
    );
  }

  Widget _buildProfileStudent() {
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<StudentByIdBloc, ApplicationState>(builder: (context, state) {
      if (state is LoaddingState) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
          ],
        );
      } else if (state is ErrorState) {
        String err = state.error;
        return Center(
          child: Text(err),
        );
      } else if (state is StudentByIdState) {
        var data = state.userByIdModel;

        return SingleChildScrollView(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.1,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => UpdateStudentInforView(
                                  id: data.data.id,
                                  userByIdModel: data,
                                  name: studentName,
                                  role: _studentRole,
                                  sex: _studentSex,
                                ));
                      },
                      icon: Icon(
                        Icons.edit_square,
                        color: Colors.blue[200],
                      )),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                        image: data.data.userInfor?.image == null ? const DecorationImage(image: AssetImage("assets/imgs/no-profile.png"), fit: BoxFit.fill) : DecorationImage(image: NetworkImage(hostImage + data.data.userInfor!.image.toString()), fit: BoxFit.fill),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text("Name: ${data.data.username ?? ""}"),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("ID: ${data.data.userInfor?.codeId ?? ""}"),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("Class: ${data.data.userInfor?.className?.nameClass ?? ""}"),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("Email: ${data.data.email}"),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("Role: ${data.data.role?.role ?? ""}"),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("Age: ${data.data.userInfor?.age ?? ""}"),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("Phone: ${data.data.userInfor?.phone ?? ""}"),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("Khan: ${data.data.userInfor?.khan ?? ""}"),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("Sangkat: ${data.data.userInfor?.sangkat ?? ""}"),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("City: ${data.data.userInfor?.city ?? ""}"),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("Province: ${data.data.province?.nameProvince ?? ""}"),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("Country: ${data.data.userInfor?.country ?? ""}"),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                        onTap: () async {
                          if (data.data.userInfor?.codeId != null) {
                            snackBar(context, "User has been add information");
                          } else {
                            await showDialog(
                                context: context,
                                builder: (context) {
                                  return AddStudentInforView(
                                    id: data.data.id,
                                    name: studentName,
                                    sex: _studentSex,
                                    role: _studentRole,
                                  );
                                });
                            Future.delayed(const Duration(milliseconds: 600), () {
                              context.read<UserBloc>().add(UserEvent());
                              context.read<StudentByIdBloc>().add(StudentEvent(id: data.data.id));
                            });
                          }
                        },
                        child: data.data.userInfor?.codeId == null
                            ? Container(
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                decoration: BoxDecoration(color: const Color(0XFF33b6ff), borderRadius: BorderRadius.circular(10)),
                                child: const Center(
                                  child: Text(
                                    "Add Information",
                                    style: TextStyle(color: Colors.white, fontSize: 18),
                                  ),
                                ),
                              )
                            : Container(
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                decoration: BoxDecoration(color: const Color.fromARGB(255, 193, 230, 250), borderRadius: BorderRadius.circular(10)),
                                child: const Center(
                                  child: Text(
                                    "Add Information",
                                    style: TextStyle(color: Colors.white, fontSize: 18),
                                  ),
                                ),
                              )),
                    const SizedBox(
                      height: 15,
                    ),
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
                                  width: 80,
                                  height: 100,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          popView(context);
                                        },
                                        child: const Text(
                                          "No",
                                          style: TextStyle(fontSize: 26),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      TextButton(
                                          onPressed: () async {
                                            context.read<StudentBloc>().add(DeleteStudentEvent(id: data.data.id, context: context));
                                            Future.delayed(const Duration(microseconds: 400), () {
                                              context.read<UserBloc>().add(UserEvent());
                                            });
                                          },
                                          child: const Text(
                                            "Yes",
                                            style: TextStyle(fontSize: 26, color: Colors.red),
                                          ))
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(color: Colors.red.withOpacity(0.5), borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                          child: Text(
                            "Delete Account",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    });
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
