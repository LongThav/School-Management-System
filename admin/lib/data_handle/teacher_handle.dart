import 'package:flutter/cupertino.dart';
import 'package:frontend_school_system/constant/url_base.dart';
import 'package:frontend_school_system/data_local/cache_auth_local.dart';
import 'package:frontend_school_system/data_provider/network/base_api_service.dart';
import 'package:frontend_school_system/data_provider/network/network_api_service.dart';
import 'package:frontend_school_system/model/user_model.dart';
import 'package:frontend_school_system/util/get_header.dart';

class HandleDataUser {
  final BaseApiService _apiService = NetworkApiService();
  final CacheAuthLocal _cacheAuthLocal = CacheAuthLocal();
  Future<UserModel> readUser({String search = ''}) async {
    try {
      String token = await _cacheAuthLocal.readToken();
      String url = '$mainUrl$user?query=$search';
      dynamic response = await _apiService.getGetApiResponse(url,
          requestHeaders: getHeaders(token));
      return UserModel.fromJson(response);
    } catch (err) {
      debugPrint("Error: $err");
      throw Exception(err);
    }
  }
}
