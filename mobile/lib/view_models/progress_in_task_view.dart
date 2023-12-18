import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/enum.dart';
import 'package:mobile/models/all_answer_assignment_model.dart';
import 'package:mobile/models/all_answer_midterm_model.dart';
import 'package:mobile/models/answer_assignment_model.dart';
import 'package:mobile/models/answer_quiz_model.dart';
import 'package:mobile/models/comment_assignment_model.dart';
import 'package:mobile/models/comment_midterm_model.dart';
import 'package:mobile/models/comment_quiz_model.dart';
import 'package:mobile/repository/progress_in_task_repository.dart';
import 'package:mobile/repository/room_mate_repository.dart';
import 'package:mobile/utils/snack_bar.dart';

import '../models/all_answer_quiz_model.dart';
import '../models/who_submit_model.dart';

class ProgressInTaskViewModel extends GetxController {
  final _progressRepo = ProgressInTaskRepository();
  final _roomRepo = RoomMateRepository();

  Rx<CommentQuizModel> cmtQuizModel = CommentQuizModel(quize: Quize()).obs;
  Rx<CommentAssignmentModel> cmtassignmentModel = CommentAssignmentModel(assignment: Assignment()).obs;
  Rx<CommentMidtermModel> cmtMidtermModel = CommentMidtermModel(midterm: Midterm()).obs;
  Rx<LoadingStatus> loadingStatus = LoadingStatus.none.obs;
  Rx<bool> loadingCmtQuiz = false.obs;
  Rx<bool> loadingCmtMidterm = false.obs;
  Rx<bool> loadingCmtAssignment = false.obs;
  Rx<AnswerQuizModel> answerQuizModel = AnswerQuizModel(quiz: AnswerQuiz(getAnswer: GetAnswer())).obs;
  Rx<LoadingStatus> loadingQuiz = LoadingStatus.none.obs;
  Rx<bool> loadingAnswerQuiz = false.obs;
  Rx<AnswerAssignmentModel> answerAssignmentModel = AnswerAssignmentModel(assignmentQuiz: Assignments()).obs;
  Rx<bool> answerAssignmentLoading = false.obs;
  Rx<AllAnswerQuizModel> allAnswerQuizModdel = AllAnswerQuizModel(answerQuiz: AllAnswerQuiz()).obs;
  Rx<AllAnswerMidtermModel> allAnswerMidtermModel = AllAnswerMidtermModel(allAnswerMidterm: AllAnswerMidterm()).obs;
  Rx<AllAnswerAssignmentModel> allAnswerAssignmentModel = AllAnswerAssignmentModel(allAnswerAssignment: AllAnswerAssignment()).obs;
  Rx<WhoSubmitModel> whoSubmitModel = WhoSubmitModel(data: WhoSubmit(codeId: CodeId())).obs;
  Rx<bool> updateAnswerLoading = false.obs;
  Rx<bool> updateAnswerMidterm = false.obs;
  Rx<bool> updateAssignment = false.obs;

  _setLoading(Rx<LoadingStatus> loading) {
    loadingStatus.value = loading.value;
  }

  _setCommentQuizModel(Rx<CommentQuizModel> cmtQuizModel) {
    this.cmtQuizModel.value = cmtQuizModel.value;
  }

  _setCommentAssignment(Rx<CommentAssignmentModel> cmtAssignment) {
    cmtassignmentModel.value = cmtAssignment.value;
  }

  _setCommentMidtermModel(Rx<CommentMidtermModel> cmtMidterm) {
    cmtMidtermModel.value = cmtMidterm.value;
  }

  _setLoadingCmtQuize(Rx<bool> value) => loadingCmtQuiz.value = value.value;
  _setLoadingCmtMidterm(Rx<bool> value) => loadingCmtMidterm.value = value.value;
  _setLoadingCmtAssignment(Rx<bool> value) => loadingCmtAssignment.value = value.value;
  _setAnswerQuizModel(Rx<AnswerQuizModel> value) => answerQuizModel.value = value.value;
  _setLoadingAswer(Rx<LoadingStatus> value) => loadingQuiz.value = value.value;
  _setAddedQuizLoading(Rx<bool> value) => loadingAnswerQuiz.value = value.value;
  _setAnswerAssignmentModel(Rx<AnswerAssignmentModel> value) {
    answerAssignmentModel.value = value.value;
  }

  _setWhoSubmit(Rx<WhoSubmitModel> value) {
    whoSubmitModel.value = value.value;
  }

  _setAllAnswerAssignmentSubmit(Rx<AllAnswerAssignmentModel> value) {
    allAnswerAssignmentModel.value = value.value;
  }

  _setAllAsnwerQuizSubmit(Rx<AllAnswerQuizModel> value) {
    allAnswerQuizModdel.value = value.value;
  }

  _setAllAnswerMidterSubmit(Rx<AllAnswerMidtermModel> value) {
    allAnswerMidtermModel.value = value.value;
  }

  _setAddAnswerAssignment(Rx<bool> value) {
    answerAssignmentLoading.value = value.value;
  }

  _setUpdateAnswerQuizLoading(Rx<bool> value) {
    updateAnswerLoading.value = value.value;
  }

  _setUpdateAnswerMidtermLoading(Rx<bool> value) {
    updateAnswerMidterm.value = value.value;
  }

  _setUpdateAnswerAssignmentLoading(Rx<bool> value) {
    updateAssignment.value = value.value;
  }

  Future<void> readCmtQuize(int taskId) async {
    _setLoading(LoadingStatus.loading.obs);
    await _progressRepo.cmtQuizeRepo(taskId).then((value) {
      _setCommentQuizModel(value.obs);
      _setLoading(LoadingStatus.complete.obs);
    }).onError((error, stackTrace) {
      _setLoading(LoadingStatus.error.obs);
    });
  }

  Future<void> readCmtAssignment(int taskId) async {
    _setLoading(LoadingStatus.loading.obs);
    await _progressRepo.cmtAssignmentRepo(taskId).then((value) {
      _setCommentAssignment(value.obs);
      _setLoading(LoadingStatus.complete.obs);
    }).onError((error, stackTrace) {
      _setLoading(LoadingStatus.error.obs);
    });
  }

  Future<void> readMidterm(int taskId) async {
    _setLoading(LoadingStatus.loading.obs);
    await _progressRepo.cmtMidtermRepo(taskId).then((value) {
      _setLoading(LoadingStatus.complete.obs);
      _setCommentMidtermModel(value.obs);
    }).onError((error, stackTrace) {
      _setLoading(LoadingStatus.error.obs);
    });
  }

  Future addCmtQuiz(String title, String subjectId, String quizId) async {
    _setLoadingCmtQuize(true.obs);
    final Map<String, dynamic> data = {
      'title': title,
      'subject_id': subjectId,
      'quize_id': quizId
    };
    await _progressRepo.addCmtQuizRepo(data).then((value) {
      _setLoadingCmtQuize(false.obs);
    }).onError((error, stackTrace) {
      _setLoadingCmtQuize(false.obs);
    });
  }

  Future addCmtMidterm(String title, String subjectId, String midtermId) async {
    _setLoadingCmtMidterm(true.obs);
    final Map<String, dynamic> data = {
      'title': title,
      'subject_id': subjectId,
      'midterm_id': midtermId
    };
    debugPrint("data: $data");
    await _progressRepo.addCmtMidtermRepo(data).then((value) {
      _setLoadingCmtMidterm(false.obs);
    }).onError((error, stackTrace) {
      debugPrint("Error: $error");
      _setLoadingCmtMidterm(false.obs);
    });
  }

  Future addCmtAssigment(String title, String subjectId, String quizId) async {
    _setLoadingCmtAssignment(true.obs);
    final Map<String, dynamic> data = {
      'title': title,
      'subject_id': subjectId,
      'assignment_id': quizId
    };
    await _progressRepo.addCmtAssignmentRepo(data).then((value) {
      _setLoadingCmtAssignment(false.obs);
    }).onError((error, stackTrace) {
      _setLoadingCmtAssignment(false.obs);
    });
  }

  Future<void> readAnswerPerQuiz(int id) async {
    _setLoadingAswer(LoadingStatus.loading.obs);
    await _progressRepo.readAnswerQuizPerQuestionRepo(id).then((value) {
      _setAnswerQuizModel(value.obs);
      _setLoadingAswer(LoadingStatus.complete.obs);
    }).onError((error, stackTrace) {
      _setLoadingAswer(LoadingStatus.error.obs);
    });
  }

  Future addedAnswerQuiz(String subjectId, String quizId, String title, BuildContext context) async {
    _setAddedQuizLoading(true.obs);
    final Map<String, dynamic> data = {
      'subject_id': subjectId,
      'quiz_id': quizId,
      'title': title
    };
    await _progressRepo.answerQuiz(data).then((value) {
      _setAddedQuizLoading(false.obs);
      Future.delayed(const Duration(milliseconds: 300), () {
        Get.back();
        snackBar(context, "Submit successfully");
      });
    }).onError((error, stackTrace) {
      _setAddedQuizLoading(false.obs);
    });
  }

  Future<void> readAnswerAssignment(int id) async {
    _setLoadingAswer(LoadingStatus.loading.obs);
    await _roomRepo.answerAssignmentRepo(id).then((value) {
      _setAnswerAssignmentModel(value.obs);
      _setLoadingAswer(LoadingStatus.complete.obs);
    }).onError((error, stackTrace) {
      _setLoadingAswer(LoadingStatus.error.obs);
    });
  }

  Future addAnswerAssignment(
    String subjectId,
    String assignmentId,
    String title,
    BuildContext context,
  ) async {
    _setAddAnswerAssignment(true.obs);
    final Map<String, dynamic> data = {
      'subject_id': subjectId,
      'assignment_id': assignmentId,
      'title': title
    };
    await _roomRepo.addAnswerAssignmentRepo(data).then((value) {
      _setAddAnswerAssignment(false.obs);
      Get.back();
      snackBar(context, "Submit successfully!");
    }).onError((error, stackTrace) {
      snackBar(context, "Failed Submited");
      _setAddAnswerAssignment(false.obs);
    });
  }

  Future<void> readAllAnswerQuizSubmited(int id) async {
    _setLoadingAswer(LoadingStatus.loading.obs);
    await _progressRepo.allAnswerQuizRepo(id).then((value) {
      _setAllAsnwerQuizSubmit(value.obs);
      _setLoadingAswer(LoadingStatus.complete.obs);
    }).onError((error, stackTrace) {
      _setLoadingAswer(LoadingStatus.error.obs);
    });
  }

  Future<void> readAllAnswerMidtermSubmited(int id) async {
    _setLoadingAswer(LoadingStatus.loading.obs);
    await _progressRepo.allAnswerMidtermRepo(id).then((value) {
      _setAllAnswerMidterSubmit(value.obs);
      _setLoadingAswer(LoadingStatus.complete.obs);
    }).onError((error, stackTrace) {
      _setLoadingAswer(LoadingStatus.error.obs);
    });
  }

  Future<void> readAllAnswerAssignmentSubmited(int id) async {
    _setLoadingAswer(LoadingStatus.loading.obs);
    await _progressRepo.allAnswerAssignnmentRepo(id).then((value) {
      _setAllAnswerAssignmentSubmit(value.obs);
      _setLoadingAswer(LoadingStatus.complete.obs);
    }).onError((error, stackTrace) {
      _setLoadingAswer(LoadingStatus.error.obs);
    });
  }

  Future<void> readWhoSubmit(int userId) async {
    _setLoading(LoadingStatus.loading.obs);
    await _roomRepo.whoSubmitRepo(userId).then((value) {
      _setWhoSubmit(value.obs);
      _setLoading(LoadingStatus.complete.obs);
    }).onError((error, stackTrace) {
      _setLoading(LoadingStatus.error.obs);
    });
  }

  Future updateAnswerQuiz(int id, String title) async {
    _setUpdateAnswerQuizLoading(true.obs);
    await _progressRepo.updateAnswerQuizRepo(id, title).then((value) {
      _setUpdateAnswerQuizLoading(false.obs);
      Get.back();
    }).onError((error, stackTrace) {
      _setUpdateAnswerQuizLoading(false.obs);
    });
  }

  Future updateAnswerMidtermLogic(int id, String title) async {
    _setUpdateAnswerMidtermLoading(true.obs);
    await _progressRepo.updateAnswerMidtermRepo(id, title).then((value) {
      _setUpdateAnswerMidtermLoading(false.obs);
      Get.back();
    }).onError((error, stackTrace) {
      _setUpdateAnswerMidtermLoading(false.obs);
    });
  }

  Future updateAnswerAssignmentLogic(int id, String title) async {
    _setUpdateAnswerAssignmentLoading(true.obs);
    await _progressRepo.updateAnswerAssignmentRepo(id, title).then((value) {
      _setUpdateAnswerAssignmentLoading(false.obs);
      Get.back();
    }).onError((error, stackTrace) {
      _setUpdateAnswerAssignmentLoading(false.obs);
    });
  }
}
