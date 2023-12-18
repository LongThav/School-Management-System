import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_school_system/constant/url_base.dart';
import 'package:frontend_school_system/data_local/cache_auth_local.dart';
import 'package:frontend_school_system/data_provider/network/base_api_service.dart';
import 'package:frontend_school_system/data_provider/network/network_api_service.dart';
import 'package:frontend_school_system/model/login_model.dart';
import 'package:frontend_school_system/model/role_model.dart';
import 'package:frontend_school_system/util/get_header.dart';
import 'package:frontend_school_system/util/snack_bar.dart';

import '../model/gender_model.dart';
import '../model/province_model.dart';
import '../model/sign_up_model.dart';

class AuthDataHandle {
  final BaseApiService _apiService = NetworkApiService();
  final CacheAuthLocal _cacheAuthLocal = CacheAuthLocal();

  Future<RoleModel> readRole() async {
    try {
      String token = await _cacheAuthLocal.readToken();
      String url = mainUrl + role;
      dynamic response = await _apiService.getGetApiResponse(url,
          requestHeaders: getHeaders(token));
      return RoleModel.fromMap(response);
    } catch (err) {
      debugPrint("Role Error: $err");
      throw Exception(err);
    }
  }

  Future<AdminSignUpModel> createAccountAdmin(dynamic data) async {
    try {
      String url = mainUrl + admin;
      dynamic response = await _apiService.getPostApiResponse(url, data: data);
      debugPrint("Data: $data");
      debugPrint("Response: $response");
      return AdminSignUpModel.fromJson(response);
    } catch (err) {
      debugPrint("Error: $err");
      throw Exception(err);
    }
  }

  Future<LoginModel> loginAccount(BuildContext context, dynamic data) async {
    try {
      String url = mainUrl + login;
      dynamic response = await _apiService.getPostApiResponse(url, data: data);
      debugPrint("Response: $response");
      return LoginModel.fromJson(response);
    } catch (err) {
      snackBar(context, "Email or password incorrect");
      debugPrint("Error: $err");
      throw Exception(err);
    }
  }

  Future<GenderModel> readGender() async {
    try {
      String token = await _cacheAuthLocal.readToken();
      String url = mainUrl + gender;
      dynamic response = await _apiService.getGetApiResponse(url,
          requestHeaders: getHeaders(token));
      return GenderModel.fromJson(response);
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<ProvincModel> readProvince() async {
    try {
      String token = await _cacheAuthLocal.readToken();
      String url = mainUrl + province;
      dynamic response = await _apiService.getGetApiResponse(url,
          requestHeaders: getHeaders(token));
      debugPrint("Response: $response");
      return ProvincModel.fromJson(response);
    } catch (err) {
      debugPrint("Error; $err");
      throw Exception(err);
    }
  }

  Future handleLogout() async {
    try {
      String url = mainUrl + logout;
      String token = await _cacheAuthLocal.readToken();
      dynamic response = await _apiService.getPostApiResponse(url,
          requestHeaders: getHeaders(token));
      return response;
    } catch (err) {
      throw Exception(err);
    }
  }

  Future createRole(dynamic data) async {
    try {
      String token = await _cacheAuthLocal.readToken();
      String url = mainUrl + role;
      var body = jsonEncode(data);
      dynamic response = await _apiService.getPostApiResponse(url,
          data: body, requestHeaders: getHeaders(token));
      return response;
    } catch (err) {
      debugPrint("Error: $err");
      throw Exception(err);
    }
  }

  Future crateProvince(dynamic data) async {
    try {
      String token = await _cacheAuthLocal.readToken();
      String url = '$mainUrl/create-province';
      var body = jsonEncode(data);
      dynamic response = await _apiService.getPostApiResponse(url,
          data: body, requestHeaders: getHeaders(token));
      return response;
    } catch (err) {
      throw Exception(err);
    }
  }
}
