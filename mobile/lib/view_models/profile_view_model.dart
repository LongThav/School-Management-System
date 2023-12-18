import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/enum.dart';
import 'package:mobile/db_helpers/cache_profile.dart';
import 'package:mobile/models/hostory_payment_model.dart';
import 'package:mobile/models/user_information_model.dart';
import 'package:mobile/repository/profile_repository.dart';
import 'package:mobile/utils/logo.dart';

ValueNotifier<int> idUserInfo = ValueNotifier(0);

class ProfileViewModdel extends GetxController {
  final ProfileRepository _profileRepository = ProfileRepository();
  final CacheProfile _cacheProfile = CacheProfile();

  Rx<String> userName = ''.obs;
  Rx<String> email = ''.obs;
  Rx<String>? image = ''.obs;
  Rx<int> id = 0.obs;
  Rx<UserInformationModel> userInfoModel = UserInformationModel().obs;
  Rx<HistoryPaymentModel> historyPaymentModel = HistoryPaymentModel(data: Data()).obs;
  Rx<bool> updateProfileLogin = false.obs;
  Rx<LoadingStatus> loadingStatus = LoadingStatus.none.obs;

  _setProfile(Rx<String> name, Rx<String> email, Rx<String> image, Rx<int> id) {
    this.email.value = email.value;
    userName.value = name.value;
    this.image?.value = image.value;
    this.id.value = id.value;
  }

  _setLoadingUpdateProfile(Rx<bool> value) => updateProfileLogin.value = value.value;
  _setLoading(Rx<LoadingStatus> loading) => loadingStatus.value = loading.value;
  _setUserInfo(Rx<UserInformationModel> userInfo) => userInfoModel.value = userInfo.value;
  _setHistoryPayment(Rx<HistoryPaymentModel> payment) => historyPaymentModel.value = payment.value;

  void readProfile() async {
    _setLoading(LoadingStatus.loading.obs);
    String name = await _cacheProfile.readUserName();
    String email = await _cacheProfile.readEmail();
    String image = await _cacheProfile.readimage();
    String id = await _cacheProfile.readUserId();
    int userId = int.parse(id);
    "Image in Logic: $image".log();
    if (name != "no-username" || email != "no-email" || image != "no-image") {
      _setProfile(name.obs, email.obs, image.obs, userId.obs);
      _setLoading(LoadingStatus.complete.obs);
    } else {
      _setLoading(LoadingStatus.error.obs);
    }
  }

  Future<void> readUserInfor(int id) async {
    _setLoading(LoadingStatus.loading.obs);
    await _profileRepository.userInfoRepo(id).then((value) {
      _setUserInfo(value.obs);
      _setLoading(LoadingStatus.complete.obs);
      "Value: $value".log();
    }).onError((error, stackTrace) {
      "Error: $error".log();
      _setLoading(LoadingStatus.error.obs);
    });
  }

  Future updateProfile(int id, String image) async {
    _setLoadingUpdateProfile(true.obs);
    final Map<String, dynamic> data = {'id': id, 'image': image};
    _profileRepository.updateProfileRepo(data).then((value) {
      _setLoadingUpdateProfile(false.obs);
    }).onError((error, stackTrace) {
      _setLoadingUpdateProfile(false.obs);
    });
  }

  int infoId = 0;

  Future<void> readHistory(int id) async {
    _setLoading(LoadingStatus.loading.obs);
    await _profileRepository.historyPaymentRepo(id).then((value) {
      _setHistoryPayment(value.obs);
      _setLoading(LoadingStatus.complete.obs);
    }).onError((error, stackTrace) {
      _setLoading(LoadingStatus.error.obs);
    });
  }
}
