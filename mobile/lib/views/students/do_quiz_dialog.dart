import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/commons/common_btn_form.dart';
import 'package:mobile/res/colors/color.dart';

class DoQuizDiaLog extends StatefulWidget {
  final String question;
  const DoQuizDiaLog({super.key, required this.question});

  @override
  State<DoQuizDiaLog> createState() => _DoQuizDiaLogState();
}

class _DoQuizDiaLogState extends State<DoQuizDiaLog> {
  final TextEditingController _answerCtrl = TextEditingController();
  @override
  void dispose() {
    _answerCtrl.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 10),
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: width,
        margin: const EdgeInsets.symmetric(horizontal:15),
        padding: EdgeInsets.only(bottom: height * 0.05),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: (){
                    Get.back();
                  }, icon: const Icon(Icons.clear, color: btnColor, size: 30,)
                ),
              ),
              const SizedBox(height: 15,),
              Align(
                alignment: Alignment.center,
                child: Text(widget.question, 
                style: const TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: height * 0.03,),
              Container(
                width: width,
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 25),
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: TextField(
                  controller: _answerCtrl,
                  maxLines: null,
                  style: const TextStyle(fontSize: 18, letterSpacing: 0.5),
                  maxLength: null,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Start do your task...',
                    hintStyle: TextStyle(
                      fontSize: 18
                    )
                  ),
                ),
              ),
              CommonBtn(
                label: "Submit", 
                color: btnColor, 
                textStyle: const TextStyle(fontSize: 18, color: Colors.white), 
                callback: (){}, 
                isLoading: false
              )
            ],
          ),
        ),
      ),
    );
  }
}
