import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_school_system/data_provider/network/base_api_service.dart';
import 'package:frontend_school_system/data_provider/network/network_api_service.dart';
import 'package:frontend_school_system/model/exam_model.dart';
import 'package:frontend_school_system/model/year_model.dart';
import 'package:frontend_school_system/util/get_header.dart';

import '../constant/url_base.dart';
import '../data_local/cache_auth_local.dart';
import '../model/year_by_id_model.dart';

class ExamHandleData {
  final BaseApiService _apiService = NetworkApiService();
  final CacheAuthLocal _cacheAuthLocal = CacheAuthLocal();

  Future<ExamModel> readExam(int id) async {
    try {
      String url = '$mainUrl$className/$id';
      String token = await _cacheAuthLocal.readToken();
      dynamic response = await _apiService.getGetApiResponse(url,
          requestHeaders: getHeaders(token));
      debugPrint("Done");
      return ExamModel.fromJson(response);
    } catch (err) {
      debugPrint("Error: $err");
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

  Future<YearByIdModel> readYearById(int id) async {
    try {
      String token = await _cacheAuthLocal.readToken();
      String url = '$mainUrl$majorById/$id';
      dynamic response = await _apiService.getGetApiResponse(url,
          requestHeaders: getHeaders(token));
      return YearByIdModel.fromJson(response);
    } catch (err) {
      debugPrint("Error: $err");
      throw Exception(err);
    }
  }

  Future createYear(dynamic data) async {
    try {
      String token = await _cacheAuthLocal.readToken();
      String url = mainUrl + year;
      var body = jsonEncode(data);
      dynamic response = await _apiService.getPostApiResponse(url,
          data: body, requestHeaders: getHeaders(token));
      return response;
    } catch (err) {
      debugPrint("Error: $err");
      throw Exception(err);
    }
  }
}
