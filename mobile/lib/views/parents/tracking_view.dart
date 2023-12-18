import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:label_marker/label_marker.dart';
import 'package:mobile/commons/common_btn_form.dart';
import 'package:mobile/commons/common_txt_style.dart';
import 'package:mobile/data/enum.dart';
import 'package:mobile/utils/logo.dart';
import '../../configs/lat_long.dart';
import '/configs/locations.dart' as locations;
import 'package:mobile/res/colors/color.dart';
import 'package:mobile/view_models/final_exam_view_model.dart';

class TrackingVeiw extends StatefulWidget {
  final String name;
  final int infoId;
  final String codeId;
  const TrackingVeiw({super.key, required this.name, required this.infoId, required this.codeId});

  @override
  State<TrackingVeiw> createState() => _TrackingVeiwState();
}

class _TrackingVeiwState extends State<TrackingVeiw> {
  final FinalExamViewModel _finalExamViewModel = Get.put(FinalExamViewModel());
  Set<Marker> markers = {};

  double _latAt = 0;
  double _longAt = 0;
  String _label = '';
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyAWOXUUM9m5pW2gMey6g1CT-cCnrrcB8sE";

  _addPolyLine() {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    'hi'.log();
    'latNotifier: ${latNotifier.value}'.log();
    '_latAt: $_latAt'.log();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(googleAPiKey, PointLatLng(latNotifier.value, longNotifie.value), PointLatLng(11.6117933, 104.923315), travelMode: TravelMode.driving, wayPoints: [
      PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")
    ]);
    if (result.points.isNotEmpty) {
      'true'.log();
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    'false'.log();
    _addPolyLine();
  }

  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      if (!mounted) return;
      // _markers.clear();
      markers.clear();
      "Label in onMapCreate: $_label".log();
      "LatNoti: ${latNotifier.value}".log();
      "Lat: $_latAt".log();
      "longNoti: ${longNotifie.value}".log();
      "Long: $_longAt".log();
      for (final office in googleOffices.offices) {
        markers
            .addLabelMarker(LabelMarker(
          label: _label,
          textStyle: const TextStyle(fontSize: 45),
          markerId: MarkerId(office.name),
          position: LatLng(_latAt, _longAt),
          // position: LatLng(latNotifier.value, longNotifie.value),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
          // icon: markerIcon,
          draggable: true,
          onDragEnd: (value) {},
        ))
            .then((value) {
          setState(() {});
        });
        // _markers[office.name] = marker;
      }
    });
  }

  @override
  void initState() {
    _finalExamViewModel.readInfoByid(widget.infoId);
    _getPolyline();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: width,
        height: height * 0.75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: _finalExamViewModel.infoByIdModel.value.infoById.lat == null && _finalExamViewModel.infoByIdModel.value.infoById.long == null
            ? null
            : Obx(() {
                switch (_finalExamViewModel.loadingStatus.value) {
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
                    var data = _finalExamViewModel.infoByIdModel.value.infoById;
                    double lat = double.parse(data.lat ?? "");
                    double long = double.parse(data.long ?? "");
                    _latAt = lat;
                    _longAt = long;
                    "Lat: ${data.lat}".log();
                    "_long: $_longAt".log();
                    _label = data.name ?? "";
                    "Label: $_label".log();
                    "Check: ${data.lat == null && data.long == null ? "no" : "have"}".log();
                    return data.lat == null && data.long == null
                        ? Container()
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.clear,
                                      color: btnColor,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      Get.back();
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: CommonTxtStyle(
                                          label: "Name: ${widget.name}",
                                          fontSize: 18,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                      Flexible(
                                        child: CommonTxtStyle(
                                          label: "CodeID: ${widget.codeId}",
                                          fontSize: 18,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  width: width,
                                  height: height * 0.5,
                                  child: GoogleMap(
                                    onMapCreated: _onMapCreated,
                                    mapType: MapType.normal,
                                    initialCameraPosition: CameraPosition(
                                      target: LatLng(_latAt, _longAt),
                                      zoom: 14.5,
                                    ),
                                    myLocationEnabled: true,
                                    myLocationButtonEnabled: true,
                                    compassEnabled: true,
                                    markers: markers,
                                    tiltGesturesEnabled: true,
                                    zoomGesturesEnabled: true,
                                    polylines: Set<Polyline>.of(polylines.values),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                                  child: CommonBtn(
                                    label: "Go to Derection",
                                    color: btnColor,
                                    textStyle: const TextStyle(fontSize: 18, color: Colors.white),
                                    callback: () {},
                                    isLoading: false,
                                  ),
                                )
                              ],
                            ),
                          );
                }
              }),
      ),
    );
  }
}
