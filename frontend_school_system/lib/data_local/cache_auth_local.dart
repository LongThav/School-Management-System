import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CacheAuthLocal{
  final FlutterSecureStorage _flutterSecureStorage = const FlutterSecureStorage();
  String token = "";
  String noToken = "noToken";

  void writeToken(String value){
    _flutterSecureStorage.write(key: token, value: value);
  }

  Future<String> readToken()async{
    String? userToken = await _flutterSecureStorage.read(key: token);
    return userToken ?? noToken;
  }

  void deleteAll(){
    _flutterSecureStorage.deleteAll();
  }
}