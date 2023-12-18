import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/enum.dart';
import 'package:mobile/db_helpers/cache_id.dart';
import 'package:mobile/db_helpers/cache_profile.dart';
import 'package:mobile/models/class_id_model.dart';

import '../models/class_mate_model.dart';
import '../repository/room_mate_repository.dart';

ValueNotifier<int> classId = ValueNotifier(0);
ValueNotifier<String> className = ValueNotifier('');
ValueNotifier<String> codeId = ValueNotifier('');

class ClassViewModdel extends GetxController {
  final RoomMateRepository _roomRepo = RoomMateRepository();
  final CacheProfile _cacheProfile = CacheProfile();
  final CacheId _cacheId = CacheId();
  Rx<ClassIdModel> classIdModel = ClassIdModel().obs;
  Rx<ClassMateModel> classMateModel = ClassMateModel().obs;
  Rx<LoadingStatus> loadingStatus = LoadingStatus.none.obs;

  _setLoading(Rx<LoadingStatus> loading) => loadingStatus.value = loading.value;
  _setClassIdModel(Rx<ClassIdModel> classId) => classIdModel.value = classId.value;
  _setClassMateModel(Rx<ClassMateModel> classMateModel) => this.classMateModel.value = classMateModel.value;

  Future<void> readClassId() async {
    _setLoading(LoadingStatus.loading.obs);
    await _roomRepo.classIdRepo().then((value) {
      _setClassIdModel(value.obs);
      _setLoading(LoadingStatus.complete.obs);
      classId.value = value.data?.classId ?? 0;
      className.value = value.data?.dataClass.nameClass ?? "";
      codeId.value = value.data?.userInfor?.codeId ?? "";
      debugPrint("Info Id: ${value.data?.userInfor?.id}");
      _cacheProfile.writeUserInfoId(value.data?.userInfor?.id);
      debugPrint("ClassID: ${value.data?.classId ?? 0}");
    }).onError((error, stackTrace) {
      _setLoading(LoadingStatus.error.obs);
    });
  }

  Future<void> readStudent() async {
    _setLoading(LoadingStatus.loading.obs);
    String id = await _cacheId.readClassId();
    int classId = int.parse(id);
    await _roomRepo.classRepo(classId).then((value) {
      _setClassMateModel(value.obs);
      _setLoading(LoadingStatus.complete.obs);
    }).onError((error, stackTrace) {
      _setLoading(LoadingStatus.error.obs);
    });
  }
}
