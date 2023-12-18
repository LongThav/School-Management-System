import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile/data/network/base_api_service.dart';
import 'package:mobile/data/network/network_api_service.dart';
import 'package:mobile/db_helpers/cache_profile.dart';
import 'package:mobile/models/hostory_payment_model.dart';
import 'package:mobile/models/user_information_model.dart';
import 'package:mobile/res/url_base.dart';
import 'package:mobile/utils/get_header.dart';
import 'package:mobile/utils/logo.dart';

class ProfileRepository {
  final BaseApiService _apiService = NetworkApiService();
  final CacheProfile _cacheProfile = CacheProfile();

  Future<UserInformationModel> userInfoRepo(int id) async {
    try {
      String token = await _cacheProfile.readToken();
      String url = '$hostUrl$user/$id';
      "Url: $url".log();
      dynamic response = await _apiService.getGetApiResponse(url,
          requestHeaders: getHeaders(token));
      "response: $response".log();
      return UserInformationModel.fromJson(response);
    } catch (err) {
      "Error: $err".log();
      throw Exception(err);
    }
  }

  Future updateProfileRepo(dynamic data) async {
    try {
      String token = await _cacheProfile.readToken();
      var body = jsonEncode(data);
      String url = hostUrl + updateProfile;
      dynamic response = await _apiService.getPutApiResponse(url,
          requestHeaders: getHeaders(token), data: body);
      return UserInformationModel.fromJson(response);
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<HistoryPaymentModel> historyPaymentRepo(int inforId) async {
    try {
      String token = await _cacheProfile.readToken();
      String url = '$hostUrl$historyPayment/$inforId';
      debugPrint("Url: $url");
      dynamic response = await _apiService.getGetApiResponse(url,
          requestHeaders: getHeaders(token));
      debugPrint("Response: $response");
      return HistoryPaymentModel.fromJson(response);
    } catch (err) {
      debugPrint("Error: $err");
      throw Exception(err);
    }
  }
}
