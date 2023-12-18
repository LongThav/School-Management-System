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
import 'package:photo_view/photo_view.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../commons/common_start.dart';
import '../../res/user_info.dart';
import '../students/quiz_answer_dialog.dart';

class DetialQuizView extends StatefulWidget {
  final String question;
  final String image;
  final int taskId;
  final int subjectId;
  const DetialQuizView({super.key, required this.taskId, required this.question, required this.image, required this.subjectId});

  @override
  State<DetialQuizView> createState() => _DetialQuizViewState();
}

class _DetialQuizViewState extends State<DetialQuizView> {
  final TextEditingController _cmtQuiz = TextEditingController();
  final TextEditingController _submitQuizctrl = TextEditingController();
  final CacheProfile _cacheProfile = CacheProfile();
  final _progressViewModel = Get.put(ProgressInTaskViewModel());

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
      _progressViewModel.readCmtQuize(widget.taskId);
      _progressViewModel.readAnswerPerQuiz(widget.taskId);
      init();
    });
    super.initState();
  }

  @override
  void dispose() {
    _cmtQuiz.dispose();
    _submitQuizctrl.dispose();
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
          "Check Quiz",
          style: TextStyle(color: btnColor),
        ),
        titleSpacing: -10,
        actions: [
          Obx(() {
            var data = _progressViewModel.answerQuizModel.value.quiz.getAnswer;
            return SizedBox(
                child: _roleUser == 'Student'
                    ? data == null
                        ? InkWell(
                            onTap: () async {
                              await showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return Obx(() {
                                      return CommonSubmitDialog(
                                        question: widget.question,
                                        controller: _submitQuizctrl,
                                        hindText: "Start do your task...",
                                        label: "Submit",
                                        isLoading: _progressViewModel.loadingAnswerQuiz.value,
                                        callback: () {
                                          if (_submitQuizctrl.text.isEmpty) {
                                            snackBar(context, "Please write your answer...");
                                          } else {
                                            "SubjectID: ${widget.subjectId}".log();
                                            "TaskID: ${widget.taskId}".log();
                                            _progressViewModel.addedAnswerQuiz(widget.subjectId.toString(), widget.taskId.toString(), _submitQuizctrl.text, context);
                                            Future.delayed(const Duration(milliseconds: 300), () {
                                              _submitQuizctrl.text = " ";
                                            });
                                          }
                                        },
                                      );
                                    });
                                  });
                              _progressViewModel.readAnswerPerQuiz(widget.taskId);
                            },
                            child: const CommonStart(label: 'Start do'))
                        : InkWell(
                            onTap: () {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) => QuizAnswerDialog(
                                        quizId: widget.taskId,
                                      ));
                            },
                            child: const CommonStart(
                              label: 'Check Your Answer',
                            ))
                    : InkWell(
                      onTap: (){
                        quizId.value = widget.taskId;
                        "QuizId: ${quizId.value}".log();
                        Get.toNamed(RouteName.allQuizSubmit);
                      },
                      child: const CommonStart(
                        label: 'Check List Student Submit')
                        
                      )
                  );
          })
        ],
      ),
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: SizedBox(
                width: width,
                height: height,
                child: widget.image.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                        child: Center(
                          child: Text(
                            widget.question,
                            style: const TextStyle(fontSize: 20, letterSpacing: 0.5),
                          ),
                        ),
                      )
                    : widget.image.split('.').last == 'png' || widget.image.split('.').last == 'jpeg' || widget.image.split('.').last == 'jpg' || widget.image.split('.').last == 'jfif'
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    widget.question,
                                    style: const TextStyle(fontSize: 20, letterSpacing: 0.5),
                                  ),
                                ),
                                InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: () {
                                    debugPrint("View Photo");
                                    Get.to(() => ViewPhoto(img: widget.image));
                                  },
                                  child: Container(
                                    width: width * 0.4,
                                    height: MediaQuery.of(context).size.height * 0.2,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), image: DecorationImage(image: NetworkImage(hostImg + widget.image.toString()), fit: BoxFit.fill)),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    widget.question,
                                    style: const TextStyle(fontSize: 20, letterSpacing: 0.5),
                                  ),
                                ),
                                InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: () async {
                                    final url = Uri.parse(hostImg + widget.image.toString());
                                    if (await canLaunchUrl(url)) {
                                      launchUrl(url);
                                    } else {
                                      // ignore: avoid_print
                                      debugPrint("Can't launch $url");
                                    }
                                  },
                                  child: Container(
                                    width: width * 0.4,
                                    height: MediaQuery.of(context).size.height * 0.2,
                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: SfPdfViewer.network(hostImg + widget.image.toString()),
                                  ),
                                ),
                              ],
                            ),
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
                              controller: _cmtQuiz,
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
                              if (_cmtQuiz.text.isEmpty) {
                                snackBar(context, "Please write something...");
                              } else if (widget.subjectId.toString().isEmpty || widget.taskId.toString().isEmpty) {
                                snackBar(context, "You don't have permission leave question!");
                              } else {
                                debugPrint("title: ${_cmtQuiz.text}");
                                debugPrint("SubjectId: ${widget.subjectId.toString()}");
                                debugPrint("Quzid: ${widget.taskId.toString()}");
                                _progressViewModel.addCmtQuiz(_cmtQuiz.text, widget.subjectId.toString(), widget.taskId.toString());
                                _progressViewModel.readCmtQuize(widget.taskId);
                                Future.delayed(const Duration(milliseconds: 400), () {
                                  _cmtQuiz.text = "";
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
                            if (_progressViewModel.cmtQuizModel.value.quize.cmt.isEmpty) {
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
                                _progressViewModel.readCmtQuize(widget.taskId);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(top: 10),
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                width: width,
                                height: height * 0.57,
                                child: ListView.builder(
                                    itemCount: _progressViewModel.cmtQuizModel.value.quize.cmt.length,
                                    itemBuilder: (context, index) {
                                      var data = _progressViewModel.cmtQuizModel.value.quize.cmt[index];
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

class ViewPhoto extends StatelessWidget {
  final String img;
  const ViewPhoto({super.key, required this.img});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: PhotoView(imageProvider: NetworkImage(hostImg + img)),
          ),
        ),
      ),
    );
  }
}
