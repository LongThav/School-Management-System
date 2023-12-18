import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/enum.dart';
import 'package:mobile/models/event_model.dart';
import 'package:mobile/models/info_by_id_model.dart';
import 'package:mobile/models/result_model.dart';
import 'package:mobile/utils/logo.dart';
import '../models/final_exams_model.dart';
import '../repository/final_exam_repository.dart';

class FinalExamViewModel extends GetxController {
  final _finaExamRepo = FinalExamRepository();

  Rx<LoadingStatus> loadingStatus = LoadingStatus.none.obs;
  Rx<FinalExamsModel> finalExamModel = FinalExamsModel(finals: Finals(subjects: Subjects())).obs;
  Rx<EventModel> eventModel = EventModel().obs;
  Rx<bool> addLatLongLoading = false.obs;
  Rx<ResultModel> resultModel = ResultModel().obs;
  Rx<InfoByIdModel> infoByIdModel = InfoByIdModel(infoById: InfoById()).obs;

  void _setLoading(Rx<LoadingStatus> value) {
    loadingStatus.value = value.value;
  }

  void _setResultModel(Rx<ResultModel> value) {
    resultModel.value = value.value;
  }

  void _setInfoByIdModel(Rx<InfoByIdModel> value) {
    infoByIdModel.value = value.value;
  }

  void _setFinalExamModel(Rx<FinalExamsModel> value) {
    finalExamModel.value = value.value;
  }

  void _setEventModel(Rx<EventModel> value) {
    eventModel.value = value.value;
  }

  void _setAddLatLongLoading(Rx<bool> value) {
    addLatLongLoading.value = value.value;
  }

  Future<void> readFinalExamRepo(int subjectId) async {
    _setLoading(LoadingStatus.loading.obs);
    await _finaExamRepo.finalExamRepo(subjectId).then((value) {
      _setFinalExamModel(value.obs);
      _setLoading(LoadingStatus.complete.obs);
    }).onError((error, stackTrace) {
      _setLoading(LoadingStatus.error.obs);
    });
  }

  Future<void> readEvent() async {
    _setLoading(LoadingStatus.none.obs);
    await _finaExamRepo.eventRepo().then((value) {
      _setEventModel(value.obs);
      _setLoading(LoadingStatus.complete.obs);
    }).onError((error, stackTrace) {
      _setLoading(LoadingStatus.error.obs);
    });
  }

  Future addLatLong(double lat, double long, int infoId, BuildContext context) async {
    _setAddLatLongLoading(true.obs);
    final Map<String, dynamic> data = {
      'lat': lat,
      'long': long,
    };
    await _finaExamRepo.addLatLongRepo(data, infoId).then((value) {
      _setAddLatLongLoading(false.obs);
      "save current location successfully".log();
      // snackBar(context, "Save current location successfully");
    }).onError((error, stackTrace) {
      "Error: $error".log();
      _setAddLatLongLoading(false.obs);
    });
  }

  Future<void> readInfoByid(int id) async {
    _setLoading(LoadingStatus.loading.obs);
    await _finaExamRepo.readInfoByIdRepo(id).then((value) {
      _setInfoByIdModel(value.obs);
      _setLoading(LoadingStatus.complete.obs);
    }).onError((error, stackTrace) {
      _setLoading(LoadingStatus.error.obs);
    });
  }

  Future<void> readResult() async {
    _setLoading(LoadingStatus.loading.obs);
    await _finaExamRepo.resultRepo().then((value) {
      _setResultModel(value.obs);
      _setLoading(LoadingStatus.complete.obs);
    }).onError((error, stackTrace) {
      _setLoading(LoadingStatus.error.obs);
    });
  }
}
