import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CacheProfile {
  final FlutterSecureStorage _flutterSecureStorage =
      const FlutterSecureStorage();
  String userToken = "Token";
  String userName = "User Name";
  String image = "Image";
  String email = "email";
  String role = "role";
  String userId = "Id";
  String userInfoId = "userInfoId";

  void writeToken(value){
    _flutterSecureStorage.write(key: userToken, value: value);
  }

  void writeUserInfoId(value){
    _flutterSecureStorage.write(key: userInfoId, value: value);
  }

  void writeUserName(value){
    _flutterSecureStorage.write(key: userName, value: value);
  }
  void writeImage(value){
    _flutterSecureStorage.write(key: image, value: value);
  }
  void writeRole(value){
    _flutterSecureStorage.write(key: role, value: value);
  }

  void writeEmail(value){
    _flutterSecureStorage.write(key: email, value: value);
  }

  void writeUserId(value){
    _flutterSecureStorage.write(key: userId, value: value);
  }

  Future<String> readToken() async {
    String? token = await _flutterSecureStorage.read(key: userToken);
    return token ?? "no-token";
  }

  Future<String> readUserName() async {
    String? name = await _flutterSecureStorage.read(key: userName);
    return name ?? "no-username";
  }

  Future<String> readEmail() async {
    String? emailUser = await _flutterSecureStorage.read(key: email);
    return emailUser ?? "no-email";
  }

  Future<String> readimage() async {
    String? imageUser = await _flutterSecureStorage.read(key: image);
    return imageUser ?? "no-image";
  }

  Future<String> readRole() async {
    String? roleUser = await _flutterSecureStorage.read(key: role);
    return roleUser ?? "no-role";
  }

  Future<String> readUserId()async{
    String? id = await _flutterSecureStorage.read(key: userId);
    return id ?? "no-id";
  }

  Future<String> readInfoId()async{
    String? infoId = await _flutterSecureStorage.read(key: userInfoId);
    return infoId ?? "no-infoId";
  }

  void deleteAll(){
    _flutterSecureStorage.deleteAll();
  }
}
