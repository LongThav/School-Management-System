import 'package:get/get.dart';
import 'package:mobile/res/routes/route_name.dart';
import 'package:mobile/views/auth/forgot_password_view.dart';
import 'package:mobile/views/mains/detail_midterm_view.dart';
import 'package:mobile/views/mains/detail_quiz_view.dart';
import 'package:mobile/views/mains/detial_assignment_view.dart';
import 'package:mobile/views/mains/google_map_view.dart';
import 'package:mobile/views/mains/history_payment_view.dart';
import 'package:mobile/views/mains/user_infor_view.dart';
import 'package:mobile/views/parents/index_parent_view.dart';
import 'package:mobile/views/splash_view.dart';
import 'package:mobile/views/students/index_student_view.dart';
import 'package:mobile/views/students/index_task_room_view.dart';
import 'package:mobile/views/teachers/index_teacher_view.dart';

import '../../views/auth/login_view.dart';
import '../../views/teachers/show_all_answer_submit_midterm_view.dart';
import '../../views/teachers/show_all_answer_submit_quiz_view.dart';
import '../../views/teachers/show_all_answer_submited_assignment_view.dart';
import '../user_info.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
          name: RouteName.splashView,
          page: () => const SplashView(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.rightToLeftWithFade,
        ),
        GetPage(
          name: RouteName.loginView,
          page: () => const LoginView(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.rightToLeftWithFade,
        ),
        GetPage(
          name: RouteName.indexStudent,
          page: () => const IndexStudentView(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.rightToLeftWithFade,
        ),
        GetPage(
          name: RouteName.indexTeacher,
          page: () => const IndexTeacherView(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.rightToLeftWithFade,
        ),
        GetPage(
          name: RouteName.userInfo,
          page: () => UserInfoView(
            userId: userId.value,
            email: email.value,
          ),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.rightToLeftWithFade,
        ),
        GetPage(
          name: RouteName.historyPayment,
          page: () => HistoryPaymentView(
            id: infoId?.value ?? 0,
          ),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.rightToLeftWithFade,
        ),
        GetPage(
          name: RouteName.indexTaskRoom,
          page: () => IndexTaskRoomView(
            subject: subJectName.value,
            subJectId: subjectId.value,
          ),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.rightToLeftWithFade,
        ),
        GetPage(
          name: RouteName.cmtQuiz,
          page: () => DetialQuizView(
            taskId: taskId.value,
            question: questionQuiz.value,
            image: image.value,
            subjectId: subjectId.value,
          ),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.rightToLeftWithFade,
        ),
        GetPage(
          name: RouteName.cmtMidterm,
          page: () => DetailMidtermView(midtermTaskId: midtermTaskId.value, question: questionMidterm.value, image: midtermImage.value, subjectId: subjectId.value),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.rightToLeftWithFade,
        ),
        GetPage(
          name: RouteName.cmtAssignment,
          page: () => DetailAssignmentView(assignmentTaskId: assignmentId.value, questionAssignment: questionAssignment.value, image: assignmentImage.value, subjectId: subjectId.value),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.rightToLeftWithFade,
        ),
        GetPage(
          name: RouteName.allQuizSubmit,
          page: () => AllAnswerQuizSubmitView(
            quizId: quizId.value,
          ),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.rightToLeftWithFade,
        ),
        GetPage(
          name: RouteName.allMidtermSubmit,
          page: () => ShowAllAnswerSubmitedMidtermView(
            midtermId: midtermId.value,
          ),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.rightToLeftWithFade,
        ),
        GetPage(
          name: RouteName.allAssignmentSubmit,
          page: () => AllAnswerAssignmentSubmitedView(
            assignmentId: assignmentsId.value,
          ),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.rightToLeftWithFade,
        ),
        GetPage(
          name: RouteName.googleMap,
          page: () => GoogleMapView(
            userId: userId.value,
          ),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.rightToLeftWithFade,
        ),
        GetPage(
          name: RouteName.indexParent,
          page: () => const IndexParentView(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.rightToLeftWithFade,
        ),
        GetPage(
          name: RouteName.forgotPassword,
          page: () => const ForgotPasswordView(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.rightToLeftWithFade,
        ),
      ];
}
