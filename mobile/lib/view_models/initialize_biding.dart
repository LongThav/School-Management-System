import 'package:get/get.dart';
import 'package:mobile/view_models/auth_view_model.dart';
import 'package:mobile/view_models/class_view_model.dart';
import 'package:mobile/view_models/profile_view_model.dart';
import 'package:mobile/view_models/progress_in_task_view.dart';
import 'package:mobile/view_models/room_view_model.dart';

import 'final_exam_view_model.dart';

class Initialize implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AuthViewModel(), fenix: true);
    Get.lazyPut(() => ProfileViewModdel(), fenix: true);
    Get.lazyPut(() => ClassViewModdel(), fenix: true);
    Get.lazyPut(() => RoomViewModel(), fenix: true);
    Get.lazyPut(() => ProgressInTaskViewModel(), fenix: true);
    Get.lazyPut(() => FinalExamViewModel(), fenix: true);
  }
}