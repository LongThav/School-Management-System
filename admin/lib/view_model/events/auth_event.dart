import 'package:flutter/material.dart';

import '../../constant/main_abstract/main_abstract.dart';

class RoleEvent extends ApplicationEvent{}
class CreateAccountEvent extends ApplicationEvent{
  final String email;
  final String role;
  final String password;
  final BuildContext context;
  CreateAccountEvent({required this.email,required this.role, required this.password, required this.context});
}

class LoginAccountEvent extends ApplicationEvent{
  final String email;
  final String password;
  final BuildContext context;
  LoginAccountEvent({required this.email, required this.password, required this.context});
}