import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:mobile/db_helpers/cache_id.dart';
import 'package:mobile/db_helpers/cache_profile.dart';
import 'package:mobile/repository/auth_repository.dart';
import 'package:mobile/utils/logo.dart';

import '../res/routes/route_name.dart';
import '../res/url_base.dart';
import '../utils/snack_bar.dart';

class AuthViewModel extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  final CacheProfile _cacheProfile = CacheProfile();
  final CacheId _cacheId = CacheId();

  Rx<bool> loginLoading = false.obs;
  Rx<bool> logoutLoading = false.obs;
  Rx<bool> forgotPasswordLoading = false.obs;
  void _forgotPasswordLoadingFn(Rx<bool> value) {
    forgotPasswordLoading.value = value.value;
  }

  _setLoginLoading(Rx<bool> value) => loginLoading.value = value.value;
  _setLogoutLoading(Rx<bool> value) => logoutLoading.value = value.value;

  Future loginViewModel(String email, String password, BuildContext context) async {
    _setLoginLoading(true.obs);
    final Map<String, dynamic> data = {
      'email': email,
      'password': password
    };
    await _authRepository.loginRep(data).then((value) {
      _setLoginLoading(false.obs);
      _cacheProfile.writeUserId(value.data.user.id.toString());
      _cacheProfile.writeToken(value.data.token);
      _cacheProfile.writeUserName(value.data.user.username);
      _cacheProfile.writeEmail(value.data.user.email);
      _cacheProfile.writeImage(value.data.user.image);
      _cacheProfile.writeRole(value.role);
      _cacheId.writeClassId(value.data.info.infoClass?.id.toString() ?? "");
      _cacheId.writeInfoId(value.data.info.userInfor?.id.toString() ?? "");
      debugPrint("id: ${value.data.user.id.toString()}");
      debugPrint("Token: ${value.data.token}");
      debugPrint("Username: ${value.data.user.username}");
      debugPrint("Email: ${value.data.user.email}");
      debugPrint("Image: ${value.data.user.image}");
      debugPrint("Role: ${value.role}");
      debugPrint("InfoId: ${value.data.info.userInfor?.id.toString() ?? ""}");
      switch (value.role) {
        case "Student":
          return Get.offAndToNamed(RouteName.indexStudent);
        case "Teacher":
          return Get.offAndToNamed(RouteName.indexTeacher);
        case "Parent":
          return Get.offNamed(RouteName.indexParent);
        default:
          break;
      }
    }).onError((error, stackTrace) {
      _setLoginLoading(false.obs);
      snackBar(context, "Email or Password incorrect");
      return null;
    });
  }

  Future logoutViewModel() async {
    _setLogoutLoading(true.obs);
    await _authRepository.logoutRepo().then((value) {
      _cacheProfile.deleteAll();
      Get.offAllNamed(RouteName.loginView);
      _setLogoutLoading(false.obs);
    }).onError((error, stackTrace) {
      _setLogoutLoading(false.obs);
    });
  }

  Future forgotPasswordLogic(String email, BuildContext context) async {
    try {
      _forgotPasswordLoadingFn(true.obs);
      String url = hostUrl + forgotPassword;
      final Map<String, dynamic> body = {
        'email': email
      };
      http.Response response = await http.post(
        Uri.parse(url),
        body: body,
      );
      if (response.statusCode == 200) {
        _forgotPasswordLoadingFn(false.obs);
        Future.delayed(const Duration(microseconds: 300), () {
          snackBar(context, "OTP has been send");
        });
        return response;
      }
    } catch (err) {
      _forgotPasswordLoadingFn(false.obs);
      throw Exception(err);
    }
  }

  Future resentOtp(String email) async {
    try {
      _forgotPasswordLoadingFn(true.obs);
      String url = hostUrl + forgotPassword;
      final Map<String, dynamic> body = {
        'email': email
      };
      http.Response response = await http.post(
        Uri.parse(url),
        body: body,
      );
      if (response.statusCode == 200) {
        _forgotPasswordLoadingFn(false.obs);
        return response;
      }
    } catch (err) {
      _forgotPasswordLoadingFn(false.obs);
      throw Exception(err);
    }
  }

  Rx<bool> verifyLoading = false.obs;
  void _setVerifyLoading(Rx<bool> value) {
    verifyLoading.value = value.value;
  }

  Future verfiyOtpLogic(String email, String token) async {
    try {
      _setVerifyLoading(true.obs);
      String url = hostUrl + verifyOtp;
      final Map<String, dynamic> body = {
        'email': email,
        'token': token
      };
      http.Response response = await http.post(
        Uri.parse(url),
        body: body,
      );
      if (response.statusCode == 200) {
        _setVerifyLoading(false.obs);
        return response;
      } else {
        'Other Error'.log();
        _setVerifyLoading(false.obs);
      }
    } catch (err) {
      _setVerifyLoading(false.obs);
      throw Exception(err);
    }
  }

  Rx<bool> resetPassswordLoading = false.obs;
  void _setResetPasswordLoading(Rx<bool> value) async {
    resetPassswordLoading.value = value.value;
  }

  Future resetPasswordLogic(
    String email,
    String newPassword,
    String comfirmedPassword,
  ) async {
    try {
      _setResetPasswordLoading(true.obs);
      String url = hostUrl + resetPassword;
      final Map<String, dynamic> body = {
        'email': email,
        'password': newPassword,
        'password_confirmation': comfirmedPassword
      };
      http.Response response = await http.post(
        Uri.parse(url),
        body: body,
      );
      if (response.statusCode == 200) {
        _setResetPasswordLoading(false.obs);
        return response;
      } else {
        'Other Error'.log();
        _setResetPasswordLoading(false.obs);
      }
    } catch (err) {
      _setResetPasswordLoading(false.obs);
      throw Exception(err);
    }
  }
}
