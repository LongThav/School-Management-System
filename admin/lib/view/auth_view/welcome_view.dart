import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_school_system/constant/color.dart';
import 'package:frontend_school_system/constant/main_abstract/main_abstract.dart';
import 'package:frontend_school_system/util/handle_push_view.dart';
import 'package:frontend_school_system/util/snack_bar.dart';
import 'package:frontend_school_system/view/auth_view/login_view.dart';
import 'package:frontend_school_system/view_model/bloc/auth_bloc.dart';
import 'package:frontend_school_system/view_model/events/auth_event.dart';
import 'package:frontend_school_system/view_model/states/completing_state/auth_completing_state.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  final TextEditingController _userNameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  late TextEditingController _roleCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  List<String> roleList = [];
  List<dynamic> role = [];
  int roleId = 0;
  bool _occured = true;
  @override
  void initState() {
    context.read<DropDownBloc>().add(RoleEvent());
    super.initState();
  }

  @override
  void dispose() {
    _userNameCtrl.dispose();
    _emailCtrl.dispose();
    _roleCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Welcome to School Management System",
              style: TextStyle(
                  fontSize: height * 0.04,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700]),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Text(
              "It is our great pleasure to have you on board! ",
              style: TextStyle(fontSize: height * 0.03, color: txtColor),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _emailCtrl,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Please input your Email"),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  BlocBuilder<AuthBloc, ApplicationState>(
                      builder: (context, state) {
                    if (state is RoleState) {
                      return DropdownButtonFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Please select your role"),
                          items: state.roleModel.role.map((e) {
                            return DropdownMenuItem(
                              value: e,
                              child: Text(e.name ?? "No_Role"),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            debugPrint("Hello: ${newValue?.id ?? 0}");
                            int id = newValue?.id ?? 0;
                            setState(() {
                              roleId = id;
                            });
                            _roleCtrl =
                                TextEditingController(text: roleId.toString());
                          });
                    } else {
                      return DropdownButtonFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Please select your role"),
                          items: role.map((e) {
                            return DropdownMenuItem(
                              value: e,
                              child: Text(e.name ?? "No_Role"),
                            );
                          }).toList(),
                          onChanged: (newValue) {});
                    }
                  }),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  TextField(
                    obscuringCharacter: '*',
                    obscureText: _occured,
                    controller: _passwordCtrl,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: "Please input your Password",
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _occured = !_occured;
                              });
                            },
                            icon: _occured
                                ? const Icon(Icons.lock_outline)
                                : const Icon(Icons.lock_open))),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  InkWell(
                    onTap: () {
                      if (_emailCtrl.text.isEmpty) {
                        snackBar(context, "Please input your email");
                      } else if (_roleCtrl.text.isEmpty) {
                        snackBar(context, "Please select your role");
                      } else if (_passwordCtrl.text.isEmpty) {
                        snackBar(context, "Please input your password");
                      } else {
                        context.read<AuthBloc>().add(CreateAccountEvent(
                            email: _emailCtrl.text,
                            role: _roleCtrl.text,
                            password: _passwordCtrl.text,
                            context: context));
                      }
                    },
                    child: Container(
                      width: width,
                      height: height * 0.08,
                      decoration: BoxDecoration(
                          color: Colors.blue[700],
                          borderRadius: BorderRadius.circular(12)),
                      child:
                          Center(child: BlocBuilder<AuthBloc, ApplicationState>(
                        builder: (context, state) {
                          if (state is CreateAccountLoadingState) {
                            bool isLoading = state.isLoading;
                            return isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: height * 0.03,
                                        fontWeight: FontWeight.bold),
                                  );
                          } else {
                            return Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: height * 0.03,
                                  fontWeight: FontWeight.bold),
                            );
                          }
                        },
                      )),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      TextButton(
                          onPressed: () {
                            pushView(context, const LoginView());
                          },
                          child: const Text("Login"))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
