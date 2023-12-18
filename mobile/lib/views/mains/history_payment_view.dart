import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/enum.dart';
import 'package:mobile/view_models/profile_view_model.dart';

import '../../res/colors/color.dart';
import '../../res/colors/get_data_row_color.dart';

class HistoryPaymentView extends StatefulWidget {
  final int id;
  const HistoryPaymentView({super.key, required this.id});

  @override
  State<HistoryPaymentView> createState() => _HistoryPaymentViewState();
}

class _HistoryPaymentViewState extends State<HistoryPaymentView> {
  final ProfileViewModdel _profileViewModdel = Get.put(ProfileViewModdel());
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _profileViewModdel.readHistory(widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleSpacing: -10,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: btnColor,
            )),
        title: const Text(
          "Payment Information",
          style: TextStyle(color: btnColor),
        ),
      ),
      body: Obx(() {
        switch (_profileViewModdel.loadingStatus.value) {
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
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: FittedBox(
                child: DataTable(
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
                        "Payments",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold),
                      ))),
                      DataColumn(
                          label: Expanded(
                              child: Text(
                        "Time",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold),
                      ))),
                    ],
                    showCheckboxColumn: false,
                    dataRowColor: MaterialStateProperty.resolveWith(GetDataRowColor),
                    rows: List.generate(
                        _profileViewModdel.historyPaymentModel.value.data
                            .payments.length, (index) {
                      var data = _profileViewModdel
                          .historyPaymentModel.value.data.payments[index];
                      return DataRow(
                        onSelectChanged: (value){
                          setState(() {
                           
                          });
                        },
                        cells: [
                        DataCell(Text(
                          '${index + 1}',
                          style:
                              TextStyle(fontSize: 18, color: Colors.grey[600]),
                        )),
                        DataCell(Text(
                          data.totalPayment,
                          style:
                              TextStyle(fontSize: 18, color: Colors.grey[600]),
                        )),
                        DataCell(Text(
                          'Empty',
                          style:
                              TextStyle(fontSize: 18, color: Colors.grey[600]),
                        )),
                      ]);
                    })),
              ),
            );
        }
      }),
    );
  }
}
