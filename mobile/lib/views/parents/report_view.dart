import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/enum.dart';
import 'package:mobile/res/colors/color.dart';

import '../../commons/common_txt_style.dart';
import '../../view_models/final_exam_view_model.dart';

class ReportView extends StatefulWidget {
  const ReportView({super.key});

  @override
  State<ReportView> createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView> {
  final _event = Get.put(FinalExamViewModel());
  @override
  void initState() {
    _event.readEvent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text(
          "Report",
          style: TextStyle(color: btnColor),
        ),
      ),
      body: Obx(() {
        switch (_event.loadingStatus.value) {
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
            return RefreshIndicator(
              onRefresh: () async {
                _event.readEvent();
              },
              child: ListView.builder(
                  itemCount: _event.eventModel.value.event.length,
                  itemBuilder: (context, index) {
                    var data = _event.eventModel.value.event[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.blue[300],
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
                      ),
                      child: Column(
                        children: [
                          CommonTxtStyle(
                            label: data.eventTitle ?? "",
                            fontSize: 20,
                            color: Colors.white,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: CommonTxtStyle(
                              label: data.dateTime ?? "No Time",
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            );
        }
      }),
    );
  }
}
