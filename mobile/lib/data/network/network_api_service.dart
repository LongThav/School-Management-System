import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../exceptions_app.dart';
import 'base_api_service.dart';

class NetworkApiService extends BaseApiService {
  @override
  Future getGetApiResponse(String url, {Map<String, String>? requestHeaders}) async {
    dynamic jsonResponse;
    try {
      final response = await http.get(Uri.parse(url), headers: requestHeaders).timeout(const Duration(seconds: 10));
      jsonResponse = returnResponse(response);
    } on SocketException {
      FetchDataException("No Internet Connection");
    }
    return jsonResponse;
  }

  @override
  Future getPostApiResponse(String url, {data, Map<String, String>? requestHeaders}) async {
    dynamic jsonResponse;
    try {
      final response = await http.post(Uri.parse(url), body: data, headers: requestHeaders).timeout(const Duration(seconds: 10));
      jsonResponse = returnResponse(response);
    } on SocketException {
      BadRequestException("No Internet Connection");
    }
    return jsonResponse;
  }

  @override
  Future getPutApiResponse(
    String url, {
    data,
    Map<String, String>? requestHeaders,
  }) async {
    dynamic jsonResponse;
    try {
      final response = await http.put(Uri.parse(url), body: data, headers: requestHeaders).timeout(const Duration(seconds: 10));
      jsonResponse = returnResponse(response);
    } on SocketException {
      BadRequestException("No Internet Connection");
    }
    return jsonResponse;
  }

  @override
  Future getDeleteApiResponse(String url, {Map<String, String>? requestHeaders, data}) async {
    dynamic jsonResponse;
    try {
      final response = await http.delete(Uri.parse(url), body: data, headers: requestHeaders).timeout(const Duration(seconds: 10));
      jsonResponse = returnResponse(response);
    } on SocketException {
      BadRequestException("No Internet Connection");
    }
    return jsonResponse;
  }
}

dynamic returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      dynamic responseJsons;
      if (response.body.isNotEmpty) {
        final responseJson = json.decode(response.body);
        responseJsons = responseJson;
        // return responseJson;
      }
      return responseJsons;
    case 400:
      throw BadRequestException("400");
    case 404:
      throw UnauthorisedException("404");
    case 500:
    default:
      throw FetchDataException('Error occured while communicating with server with status code ${response.statusCode.toString()}');
  }
}
