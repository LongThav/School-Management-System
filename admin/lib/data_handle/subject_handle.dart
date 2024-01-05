import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:frontend_school_system/constant/url_base.dart';
import 'package:frontend_school_system/data_provider/network/base_api_service.dart';
import 'package:frontend_school_system/data_provider/network/network_api_service.dart';

import '../data_local/cache_auth_local.dart';
import '../model/subject_by_id_model.dart';
import '../model/subject_model.dart';
import '../util/get_header.dart';

class SubjectHandle {
  final BaseApiService _apiService = NetworkApiService();
  final CacheAuthLocal _cacheAuthLocal = CacheAuthLocal();

  Future createSubject(dynamic data) async {
    try {
      String token = await _cacheAuthLocal.readToken();
      var body = jsonEncode(data);
      String url = mainUrl + crateSubject;
      dynamic response = await _apiService.getPostApiResponse(url,
          data: body, requestHeaders: getHeaders(token));
      return response;
    } catch (err) {
      debugPrint("Error: $err");
      throw Exception(err);
    }
  }

  Future<SubjectModel> readSubject(int id) async {
    try {
      String token = await _cacheAuthLocal.readToken();
      String url = '$mainUrl$subject/$id';
      dynamic response = await _apiService.getGetApiResponse(url,
          requestHeaders: getHeaders(token));
      return SubjectModel.fromJson(response);
    } catch (err) {
      debugPrint("Error: $err");
      throw Exception(err);
    }
  }

  Future<SubjectByIdModel> readPersonInSubject(int id) async {
    try {
      String token = await _cacheAuthLocal.readToken();
      String url = '$mainUrl$subJectById/$id';
      dynamic response = await _apiService.getGetApiResponse(url,
          requestHeaders: getHeaders(token));
      debugPrint("Done");
      return SubjectByIdModel.fromJson(response);
    } catch (err) {
      debugPrint("Error: $err");
      throw Exception(err);
    }
  }

  Future addStudentIntoSubject(int id, String subjectId) async {
    try {
      String token = await _cacheAuthLocal.readToken();
      final Map<String, dynamic> data = {
        'subject_id': subjectId,
      };
      var body = jsonEncode(data);
      String url = '$mainUrl$addPerson/$id';
      dynamic response = await _apiService.getPutApiResponse(url,
          requestHeaders: getHeaders(token), data: body);
      return response;
    } catch (err) {
      debugPrint("Error: $err");
      throw Exception(err);
    }
  }
}
