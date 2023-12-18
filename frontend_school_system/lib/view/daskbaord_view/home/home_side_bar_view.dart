import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_school_system/constant/color.dart';
import 'package:frontend_school_system/util/snack_bar.dart';
import 'package:frontend_school_system/view_model/bloc/auth_bloc.dart';
import 'package:frontend_school_system/view_model/events/student_event.dart';

import '../../../data_local/cache_auth_local.dart';
import '../../../view_model/cubit/major_cubit.dart';

class HomeSideBarView extends StatefulWidget {
  const HomeSideBarView({super.key});

  @override
  State<HomeSideBarView> createState() => _HomeSideBarViewState();
}

class _HomeSideBarViewState extends State<HomeSideBarView> {
  final CacheAuthLocal _cacheAuthLocal = CacheAuthLocal();
  final TextEditingController _roleCtrl = TextEditingController();
  final TextEditingController _provinceCtrl = TextEditingController();
  List<dynamic> featurHome = [
    {
      'icon': 'assets/imgs/profile-add.png',
      'title': 'Create other admins',
    },
    {
      'icon': 'assets/imgs/teacher.png',
      'title': 'Create Province',
    },
  ];
  @override
  void dispose() {
    _roleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isLoading = context.read<MajorCubit>().isLoading;
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.1, vertical: height * 0.03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.025,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Learn  how to launch faster"),
                    Text(
                        "watch our webinar for tips from our experts and get a limited time offer."),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.notifications_outlined,
                          size: 30,
                        )),
                    SizedBox(
                      width: width * 0.05,
                    ),
                    InkWell(
                      onTap: () {
                        _cacheAuthLocal.deleteAll();
                        context
                            .read<AuthBloc>()
                            .add(LogoutEvent(context: context));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 8),
                        decoration: BoxDecoration(
                            color: const Color(0XFF33b6ff),
                            borderRadius: BorderRadius.circular(12)),
                        child: const Center(
                          child: Text("Logout"),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: height * 0.1,
            ),
            Text(
              "Welcome to your dashboard, University",
              style: TextStyle(
                  fontSize: 28,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Text(
              "Norton University",
              style: TextStyle(fontSize: 20, color: Colors.grey[700]),
            ),
            SizedBox(
              height: height * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: List.generate(featurHome.length, (index) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(12),
                      hoverColor: Colors.blue.withOpacity(0.5),
                      onTap: () {
                        if (index == 0) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Container(
                                    width: width * 0.24,
                                    height: height * 0.27,
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          "Create Role",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: width,
                                          height: height * 0.05,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: Colors.white),
                                          child: Center(
                                            child: TextField(
                                              controller: _roleCtrl,
                                              decoration: const InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Add Role',
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          bottom: 15,
                                                          left: 15)),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (_roleCtrl.text.isEmpty) {
                                              snackBar(
                                                  context, "Please add role");
                                            } else {
                                              final Map<String, dynamic> data =
                                                  {'role': _roleCtrl.text};
                                              context
                                                  .read<MajorCubit>()
                                                  .createRole(data, context);
                                              Future.delayed(
                                                  const Duration(
                                                      milliseconds: 500), () {
                                                _roleCtrl.text = "";
                                              });
                                            }
                                          },
                                          child: Container(
                                            width: width,
                                            height: height * 0.05,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: flex1),
                                            child: Center(
                                              child: isLoading
                                                  ? const CircularProgressIndicator()
                                                  : const Text(
                                                      "Create Role",
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.white),
                                                    ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        } else if (index == 1) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Container(
                                    width: width * 0.24,
                                    height: height * 0.27,
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          "Create Province",
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: width,
                                          height: height * 0.05,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: Colors.white),
                                          child: Center(
                                            child: TextField(
                                              controller: _provinceCtrl,
                                              decoration: const InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Add Province',
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          bottom: 15,
                                                          left: 15)),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        InkWell(
                                          onTap: (){
                                            if(_provinceCtrl.text.isEmpty){
                                              snackBar(context, "Please Add Province");
                                            }else{
                                              final Map<String,dynamic> data = {
                                                'name_province': _provinceCtrl.text,
                                              };
                                              context.read<MajorCubit>().createProvince(data, context);
                                            }
                                            Future.delayed(const Duration(milliseconds: 500),(){
                                              _provinceCtrl.text = "";
                                            });
                                          },
                                          child: Container(
                                            width: width,
                                            height: height * 0.05,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: flex1),
                                            child: const Center(
                                              child: Text(
                                                "Create Province",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        } else {}
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 15),
                        child: Row(
                          children: [
                            Image.asset(featurHome[index]['icon']),
                            SizedBox(
                              width: width * 0.015,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  featurHome[index]['title'],
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.grey[700]),
                                ),
                                const Text(
                                    'Create rich course content and coaching products for your students.'),
                                const Text(
                                    'When you give them a pricing plan, they’ll appear on your site!')
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  margin: EdgeInsets.only(top: height * 0.35),
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
