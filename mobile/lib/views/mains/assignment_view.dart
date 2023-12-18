import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/res/routes/route_name.dart';
import 'package:mobile/res/user_info.dart';

import '../../data/enum.dart';
import '../../res/url_base.dart';
import '../../view_models/room_view_model.dart';

class AssignmentView extends StatefulWidget {
  final int subJectId;
  const AssignmentView({super.key, required this.subJectId});

  @override
  State<AssignmentView> createState() => _AssignmentViewState();
}

class _AssignmentViewState extends State<AssignmentView> {
  final RoomViewModel _roomViewModel =
      Get.put(RoomViewModel(), permanent: true);
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _roomViewModel.readAssignment(widget.subJectId);
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
      var data = _roomViewModel.assignmetModl.value;
      if (data.assignment.midterm.isEmpty) {
        return const Center(
          child: Text(
            "No Assignment",
            style: TextStyle(fontSize: 18),
          ),
        );
      }
      return SingleChildScrollView(
        child: Column(
          children: List.generate(data.assignment.midterm.length, (index) {
            var midterm = data.assignment.midterm[index];
            return InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                assignmentId.value = midterm.id;
                assignmentImage.value = midterm.image ?? "";
                questionAssignment.value = midterm.title;
                Get.toNamed(RouteName.cmtAssignment);
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
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            midterm.title,
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey[700]),
                          ),
                        )),
                    SizedBox(
                      child: midterm.image == null
                          ? const SizedBox.shrink()
                          : Container(
                              width: width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.2,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          hostImg + midterm.image.toString()),
                                      fit: BoxFit.fill)),
                            ),
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
