import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:editable_image/editable_image.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mobile/commons/common_btn_form.dart';
import 'package:mobile/data/enum.dart';
import 'package:mobile/res/colors/color.dart';
import 'package:mobile/res/routes/route_name.dart';
import 'package:mobile/view_models/auth_view_model.dart';
import 'package:mobile/view_models/profile_view_model.dart';

import '../../res/url_base.dart';
import '../../res/user_info.dart';
import '../../view_models/class_view_model.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ClassViewModdel _classViewModdel = Get.put(ClassViewModdel());
  final ProfileViewModdel _profileViewModdel = Get.put(ProfileViewModdel());
  final AuthViewModel _authViewModel = Get.put(AuthViewModel());
  final List<dynamic> _profile = [
    {
      "icon": Icons.person_outline,
      "title": "Information",
    },
    {
      "icon": LineIcons.dollarSign,
      "title": "History Payment",
    },
    {
      "icon": Icons.location_pin,
      "title": "Location",
    },
    {
      "icon": Icons.support_agent,
      "title": "Team Support",
    },
  ];
  // final int _userInfoId = 0;
  File? _profilePicFile;
  String _base64Image = '';
  Future<void> _directUpdateImage(File? file) async {
    if (file == null) return;
    setState(() {
      _profilePicFile = file;
    });
    debugPrint("Img Path: ${_profilePicFile?.path}");
    String fileName = _profilePicFile!.path.split('/').last;
    debugPrint("FileaName: $fileName");
    // final bytes = File(_profilePicFile!.path).readAsBytesSync();
    List<int> imageBytes = File(_profilePicFile!.path).readAsBytesSync();
    String img64 = base64Encode(imageBytes);
    _base64Image = "data:image/png;base64,$img64";
  }

  @override
  void initState() {
    _profileViewModdel.readProfile();
    _classViewModdel.readClassId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (_profileViewModdel.loadingStatus.value) {
        case LoadingStatus.none:
        case LoadingStatus.loading:
          return const Center(
            child: CircularProgressIndicator(),
          );
        case LoadingStatus.error:
          return const Center(
            child: Text("Error"),
          );
        case LoadingStatus.complete:
          return _buildBody();
      }
    });
  }

  Widget _buildBody() {
    return Obx(() {
      "Img: ${_profileViewModdel.image ?? ""}";
      debugPrint("UserId: ${_profileViewModdel.id.value}");
      email.value = _profileViewModdel.email.value;
      infoId?.value =
          _classViewModdel.classIdModel.value.data?.userInfor?.id ?? 0;
      debugPrint("InfoID: ${infoId?.value}");
      return SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  EditableImage(
                    onChange: _directUpdateImage,
                    image: _profilePicFile != null
                        ? Image.file(_profilePicFile!, fit: BoxFit.cover)
                        // ignore: unrelated_type_equality_checks
                        : _profileViewModdel.image != null? Image.asset("assets/imgs/no-profile.png") : Image.network(
                            hostImg + _profileViewModdel.image.toString()),
                    size: 75,
                    imagePickerTheme: ThemeData(
                      // Define the default brightness and colors.
                      primaryColor: Colors.white,
                      shadowColor: Colors.transparent,
                      colorScheme:
                          const ColorScheme.light(background: Colors.white70),
                      iconTheme: const IconThemeData(color: Colors.black87),

                      // Define the default font family.
                      fontFamily: 'Georgia',
                    ),
                    imageBorder: Border.all(color: Colors.blue, width: 2),
                    editIconBorder: Border.all(color: Colors.purple, width: 2),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "Name: ${_profileViewModdel.userName}\n",
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 18)),
                          TextSpan(
                              text: "Email: ${_profileViewModdel.email}\n",
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 18)),
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                children: List.generate(_profile.length, (index) {
                  return InkWell(
                    onTap: () {
                      userId.value = _profileViewModdel.id.value;
                      switch (index) {
                        case 0:
                          Get.toNamed(RouteName.userInfo);
                          break;
                        case 1:
                          Get.toNamed(RouteName.historyPayment);
                          break;
                        case 2:
                          Get.toNamed(RouteName.googleMap);
                          break;
                      }
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      child: Row(
                        children: [
                          Icon(
                            _profile[index]['icon'],
                            size: 40,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            _profile[index]['title'],
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey[700]),
                          )
                        ],
                      ),
                    ),
                  );
                }),
              ),
              InkWell(
                onTap: () {
                  // _cacheProfile.deleteAll();
                  // Get.offAllNamed(RouteName.loginView);
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 4),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.blue),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: const Center(
                                      child: Text(
                                        "No",
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _authViewModel.logoutViewModel();
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 4),
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: const Center(
                                        child: Text(
                                          "Yes",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.logout_outlined,
                        size: 40,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Logout",
                        style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              _profilePicFile != null
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: CommonBtn(
                        callback: () {
                          debugPrint("Image Base64: $_base64Image");
                        },
                        label: 'Update Profile',
                        isLoading: false,
                        color: btnColor,
                        textStyle: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      );
    });
  }
}
