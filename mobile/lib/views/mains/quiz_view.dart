import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:mobile/res/routes/route_name.dart';

import '../../data/enum.dart';
import '../../res/url_base.dart';
import '../../res/user_info.dart';
import '../../view_models/room_view_model.dart';

class QuizeView extends StatefulWidget {
  final int subJectId;
  const QuizeView({super.key, required this.subJectId});

  @override
  State<QuizeView> createState() => _QuizeViewState();
}

class _QuizeViewState extends State<QuizeView> {
  final _roomViewModel = Get.put(RoomViewModel());
  int? pages;
  bool isReady = false;
  
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _roomViewModel.readQuiz(widget.subJectId);
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
          return _buildMidterm();
      }
    });
  }

  Widget _buildMidterm() {
    double width = MediaQuery.of(context).size.width;
    return Obx(() {
      var data = _roomViewModel.quizModel.value;
      if (data.quiz.quiz.isEmpty) {
        return const Center(
          child: Text(
            "No Quiz",
            style: TextStyle(fontSize: 18),
          ),
        );
      }
      return SingleChildScrollView(
        child: Column(
          children: List.generate(data.quiz.quiz.length, (index) {
            var midterm = data.quiz.quiz[index];
            return InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                image.value = midterm.image ?? "";
                taskId.value = midterm.id;
                questionQuiz.value = midterm.title;
                Get.toNamed(RouteName.cmtQuiz);
                var img = midterm.image;
                debugPrint("file: ${midterm.image}");
                debugPrint("Extension file: ${img?.split('.').last}");
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
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Text(
                            midterm.title,
                            style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                          ),
                        )),
                    SizedBox(
                      child: midterm.image == null
                          ? const SizedBox.shrink()
                          : midterm.image?.split('.').last == 'png' || midterm.image?.split('.').last == 'jpeg' || midterm.image?.split('.').last == 'jfif' || midterm.image?.split('.').last == 'jpg'
                              ? Container(
                                  width: width * 0.4,
                                  height: MediaQuery.of(context).size.height * 0.2,
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        hostImg + midterm.image.toString()), 
                                        fit: BoxFit.fill)),
                                )
                              : midterm.image?.split('.').last == 'pdf'
                                  ? InkWell(
                                      // onTap: () async {
                                      //   final url = Uri.parse(hostImg + midterm.image.toString());
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
                                        child: SfPdfViewer.network(hostImg + midterm.image.toString()),
                                      ),
                                    )
                                  : midterm.image?.split('.').last == 'doc' || midterm.image?.split('.').last == 'docx'
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
                          midterm.dateTime ?? "No Time",
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
      );
    });
  }
}
