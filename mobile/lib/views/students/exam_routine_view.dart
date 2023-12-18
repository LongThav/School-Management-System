import 'package:flutter/material.dart';
import 'package:mobile/commons/common_txt_style.dart';
import 'package:mobile/view_models/final_exam_view_model.dart';
import 'package:mobile/view_models/room_view_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'package:mobile/res/colors/color.dart';
import '../../data/enum.dart';
import '../../res/url_base.dart';
import '../../view_models/class_view_model.dart';

class ExamRoutineView extends StatefulWidget {
  const ExamRoutineView({super.key});

  @override
  State<ExamRoutineView> createState() => _ExamRoutineViewState();
}

class _ExamRoutineViewState extends State<ExamRoutineView> {
  final ClassViewModdel _classViewModdel = Get.put(ClassViewModdel());
  final FinalExamViewModel _finalExamViewModel = Get.put(FinalExamViewModel());
  final RoomViewModel _roomViewModel = Get.put(RoomViewModel());
  @override
  void initState() {
    _classViewModdel.readStudent();
    _roomViewModel.readSubject();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Text(
          "Final Exam",
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
      ),
      body: Obx(() {
        switch (_roomViewModel.loadingStatus.value) {
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
      }),
    );
  }

  Widget _buildBody() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Obx(() {
      return RefreshIndicator(
        onRefresh: () async {
          _roomViewModel.readSubject();
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView.builder(
              itemCount: _roomViewModel.subJectModel.value.data.subject.length,
              itemBuilder: (context, index) {
                var data = _roomViewModel.subJectModel.value.data.subject[index];
                return InkWell(
                  onTap: () {
                    _finalExamViewModel.readFinalExamRepo(data.id);
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            insetPadding: const EdgeInsets.symmetric(horizontal: 10),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            child: Container(
                              width: width,
                              height: height * 0.6,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                              child: Obx(() {
                                switch (_finalExamViewModel.loadingStatus.value) {
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
                                    var data = _finalExamViewModel.finalExamModel.value.finals.finalExam;
                                    if (data.isEmpty) {
                                      return Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: IconButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                icon: const Icon(
                                                  Icons.clear,
                                                  color: btnColor,
                                                  size: 30,
                                                )),
                                          ),
                                          SizedBox(
                                            height: height * 0.17,
                                          ),
                                          const Center(
                                            child: CommonTxtStyle(
                                              label: "No Final Exam",
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                    return SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: IconButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                icon: const Icon(
                                                  Icons.clear,
                                                  color: btnColor,
                                                  size: 30,
                                                )),
                                          ),
                                          Text(
                                            "Subject Name: ${_finalExamViewModel.finalExamModel.value.finals.subjects.title}",
                                            style: const TextStyle(fontSize: 22),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Column(
                                            children: List.generate(data.length, (index) {
                                              return Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Flexible(
                                                        child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          "DateTime: ${data[index].dateTime}",
                                                          style: const TextStyle(fontSize: 18, color: btnColor),
                                                        ),
                                                        const Text(
                                                          "Link For Final Exam: ",
                                                          style: TextStyle(fontSize: 18),
                                                        ),
                                                      ],
                                                    )),
                                                    Flexible(
                                                      child: TextButton(
                                                          onPressed: () async {
                                                            final url = Uri.parse(data[index].title);
                                                            if (await canLaunchUrl(url)) {
                                                              launchUrl(url);
                                                            } else {
                                                              // ignore: avoid_print
                                                              debugPrint("Can't launch $url");
                                                            }
                                                          },
                                                          child: Text(data[index].title)),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),
                                          ),
                                        ],
                                      ),
                                    );
                                }
                              }),
                            ),
                          );
                        });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: width,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: btnColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(
                                "Subject: ${data.title}",
                                style: const TextStyle(fontSize: 18, color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Text(
                                "Class: ${className.value}",
                                style: const TextStyle(fontSize: 15, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          child: data.image == null
                              ? const SizedBox.shrink()
                              : Container(
                                  width: width,
                                  height: 60,
                                  decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(hostImg + data.image.toString()), fit: BoxFit.fill)),
                                ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      );
    });
  }
}
