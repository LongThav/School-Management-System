import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/commons/common_txt_style.dart';
import 'package:mobile/data/enum.dart';
import 'package:mobile/res/colors/color.dart';
import 'package:mobile/res/url_base.dart';
import 'package:mobile/utils/snack_bar.dart';

import '../../commons/common_check_current_location_student.dart';
import '../../view_models/class_view_model.dart';

class ClassStudentView extends StatefulWidget {
  const ClassStudentView({super.key});

  @override
  State<ClassStudentView> createState() => _ClassStudentViewState();
}

class _ClassStudentViewState extends State<ClassStudentView> {
  final ClassViewModdel _classViewModdel = Get.put(ClassViewModdel());
  final TextEditingController _searchCtrl = TextEditingController();
  @override
  void initState() {
    _classViewModdel.readStudent();
    super.initState();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: const Text(
            "Room Mate",
            style: TextStyle(color: btnColor, letterSpacing: 1),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 16, right: 15),
              child: Text(
                "Class: ${className.value}",
                style: TextStyle(letterSpacing: 0.5, fontSize: 18, color: Colors.grey[700]),
              ),
            )
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 0),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _searchCtrl,
                decoration: const InputDecoration(border: InputBorder.none, hintText: "Search name or id", hintStyle: TextStyle(fontSize: 18), prefixIcon: Icon(Icons.search)),
              ),
            ),
          ),
        ),
        body: _buildCheckStatus());
  }

  Widget _buildCheckStatus() {
    return Obx(() {
      switch (_classViewModdel.loadingStatus.value) {
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
      var data = _classViewModdel.classMateModel;
      return RefreshIndicator(
        onRefresh: () async {
          _classViewModdel.readStudent();
        },
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: data.value.data?.students?.length,
            itemBuilder: (context, index) {
              var student = data.value.data?.students?[index];
              return Padding(
                padding: const EdgeInsets.only(top: 15),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  onTap: () {
                    if(student?.lat == null && student?.long == null){
                      snackBar(context, "Student doesn't allow GPS");
                    }else{
                      showDialog(context: context, builder: (context){
                      return CommonCheckCurrentLocation(
                        name: student?.name ?? "", 
                        infoId: student?.id ?? 0, 
                        codeId: student?.codeId ?? ""
                      );
                    });
                    }
                  },
                  leading: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(shape: BoxShape.circle, image: student?.image == null ? const DecorationImage(image: AssetImage("assets/imgs/no-profile.png"), fit: BoxFit.fill) : DecorationImage(image: NetworkImage(hostImg + student!.image.toString()), fit: BoxFit.fill)),
                  ),
                  title: CommonTxtStyle(
                    fontSize: 18,
                    label: "Name: ${student?.name ?? "No Name"}",
                    color: Colors.grey[700],
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: CommonTxtStyle(
                      fontSize: 18,
                      label: "ID: ${student?.codeId ?? ""}",
                      color: Colors.grey[700],
                    ),
                  ),
                  trailing: student?.codeId == codeId.value
                      ? const CircleAvatar(
                          radius: 12,
                          child: Text(
                            'Me',
                            style: TextStyle(fontSize: 11, color: Colors.white),
                          ))
                      : null,
                ),
              );
            }),
      );
    });
  }
}
