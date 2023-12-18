import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mobile/views/mains/profile_view.dart';
import 'package:mobile/views/students/exam_routine_view.dart';
import 'package:mobile/views/students/result_view.dart';

import '../mains/class_room_view.dart';
import 'class_student_view.dart';

class IndexStudentView extends StatefulWidget {
  const IndexStudentView({super.key});

  @override
  State<IndexStudentView> createState() => _IndexStudentViewState();
}

class _IndexStudentViewState extends State<IndexStudentView> {
  final List<dynamic> _studentListPage = [
    const ClassRoomView(),
    const ExamRoutineView(),
    const ClassStudentView(),
    const ResultView(),
    const ProfileView(),
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _studentListPage[index],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          mouseCursor: MaterialStateMouseCursor.clickable,
          enableFeedback: true,
          elevation: 0,
          selectedItemColor: Colors.grey[700],
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(fontSize: 15),
          showUnselectedLabels: true,
          unselectedLabelStyle: const TextStyle(fontSize: 15),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  LineIcons.graduationCap,
                  size: 35,
                ),
                label: "Room"),
            BottomNavigationBarItem(
                icon: Icon(
                  LineIcons.tasks,
                  size: 35,
                ),
                label: "Final"),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.group_outlined,
                size: 35,
              ),
              label: "Class",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.list_outlined,
                size: 35,
              ),
              label: "Result",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings_outlined,
                size: 35,
              ),
              label: "Profile",
            ),
          ]),
    );
  }
}
