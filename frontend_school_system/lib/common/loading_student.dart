import 'package:flutter/material.dart';

class CommonLoadingStudent extends StatefulWidget {
  const CommonLoadingStudent({super.key});

  @override
  State<CommonLoadingStudent> createState() => _CommonLoadingStudentState();
}

class _CommonLoadingStudentState extends State<CommonLoadingStudent> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.1, vertical: height * 0.03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/imgs/no-student.png"),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Text(
                    "No Student at this time",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                      "Teachers will appear here after they enroll in your school.  ")
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox.shrink(),
                Container(
                  alignment: Alignment.bottomRight,
                  margin: EdgeInsets.only(top: height * 0.1),
                  width: 140,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                      color: const Color(0XFF152259),
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: Row(
                      children: [
                        Image.asset('assets/imgs/mic.png'),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Support",
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
