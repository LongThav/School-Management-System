import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:mobile/res/colors/color.dart';

class CommonSubmitDialog extends StatelessWidget {
  final String question;
  final TextEditingController controller;
  final String hindText;
  final String label;
  final Callback callback;
  final bool isLoading;
  const CommonSubmitDialog({
    super.key,
    required this.question,
    required this.controller,
    required this.hindText,
    required this.callback,
    required this.label,
    required this.isLoading,
  });

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
        margin: const EdgeInsets.symmetric(horizontal: 15),
        padding: EdgeInsets.only(bottom: height * 0.05),
        color: Colors.white,
        child: SingleChildScrollView(
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
              const SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  question,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Container(
                width: width,
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 25),
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: controller,
                  maxLines: null,
                  style: const TextStyle(fontSize: 18, letterSpacing: 0.5),
                  maxLength: null,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(border: InputBorder.none, hintText: hindText, hintStyle: const TextStyle(fontSize: 18)),
                ),
              ),
              // CommonBtn(
              //   label: widget.label,
              //   color: btnColor,
              //   textStyle: const TextStyle(fontSize: 18, color: Colors.white),
              //   callback: widget.callback,
              //   isLoading: widget.isLoading,
              // )
              InkWell(
                onTap: callback,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: btnColor,
                  ),
                  child: Center(
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            label,
                            style: const TextStyle(fontSize: 18, color: Colors.white),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
