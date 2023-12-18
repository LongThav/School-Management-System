import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/commons/common_dialog_submit.dart';
import 'package:mobile/commons/common_txt_style.dart';
import 'package:mobile/data/enum.dart';
import 'package:mobile/db_helpers/cache_profile.dart';
import 'package:mobile/res/colors/color.dart';
import 'package:mobile/res/routes/route_name.dart';
import 'package:mobile/res/url_base.dart';
import 'package:mobile/utils/logo.dart';
import 'package:mobile/utils/snack_bar.dart';
import 'package:mobile/view_models/progress_in_task_view.dart';

import '../../commons/common_start.dart';
import '../../res/user_info.dart';
import '../students/assignment_answer_dialog.dart';
import 'detail_quiz_view.dart';

class DetailAssignmentView extends StatefulWidget {
  final String questionAssignment;
  final String image;
  final int assignmentTaskId;
  final int subjectId;
  const DetailAssignmentView({super.key, required this.assignmentTaskId, required this.questionAssignment, required this.image, required this.subjectId});

  @override
  State<DetailAssignmentView> createState() => _DetailAssignmentViewState();
}

class _DetailAssignmentViewState extends State<DetailAssignmentView> {
  final TextEditingController _cmtMidterm = TextEditingController();
  final TextEditingController _submitAssignmentCtrl = TextEditingController();
  final CacheProfile _cacheProfile = CacheProfile();
  final _progressViewModel = Get.put(ProgressInTaskViewModel());

  String _roleUser = '';

  void init() async {
    String role = await _cacheProfile.readRole();
    setState(() {
      _roleUser = role;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _progressViewModel.readCmtAssignment(widget.assignmentTaskId);
      _progressViewModel.readAnswerAssignment(widget.assignmentTaskId);
      init();
    });
    super.initState();
  }

  @override
  void dispose() {
    _cmtMidterm.dispose();
    _submitAssignmentCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: btnColor,
            )),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Text(
          "Check Assignment",
          style: TextStyle(color: btnColor),
        ),
        titleSpacing: -10,
        actions: [
          Obx(() {
            var data = _progressViewModel.answerAssignmentModel.value.assignmentQuiz;
            return SizedBox(
                child: _roleUser == 'Student'
                    ? data.getAnswer == null
                        ? InkWell(
                            onTap: () async {
                              await showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return Obx(() {
                                      return CommonSubmitDialog(
                                        question: widget.questionAssignment,
                                        controller: _submitAssignmentCtrl,
                                        hindText: "Start do your task...",
                                        label: 'Submit',
                                        isLoading: _progressViewModel.answerAssignmentLoading.value,
                                        callback: () {
                                          if (_submitAssignmentCtrl.text.isEmpty) {
                                            snackBar(context, "Please write your answer");
                                          } else {
                                            "SubjectId: ${widget.subjectId}".log();
                                            "AssignmentId: ${widget.assignmentTaskId}".log();
                                            _progressViewModel.addAnswerAssignment(
                                              widget.subjectId.toString(),
                                              widget.assignmentTaskId.toString(),
                                              _submitAssignmentCtrl.text,
                                              context,
                                            );
                                          }
                                        },
                                      );
                                    });
                                  });
                              _progressViewModel.readAnswerAssignment(widget.assignmentTaskId);
                            },
                            child: const CommonStart(
                              label: 'Start do',
                            ))
                        : InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AssignmentAnswerDailog(
                                        assignmentId: widget.assignmentTaskId,
                                      ));
                            },
                            child: const CommonStart(label: 'Check Your Answer'))
                    : InkWell(
                        onTap: () {
                          assignmentsId.value = widget.assignmentTaskId;
                          Get.toNamed(RouteName.allAssignmentSubmit);
                        },
                        child: const CommonStart(label: 'Check List Student Submit')));
          }),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: SizedBox(
                width: width,
                height: height,
                child: widget.image.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Center(
                          child: Text(
                            widget.questionAssignment,
                            style: const TextStyle(fontSize: 20, letterSpacing: 0.5),
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.questionAssignment,
                              style: const TextStyle(fontSize: 20, letterSpacing: 0.5),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(() => ViewPhoto(
                                    img: widget.image,
                                  ));
                            },
                            child: Container(
                              width: width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.2,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), image: DecorationImage(image: NetworkImage(hostImg + widget.image.toString()), fit: BoxFit.fill)),
                            ),
                          ),
                        ],
                      ),
              )),
          Expanded(
              flex: 3,
              child: SizedBox(
                width: width,
                height: height,
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: width * 0.6,
                            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            alignment: Alignment.topCenter,
                            decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(8)),
                            child: TextField(
                              maxLength: null,
                              maxLines: null,
                              controller: _cmtMidterm,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Leave your question',
                                prefixIcon: Icon(Icons.comment_outlined),
                                prefixIconColor: Colors.grey,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (_cmtMidterm.text.isEmpty) {
                                snackBar(context, "Please write something...");
                              } else if (widget.subjectId.toString().isEmpty || widget.assignmentTaskId.toString().isEmpty) {
                                snackBar(context, "You don't have permission leave question!");
                              } else {
                                debugPrint("title: ${_cmtMidterm.text}");
                                debugPrint("SubjectId: ${widget.subjectId.toString()}");
                                debugPrint("Quzid: ${widget.assignmentTaskId.toString()}");
                                _progressViewModel.addCmtAssigment(_cmtMidterm.text, widget.subjectId.toString(), widget.assignmentTaskId.toString());
                                _progressViewModel.readCmtAssignment(widget.assignmentTaskId);
                                Future.delayed(const Duration(milliseconds: 400), () {
                                  _cmtMidterm.text = "";
                                });
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.blue[400],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(
                                child: Text(
                                  "Questions",
                                  style: TextStyle(fontSize: 18, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Obx(() {
                        switch (_progressViewModel.loadingStatus.value) {
                          case LoadingStatus.none:
                          case LoadingStatus.loading:
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: height * 0.25,
                                ),
                                const CircularProgressIndicator(),
                              ],
                            );
                          case LoadingStatus.error:
                            return const Center(
                              child: Text("Error"),
                            );
                          case LoadingStatus.complete:
                            if (_progressViewModel.cmtassignmentModel.value.assignment.cmt.isEmpty) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: height * 0.25,
                                  ),
                                  const CommonTxtStyle(fontSize: 18, label: "No Question here!")
                                ],
                              );
                            }
                            return RefreshIndicator(
                              onRefresh: () async {
                                _progressViewModel.readCmtAssignment(widget.assignmentTaskId);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(top: 10),
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                width: width,
                                height: height * 0.57,
                                child: ListView.builder(
                                    itemCount: _progressViewModel.cmtassignmentModel.value.assignment.cmt.length,
                                    itemBuilder: (context, index) {
                                      var data = _progressViewModel.cmtassignmentModel.value.assignment.cmt[index];
                                      return Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                              top: 25,
                                            ),
                                            child: Icon(
                                              Icons.person_outline,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Flexible(
                                            child: Container(
                                              margin: const EdgeInsets.symmetric(vertical: 10),
                                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                              decoration: BoxDecoration(color: Colors.blue[100], borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), bottomRight: Radius.circular(15))),
                                              child: CommonTxtStyle(
                                                fontSize: 17,
                                                label: data.title,
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                              ),
                            );
                        }
                      }),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
