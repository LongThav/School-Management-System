import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_school_system/constant/url_base.dart';
import 'package:frontend_school_system/model/major_by_id_model.dart';
import 'package:frontend_school_system/model/major_model.dart';
import 'package:frontend_school_system/util/get_header.dart';

import '../data_local/cache_auth_local.dart';
import '../data_provider/network/base_api_service.dart';
import '../data_provider/network/network_api_service.dart';
import '../model/class_by_id_major_model.dart';
import '../model/history_payment_model.dart';

class MajorHandleData {
  final BaseApiService _apiService = NetworkApiService();
  final CacheAuthLocal _cacheAuthLocal = CacheAuthLocal();

  Future<MajorModel> readMajor() async {
    try {
      String url = mainUrl + major;
      String token = await _cacheAuthLocal.readToken();
      dynamic response = await _apiService.getGetApiResponse(url,
          requestHeaders: getHeaders(token));
      debugPrint("Reponse: $response");
      return MajorModel.fromJson(response);
    } catch (err) {
      debugPrint("Error; $err");
      throw Exception(err);
    }
  }

  Future createMajor(dynamic data) async {
    try {
      String url = mainUrl + addMajor;
      var body = jsonEncode(data);
      String token = await _cacheAuthLocal.readToken();
      dynamic response = await _apiService.getPostApiResponse(url,
          requestHeaders: getHeaders(token), data: body);
      return response;
    } catch (err) {
      debugPrint("Error; $err");
      throw Exception(err);
    }
  }

  Future<MajorByIdModel> readMajorById(int id) async {
    try {
      String url = '$mainUrl$addMajor/$id';
      String token = await _cacheAuthLocal.readToken();
      dynamic response = await _apiService.getGetApiResponse(url,
          requestHeaders: getHeaders(token));
      return MajorByIdModel.fromJson(response);
    } catch (err) {
      debugPrint("Error: $err");
      throw Exception(err);
    }
  }

  Future createClass(dynamic data) async {
    try {
      String url = mainUrl + className;
      String token = await _cacheAuthLocal.readToken();
      var body = jsonEncode(data);
      dynamic response = await _apiService.getPostApiResponse(url,
          data: body, requestHeaders: getHeaders(token));
      return response;
    } catch (err) {
      debugPrint("Error: $err");
      throw Exception(err);
    }
  }

  Future createFinalExam(dynamic data) async {
    try {
      String url = mainUrl + addFinalExam;
      String token = await _cacheAuthLocal.readToken();
      var body = jsonEncode(data);
      dynamic response = await _apiService.getPostApiResponse(url,
          data: body, requestHeaders: getHeaders(token));
      return response;
    } catch (err) {
      debugPrint("Error: $err");
      throw Exception(err);
    }
  }

  Future<ClassByModorIdModel> readClass(int id) async {
    try {
      String url = '$mainUrl$addMajor/$id';
      String token = await _cacheAuthLocal.readToken();
      dynamic response = await _apiService.getGetApiResponse(url,
          requestHeaders: getHeaders(token));
      debugPrint("Response: $response");
      return ClassByModorIdModel.fromJson(response);
    } catch (err) {
      debugPrint("Error");
      throw Exception(err);
    }
  }

  Future<HistoryPaymentModel> hostoryPaymentRepo(int userInfoId) async {
    try {
      String url = mainUrl + userInfo + '/$userInfoId';
      String token = await _cacheAuthLocal.readToken();
      dynamic response = await _apiService.getGetApiResponse(url,
          requestHeaders: getHeaders(token));
      return HistoryPaymentModel.fromJson(response);
    } catch (err) {
      debugPrint("Error");
      throw Exception(err);
    }
  }
}
