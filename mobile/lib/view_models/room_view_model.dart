import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/enum.dart';
import 'package:mobile/data/network/base_api_service.dart';
import 'package:mobile/data/network/network_api_service.dart';
import 'package:mobile/db_helpers/cache_id.dart';
import 'package:mobile/db_helpers/cache_profile.dart';
import 'package:mobile/models/all_task_in_subject_model.dart';
import 'package:mobile/models/assignment_model.dart';
import 'package:mobile/models/midterm_model.dart';
import 'package:mobile/models/quiz_model.dart';
import 'package:mobile/models/subject_model.dart';
import 'package:mobile/repository/room_mate_repository.dart';
import 'package:mobile/res/date.dart';
import 'package:mobile/res/url_base.dart';
import 'package:mobile/utils/get_header.dart';
import 'package:mobile/utils/logo.dart';
import 'package:mobile/utils/snack_bar.dart';

import '../models/answer_midterm_model.dart';
import '../repository/progress_in_task_repository.dart';

class RoomViewModel extends GetxController {
  final RoomMateRepository _roomMateRepository = RoomMateRepository();
  final ProgressInTaskRepository _progressInTaskRepository = ProgressInTaskRepository();
  final BaseApiService _apiService = NetworkApiService();
  final _cacheLocal = CacheProfile();
  final CacheId _cacheId = CacheId();

  Rx<SubJectModel> subJectModel = SubJectModel(data: Data()).obs;
  Rx<LoadingStatus> loadingStatus = LoadingStatus.none.obs;
  Rx<MidtermModel> midTemModel = MidtermModel(data: Term()).obs;
  Rx<QuizModel> quizModel = QuizModel(quiz: Quiz()).obs;
  Rx<AssignmentModel> assignmetModl = AssignmentModel(assignment: Assignment()).obs;
  Rx<AllTaskInSubjectModel> allTaskInSubjectModel = AllTaskInSubjectModel(allTask: AllTask()).obs;
  Rx<bool> createQuizLoading = false.obs;
  Rx<bool> createMidtermLoading = false.obs;
  Rx<bool> createAssignment = false.obs;
  Rx<bool> answerMidterm = false.obs;
  Rx<bool> addScoreLoadingQuiz = false.obs;
  Rx<bool> addScoreLoadingMidterm = false.obs;
  Rx<bool> addScoreLoadingAssignment = false.obs;
  Rx<AnswerMidtermModel> answerMidtermModel = AnswerMidtermModel(midterm: Midterms(getAnswer: MidtermQuiz())).obs;

  _setLoading(Rx<LoadingStatus> loading) => loadingStatus.value = loading.value;
  _setSubModel(Rx<SubJectModel> subJectModel) => this.subJectModel.value = subJectModel.value;
  _setMidtermModel(Rx<MidtermModel> midterm) => midTemModel.value = midterm.value;
  _setQuizModel(Rx<QuizModel> quiz) => quizModel.value = quiz.value;
  _setAssignmentModel(Rx<AssignmentModel> assignment) => assignmetModl.value = assignment.value;
  _setAllTaskInSubjectModel(Rx<AllTaskInSubjectModel> allTask) => allTaskInSubjectModel.value = allTask.value;
  _setCreateQuizLoading(Rx<bool> value) => createQuizLoading.value = value.value;
  _setCreateMidtermLoading(Rx<bool> value) => createMidtermLoading.value = value.value;
  _setCreateAssignmentLoading(Rx<bool> value) => createAssignment.value = value.value;
  _setAnswerMidter(Rx<AnswerMidtermModel> value) => answerMidtermModel.value = value.value;
  _setLoadingAnswerMidterm(Rx<bool> value) {
    answerMidterm.value = value.value;
  }

  _setAddScoreQuiz(Rx<bool> value) {
    addScoreLoadingQuiz.value = value.value;
  }

  _setAddScoreMidterm(Rx<bool> value) {
    addScoreLoadingMidterm.value = value.value;
  }

  _setAddScoreAssignment(Rx<bool> value) {
    addScoreLoadingAssignment.value = value.value;
  }

  Future<void> readSubject() async {
    String id = await _cacheId.readClassId();
    int classId = int.parse(id);
    _setLoading(LoadingStatus.loading.obs);
    await _roomMateRepository.subJectRepo(classId).then((value) {
      _setSubModel(value.obs);
      _setLoading(LoadingStatus.complete.obs);
    }).onError((error, stackTrace) {
      _setLoading(LoadingStatus.error.obs);
    });
  }

  Future<void> readMidterm(int id) async {
    _setLoading(LoadingStatus.loading.obs);
    await _roomMateRepository.midtermRepo(id).then((value) {
      _setMidtermModel(value.obs);
      _setLoading(LoadingStatus.complete.obs);
    }).onError((error, stackTrace) {
      _setLoading(LoadingStatus.error.obs);
    });
  }

  Future<void> readQuiz(int id) async {
    _setLoading(LoadingStatus.loading.obs);
    await _roomMateRepository.quizRepo(id).then((value) {
      _setQuizModel(value.obs);
      _setLoading(LoadingStatus.complete.obs);
    }).onError((error, stackTrace) {
      _setLoading(LoadingStatus.error.obs);
    });
  }

  Future<void> readAssignment(int id) async {
    _setLoading(LoadingStatus.loading.obs);
    await _roomMateRepository.assignmentRepo(id).then((value) {
      _setAssignmentModel(value.obs);
      _setLoading(LoadingStatus.complete.obs);
    }).onError((error, stackTrace) {
      _setLoading(LoadingStatus.error.obs);
    });
  }

  Future<void> readAllTasKInSubjecct(int id) async {
    _setLoading(LoadingStatus.loading.obs);
    await _roomMateRepository.allTaskRepo(id).then((value) {
      _setAllTaskInSubjectModel(value.obs);
      _setLoading(LoadingStatus.complete.obs);
    }).onError((error, stackTrace) {
      _setLoading(LoadingStatus.error.obs);
    });
  }

  Future createQuiz(String classId, String title, String subJectid) async {
    _setCreateQuizLoading(true.obs);
    final Map<String, dynamic> data = {
      'class_id': classId,
      'title': title,
      'subject_id': subJectid,
      'date_time': dateTime,
    };
    debugPrint("data: $data");
    await _roomMateRepository.createQuizeRepo(data).then((value) {
      _setCreateQuizLoading(false.obs);
      Get.back();
    }).onError((error, stackTrace) {
      _setCreateQuizLoading(false.obs);
    });
  }

  Future createMidterm(String classId, String title, String subJectid) async {
    _setCreateMidtermLoading(true.obs);
    final Map<String, dynamic> data = {
      'class_id': classId,
      'title': title,
      'subject_id': subJectid,
      'date_time': dateTime,
    };
    await _roomMateRepository.createMidtermRepo(data).then((value) {
      _setCreateMidtermLoading(false.obs);
      Get.back();
    }).onError((error, stackTrace) {
      _setCreateMidtermLoading(false.obs);
    });
  }

  Future createAssignments(String classId, String title, String subJectid) async {
    _setCreateAssignmentLoading(true.obs);
    final Map<String, dynamic> data = {
      'class_id': classId,
      'title': title,
      'subject_id': subJectid,
      'date_time': dateTime,
    };
    debugPrint("Data: $data");
    await _roomMateRepository.createAssignmentRepo(data).then((value) {
      _setCreateAssignmentLoading(false.obs);
      Get.back();
    }).onError((error, stackTrace) {
      _setCreateAssignmentLoading(false.obs);
    });
  }

  Future<void> readAnswerMidterm(int id) async {
    _setLoading(LoadingStatus.loading.obs);
    try {
      String url = '$hostUrl$answerQuestionMidterm/$id';
      String token = await _cacheLocal.readToken();
      var response = await _apiService.getGetApiResponse(url, requestHeaders: getHeaders(token));
      _setAnswerMidter(AnswerMidtermModel.fromJson(response).obs);
      _setLoading(LoadingStatus.complete.obs);
    } catch (err) {
      "Error: $err".log();
      _setLoading(LoadingStatus.error.obs);
    }
  }

  Future answerMidtermQuestion(String subjectId, String midtermId, String title, BuildContext context) async {
    _setLoadingAnswerMidterm(true.obs);
    await _roomMateRepository.answerMidtermQuestionRepo(subjectId, midtermId, title, context).then((value) {
      _setLoadingAnswerMidterm(false.obs);
      Get.back();
      snackBar(context, "Submit successfully!");
    }).onError((error, stackTrace) {
      snackBar(context, "Failed Submited");
      _setLoadingAnswerMidterm(false.obs);
    });
  }

  Future addScoreQuiz(int id, String score) async {
    _setAddScoreQuiz(true.obs);
    await _progressInTaskRepository.addScoreQuizRepo(id, score).then((value) {
      _setAddScoreQuiz(false.obs);
      Get.back();
    }).onError((error, stackTrace) {
      _setAddScoreQuiz(false.obs);
    });
  }

  Future addScoreMidterm(int id, String score) async {
    _setAddScoreMidterm(true.obs);
    await _progressInTaskRepository.addScoreMidtermRepo(id, score).then((value) {
      _setAddScoreMidterm(false.obs);
      Get.back();
    }).onError((error, stackTrace) {
      _setAddScoreMidterm(false.obs);
    });
  }

  Future addScoreAssignment(int id, String score) async {
    _setAddScoreAssignment(true.obs);
    await _progressInTaskRepository.addScoreAssignmentRepo(id, score).then((value) {
      _setAddScoreAssignment(false.obs);
      Get.back();
    }).onError((error, stackTrace) {
      _setAddScoreAssignment(false.obs);
    });
  }
}
