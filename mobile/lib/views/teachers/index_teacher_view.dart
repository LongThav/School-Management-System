import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../mains/class_room_view.dart';
import '../mains/profile_view.dart';
import 'notice_and_event_view.dart';

class IndexTeacherView extends StatefulWidget {
  const IndexTeacherView({super.key});

  @override
  State<IndexTeacherView> createState() => _IndexTeacherViewState();
}

class _IndexTeacherViewState extends State<IndexTeacherView> {
  final List<dynamic> _teacherListView = [
    const ClassRoomView(),
    const NoticAndEventView(),
    const ProfileView(), 
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _teacherListView[index],
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
                Icons.event_outlined,
                size: 35,
              ),
              label: "Event",
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