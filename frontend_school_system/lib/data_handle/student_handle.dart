import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:frontend_school_system/constant/url_base.dart';
import 'package:frontend_school_system/data_local/cache_auth_local.dart';
import 'package:frontend_school_system/data_provider/network/base_api_service.dart';
import 'package:frontend_school_system/data_provider/network/network_api_service.dart';
import 'package:frontend_school_system/model/all_major_model.dart';
import 'package:frontend_school_system/model/class_model.dart';
import 'package:frontend_school_system/model/gender_model.dart';
import 'package:frontend_school_system/model/student_model.dart';
import 'package:frontend_school_system/model/user_by_id_model.dart';
import 'package:frontend_school_system/util/get_header.dart';

import '../model/all_user_model.dart';
import '../model/type_year_model.dart';
import '../model/year_model.dart';

class HandleDataStudent {
  final BaseApiService _apiService = NetworkApiService();
  final CacheAuthLocal _cacheAuthLocal = CacheAuthLocal();
  Future<UserByIdModel> readUserById(int id) async {
    try {
      String token = await _cacheAuthLocal.readToken();
      String url = '$mainUrl$user/$id';
      dynamic response = await _apiService.getGetApiResponse(url,
          requestHeaders: getHeaders(token));
      debugPrint("Response: $response");
      return UserByIdModel.fromJson(response);
    } catch (err) {
      debugPrint("Error: $err");
      throw Exception(err);
    }
  }

  Future<UserSignUpModel> createUser(dynamic data) async {
    try {
      String url = mainUrl + signUp;
      String token = await _cacheAuthLocal.readToken();
      var body = jsonEncode(data);
      dynamic response = await _apiService.getPostApiResponse(url,
          data: body, requestHeaders: getHeaders(token));
      debugPrint("Data: $data");
      debugPrint("Response: $response");
      return UserSignUpModel.fromJson(response);
    } catch (err) {
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

  Future addUserInfor(dynamic data) async {
    try {
      String url = mainUrl + addInforUser;
      debugPrint("Data: $data");
      dynamic response = await _apiService.getPostApiResponse(url, data: data);
      debugPrint("Reponse: $response");
      return response;
    } catch (err) {
      debugPrint("Eerr: $err");
      throw Exception(err);
    }
  }

  Future<ClassModel> readClass() async {
    try {
      String token = await _cacheAuthLocal.readToken();
      String url = mainUrl + className;
      dynamic response = await _apiService.getGetApiResponse(url,
          requestHeaders: getHeaders(token));
      debugPrint("Response: $response");
      return ClassModel.fromJson(response);
    } catch (err) {
      debugPrint("Class Error: $err");
      throw Exception(err);
    }
  }

  Future deleteStudent(int id) async {
    try {
      String token = await _cacheAuthLocal.readToken();
      String url = '$mainUrl$delete/$id';
      dynamic response = await _apiService.getDeleteApiResponse(url,
          requestHeaders: getHeaders(token));
      debugPrint("Response: $response");
      return response;
    } catch (err) {
      throw Exception(err);
    }
  }

  Future updateUserInfor(dynamic data) async {
    try {
      String token = await _cacheAuthLocal.readToken();
      debugPrint("Data: $data");
      var body = jsonEncode(data);
      String url = mainUrl + updateInfor;
      dynamic response = await _apiService.getPutApiResponse(url,
          data: body, requestHeaders: getHeaders(token));
      debugPrint("Response: $response");
      return response;
    } catch (err) {
      debugPrint("Error: $err");
      throw Exception(err);
    }
  }

  Future<StudentModel> readStudent(int id) async {
    try {
      String url = '$mainUrl$className/$id';
      String token = await _cacheAuthLocal.readToken();
      dynamic response = await _apiService.getGetApiResponse(url,
          requestHeaders: getHeaders(token));
      return StudentModel.fromJson(response);
    } catch (err) {
      debugPrint("Error: $err");
      throw Exception(err);
    }
  }

  Future<AllMajorModel> readAllMajor() async {
    try {
      String token = await _cacheAuthLocal.readToken();
      String url = mainUrl + major;
      dynamic response = await _apiService.getGetApiResponse(url,
          requestHeaders: getHeaders(token));
      return AllMajorModel.fromJson(response);
    } catch (err) {
      debugPrint("Error: $err");
      throw Exception(err);
    }
  }

  Future paymentHandle(dynamic data, int id) async {
    try {
      String token = await _cacheAuthLocal.readToken();
      var body = jsonEncode(data);
      String url = '$mainUrl$updatePayment/$id';
      dynamic response = await _apiService.getPutApiResponse(url,
          data: body, requestHeaders: getHeaders(token));
      return response;
    } catch (err) {
      debugPrint("Error: $err");
      throw Exception(err);
    }
  }

  Future<TypeYearModel> readTypeYear() async {
    try {
      String token = await _cacheAuthLocal.readToken();
      String url = mainUrl + year;
      dynamic response = await _apiService.getGetApiResponse(url,
          requestHeaders: getHeaders(token));
      return TypeYearModel.fromJson(response);
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<YearModel> readYear() async {
    try {
      String token = await _cacheAuthLocal.readToken();
      String url = mainUrl + year;
      dynamic response = await _apiService.getGetApiResponse(url,
          requestHeaders: getHeaders(token));
      return YearModel.fromJson(response);
    } catch (err) {
      debugPrint("Error: $err");
      throw Exception(err);
    }
  }

  Future paymentRepo(dynamic data) async {
    try {
      String token = await _cacheAuthLocal.readToken();
      var body = jsonEncode(data);
      String url = '$mainUrl$payment';
      dynamic response = await _apiService.getPostApiResponse(url,
          data: body, requestHeaders: getHeaders(token));
      debugPrint("Response: $response");
      return response;
    } catch (err) {
      debugPrint("Error: $err");
      throw Exception(err);
    }
  }
}
