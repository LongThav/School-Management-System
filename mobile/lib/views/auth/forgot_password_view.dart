import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/commons/common_btn_form.dart';
import 'package:mobile/commons/common_txt_style.dart';
import 'package:mobile/res/colors/color.dart';
import 'package:mobile/utils/snack_bar.dart';
import 'package:mobile/view_models/auth_view_model.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final FocusNode _emailFocus = FocusNode();
  final TextEditingController _emailCtrl = TextEditingController();
  final _auth = Get.put(AuthViewModel());
  @override
  void dispose() {
    _emailFocus.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: btnColor,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: const CommonTxtStyle(
          label: 'Forgot Password',
          color: btnColor,
        ),
        titleSpacing: -10,
      ),
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
            height: 15,
          ),
          Obx(() {
            return Padding(
              padding: const EdgeInsets.all(15),
              child: CommonBtn(
                label: 'Send OTp',
                color: btnColor,
                textStyle: const TextStyle(fontSize: 18, color: Colors.white),
                callback: () {
                  if (_emailCtrl.text.isEmpty) {
                    snackBar(context, "Please input your email");
                  } else {
                    _auth.forgotPasswordLogic(_emailCtrl.text, context);
                  }
                },
                isLoading: _auth.forgotPasswordLoading.value,
              ),
            );
          })
        ],
      ),
    );
  }
}
