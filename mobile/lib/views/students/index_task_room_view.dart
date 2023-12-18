import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/db_helpers/cache_profile.dart';
import 'package:mobile/res/colors/color.dart';
import 'package:mobile/views/mains/all_task_in_subject_view.dart';
import 'package:mobile/views/teachers/assignment_dialog.dart';
import 'package:mobile/views/teachers/midterm_dialog.dart';

import '../../view_models/room_view_model.dart';
import '../mains/assignment_view.dart';
import '../mains/midterm_view.dart';
import '../mains/quiz_view.dart';
import '../teachers/quiz_dailog.dart';

class IndexTaskRoomView extends StatefulWidget {
  final int subJectId;
  final String subject;
  const IndexTaskRoomView({super.key, required this.subject, required this.subJectId});

  @override
  State<IndexTaskRoomView> createState() => _IndexTaskRoomViewState();
}

class _IndexTaskRoomViewState extends State<IndexTaskRoomView> {
  final PageController _pageView = PageController();
  final CacheProfile _cacheProfile = CacheProfile();
  final RoomViewModel _roomViewModel = Get.put(RoomViewModel());
  String _filterName = "";
  final List<String> _title = [
    'All',
    'Quiz',
    'Midterm',
    'Assignment'
  ];
  int _select = 0;
  String _role = '';

  void init() async {
    _role = await _cacheProfile.readRole();
    debugPrint("Role: $_role");
  }

  void _buildAdd() {
    if (_select == 1) {
      debugPrint("Quize");
      showDialog(
        context: context,
        builder: (context) => QuizDialog(
          subjectId: widget.subJectId,
        ),
      );
    } else if (_select == 2) {
      debugPrint("Midterm");
      showDialog(
        context: context,
        builder: (context) => MidtermDialog(
          subjectId: widget.subJectId,
        ),
      );
    } else if (_select == 3) {
      debugPrint("Assignment");
      showDialog(
        context: context,
        builder: (context) => AssignmentDialog(
          subjectId: widget.subJectId,
        ),
      );
    }
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    _pageView.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              _roomViewModel.readSubject();
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: btnColor,
            )),
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: -10,
        title: Text(
          widget.subject,
          style: const TextStyle(color: btnColor),
        ),
        actions: [
          SizedBox(
            child: _role == "Student"
                ? null
                : _select == 0
                    ? null
                    : InkWell(
                        onTap: () {
                          _buildAdd();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          margin: const EdgeInsets.only(right: 15, top: 5, bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.blue[600],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: _select == 0
                              ? null
                              : Center(
                                  child: Text(
                                    'Create: $_filterName',
                                    style: const TextStyle(fontSize: 18, color: Colors.white),
                                  ),
                                ),
                        ),
                      ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            _buildFilter(),
            const SizedBox(
              height: 10,
            ),
            _buildBodyFilter(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilter() {
    return SizedBox(
      height: 45,
      child: ListView.builder(
          itemCount: _title.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  _select = index;
                  _filterName = _title[index];
                });
                _pageView.jumpToPage(index);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                margin: const EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                  color: _select == index ? Colors.blue[600] : btnColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    _title[index],
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget _buildBodyFilter() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      height: height * 1.5,
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (value) {
          setState(() {
            _select = value;
          });
        },
        controller: _pageView,
        children: [
          SizedBox(
            width: width,
            height: height,
            child: AllTaskInSubjectView(
              subejctid: widget.subJectId,
            ),
          ),
          SizedBox(
              width: width,
              height: height,
              child: QuizeView(
                subJectId: widget.subJectId,
              )),
          SizedBox(
            width: width,
            height: height,
            child: MidtermView(
              subjectId: widget.subJectId,
            ),
          ),
          SizedBox(
            width: width,
            height: height,
            child: AssignmentView(
              subJectId: widget.subJectId,
            ),
          ),
        ],
      ),
    );
  }
}
