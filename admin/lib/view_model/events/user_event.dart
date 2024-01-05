import 'package:frontend_school_system/constant/main_abstract/main_abstract.dart';

class UserEvent extends ApplicationEvent{
  final String search;
  UserEvent({this.search = " "});
}
