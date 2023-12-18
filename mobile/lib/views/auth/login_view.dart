import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/commons/common_btn_form.dart';
import 'package:mobile/res/colors/color.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mobile/res/routes/route_name.dart';
import 'package:mobile/view_models/auth_view_model.dart';

import '../../utils/snack_bar.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  bool _obccured = true;
  final AuthViewModel _authViewModel = Get.put(AuthViewModel());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 0),
              child: Text(
                "Email",
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: _emailCtrl,
              focusNode: _emailFocus,
              decoration: const InputDecoration(
                hintText: "example@gmail.com",
                hintStyle: TextStyle(color: Colors.grey),
                suffixIcon: Icon(
                  Icons.person,
                  color: btnColor,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 0),
              child: Text(
                "Password",
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              focusNode: _passwordFocus,
              obscureText: _obccured,
              obscuringCharacter: '*',
              controller: _passwordCtrl,
              decoration: InputDecoration(
                  hintText: "***********",
                  hintStyle: const TextStyle(color: Colors.grey, letterSpacing: 1.5),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obccured = !_obccured;
                        });
                      },
                      icon: _obccured
                          ? const Icon(
                              LineIcons.eyeSlash,
                              color: btnColor,
                              size: 25,
                            )
                          : const Icon(
                              LineIcons.eye,
                              color: btnColor,
                              size: 25,
                            )),
                  contentPadding: const EdgeInsets.only(top: 20)),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Obx(
              () => CommonBtn(
                  isLoading: _authViewModel.loginLoading.value,
                  label: "Login",
                  color: btnColor,
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  callback: () {
                    if (_emailCtrl.text.isEmpty) {
                      snackBar(context, "Please input your email");
                    } else if (_passwordCtrl.text.isEmpty) {
                      snackBar(context, "Please input your password");
                    } else {
                      _authViewModel.loginViewModel(_emailCtrl.text, _passwordCtrl.text, context);
                    }
                  }),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: (){
              Get.toNamed(RouteName.forgotPassword);
            },
            child: const Align(
              alignment: Alignment.center,
              child: Text(
                "Forgot Password?",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
          )
        ],
      ),
    );
  }
}
