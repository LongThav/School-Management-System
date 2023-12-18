import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mobile/db_helpers/cache_profile.dart';
import 'package:mobile/res/routes/route_name.dart';
import 'package:mobile/utils/logo.dart';
import 'package:mobile/view_models/profile_view_model.dart';

import '../configs/lat_long.dart';
import '../view_models/class_view_model.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final CacheProfile _cacheProfile = CacheProfile();
  final ClassViewModdel _classViewModdel = Get.put(ClassViewModdel());

  void init() async {
    String token = await _cacheProfile.readToken();
    String infoId = await _cacheProfile.readInfoId();
    "Token: $token".log();
    debugPrint("Info ID: $infoId");
    if (infoId == "no-infoId") {
      // Id Userinfo will empty
    } else {
      idUserInfo.value = int.parse(infoId);
    }
    debugPrint("Token User: $token");
    if (token == "no-token") {
      Future.delayed(const Duration(milliseconds: 600), () {
        Get.offNamed(RouteName.loginView);
      });
    } else {
      String role = await _cacheProfile.readRole();
      switch (role) {
        case "Student":
          return Get.offNamed(RouteName.indexStudent);
        case "Teacher":
          return Get.offNamed(RouteName.indexTeacher);
        case "Parent":
          return Get.offNamed(RouteName.indexParent);
        default:
          break;
      }
    }
  }

  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          debugPrint('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          debugPrint("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        getLocation();
      }
    } else {
      debugPrint("GPS Service is not enabled, turn on GPS location");
    }
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    long = position.longitude.toString();
    lat = position.latitude.toString();

    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
      //device must move horizontally before an update event is generated;
    );

    // ignore: unused_local_variable
    StreamSubscription<Position> positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position position) {
      position.longitude.log();
      position.latitude.log();
      latNotifier.value = position.latitude;
      longNotifie.value = position.longitude;
      long = position.longitude.toString();
      lat = position.latitude.toString();
      // if (latNotifier.value == 0 && longNotifie.value == 0) {
      // } else {
      //   "Have lat long".log();
      //   _userInfoId();
      //   _examViewModel.addLatLong(latNotifier.value, longNotifie.value, infoId, context);
      // }
    });
  }

  @override
  void initState() {
    super.initState();
    _classViewModdel.readClassId();
    Future.delayed(const Duration(milliseconds: 500), () {
      init();
      checkGps();
    });
  }

  int infoId = 0;

  // final CacheId _cacheId = CacheId();
  // _userInfoId() async {
  //   String id = await _cacheId.readInfoId();
  //   int infoId = int.parse(id);
  //   setState(() {
  //     this.infoId = infoId;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Icon(
          LineIcons.graduationCap,
          size: 60,
          color: Colors.grey,
        ),
      ),
    );
  }
}
