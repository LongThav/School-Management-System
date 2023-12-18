import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_school_system/constant/main_abstract/main_abstract.dart';
import 'package:frontend_school_system/util/handle_push_view.dart';
import 'package:frontend_school_system/view_model/bloc/auth_bloc.dart';
import 'package:frontend_school_system/view_model/events/auth_event.dart';
import 'package:frontend_school_system/view_model/states/completing_state/auth_completing_state.dart';

import '../../constant/color.dart';
import '../../util/snack_bar.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  bool _occured = true;
  @override
  void dispose() {
    _emailCtrl.dispose();
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
              "Welcome, Log into  you account",
              style: TextStyle(
                  fontSize: height * 0.04,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700]),
            ),
            SizedBox(
              height: height * 0.08,
            ),
            Text(
              "It is our great pleasure to have",
              style: TextStyle(fontSize: height * 0.03, color: txtColor),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Text(
              "you on board! ",
              style: TextStyle(fontSize: height * 0.03, color: txtColor),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                      } else if (_passwordCtrl.text.isEmpty) {
                        snackBar(context, "Please input your password");
                      } else {
                        context.read<AuthBloc>().add(LoginAccountEvent(
                          context: context,
                            email: _emailCtrl.text,
                            password: _passwordCtrl.text,
                            ));
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
                          if (state is LoginAccountLoadingState) {
                            bool isLoading = state.isLoading;
                            return isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: height * 0.03,
                                        fontWeight: FontWeight.bold),
                                  );
                          } else {
                            return Text(
                              "Login",
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
                      const Text("Don't have account?"),
                      TextButton(
                          onPressed: () {
                            popView(context);
                          },
                          child: const Text("SignUp"))
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
