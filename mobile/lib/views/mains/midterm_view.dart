import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/enum.dart';
import 'package:mobile/res/routes/route_name.dart';
import 'package:mobile/res/url_base.dart';
import 'package:mobile/res/user_info.dart';
import 'package:mobile/view_models/room_view_model.dart';

class MidtermView extends StatefulWidget {
  final int subjectId;
  const MidtermView({super.key, required this.subjectId});

  @override
  State<MidtermView> createState() => _MidtermViewState();
}

class _MidtermViewState extends State<MidtermView> {
  final RoomViewModel _roomViewModel =
      Get.put(RoomViewModel(), permanent: true);
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _roomViewModel.readMidterm(widget.subjectId);
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
      var data = _roomViewModel.midTemModel.value;
      if (data.data.midterm.isEmpty) {
        return const Center(
          child: Text(
            "No Quiz",
            style: TextStyle(fontSize: 18),
          ),
        );
      }
      return SingleChildScrollView(
        child: Column(
          children: List.generate(data.data.midterm.length, (index) {
            var midterm = data.data.midterm[index];
            return InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                midtermImage.value = midterm.image ?? "";
                questionMidterm.value = midterm.title;
                midtermTaskId.value = midterm.id;
                Get.toNamed(RouteName.cmtMidterm);
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
                              padding: const EdgeInsets.symmetric(horizontal: 15),
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
