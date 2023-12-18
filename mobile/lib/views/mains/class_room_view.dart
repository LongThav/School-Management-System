import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mobile/data/enum.dart';
import 'package:mobile/res/colors/color.dart';
import 'package:mobile/res/routes/route_name.dart';
import 'package:mobile/res/url_base.dart';
import 'package:mobile/utils/logo.dart';

import '../../configs/lat_long.dart';
import '../../db_helpers/cache_id.dart';
import '../../res/user_info.dart';
import '../../view_models/class_view_model.dart';
import '../../view_models/final_exam_view_model.dart';
import '../../view_models/room_view_model.dart';

class ClassRoomView extends StatefulWidget {
  const ClassRoomView({super.key});

  @override
  State<ClassRoomView> createState() => _ClassRoomViewState();
}

class _ClassRoomViewState extends State<ClassRoomView> {
  final TextEditingController _searchCtrl = TextEditingController();
  final FinalExamViewModel _examViewModel = Get.put(FinalExamViewModel());
  final RoomViewModel _roomViewModel = Get.put(RoomViewModel());
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;
  int infoId = 0;

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

  @override
  void initState() {
    _roomViewModel.readSubject();
    checkGps();
    _userInfoId();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      "Start".log();
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: const Text(
          "Room Mate",
          style: TextStyle(color: btnColor, letterSpacing: 1),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15),
            // child: Text(
            //   "Class: ${className.value}",
            //   style: TextStyle(
            //       letterSpacing: 0.5, fontSize: 18, color: Colors.grey[700]),
            // ),
            child: Icon(
              Icons.notifications,
              color: btnColor,
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 0),
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: _searchCtrl,
              decoration: const InputDecoration(border: InputBorder.none, hintText: "Search name or id", hintStyle: TextStyle(fontSize: 18), prefixIcon: Icon(Icons.search)),
            ),
          ),
        ),
      ),
      body: Obx(() {
        switch (_roomViewModel.loadingStatus.value) {
          case LoadingStatus.none:
          case LoadingStatus.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case LoadingStatus.error:
            return const Center(
              child: Text("Error"),
            );
          case LoadingStatus.complete:
            return _buildBody();
        }
      }),
    );
  }

  Widget _buildBody() {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return Obx(() {
      return RefreshIndicator(
        onRefresh: () async {
          _roomViewModel.readSubject();
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView.builder(
              itemCount: _roomViewModel.subJectModel.value.data.subject.length,
              itemBuilder: (context, index) {
                var data = _roomViewModel.subJectModel.value.data.subject[index];
                return InkWell(
                  onTap: () {
                    Get.toNamed(RouteName.indexTaskRoom);
                    subJectName.value = data.title;
                    subjectId.value = data.id;
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: width,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: btnColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(
                                "Subject: ${data.title}",
                                style: const TextStyle(fontSize: 18, color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Text(
                                "Class: ${className.value}",
                                style: const TextStyle(fontSize: 15, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          child: data.image == null
                              ? const SizedBox.shrink()
                              : Container(
                                  width: width,
                                  height: 60,
                                  decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(hostImg + data.image.toString()), fit: BoxFit.fill)),
                                ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      );
    });
  }
}
