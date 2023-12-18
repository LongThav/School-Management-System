// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../constant/main_abstract/main_abstract.dart';
// import '../../../model/class_by_id_major_model.dart';
// import '../../../model/major_model.dart';
// import '../../../model/student_model.dart';
// import '../../../util/snack_bar.dart';
// import '../../../view_model/cubit/class_cubit.dart';
// import '../../../view_model/cubit/cubit_condition/cubit_state.dart';
// import '../../../view_model/cubit/major_cubit.dart';

// class StudentInforView extends StatefulWidget {
//   const StudentInforView({super.key});

//   @override
//   State<StudentInforView> createState() => _StudentInforViewState();
// }

// class _StudentInforViewState extends State<StudentInforView> {
//   late final TextEditingController _majorCtrl = TextEditingController();
//   late final TextEditingController _classCtrl = TextEditingController();
//   String _majorName = '';
//   int _majorId = 0;
//   String _className = '';
//   int classId = 0;
//   bool selectBtnSearch = false;
//   List<Student> _student = [];
//   @override
//   void initState() {
//     context.read<MajorCubit>().readMajor();
//     if (_majorId == 0) {
//       return;
//     } else {
//       context.read<ClassCubit>().readMajorById(_majorId);
//     }
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _majorCtrl.dispose();
//     _classCtrl.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _buildBody(),
//     );
//   }

//   Widget _buildBody() {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     return Row(
//       children: [
//         Expanded(
//           flex: 1,
//           child: SizedBox(
//             width: width,
//             height: height,
//             child: _buildMajor(),
//           ),
//         ),
//         Expanded(
//           flex: 1,
//           child: SizedBox(
//             width: width,
//             height: height,
//             child: _buildYear(),
//           ),
//         ),
//         Expanded(
//           flex: 1,
//           child: Container(
//             width: width,
//             height: height,
//             color: Colors.yellow,
//           ),
//         ),
//         Expanded(
//           flex: 3,
//           child: Container(
//             width: width,
//             height: height,
//             color: Colors.purple,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildMajor() {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(15),
//       child: Column(
//         children: [
//           Align(
//             alignment: Alignment.centerRight,
//             child: InkWell(
//               onTap: () {
//                 showDialog(
//                     context: context,
//                     builder: (context) {
//                       return Dialog(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: SizedBox(
//                           width: width * 0.3,
//                           height: height * 0.3,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               const Text(
//                                 "Create Major",
//                                 style: TextStyle(fontSize: 18),
//                               ),
//                               const SizedBox(
//                                 height: 15,
//                               ),
//                               Container(
//                                 margin:
//                                     const EdgeInsets.symmetric(horizontal: 15),
//                                 width: width,
//                                 height: height * 0.05,
//                                 decoration: BoxDecoration(
//                                   border: Border.all(color: Colors.grey),
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 child: Center(
//                                   child: TextField(
//                                     controller: _majorCtrl,
//                                     decoration: const InputDecoration(
//                                         border: InputBorder.none,
//                                         contentPadding: EdgeInsets.only(
//                                             bottom: 18, left: 10),
//                                         hintText: "Add Major"),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 15,
//                               ),
//                               InkWell(
//                                 onTap: () {
//                                   if (_majorCtrl.text.isEmpty) {
//                                     snackBar(context, "Please Create Major");
//                                   } else {
//                                     context
//                                         .read<MajorCubit>()
//                                         .createMajor(_majorCtrl.text, context);
//                                   }
//                                   _majorCtrl.text = "";
//                                 },
//                                 child: Container(
//                                   margin: const EdgeInsets.symmetric(
//                                       horizontal: 15),
//                                   width: width,
//                                   height: height * 0.05,
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(8),
//                                       color: const Color(0XFF33b6ff)),
//                                   child: Center(
//                                     child: BlocBuilder<MajorCubit, CubitState>(
//                                       builder: (context, state) {
//                                         if (state
//                                             is LoadingCreateMajoCubitrState) {
//                                           bool isLoading = state.isLoading;
//                                           return isLoading
//                                               ? const CircularProgressIndicator(
//                                                   color: Colors.white,
//                                                 )
//                                               : const Text(
//                                                   "Create Major",
//                                                   style: TextStyle(
//                                                       fontSize: 18,
//                                                       color: Colors.white),
//                                                 );
//                                         } else {
//                                           return const Text(
//                                             "Create Major",
//                                             style: TextStyle(
//                                                 fontSize: 18,
//                                                 color: Colors.white),
//                                           );
//                                         }
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     });
//               },
//               child: const Icon(
//                 Icons.add_outlined,
//                 color: Color(0XFF33b6ff),
//               ),
//             ),
//           ),
//           BlocBuilder<MajorCubit, CubitState>(builder: (context, state) {
//             if (state is InitializeCubitState || state is LoadingCubitState) {
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     height: height * 0.4,
//                   ),
//                   const CircularProgressIndicator(),
//                 ],
//               );
//             } else if (state is ErrorCubitState) {
//               String err = state.error;
//               return Center(
//                 child: Text(err),
//               );
//             } else if (state is MajorState) {
//               return _buildTable(state.majorModel);
//             } else {
//               return const SizedBox.shrink();
//             }
//           }),
//         ],
//       ),
//     );
//   }

//   Widget _buildTable(MajorModel majorModel) {
//     return FittedBox(
//       child: DataTable(
//           dataRowColor: MaterialStateProperty.resolveWith(_getDataRowColor),
//           columns: [
//             DataColumn(
//                 label: Expanded(
//                     child: Text(
//               "Numers",
//               style: TextStyle(
//                   fontSize: 18,
//                   color: Colors.grey[700],
//                   fontWeight: FontWeight.bold),
//             ))),
//             DataColumn(
//                 label: Expanded(
//                     child: Text(
//               "Majors",
//               style: TextStyle(
//                   fontSize: 18,
//                   color: Colors.grey[700],
//                   fontWeight: FontWeight.bold),
//             ))),
//           ],
//           showCheckboxColumn: false,
//           rows: List.generate(majorModel.data.length, (index) {
//             return DataRow(
//               onSelectChanged: (bool? value) {
//                 setState(() {
//                   _majorName = majorModel.data[index].majorName;
//                   _majorId = majorModel.data[index].id;
//                 });
//                 context
//                     .read<MajorCubit>()
//                     .readClassByIdMajor(majorModel.data[index].id);
//               },
//               cells: [
//                 DataCell(Text('${index + 1}')),
//                 DataCell(Text(majorModel.data[index].majorName)),
//               ],
//             );
//           })),
//     );
//   }

//   Color _getDataRowColor(Set<MaterialState> states) {
//     const Set<MaterialState> interactiveStates = <MaterialState>{
//       MaterialState.pressed,
//       MaterialState.hovered,
//       MaterialState.focused,
//     };
//     if (states.any(interactiveStates.contains)) {
//       return Colors.blue.withOpacity(0.5);
//     }
//     return Colors.transparent;
//   }

//   Widget _buildYear(){
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(15),
//       child: Column(
//         children: [
//           Align(
//             alignment: Alignment.centerRight,
//             child: InkWell(
//               onTap: () {
//                 showDialog(
//                     context: context,
//                     builder: (context) {
//                       return Dialog(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: SizedBox(
//                           width: width * 0.3,
//                           height: height * 0.3,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               const Text(
//                                 "Create Major",
//                                 style: TextStyle(fontSize: 18),
//                               ),
//                               const SizedBox(
//                                 height: 15,
//                               ),
//                               Container(
//                                 margin:
//                                     const EdgeInsets.symmetric(horizontal: 15),
//                                 width: width,
//                                 height: height * 0.05,
//                                 decoration: BoxDecoration(
//                                   border: Border.all(color: Colors.grey),
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 child: Center(
//                                   child: TextField(
//                                     controller: _majorCtrl,
//                                     decoration: const InputDecoration(
//                                         border: InputBorder.none,
//                                         contentPadding: EdgeInsets.only(
//                                             bottom: 18, left: 10),
//                                         hintText: "Add Major"),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 15,
//                               ),
//                               InkWell(
//                                 onTap: () {
//                                   if (_majorCtrl.text.isEmpty) {
//                                     snackBar(context, "Please Create Major");
//                                   } else {
//                                     context
//                                         .read<MajorCubit>()
//                                         .createMajor(_majorCtrl.text, context);
//                                   }
//                                   _majorCtrl.text = "";
//                                 },
//                                 child: Container(
//                                   margin: const EdgeInsets.symmetric(
//                                       horizontal: 15),
//                                   width: width,
//                                   height: height * 0.05,
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(8),
//                                       color: const Color(0XFF33b6ff)),
//                                   child: Center(
//                                     child: BlocBuilder<MajorCubit, CubitState>(
//                                       builder: (context, state) {
//                                         if (state
//                                             is LoadingCreateMajoCubitrState) {
//                                           bool isLoading = state.isLoading;
//                                           return isLoading
//                                               ? const CircularProgressIndicator(
//                                                   color: Colors.white,
//                                                 )
//                                               : const Text(
//                                                   "Create Major",
//                                                   style: TextStyle(
//                                                       fontSize: 18,
//                                                       color: Colors.white),
//                                                 );
//                                         } else {
//                                           return const Text(
//                                             "Create Major",
//                                             style: TextStyle(
//                                                 fontSize: 18,
//                                                 color: Colors.white),
//                                           );
//                                         }
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     });
//               },
//               child: const Icon(
//                 Icons.add_outlined,
//                 color: Color(0XFF33b6ff),
//               ),
//             ),
//           ),
//           BlocBuilder<MajorCubit, CubitState>(builder: (context, state) {
//             if (state is InitializeCubitState || state is LoadingCubitState) {
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     height: height * 0.4,
//                   ),
//                   const CircularProgressIndicator(),
//                 ],
//               );
//             } else if (state is ErrorCubitState) {
//               String err = state.error;
//               return Center(
//                 child: Text(err),
//               );
//             } else if (state is ClassByMajorId) {
//               return _buildYearTable(state.classByModorIdModel);
//             } else {
//               return const SizedBox.shrink();
//             }
//           }),
//         ],
//       ),
//     );
//   }
//   Widget _buildYearTable(ClassByModorIdModel classByMajorId) {
//     return FittedBox(
//       child: DataTable(
//           dataRowColor: MaterialStateProperty.resolveWith(_getDataRowColor),
//           columns: [
//             DataColumn(
//                 label: Expanded(
//                     child: Text(
//               "Numers",
//               style: TextStyle(
//                   fontSize: 18,
//                   color: Colors.grey[700],
//                   fontWeight: FontWeight.bold),
//             ))),
//             DataColumn(
//                 label: Expanded(
//                     child: Text(
//               "Year",
//               style: TextStyle(
//                   fontSize: 18,
//                   color: Colors.grey[700],
//                   fontWeight: FontWeight.bold),
//             ))),
//           ],
//           showCheckboxColumn: false,
//           rows: List.generate(classByMajorId.data.length, (index) {
//             var data = classByMajorId.data[index];
//             return DataRow(
//               onSelectChanged: (bool? value) {
//                 setState(() {
//                   _majorName = data.majorName ?? "";
//                   _majorId = data.id;
//                 });
//                 context.read<MajorCubit>().readClassByIdMajor(_majorId);
//               },
//               cells: [
//                 DataCell(Text('${index + 1}')),
//                 DataCell(Text(data.year?.year ?? "")),
//               ],
//             );
//           })),
//     );
//   }
// }
