import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/enum.dart';
import 'package:mobile/models/result_model.dart';
import 'package:mobile/res/colors/color.dart';
import 'package:mobile/utils/logo.dart';

import '../../view_models/final_exam_view_model.dart';

class ResultView extends StatefulWidget {
  const ResultView({super.key});

  @override
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  final _finalExam = Get.put(FinalExamViewModel());
  late final List<Result> _resultModel = [];

  @override
  void initState() {
    _finalExam.readResult();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Text(
          "Result",
          style: TextStyle(color: btnColor),
        ),
      ),
      body: Obx(() {
        switch (_finalExam.loadingStatus.value) {
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
            if (_finalExam.resultModel.value.result.isEmpty) {
              return const Center(
                child: Text("No Result!"),
              );
            } else {
              for (var result in _finalExam.resultModel.value.result) {
                if (result.file != "test" && result.title != "test") {
                  _resultModel.add(result);
                } else {
                  "else condition".log();
                  return const Center(
                    child: Text("No Result!"),
                  );
                }
              }
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: List.generate(_resultModel.length, (index) {
                  return const Text("Have");
                }),
              ),
            );
        }
      }),
    );
  }
}
