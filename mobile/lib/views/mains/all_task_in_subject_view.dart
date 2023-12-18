import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:mobile/res/colors/color.dart';

import '../../data/enum.dart';
import '../../res/routes/route_name.dart';
import '../../res/url_base.dart';
import '../../res/user_info.dart';
import '../../view_models/room_view_model.dart';

class AllTaskInSubjectView extends StatefulWidget {
  final int subejctid;
  const AllTaskInSubjectView({super.key, required this.subejctid});

  @override
  State<AllTaskInSubjectView> createState() => _AllTaskInSubjectViewState();
}

class _AllTaskInSubjectViewState extends State<AllTaskInSubjectView> {
  final RoomViewModel _roomViewModel = Get.put(RoomViewModel(), permanent: true);
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timings) {
      _roomViewModel.readAllTasKInSubjecct(widget.subejctid);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
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
          return _buildAllTask();
      }
    });
  }

  Widget _buildAllTask() {
    double width = MediaQuery.of(context).size.width;
    return Obx(() {
      var data = _roomViewModel.allTaskInSubjectModel.value.allTask;
      if (data.assignment.isEmpty && data.quize.isEmpty && data.midterm.isEmpty) {
        return const Center(
          child: Text(
            "No Task",
            style: TextStyle(fontSize: 18),
          ),
        );
      } else if (data.quize.isEmpty || data.assignment.isNotEmpty || data.midterm.isEmpty) {
        data;
      } else if (data.assignment.isEmpty || data.quize.isEmpty || data.midterm.isNotEmpty) {
        data;
      } else if (data.assignment.isNotEmpty || data.quize.isNotEmpty || data.midterm.isEmpty) {
        data;
      } else if (data.assignment.isNotEmpty && data.quize.isNotEmpty && data.midterm.isNotEmpty) {
        data;
      }
      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: [
            SizedBox(
              child: data.quize.isEmpty
                  ? const SizedBox.shrink()
                  : Container(
                      width: width,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: btnColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Quize",
                                style: TextStyle(fontSize: 18),
                              )),
                          Column(
                            children: List.generate(data.quize.length, (index) {
                              var item = data.quize[index];
                              return InkWell(
                                onTap: () {
                                  image.value = item.image ?? "";
                                  taskId.value = item.id;
                                  questionQuiz.value = item.title;
                                  Get.toNamed(RouteName.cmtQuiz);
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(vertical: 15),
                                  width: width,
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  decoration: BoxDecoration(
                                    color: Colors.purple[100],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    children: [
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 15),
                                            child: Text(
                                              item.title,
                                              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                                            ),
                                          )),
                                      SizedBox(
                                        child: item.image == null
                                            ? const SizedBox.shrink()
                                            : item.image?.split('.').last == 'png' || item.image?.split('.').last == 'jpeg' || item.image?.split('.').last == 'jfif' || item.image?.split('.').last == 'jpg'
                                                ? Container(
                                                    width: width * 0.4,
                                                    height: MediaQuery.of(context).size.height * 0.2,
                                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), image: DecorationImage(image: NetworkImage(hostImg + item.image.toString()), fit: BoxFit.fill)),
                                                  )
                                                : item.image?.split('.').last == 'pdf'
                                                    ? InkWell(
                                                        // onTap: () async {
                                                        //   final url = Uri.parse(hostImg + item.image.toString());
                                                        //   if (await canLaunchUrl(url)) {
                                                        //     launchUrl(url);
                                                        //   } else {
                                                        //     // ignore: avoid_print
                                                        //     debugPrint("Can't launch $url");
                                                        //   }
                                                        //   debugPrint(hostImg + midterm.image.toString());
                                                        // },
                                                        child: Container(
                                                          width: width * 0.4,
                                                          height: MediaQuery.of(context).size.height * 0.2,
                                                          padding: const EdgeInsets.symmetric(horizontal: 15),
                                                          decoration: BoxDecoration(
                                                            color: Colors.grey,
                                                            borderRadius: BorderRadius.circular(12),
                                                          ),
                                                          child: SfPdfViewer.network(hostImg + item.image.toString()),
                                                        ),
                                                      )
                                                    : item.image?.split('.').last == 'doc' || item.image?.split('.').last == 'docx'
                                                        ? const Center(
                                                            child: Text("File Word"),
                                                          )
                                                        : null,
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 15),
                                          child: Text(
                                            item.dateTime ?? "No Time",
                                            style: TextStyle(color: Colors.grey[700]),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              child: data.midterm.isEmpty
                  ? null
                  : Container(
                      width: width,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: btnColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Midterm",
                                style: TextStyle(fontSize: 18),
                              )),
                          Column(
                            children: List.generate(data.midterm.length, (index) {
                              var item = data.midterm[index];
                              return InkWell(
                                onTap: () {
                                  midtermImage.value = item.image ?? "";
                                  questionMidterm.value = item.title;
                                  midtermTaskId.value = item.id;
                                  Get.toNamed(RouteName.cmtMidterm);
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(vertical: 15),
                                  width: width,
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  decoration: BoxDecoration(
                                    color: Colors.purple[100],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    children: [
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 15),
                                            child: Text(
                                              item.title,
                                              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                                            ),
                                          )),
                                      SizedBox(
                                        child: item.image == null
                                            ? const SizedBox.shrink()
                                            : Container(
                                                width: width * 0.4,
                                                height: MediaQuery.of(context).size.height * 0.2,
                                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                                decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(hostImg + item.image.toString()), fit: BoxFit.fill)),
                                              ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 15),
                                          child: Text(
                                            item.dateTime ?? "No Time",
                                            style: TextStyle(color: Colors.grey[700]),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              child: data.assignment.isEmpty
                  ? null
                  : Container(
                      width: width,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: btnColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Assignment",
                                style: TextStyle(fontSize: 18),
                              )),
                          Column(
                            children: List.generate(data.assignment.length, (index) {
                              var item = data.assignment[index];
                              return InkWell(
                                onTap: () {
                                  assignmentId.value = item.id;
                                  assignmentImage.value = item.image ?? "";
                                  questionAssignment.value = item.title;
                                  Get.toNamed(RouteName.cmtAssignment);
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(vertical: 15),
                                  width: width,
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  decoration: BoxDecoration(
                                    color: Colors.purple[100],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    children: [
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 15),
                                            child: Text(
                                              item.title,
                                              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                                            ),
                                          )),
                                      SizedBox(
                                        child: item.image == null
                                            ? const SizedBox.shrink()
                                            : Container(
                                                width: width * 0.4,
                                                height: MediaQuery.of(context).size.height * 0.2,
                                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                                decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(hostImg + item.image.toString()), fit: BoxFit.fill)),
                                              ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 15),
                                          child: Text(
                                            item.dateTime ?? "No Time",
                                            style: TextStyle(color: Colors.grey[700]),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      );
    });
  }
}
