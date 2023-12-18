import 'dart:async';

import 'package:flutter/material.dart';

import '../../constant/color.dart';
import 'billing/billing_view.dart';
import 'exam/exam_view.dart';
import 'major/major_view.dart';
import 'home/home_side_bar_view.dart';
import 'student/student_view.dart';
import 'subject/subject_view.dart';
import 'teacher/teacher_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final PageController _pageController = PageController();
  int pageIndex = 0;
  List<dynamic> listSideBar = [
    {'icon': Icons.home_outlined, 'title': 'Home'},
    {
      'icon': Icons.person_outline,
      'title': 'Teacher',
    },
    {
      'icon': Icons.school_outlined,
      'title': 'Student',
    },
    {
      'icon': Icons.payment_outlined,
      'title': 'Billing',
    },
    {
      'icon': Icons.grade,
      'title': 'Major',
    },
    {'icon': Icons.quiz_outlined, 'title': 'Task'},
    {'icon': Icons.subject_outlined, 'title': 'Subject'},
  ];
  @override
  void initState() {
    Timer(const Duration(microseconds: 600), () {
      _pageController;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Row(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                color: flex1,
                child: _buildSideBar(width, height),
              )),
          Expanded(
            flex: 6,
            child: _buildPageView(width, height),
          ),
        ],
      ),
    );
  }

  Widget _buildSideBar(double width, double height) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        Padding(
          padding: EdgeInsets.only(top: height * 0.03),
          child: Center(
            child: Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage("assets/imgs/profile.jpg"))),
            ),
          ),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "LongThav SiPav",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              Text(
                "B20211366",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ],
          ),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        const Divider(
          thickness: 1,
          color: Colors.grey,
        ),
        SizedBox(
          height: height * 0.03,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.01),
          child: Column(
            children: List.generate(listSideBar.length, (index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    pageIndex = index;
                  });
                  _pageController.jumpToPage(index);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  decoration: BoxDecoration(
                    color: pageIndex == index ? const Color(0XFF33b6ff) : null,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        listSideBar[index]['icon'],
                        size: 30,
                        color: pageIndex == index ? Colors.white : Colors.grey,
                      ),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      Text(
                        listSideBar[index]['title'],
                        style: TextStyle(
                            fontSize: 18,
                            color: pageIndex == index
                                ? Colors.white
                                : Colors.grey),
                      )
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildPageView(double width, double height) {
    return PageView(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      onPageChanged: (value) {
        setState(() {
          pageIndex = value;
        });
      },
      children: [
        SizedBox(
          width: width,
          height: height,
          child: const HomeSideBarView(),
        ),
        SizedBox(
          width: width,
          height: height,
          child: const TeacherView(),
        ),
        SizedBox(
          width: width,
          height: height,
          child: const StudentView(),
        ),
        SizedBox(
          width: width,
          height: height,
          child:const BillingView(),
        ),
        SizedBox(
          width: width,
          height: height,
          child: const MajorView(),
        ),
        SizedBox(
          width: width,
          height: height,
          child: const ExameView(),
        ),
        SizedBox(
          width: width,
          height: height,
          child: const SubjectView(),
        ),
      ],
    );
  }
}
