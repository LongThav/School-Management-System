import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/commons/common_txt_style.dart';
import 'package:mobile/data/enum.dart';
import 'package:mobile/res/colors/color.dart';
import 'package:mobile/res/routes/route_name.dart';
import 'package:mobile/res/url_base.dart';
import 'package:mobile/utils/logo.dart';
import 'package:mobile/utils/snack_bar.dart';
import 'package:mobile/view_models/room_view_model.dart';
import '../../commons/common_start.dart';
import 'package:mobile/view_models/progress_in_task_view.dart';

import '../../commons/common_dialog_submit.dart';
import '../../exports.dart';
import '../../res/user_info.dart';
import '../students/midterm_answer_diglog.dart';
import 'detail_quiz_view.dart';

class DetailMidtermView extends StatefulWidget {
  final String question;
  final String image;
  final int midtermTaskId;
  final int subjectId;
  const DetailMidtermView({super.key, required this.midtermTaskId, required this.question, required this.image, required this.subjectId});

  @override
  State<DetailMidtermView> createState() => _DetailMidtermViewState();
}

class _DetailMidtermViewState extends State<DetailMidtermView> {
  final TextEditingController _cmtMidterm = TextEditingController();
  final CacheProfile _cacheProfile = CacheProfile();
  final TextEditingController _submitMidterm = TextEditingController();
  final _progressViewModel = Get.put(ProgressInTaskViewModel());
  final _roomViewModel = Get.put(RoomViewModel());

  String _roleUser = '';

  void init() async {
    String role = await _cacheProfile.readRole();
    'RoleUser: $role'.log();
    setState(() {
      _roleUser = role;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _progressViewModel.readMidterm(widget.midtermTaskId);
      _roomViewModel.readAnswerMidterm(widget.midtermTaskId);
      init();
    });
    super.initState();
  }

  @override
  void dispose() {
    _cmtMidterm.dispose();
    _submitMidterm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    "_roleUser: $_roleUser".log();
    "Midterm ID: ${widget.midtermTaskId}".log();
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
          "Check Midterm",
          style: TextStyle(color: btnColor),
        ),
        titleSpacing: -10,
        actions: [
          Obx(() {
            var data = _roomViewModel.answerMidtermModel.value.midterm;
            "Loading status: ${_roomViewModel.answerMidterm.value}".log();
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
                                        question: widget.question,
                                        controller: _submitMidterm,
                                        hindText: "Start do your task...",
                                        label: "Submit",
                                        isLoading: _roomViewModel.answerMidterm.value,
                                        callback: () {
                                          if (_submitMidterm.text.isEmpty) {
                                            snackBar(context, "Please write your answer...");
                                          } else {
                                            "SubjectId: ${widget.subjectId}".log();
                                            "MidtermId: ${widget.midtermTaskId}".log();
                                            _roomViewModel.answerMidtermQuestion(widget.subjectId.toString(), widget.midtermTaskId.toString(), _submitMidterm.text, context);
                                            Future.delayed(const Duration(milliseconds: 500), () {
                                              _submitMidterm.text = " ";
                                            });
                                          }
                                        },
                                      );
                                    });
                                  });
                              _roomViewModel.readAnswerMidterm(widget.midtermTaskId);
                            },
                            child: const CommonStart(
                              label: "Start do",
                            ))
                        : InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => MidtermAnswerDailog(
                                        midtermId: widget.midtermTaskId,
                                      ));
                            },
                            child: const CommonStart(label: "Check Your Answer"))
                    : InkWell(
                        onTap: () {
                          midtermId.value = widget.midtermTaskId;
                          Get.toNamed(RouteName.allMidtermSubmit);
                        },
                        child: const CommonStart(label: "Check List Student Submit")));
          })
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
                            widget.question,
                            style: const TextStyle(fontSize: 20, letterSpacing: 0.5),
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.question,
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
                              controller: _cmtMidterm,
                              maxLength: null,
                              maxLines: null,
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
                              } else if (widget.subjectId.toString().isEmpty || widget.midtermTaskId.toString().isEmpty) {
                                snackBar(context, "You don't have permission leave question!");
                              } else {
                                debugPrint("title: ${_cmtMidterm.text}");
                                debugPrint("SubjectId: ${widget.subjectId.toString()}");
                                debugPrint("Quzid: ${widget.midtermTaskId.toString()}");
                                _progressViewModel.addCmtMidterm(_cmtMidterm.text, widget.subjectId.toString(), widget.midtermTaskId.toString());
                                _progressViewModel.readMidterm(widget.midtermTaskId);
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
                            if (_progressViewModel.cmtMidtermModel.value.midterm.cmt.isEmpty) {
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
                                _progressViewModel.readMidterm(widget.midtermTaskId);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(top: 10),
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                width: width,
                                height: height * 0.57,
                                child: ListView.builder(
                                    itemCount: _progressViewModel.cmtMidtermModel.value.midterm.cmt.length,
                                    itemBuilder: (context, index) {
                                      var data = _progressViewModel.cmtMidtermModel.value.midterm.cmt[index];
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
                                          Container(
                                            margin: const EdgeInsets.symmetric(vertical: 10),
                                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                            decoration: BoxDecoration(color: Colors.blue[100], borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), bottomRight: Radius.circular(15))),
                                            child: CommonTxtStyle(
                                              fontSize: 17,
                                              label: data.title,
                                              color: Colors.grey[700],
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
