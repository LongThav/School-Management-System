import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/commons/common_btn_form.dart';
import 'package:mobile/commons/common_txt_style.dart';
import 'package:mobile/data/enum.dart';
import 'package:mobile/res/colors/color.dart';
import 'package:mobile/utils/snack_bar.dart';

import '../../view_models/progress_in_task_view.dart';

class QuizAnswerDialog extends StatefulWidget {
  final int quizId;
  const QuizAnswerDialog({super.key, required this.quizId});

  @override
  State<QuizAnswerDialog> createState() => _QuizAnswerDialogState();
}

class _QuizAnswerDialogState extends State<QuizAnswerDialog> {
  final _progressViewModel = Get.put(ProgressInTaskViewModel());
  final TextEditingController _updateAnswerCtrl = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _progressViewModel.readAnswerPerQuiz(widget.quizId);
    });
    super.initState();
  }

  @override
  void dispose() {
    _updateAnswerCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 30),
        height: MediaQuery.of(context).size.height * 0.5,
        child: Obx(() {
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
              var data = _progressViewModel.answerQuizModel.value;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Align(
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
                    Align(
                      alignment: Alignment.center,
                      child: CommonTxtStyle(
                        fontSize: 20,
                        label: data.quiz.title,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: CommonTxtStyle(fontSize: 18, label: 'Your Answer'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CommonTxtStyle(
                      fontSize: 18,
                      label: data.quiz.getAnswer?.title ?? "",
                      color: Colors.grey[700],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    CommonBtn(
                      label: 'Update Answer',
                      color: btnColor,
                      textStyle: const TextStyle(fontSize: 18, color: Colors.white),
                      callback: () {
                        _updateAnswerCtrl.text = data.quiz.getAnswer?.title ?? "";
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                insetPadding: const EdgeInsets.symmetric(horizontal: 10),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.only(left: 15, right: 15, bottom: 30),
                                  height: MediaQuery.of(context).size.height * 0.5,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Align(
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
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        TextField(
                                          maxLength: null,
                                          maxLines: null,
                                          controller: _updateAnswerCtrl,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              hintText: "Please write your answer"),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Obx(() => CommonBtn(
                                              label: "Update Answer",
                                              color: btnColor,
                                              textStyle: const TextStyle(fontSize: 18, color: Colors.white),
                                              callback: () {
                                                if (_updateAnswerCtrl.text.isEmpty) {
                                                  snackBar(context, "Please write your answer");
                                                } else {
                                                  _progressViewModel.updateAnswerQuiz(data.quiz.getAnswer?.id ?? 0, _updateAnswerCtrl.text);
                                                  _progressViewModel.readAnswerPerQuiz(widget.quizId);
                                                }
                                              },
                                              isLoading: _progressViewModel.updateAnswerLoading.value,
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      isLoading: false,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: data.quiz.getAnswer?.score == null
                          ? const CommonTxtStyle(
                              label: "Score: 0.0",
                              fontSize: 20,
                              color: Colors.red,
                            )
                          : CommonTxtStyle(
                              label: 'Score: ${data.quiz.getAnswer?.score}',
                              fontSize: 20,
                              color: Colors.red,
                            ),
                    )
                  ],
                ),
              );
          }
        }),
      ),
    );
  }
}
