import 'package:frontend_school_system/model/role_model.dart';

import '../../../constant/main_abstract/main_abstract.dart';

class RoleState extends ApplicationState{
  final RoleModel roleModel;
  RoleState({required this.roleModel});
}

class CreateAccountLoadingState extends ApplicationState{
  bool isLoading;
  CreateAccountLoadingState({required this.isLoading});
}

class LoginAccountLoadingState extends ApplicationState{
  bool isLoading;
  LoginAccountLoadingState({required this.isLoading});
}