import '../../../constant/main_abstract/main_abstract.dart';

class InitializeState extends ApplicationState{}
class LoaddingState extends ApplicationState{}
class ErrorState extends ApplicationState{
  final String error;
  ErrorState({required this.error});
}
class LoadingGenderState extends ApplicationState{}
class ErrorGenderState extends ApplicationState{
    final String error;
  ErrorGenderState({required this.error});
}