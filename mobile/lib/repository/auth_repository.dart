import 'package:flutter/material.dart';
import 'package:mobile/data/network/base_api_service.dart';
import 'package:mobile/data/network/network_api_service.dart';
import 'package:mobile/db_helpers/cache_profile.dart';
import 'package:mobile/res/url_base.dart';
import 'package:mobile/utils/get_header.dart';

import '../models/login_model.dart';

class AuthRepository {
  final BaseApiService _apiService = NetworkApiService();
  final CacheProfile _cacheProfile = CacheProfile();

  Future<LoginModel> loginRep(dynamic data) async {
    try {
      String url = hostUrl + login;
      dynamic response = await _apiService.getPostApiResponse(url, data: data);
      debugPrint("Response: $response");
      return LoginModel.fromJson(response);
    } catch (err) {
      debugPrint("Error: $err");
      throw Exception(err);
    }
  }

  Future logoutRepo() async {
    try {
      String url = hostUrl + logout;
      String token = await _cacheProfile.readToken();
      dynamic response = await _apiService.getPostApiResponse(url,
          requestHeaders: getHeaders(token));
      return response;
    } catch (err) {
      debugPrint("Error: $err");
      throw Exception(err);
    }
  }
}
