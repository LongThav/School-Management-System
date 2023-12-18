import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:label_marker/label_marker.dart';
import 'package:mobile/data/enum.dart';
import 'package:mobile/db_helpers/cache_id.dart';
import 'package:mobile/utils/logo.dart';
import 'package:mobile/view_models/final_exam_view_model.dart';
import '../../configs/lat_long.dart';
import '../../view_models/profile_view_model.dart';
import '/configs/locations.dart' as locations;
import 'package:get/get.dart';
import 'package:mobile/commons/common_txt_style.dart';
import 'package:mobile/res/colors/color.dart';

class GoogleMapView extends StatefulWidget {
  final int userId;
  const GoogleMapView({super.key, required this.userId});

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  String _userName = "";
  Set<Marker> markers = {};
  final Set<Polyline> _polyline = {};
  final CacheId _cacheId = CacheId();
  final FinalExamViewModel _examViewModel = Get.put(FinalExamViewModel());
  final ProfileViewModdel _profileViewModdel = Get.put(ProfileViewModdel());
  List<LatLng> latLen = const [
    LatLng(19.0759837, 72.8776559),
    LatLng(28.679079, 77.069710),
    LatLng(26.850000, 80.949997),
    LatLng(24.879999, 74.629997),
    LatLng(16.166700, 74.833298),
    LatLng(12.971599, 77.594563),
  ];
  double _latAt = 0;
  double _longAt = 0;
  int userInfoId = 0;
  void polylineInit() {
    for (int i = 0; i < latLen.length; i++) {
      markers.add(
          // added markers
          Marker(
        markerId: MarkerId(i.toString()),
        position: latLen[i],
        infoWindow: const InfoWindow(
          title: 'HOTEL',
          snippet: '5 Star Hotel',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
      setState(() {});
      _polyline.add(Polyline(
        polylineId: const PolylineId('1'),
        points: latLen,
        color: Colors.green,
      ));
    }
  }

  void init() async {
    String id = await _cacheId.readInfoId();
    int infoId = int.parse(id);
    // _examViewModel.addLatLong(lat, long, infoId);
    "InfoId: $infoId".log();
    setState(() {
      userInfoId = infoId;
    });
    _profileViewModdel.readUserInfor(widget.userId);
  }

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(const ImageConfiguration(), "assets/imgs/profile.jpg").then((value) {
      setState(() {
        markerIcon = value;
      });
    });
  }

  double _latAutUpdate = 0;
  double _longAutUpdate = 0;
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      if (!mounted) return;
      // _markers.clear();
      markers.clear();
      for (final office in googleOffices.offices) {
        // final marker = Marker(
        //   // markerId: MarkerId(office.name),
        //   markerId: const MarkerId("LongThav SiPav"),
        //   // position: LatLng(latNotifier.value, longNotifie.value),
        //   position: LatLng(_latAt, _longAt),
        //   infoWindow: InfoWindow(
        //     title: office.name,
        //     snippet: office.address,
        //   ),
        //   draggable: true,
        //   onDragEnd: (value) {
        //     //value is new position
        //     "lat: ${value.latitude}".log();
        //     "long: ${value.longitude}".log();
        //     // _longAt = value.longitude.toString();
        //     // _latAt = value.latitude.toString();
        //     _longAutUpdate = value.longitude;
        //     _latAutUpdate = value.latitude;
        //   },
        // );
        "UserName Label: $_userName".log();
        markers.addLabelMarker(LabelMarker(
          label: _userName,
          markerId: const MarkerId(''),
          position: LatLng(latNotifier.value, longNotifie.value),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
          // icon: markerIcon,
          draggable: true,
          onDragEnd: (value) {
            //value is new position
            "lat: ${value.latitude}".log();
            "long: ${value.longitude}".log();
            // _longAt = value.longitude.toString();
            // _latAt = value.latitude.toString();
            _longAutUpdate = value.longitude;
            _latAutUpdate = value.latitude;
          },
        )).then((value){
          setState(() {
            
          });
        });
        // _markers[office.name] = marker;
      }
    });
  }

  @override
  void initState() {
    addCustomIcon();
    init();
    Future.delayed(const Duration(milliseconds: 500),(){});
    polylineInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    latNotifier.value.log();
    longNotifie.value.log();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: btnColor,
          ),
        ),
        title: const CommonTxtStyle(
          label: 'Set Your Location',
          fontSize: 18,
          color: btnColor,
        ),
        titleSpacing: -10,
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed: () {
                // "InfoId: $userInfoId".log();
                // _examViewModel.addLatLong(_latAutUpdate, _longAutUpdate, userInfoId, context);
                // _profileViewModdel.readUserInfor(widget.userId);
                // setState(() {
                //   markers.clear();
                // });
              },
              icon: const Icon(
                Icons.location_pin,
                color: btnColor,
              ))
        ],
      ),
      // body: GoogleMap(
      //   onMapCreated: _onMapCreated,
      //   mapType: MapType.normal,
      //   initialCameraPosition: CameraPosition(
      //     target: LatLng(latNotifier.value, longNotifie.value),
      //     zoom: 14,
      //   ),
      //   myLocationEnabled: true,
      //   markers: _markers.values.toSet(),
      // ),
      body: Obx(() {
        switch (_profileViewModdel.loadingStatus.value) {
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
            return _buildGoogleMap();
        }
      }),
    );
  }

  Widget _buildGoogleMap() {
    return Obx(() {
      var data = _profileViewModdel.userInfoModel.value.data?.userInfor;
      double lat = double.parse(data?.lat ?? "");
      double long = double.parse(data?.long ?? "");
      _userName = data?.name ?? "";
      "_UserName: $_userName".log();
      _latAt = lat;
      _longAt = long;
      return GoogleMap(
        onMapCreated: _onMapCreated,
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          // target: LatLng(latNotifier.value, longNotifie.value),
          target: LatLng(_latAt, _longAt),
          zoom: 14,
        ),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        compassEnabled: true,
        polylines: _polyline,
        // markers: _markers.values.toSet(),
        markers: markers,
      );
    });
  }
}
