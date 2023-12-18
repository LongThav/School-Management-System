import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mobile/commons/common_txt_style.dart';
import 'package:mobile/data/enum.dart';
import 'package:mobile/res/colors/color.dart';
import 'package:mobile/utils/logo.dart';
import 'package:mobile/views/parents/tracking_view.dart';

import '../../commons/common_check_current_location_student.dart';
import '../../configs/lat_long.dart';
import '../../db_helpers/cache_id.dart';
import '../../res/url_base.dart';
import '../../utils/snack_bar.dart';
import '../../view_models/class_view_model.dart';
import '../../view_models/final_exam_view_model.dart';

class FindChilView extends StatefulWidget {
  const FindChilView({super.key});

  @override
  State<FindChilView> createState() => _FindChilViewState();
}

class _FindChilViewState extends State<FindChilView> {
  final ClassViewModdel _classViewModdel = Get.put(ClassViewModdel());
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;
  int infoId = 0;
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
      if (latNotifier.value == 0 && longNotifie.value == 0) {
      } else {
        "Have lat long".log();
        "Lat: ${latNotifier.value}".log();
        "long: ${longNotifie.value}".log();
        // _userInfoId();
      }
    });
  }

  final FinalExamViewModel _examViewModel = Get.put(FinalExamViewModel());

  final CacheId _cacheId = CacheId();
  _userInfoId() async {
    String id = await _cacheId.readInfoId();
    int inforId = int.parse(id);
    'inFOId: $infoId'.log();
    setState(() {
      infoId = inforId;
      _examViewModel.addLatLong(latNotifier.value, longNotifie.value, infoId, context);
    });
  }

  @override
  void initState() {
    checkGps();
    _userInfoId();
    _classViewModdel.readStudent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const CommonTxtStyle(
          label: "Find Your child",
          color: btnColor,
        ),
      ),
      body: Obx((){
        switch(_classViewModdel.loadingStatus.value){
          case LoadingStatus.none:
          case LoadingStatus.loading:
           return const Center(child: CircularProgressIndicator(),);
          case LoadingStatus.error:
           return const Center(child: Text("Error"),);
          case LoadingStatus.complete:
           return _buildBody();
        }
      }),
    );
  }
  Widget _buildBody() {
    return Obx(() {
      var data = _classViewModdel.classMateModel;
      return RefreshIndicator(
        onRefresh: () async {
          _classViewModdel.readStudent();
        },
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: data.value.data?.students?.length,
            itemBuilder: (context, index) {
              var student = data.value.data?.students?[index];
              return Padding(
                padding: const EdgeInsets.only(top: 15),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  onTap: () {
                    if(student?.lat == null && student?.long == null){
                      snackBar(context, "Student doesn't allow GPS");
                    }else{
                      showDialog(context: context, builder: (context){
                      return TrackingVeiw(
                        name: student?.name ?? "", 
                        infoId: student?.id ?? 0, 
                        codeId: student?.codeId ?? ""
                      );
                    });
                    }
                  },
                  leading: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(shape: BoxShape.circle, image: student?.image == null ? const DecorationImage(image: AssetImage("assets/imgs/no-profile.png"), fit: BoxFit.fill) : DecorationImage(image: NetworkImage(hostImg + student!.image.toString()), fit: BoxFit.fill)),
                  ),
                  title: CommonTxtStyle(
                    fontSize: 18,
                    label: "Name: ${student?.name ?? "No Name"}",
                    color: Colors.grey[700],
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: CommonTxtStyle(
                      fontSize: 18,
                      label: "Phone: ${student?.phone ?? ""}",
                      color: Colors.grey[700],
                    ),
                  ),
                  trailing: student?.codeId == codeId.value
                      ? const CircleAvatar(
                          radius: 12,
                          child: Text(
                            'Me',
                            style: TextStyle(fontSize: 11, color: Colors.white),
                          ))
                      : null,
                ),
              );
            }),
      );
    });
  }
}


//https://stackoverflow.com/questions/69900640/show-directions-using-google-map-flutter-package