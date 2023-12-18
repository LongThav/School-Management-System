import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mobile/views/mains/profile_view.dart';
import 'package:mobile/views/parents/report_view.dart';

import 'find_your_child_view.dart';

class IndexParentView extends StatefulWidget {
  const IndexParentView({super.key});

  @override
  State<IndexParentView> createState() => _IndexParentViewState();
}

class _IndexParentViewState extends State<IndexParentView> {
  List<dynamic> parentList = [
    const FindChilView(),
    const ReportView(),
    const ProfileView(),
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: parentList[index],
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
                  LineIcons.locationArrow,
                  size: 35,
                ),
                label: "find"),
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
