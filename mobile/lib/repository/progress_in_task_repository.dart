import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/data/network/base_api_service.dart';
import 'package:mobile/data/network/network_api_service.dart';
import 'package:mobile/db_helpers/cache_profile.dart';
import 'package:mobile/models/all_answer_assignment_model.dart';
import 'package:mobile/models/all_answer_midterm_model.dart';
import 'package:mobile/models/all_answer_quiz_model.dart';
import 'package:mobile/models/answer_quiz_model.dart';
import 'package:mobile/models/comment_assignment_model.dart';
import 'package:mobile/models/comment_midterm_model.dart';
import 'package:mobile/models/comment_quiz_model.dart';
import 'package:mobile/res/url_base.dart';
import 'package:mobile/utils/get_header.dart';
import 'package:mobile/utils/logo.dart';

class ProgressInTaskRepository {
  final BaseApiService _apiService = NetworkApiService();
  final CacheProfile _cacheProfile = CacheProfile();

  Future<CommentMidtermModel> cmtMidtermRepo(int taskId) async {
    try {
      String token = await _cacheProfile.readToken();
      String url = '$hostUrl$cmtMidterm/$taskId';
      dynamic response = await _apiService.getGetApiResponse(
        url,
        requestHeaders: getHeaders(token),
      );
      debugPrint("Response: $response");
      return CommentMidtermModel.fromJson(response);
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<CommentQuizModel> cmtQuizeRepo(int taskId) async {
    try {
      String token = await _cacheProfile.readToken();
      String url = '$hostUrl$cmtQuize/$taskId';
      dynamic response = await _apiService.getGetApiResponse(
        url,
        requestHeaders: getHeaders(token),
      );
      return CommentQuizModel.fromJson(response);
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<CommentAssignmentModel> cmtAssignmentRepo(int taskId) async {
    try {
      String token = await _cacheProfile.readToken();
      String url = '$hostUrl$cmtAssignment/$taskId';
      dynamic response = await _apiService.getGetApiResponse(
        url,
        requestHeaders: getHeaders(token),
      );
      return CommentAssignmentModel.fromJson(response);
    } catch (err) {
      throw Exception(err);
    }
  }

  Future addCmtQuizRepo(dynamic data) async {
    try {
      String url = hostUrl + addCmtQuiz;
      String token = await _cacheProfile.readToken();
      var body = jsonEncode(data);
      dynamic response = await _apiService.getPostApiResponse(
        url,
        data: body,
        requestHeaders: getHeaders(token),
      );
      return response;
    } catch (err) {
      debugPrint("Error: $err");
      throw Exception(err);
    }
  }

  Future addCmtMidtermRepo(dynamic data) async {
    try {
      String url = hostUrl + addCmtMidterm;
      String token = await _cacheProfile.readToken();
      var body = jsonEncode(data);
      dynamic response = await _apiService.getPostApiResponse(
        url,
        data: body,
        requestHeaders: getHeaders(token),
      );
      debugPrint("Response: $response");
      return response;
    } catch (err) {
      debugPrint("Error: $err");
      throw Exception(err);
    }
  }

  Future addCmtAssignmentRepo(dynamic data) async {
    try {
      String url = hostUrl + addCmtAssignment;
      String token = await _cacheProfile.readToken();
      var body = jsonEncode(data);
      dynamic response = await _apiService.getPostApiResponse(
        url,
        data: body,
        requestHeaders: getHeaders(token),
      );
      return response;
    } catch (err) {
      debugPrint("Error: $err");
      throw Exception(err);
    }
  }

  Future<AnswerQuizModel> readAnswerQuizPerQuestionRepo(int id) async {
    try {
      String url = '$hostUrl$answerquestionQuiz/$id';
      String token = await _cacheProfile.readToken();
      var response = await _apiService.getGetApiResponse(
        url,
        requestHeaders: getHeaders(token),
      );
      return AnswerQuizModel.fromJson(response);
    } catch (err) {
      debugPrint("Error: $err");
      throw Exception(err);
    }
  }

  Future answerQuiz(dynamic data) async {
    try {
      String url = hostUrl + addAnswerQuiz;
      String token = await _cacheProfile.readToken();
      var body = jsonEncode(data);
      dynamic response = await _apiService.getPostApiResponse(
        url,
        data: body,
        requestHeaders: getHeaders(token),
      );
      return response;
    } catch (err) {
      debugPrint("Error: $err");
      throw Exception(err);
    }
  }

  Future<AllAnswerQuizModel> allAnswerQuizRepo(int id) async {
    try {
      String url = '$hostUrl$allAnswerQuizSubmit/$id';
      String token = await _cacheProfile.readToken();
      var response = await _apiService.getGetApiResponse(
        url,
        requestHeaders: getHeaders(token),
      );
      return AllAnswerQuizModel.fromJson(response);
    } catch (err) {
      "Error: $err".log();
      throw Exception(err);
    }
  }

  Future<AllAnswerMidtermModel> allAnswerMidtermRepo(int id) async {
    try {
      String url = '$hostUrl$allAnswerMidtermSubmit/$id';
      String token = await _cacheProfile.readToken();
      var response = await _apiService.getGetApiResponse(
        url,
        requestHeaders: getHeaders(token),
      );
      return AllAnswerMidtermModel.fromJson(response);
    } catch (err) {
      "Error: $err".log();
      throw Exception(err);
    }
  }

  Future<AllAnswerAssignmentModel> allAnswerAssignnmentRepo(int id) async {
    try {
      String url = '$hostUrl$allAnswerAssignmentSubmit/$id';
      String token = await _cacheProfile.readToken();
      var response = await _apiService.getGetApiResponse(
        url,
        requestHeaders: getHeaders(token),
      );
      return AllAnswerAssignmentModel.fromJson(response);
    } catch (err) {
      "Error: $err".log();
      throw Exception(err);
    }
  }

  Future addScoreQuizRepo(int id, String score) async {
    try {
      String token = await _cacheProfile.readToken();
      String url = '$hostUrl$addScoreQuiz/$id';
      final Map<String, dynamic> map = {
        'score': score
      };
      var body = jsonEncode(map);
      var response = await _apiService.getPutApiResponse(
        url,
        data: body,
        requestHeaders: getHeaders(token),
      );
      "Response: $response".log();
      return response;
    } catch (err) {
      "Error: $err".log();
      throw Exception(err);
    }
  }

  Future addScoreMidtermRepo(int id, String score) async {
    try {
      String token = await _cacheProfile.readToken();
      String url = '$hostUrl$addScoreMidterm/$id';
      final Map<String, dynamic> map = {
        'score': score
      };
      var body = jsonEncode(map);
      var response = await _apiService.getPutApiResponse(
        url,
        data: body,
        requestHeaders: getHeaders(token),
      );
      "Response: $response".log();
      return response;
    } catch (err) {
      "Error: $err".log();
      throw Exception(err);
    }
  }

  Future addScoreAssignmentRepo(int id, String score) async {
    try {
      String token = await _cacheProfile.readToken();
      String url = '$hostUrl$addScoreAssignment/$id';
      final Map<String, dynamic> map = {
        'score': score
      };
      var body = jsonEncode(map);
      var response = await _apiService.getPutApiResponse(
        url,
        data: body,
        requestHeaders: getHeaders(token),
      );
      "Response: $response".log();
      return response;
    } catch (err) {
      "Error: $err".log();
      throw Exception(err);
    }
  }

  Future updateAnswerQuizRepo(int id, String title) async {
    try {
      String token = await _cacheProfile.readToken();
      String url = '$hostUrl$updateAnswerQuiz/$id';
      final Map<String, dynamic> map = {
        'title': title
      };
      var body = jsonEncode(map);
      var response = await _apiService.getPutApiResponse(
        url,
        data: body,
        requestHeaders: getHeaders(token),
      );
      "Response: $response".log();
      return response;
    } catch (err) {
      "Error: $err".log();
      throw Exception(err);
    }
  }

  Future updateAnswerMidtermRepo(int id, String title) async {
    try {
      String token = await _cacheProfile.readToken();
      String url = '$hostUrl$updateAnswerMidterm/$id';
      final Map<String, dynamic> map = {
        'title': title
      };
      var body = jsonEncode(map);
      var response = await _apiService.getPutApiResponse(
        url,
        data: body,
        requestHeaders: getHeaders(token),
      );
      "Response: $response".log();
      return response;
    } catch (err) {
      "Error: $err".log();
      throw Exception(err);
    }
  }

  Future updateAnswerAssignmentRepo(int id, String title) async {
    try {
      String token = await _cacheProfile.readToken();
      String url = '$hostUrl$updateAnswerAssignment/$id';
      final Map<String, dynamic> map = {
        'title': title
      };
      var body = jsonEncode(map);
      var response = await _apiService.getPutApiResponse(
        url,
        data: body,
        requestHeaders: getHeaders(token),
      );
      "Response: $response".log();
      return response;
    } catch (err) {
      "Error: $err".log();
      throw Exception(err);
    }
  }
}
