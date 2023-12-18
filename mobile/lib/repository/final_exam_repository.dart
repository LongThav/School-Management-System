import 'dart:convert';

import 'package:mobile/models/event_model.dart';
import 'package:mobile/utils/get_header.dart';
import 'package:mobile/utils/logo.dart';

import '../data/network/base_api_service.dart';
import '../data/network/network_api_service.dart';
import '../db_helpers/cache_profile.dart';
import '../models/final_exams_model.dart';
import '../models/info_by_id_model.dart';
import '../models/result_model.dart';
import '../res/url_base.dart';

class FinalExamRepository {
  final BaseApiService _apiService = NetworkApiService();
  final CacheProfile _cacheProfile = CacheProfile();

  Future<FinalExamsModel> finalExamRepo(int subjectId) async {
    try {
      String token = await _cacheProfile.readToken();
      String url = '$hostUrl$subjectIdUrl/$subjectId';
      var data = await _apiService.getGetApiResponse(
        url,
        requestHeaders: getHeaders(token),
      );
      "Response: $data".log();
      return FinalExamsModel.fromJson(data);
    } catch (err) {
      'Error: $err'.log();
      throw Exception(err);
    }
  }

  Future<EventModel> eventRepo() async {
    try {
      String token = await _cacheProfile.readToken();
      String url = hostUrl + event;
      var data = await _apiService.getGetApiResponse(
        url,
        requestHeaders: getHeaders(token),
      );
      "Response: $data".log();
      return EventModel.fromJson(data);
    } catch (err) {
      "Error: $err".log();
      throw Exception(err);
    }
  }

  Future addLatLongRepo(dynamic data, int infoId) async {
    try {
      String token = await _cacheProfile.readToken();
      String url = '$hostUrl$addLatLong/$infoId';
      "url: $url".log();
      var body = jsonEncode(data);
      var json = _apiService.getPutApiResponse(
        url,
        data: body,
        requestHeaders: getHeaders(token),
      );
      "Json: $json".log();
      return json;
    } catch (err) {
      "Error: $err".log();
      throw Exception(err);
    }
  }

  Future<InfoByIdModel> readInfoByIdRepo(int infoId) async {
    try {
      String token = await _cacheProfile.readToken();
      String url = '$hostUrl$info/$infoId';
      var json = await _apiService.getGetApiResponse(
        url,
        requestHeaders: getHeaders(token),
      );
      "Response: $json".log();
      return InfoByIdModel.fromJson(json);
    } catch (err) {
      "Error: $err".log();
      throw Exception(err);
    }
  }

  Future<ResultModel> resultRepo() async {
    try {
      String token = await _cacheProfile.readToken();
      String url = '$hostUrl$result';
      var json = await _apiService.getGetApiResponse(
        url,
        requestHeaders: getHeaders(token),
      );
      return ResultModel.fromJson(json);
    } catch (err) {
      "Error: $err".log();
      throw Exception(err);
    }
  }
}
