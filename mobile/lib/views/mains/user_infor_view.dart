import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/commons/common_btn_form.dart';
import 'package:mobile/commons/common_txt_style.dart';
import 'package:mobile/data/enum.dart';
import 'package:mobile/res/colors/color.dart';
import 'package:mobile/res/url_base.dart';
import 'package:mobile/view_models/profile_view_model.dart';

class UserInfoView extends StatefulWidget {
  final int userId;
  final String? email;
  const UserInfoView({super.key, required this.userId, required this.email});

  @override
  State<UserInfoView> createState() => _UserInfoViewState();
}

class _UserInfoViewState extends State<UserInfoView> {
  final ProfileViewModdel _profileViewModdel = Get.put(ProfileViewModdel());

  @override
  void initState() {
    debugPrint("UserId: ${widget.userId}");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _profileViewModdel.readUserInfor(widget.userId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleSpacing: -10,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: btnColor,
            )),
        title: const Text(
          "User Information",
          style: TextStyle(color: btnColor),
        ),
      ),
      body: _buildBody(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: CommonBtn(
          label: "Update Information", 
          color: btnColor, 
          textStyle: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500), 
          callback: (){}, 
          isLoading: false
        ),
      ),
    );
  }

  Widget _buildBody() {
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
          return _buildInfo();
      }
    });
  }

  Widget _buildInfo() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Obx(() {
      var data = _profileViewModdel.userInfoModel.value;
      var userInfo = data.data?.userInfor;
      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: width * 0.2,
                  height: height * 0.09,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                      image: data.data?.image != null
                          ? const DecorationImage(
                              image: AssetImage("assets/imgs/no-profile.png"),
                              fit: BoxFit.fill)
                          :  DecorationImage(
                              image: NetworkImage(hostImg + data.data!.image.toString()), fit: BoxFit.fill)),
                ),
                SizedBox(
                  width: width * 0.08,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(color: Colors.grey[700], fontSize: 18),
                        children: [
                          TextSpan(
                            text: "Name: ${userInfo?.name}\n",
                          ),
                          TextSpan(
                            text: "ID: ${userInfo?.codeId}\n",
                          ),
                        ]),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonTxtStyle(
                      color: Colors.grey[700],
                      fontSize: 18,
                      label: "Sex: ${userInfo?.sex}"),
                  CommonTxtStyle(
                      color: Colors.grey[700],
                      fontSize: 18,
                      label: "Age: ${userInfo?.age}"),
                  CommonTxtStyle(
                      color: Colors.grey[700],
                      fontSize: 18,
                      label: "Year: ${userInfo?.getYear?.year}"),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: CommonTxtStyle(
                  color: Colors.grey[700],
                  fontSize: 18,
                  label: "Class: ${userInfo?.className?.nameClass}"),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                CommonTxtStyle(
                    color: Colors.grey[700],
                    fontSize: 18,
                    label: "Khan: ${userInfo?.khan}"),
                const SizedBox(
                  width: 20,
                ),
                CommonTxtStyle(
                    color: Colors.grey[700],
                    fontSize: 18,
                    label: "Sangkat: ${userInfo?.sangkat}"),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                CommonTxtStyle(
                    color: Colors.grey[700],
                    fontSize: 18,
                    label: "City: ${userInfo?.city}"),
                const SizedBox(
                  width: 20,
                ),
                CommonTxtStyle(
                    color: Colors.grey[700],
                    fontSize: 18,
                    label: "Country: ${userInfo?.country}"),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: CommonTxtStyle(
                  color: Colors.grey[700],
                  fontSize: 18,
                  label: "Phone: ${userInfo?.phone}"),
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: CommonTxtStyle(
                  color: Colors.grey[700],
                  fontSize: 18,
                  label: "Email: ${widget.email ?? ""}"),
            ),
          ],
        ),
      );
    });
  }
}
