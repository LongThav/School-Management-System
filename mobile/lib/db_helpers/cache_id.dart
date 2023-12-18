import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CacheId{
  final FlutterSecureStorage _flutterSecureStorage = const FlutterSecureStorage();
  String classId = "/class";
  String infoId = "infoId";

  void writeClassId(String value){
    _flutterSecureStorage.write(key: classId, value: value);
  }
  Future<String> readClassId()async{
    String? id = await _flutterSecureStorage.read(key: classId);
    return id ?? "no-classId";
  }

  void writeInfoId(String value){
    _flutterSecureStorage.write(key: infoId, value: value);
  }

  Future<String> readInfoId()async{
    String? id = await _flutterSecureStorage.read(key: infoId);
    return id ?? "no-infoId";
  }
}