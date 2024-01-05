import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_school_system/constant/color.dart';

import '../../../constant/main_abstract/main_abstract.dart';
import '../../../model/student_model.dart';
import '../../../view_model/cubit/class_cubit.dart';
import '../../../view_model/cubit/cubit_condition/cubit_state.dart';
import '../../../view_model/cubit/subject_cubit.dart';

class AddPersonIntoSubjectView extends StatefulWidget {
  final int subjectId;
  final int classId;
  const AddPersonIntoSubjectView(
      {super.key, required this.subjectId, required this.classId});

  @override
  State<AddPersonIntoSubjectView> createState() =>
      _AddPersonIntoSubjectViewState();
}

class _AddPersonIntoSubjectViewState extends State<AddPersonIntoSubjectView> {
  List<Student> _student = [];

  @override
  void initState() {
    context.read<StudentCubit>().readStudent(widget.classId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        width: width * 0.5,
        height: height,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: BlocBuilder<StudentCubit, CubitState>(
            builder: (context, state) {
              if (state is LoadingCubitState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height * 0.4,
                    ),
                    const CircularProgressIndicator(),
                  ],
                );
              } else if (state is ErrorCubitState) {
                return Center(
                  child: Text(state.error),
                );
              } else if (state is StudentClassState) {
                return _buildListPeople(state.studentModel);
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildListPeople(StudentModel studentModel) {
    var data = studentModel.data.students;
    _student = [];
    for (var item in data) {
      if (item.subjectId == null || item.subjectId != widget.subjectId) {
        _student.add(item);
      }
    }
    return FittedBox(
      child: DataTable(
          // dataRowColor: MaterialStateProperty.resolveWith(_getDataRowColor),
          columns: [
            DataColumn(
                label: Expanded(
                    child: Text(
              "Numers",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold),
            ))),
            DataColumn(
                label: Expanded(
                    child: Text(
              "Name",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold),
            ))),
            DataColumn(
                label: Expanded(
                    child: Text(
              "StudentID",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold),
            ))),
            DataColumn(
                label: Expanded(
                    child: Text(
              "Phone",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold),
            ))),
            DataColumn(
                label: Expanded(
                    child: Text(
              "Image",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold),
            ))),
            DataColumn(
                label: Expanded(
                    child: Text(
              "Gender",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold),
            ))),
            DataColumn(
                label: Expanded(
                    child: Text(
              "Add",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold),
            ))),
          ],
          showCheckboxColumn: false,
          dataRowHeight: 100,
          rows: List.generate(_student.length, (index) {
            var data = _student[index];
            return DataRow(onSelectChanged: (bool? value) {}, cells: [
              DataCell(Text('${index + 1}')),
              DataCell(Text(data.name ?? "")),
              DataCell(Text(data.codeId ?? "")),
              DataCell(Text(data.phone ?? "")),
              DataCell(Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey,
                    image: data.image == null
                        ? const DecorationImage(
                            image: AssetImage('assets/imgs/no-profile.png'),
                            fit: BoxFit.fill)
                        : DecorationImage(
                            image: NetworkImage(data.image.toString()))),
              )),
              DataCell(Text(data.sex ?? "")),
              DataCell(InkWell(
                onTap: () {
                  context.read<SubjectAdded>().addPerson(data.id, widget.subjectId.toString(), context);
                  context.read<StudentCubit>().readStudent(widget.classId);
                  context.read<SubjectByIdCubit>().readSubjectById(widget.subjectId);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 25),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                    color: flex1,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      "Add",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              )),
            ]);
          })),
    );
  }
}
