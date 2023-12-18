import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/commons/common_btn_form.dart';
import 'package:mobile/db_helpers/cache_id.dart';
import 'package:mobile/res/colors/color.dart';
import 'package:mobile/utils/snack_bar.dart';
import 'package:mobile/view_models/room_view_model.dart';

class QuizDialog extends StatefulWidget {
  final int subjectId;
  const QuizDialog({super.key, required this.subjectId});

  @override
  State<QuizDialog> createState() => _QuizDialogState();
}

class _QuizDialogState extends State<QuizDialog> {
  final RoomViewModel _roomViewModel =
      Get.put(RoomViewModel(), permanent: true);
  final CacheId _cacheId = CacheId();
  late final TextEditingController _txtCtrl = TextEditingController();
  String _classId = "";
  void init() async {
    _classId = await _cacheId.readClassId();
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    _txtCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(15),
        width: width,
        margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Create Quize",
                    style: TextStyle(
                        fontSize: 18,
                        color: btnColor,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.clear_outlined,
                        color: btnColor,
                        size: 30,
                      ))
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 15, bottom: 20, top: 0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  maxLength: null,
                  maxLines: null,
                  controller: _txtCtrl,
                  decoration: const InputDecoration(
                    border: InputBorder.none, hintText: "please input title",  
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(() {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: CommonBtn(
                      label: 'Create Quize',
                      color: btnColor,
                      textStyle:
                          const TextStyle(fontSize: 18, color: Colors.white),
                      callback: () {
                        if (_txtCtrl.text.isEmpty) {
                          snackBar(context, "Please input your quiz");
                        } else if (widget.subjectId.toString().isEmpty) {
                          snackBar(context, "You can't create quize");
                        } else if (_classId.isEmpty) {
                          snackBar(context, "You can't create quize");
                        } else {
                          _roomViewModel.createQuiz(_classId, _txtCtrl.text,
                              widget.subjectId.toString());
                          _roomViewModel.readQuiz(widget.subjectId);
                        }
                      },
                      isLoading: _roomViewModel.createQuizLoading.value),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
