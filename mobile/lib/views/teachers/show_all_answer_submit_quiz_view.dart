import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/commons/common_txt_style.dart';
import 'package:mobile/data/enum.dart';
import 'package:mobile/res/colors/color.dart';
import 'package:mobile/utils/snack_bar.dart';

import '../../commons/common_btn_form.dart';
import '../../view_models/progress_in_task_view.dart';
import '../../view_models/room_view_model.dart';

class AllAnswerQuizSubmitView extends StatefulWidget {
  final int quizId;
  const AllAnswerQuizSubmitView({super.key, required this.quizId});

  @override
  State<AllAnswerQuizSubmitView> createState() => _AllAnswerQuizSubmitViewState();
}

class _AllAnswerQuizSubmitViewState extends State<AllAnswerQuizSubmitView> {
  final _progressViewModel = Get.put(ProgressInTaskViewModel());
  final _roomView = Get.put(RoomViewModel());
  final TextEditingController _scoreCtrl = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _progressViewModel.readAllAnswerQuizSubmited(widget.quizId);
    });
    super.initState();
  }

  @override
  void dispose() {
    _scoreCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: btnColor,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        elevation: 0.0,
        title: const CommonTxtStyle(
          label: 'Show List Student Submited',
          color: btnColor,
        ),
        titleSpacing: -10,
      ),
      body: _buildbody(),
    );
  }

  Widget _buildbody() {
    return Obx(() {
      switch (_progressViewModel.loadingQuiz.value) {
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
          if(_progressViewModel.allAnswerQuizModdel.value.answerQuiz.allAnswer.isEmpty){
            return const Center(child: CommonTxtStyle(label: "No Student Submited", fontSize: 18,),);
          }
          return RefreshIndicator(
            onRefresh: () async {
              _progressViewModel.readAllAnswerQuizSubmited(widget.quizId);
            },
            child: ListView.builder(
                itemCount: _progressViewModel.allAnswerQuizModdel.value.answerQuiz.allAnswer.length,
                itemBuilder: (context, index) {
                  var data = _progressViewModel.allAnswerQuizModdel.value.answerQuiz.allAnswer[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                    onTap: () {
                      _progressViewModel.readWhoSubmit(data.userId);
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return Dialog(
                              insetPadding: const EdgeInsets.symmetric(horizontal: 10),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height * 0.6,
                                child: Obx(() {
                                  switch (_progressViewModel.loadingStatus.value) {
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
                                      var info = _progressViewModel.whoSubmitModel.value;
                                      return SingleChildScrollView(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(right: 15),
                                              child: Align(
                                                alignment: Alignment.centerRight,
                                                child: IconButton(
                                                  icon: const Icon(
                                                    Icons.clear,
                                                    size: 30,
                                                    color: btnColor,
                                                  ),
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: CommonTxtStyle(
                                                label: "Name: ${info.data.username}",
                                                fontSize: 18,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: CommonTxtStyle(
                                                label: "ID: ${info.data.codeId.codeId}",
                                                fontSize: 18,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 20),
                                              child: TextField(
                                                keyboardType: TextInputType.number,
                                                controller: _scoreCtrl,
                                                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), hintText: "Input Score"),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Obx(() => Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                                  child: CommonBtn(
                                                    label: "Set Score",
                                                    color: btnColor,
                                                    textStyle: const TextStyle(fontSize: 18, color: Colors.white),
                                                    callback: () {
                                                      if (_scoreCtrl.text.isEmpty) {
                                                        snackBar(context, "Please input score");
                                                      } else {
                                                        _roomView.addScoreQuiz(data.id, _scoreCtrl.text);
                                                        Future.delayed(const Duration(milliseconds: 300));
                                                        _progressViewModel.readAllAnswerQuizSubmited(widget.quizId);
                                                      }
                                                      Future.delayed(const Duration(milliseconds: 300), () {
                                                        _scoreCtrl.text = "";
                                                      });
                                                    },
                                                    isLoading: _roomView.addScoreLoadingQuiz.value,
                                                  ),
                                                ))
                                          ],
                                        ),
                                      );
                                  }
                                }),
                              ),
                            );
                          });
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    leading: CommonTxtStyle(
                      label: '${index + 1}',
                      fontSize: 18,
                      color: Colors.grey[700],
                    ),
                    title: CommonTxtStyle(
                      label: data.title,
                      fontSize: 18,
                      color: Colors.grey[700],
                    ),
                    trailing: CommonTxtStyle(
                      label: data.score == null ? "Score: 0.0" : "Score: ${data.score}",
                      fontSize: 17,
                      color: Colors.red,
                    ),
                  );
                }),
          );
      }
    });
  }
}
