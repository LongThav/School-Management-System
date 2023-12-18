import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/data/network/base_api_service.dart';
import 'package:mobile/data/network/network_api_service.dart';
import 'package:mobile/db_helpers/cache_profile.dart';
import 'package:mobile/models/all_task_in_subject_model.dart';
import 'package:mobile/models/assignment_model.dart';
import 'package:mobile/models/class_id_model.dart';
import 'package:mobile/models/class_mate_model.dart';
import 'package:mobile/models/subject_model.dart';
import 'package:mobile/utils/logo.dart';

import '../models/answer_assignment_model.dart';
import '../models/midterm_model.dart';
import '../models/quiz_model.dart';
import '../models/who_submit_model.dart';
import '../res/url_base.dart';
import '../utils/get_header.dart';

class RoomMateRepository {
  final BaseApiService _apiService = NetworkApiService();
  final CacheProfile _cacheProfile = CacheProfile();

  Future<ClassMateModel> classRepo(int id) async {
    try {
      String token = await _cacheProfile.readToken();
      String url = "$hostUrl$classRoom/$id";
      debugPrint("Url: $url");
      dynamic response = await _apiService.getGetApiResponse(
        url,
        requestHeaders: getHeaders(token),
      );
      return ClassMateModel.fromJson(response);
    } catch (err) {
      debugPrint("Error: $err");
      throw Exception(err);
    }
  }

  Future<ClassIdModel> classIdRepo() async {
    try {
      String token = await _cacheProfile.readToken();
      String userId = await _cacheProfile.readUserId();
      int id = int.parse(userId);
      String url = "$hostUrl$user/$id";
      dynamic response = await _apiService.getGetApiResponse(
        url,
        requestHeaders: getHeaders(token),
      );
      return ClassIdModel.fromJson(response);
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<SubJectModel> subJectRepo(int id) async {
    try {
      String token = await _cacheProfile.readToken();
      String url = '$hostUrl$subJect/$id';
      dynamic response = await _apiService.getGetApiResponse(
        url,
        requestHeaders: getHeaders(token),
      );
      return SubJectModel.fromJson(response);
    } catch (err) {
      debugPrint("Error: $err");
      throw Exception(err);
    }
  }

  Future<MidtermModel> midtermRepo(int id) async {
    try {
      String token = await _cacheProfile.readToken();
      String url = '$hostUrl$midterm/$id';
      dynamic response = await _apiService.getGetApiResponse(
        url,
        requestHeaders: getHeaders(token),
      );
      return MidtermModel.fromJson(response);
    } catch (err) {
      debugPrint("Error: $err");
      throw Exception(err);
    }
  }

  Future<QuizModel> quizRepo(int subJectid) async {
    try {
      String token = await _cacheProfile.readToken();
      String url = '$hostUrl$quiz/$subJectid';
      dynamic response = await _apiService.getGetApiResponse(
        url,
        requestHeaders: getHeaders(token),
      );
      return QuizModel.fromJson(response);
    } catch (err) {
      debugPrint("Error: $err");
      throw Exception(err);
    }
  }

  Future<AssignmentModel> assignmentRepo(int subJectid) async {
    try {
      String token = await _cacheProfile.readToken();
      String url = '$hostUrl$assignment/$subJectid';
      dynamic response = await _apiService.getGetApiResponse(
        url,
        requestHeaders: getHeaders(token),
      );
      return AssignmentModel.fromJson(response);
    } catch (err) {
      debugPrint("Error: $err");
      throw Exception(err);
    }
  }

  Future<AllTaskInSubjectModel> allTaskRepo(int subjectId) async {
    try {
      String token = await _cacheProfile.readToken();
      String url = '$hostUrl$task/$subjectId';
      dynamic response = await _apiService.getGetApiResponse(
        url,
        requestHeaders: getHeaders(token),
      );
      debugPrint("Response: $response");
      return AllTaskInSubjectModel.fromJson(response);
    } catch (err) {
      debugPrint("Error: $err");
      throw Exception(err);
    }
  }

  Future createQuizeRepo(dynamic data) async {
    try {
      String url = hostUrl + createQuiz;
      var body = jsonEncode(data);
      String token = await _cacheProfile.readToken();
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

  Future createMidtermRepo(dynamic data) async {
    try {
      String url = hostUrl + createMidterm;
      var body = jsonEncode(data);
      String token = await _cacheProfile.readToken();
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

  Future createAssignmentRepo(dynamic data) async {
    try {
      String url = hostUrl + createAssignment;
      var body = jsonEncode(data);
      String token = await _cacheProfile.readToken();
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

  Future answerMidtermQuestionRepo(
    String subjectId,
    String midtermId,
    String title,
    BuildContext context,
  ) async {
    try {
      final Map<String, dynamic> data = {
        'subject_id': subjectId,
        'midterm_id': midtermId,
        'title': title
      };
      var body = jsonEncode(data);
      String url = '$hostUrl$addAnswerMidterm';
      String token = await _cacheProfile.readToken();
      var response = await _apiService.getPostApiResponse(
        url,
        data: body,
        requestHeaders: getHeaders(token),
      );
      return response;
    } catch (err) {
      "Error: $err".log();
      throw Exception(err);
    }
  }

  Future<AnswerAssignmentModel> answerAssignmentRepo(int id) async {
    try {
      String url = '$hostUrl$answerAssignment/$id';
      String token = await _cacheProfile.readToken();
      var response = await _apiService.getGetApiResponse(
        url,
        requestHeaders: getHeaders(token),
      );
      return AnswerAssignmentModel.fromJson(response);
    } catch (err) {
      "Error: $err".log();
      throw Exception(err);
    }
  }

  Future addAnswerAssignmentRepo(dynamic data) async {
    try {
      String token = await _cacheProfile.readToken();
      String url = hostUrl + addAnswerAssignment;
      var body = jsonEncode(data);
      var response = await _apiService.getPostApiResponse(
        url,
        data: body,
        requestHeaders: getHeaders(token),
      );
      return response;
    } catch (err) {
      "Error: $err".log();
      throw Exception(err);
    }
  }

  Future<WhoSubmitModel> whoSubmitRepo(int id) async {
    try {
      String token = await _cacheProfile.readToken();
      String url = '$hostUrl$whoSubmit/$id';
      var response = await _apiService.getGetApiResponse(
        url,
        requestHeaders: getHeaders(token),
      );
      return WhoSubmitModel.fromJson(response);
    } catch (err) {
      "Error: $err".log();
      throw Exception(err);
    }
  }
}
