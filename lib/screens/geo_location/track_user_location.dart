import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_widget/google_maps_widget.dart';
import 'package:location/location.dart';

//import files
import '../../config/palette.dart';
import '../../utils/icon/custom_icon.dart';
import '../../widgets/alert/toast.dart';

class TrackUserLocation extends StatefulWidget {
  final String? vehicleId;

  const TrackUserLocation({Key? key, this.vehicleId}) : super(key: key);

  @override
  State<TrackUserLocation> createState() => _TrackUserLocationState();
}

class _TrackUserLocationState extends State<TrackUserLocation> {
  final mapsWidgetController = GlobalKey<GoogleMapsWidgetState>();

  bool shownToast = false;

  bool reachedDest = false;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};

  @override
  void initState() {
    for (int i = 0; i < latLen.length; i++) {
      _markers.add(
          // added markers
          Marker(
        markerId: MarkerId(i.toString()),
        position: latLen[i],
        icon: BitmapDescriptor.defaultMarker,
      ));
      setState(() {});
      _polyline.add(Polyline(
        polylineId: const PolylineId('1'),
        points: latLen,
        width: 2,
        color: darkBlue,
      ));
    }
    super.initState();
  }

  @override
  @override
  void dispose() {
    super.dispose();
  }

  LocationData? currentLocation;

  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then(
      (location) {
        currentLocation = location;
      },
    );
    /*location.onLocationChanged.listen(
      (newLoc) {
        currentLocation = newLoc;
        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 13.5,
              target: LatLng(
                newLoc.latitude!,
                newLoc.longitude!,
              ),
            ),
          ),
        );
        setState(() {});
      },
    );*/
  }

  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng sourceLocation = LatLng(3.1379116, 101.6296056);
  static const LatLng destination = LatLng(3.1362133, 101.6316105);
  List<LatLng> latLen = const [
    LatLng(3.138164658578095, 101.62975788116456),
    LatLng(3.1382985679118374, 101.62948966026306),
    LatLng(3.138164658578095, 101.62922143936159),
    LatLng(3.1380307492271777, 101.62900149822237),
    LatLng(3.1377629304738814, 101.62893176078798),
    LatLng(3.137077314152752, 101.62987589836122),
    LatLng(3.136209580351658, 101.63093805313112),
    LatLng(3.1360596015970046, 101.63117408752441),
    LatLng(3.1365898835259736, 101.63102924823761),
    LatLng(3.137318351191913, 101.63020312786104),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: barShadowColor,
                      offset: const Offset(0, 3),
                      blurRadius: 8,
                    )
                  ]),
                  child: AppBar(
                      backgroundColor: white,
                      elevation: 0,
                      leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(CustomIcon.arrowBack,
                            color: blackCustom, size: 20),
                      ),
                      title: Center(
                          child: Text("Laluan Kompaktor - ${widget.vehicleId}",
                              style: TextStyle(
                                fontSize: 15,
                                color: blackCustom,
                                fontWeight: FontWeight.w400,
                              )))))),
          body: Column(
            children: [
              Expanded(
                child: GoogleMapsWidget(
                  apiKey: "AIzaSyC6dxJRHz9I2_nWGXFyDFAF3TuMObeS1Qk",
                  key: mapsWidgetController,
                  sourceLatLng: sourceLocation,
                  destinationLatLng: destination,
                  myLocationEnabled: true,
                  ///////////////////////////////////////////////////////
                  //////////////    OPTIONAL PARAMETERS    //////////////
                  ///////////////////////////////////////////////////////
                  routeWidth: 2,
                  routeColor: green,
                  sourceMarkerIconInfo: MarkerIconInfo(
                    infoWindowTitle: "This is source name",
                    onTapInfoWindow: (_) {
                      //print("Tapped on source info window");
                    },
                    assetMarkerSize: const Size.square(80),
                    assetPath: "assets/image/source-marker-icon.png",
                  ),
                  destinationMarkerIconInfo: const MarkerIconInfo(
                    assetPath: "assets/image/destination-marker-icon.png",
                    assetMarkerSize: Size.square(80),
                  ),
                  driverMarkerIconInfo: MarkerIconInfo(
                    infoWindowTitle: "Alex",
                    assetPath: "assets/image/driver-marker-icon.png",
                    onTapMarker: (currentLocation) {
                      //print("Driver is currently at $currentLocation");
                    },
                    assetMarkerSize: const Size(50, 90),
                    //rotation: 90,
                  ),
                  onMapCreated: (mapController) {
                    _controller.complete(mapController);
                  },
                  polylines: _polyline,
                  onPolylineUpdate: (p) {
                    //print("Polyline updated: ${p.points}");
                  },
                  updatePolylinesOnDriverLocUpdate:
                      reachedDest == false ? true : false,

                  /// Mock compactor's stream
                  driverCoordinatesStream:
                      Stream.periodic(const Duration(seconds: 2), (i) {
                    return LatLng(3.1378175500000003 - i / 10000,
                        101.62956750000001 + i / 10000);
                    //currentLocation!.latitude!+ i / 10000,
                    //currentLocation!.longitude!- i / 10000);
                  }),
                  totalTimeCallback: (time) {
                    //print(time);
                  },
                  totalDistanceCallback: (distance) {
                    //print(distance);
                    var aStr = distance!.replaceAll(RegExp(r'[^.0-9]'), '');
                    var aInt = double.parse(aStr);
                    if (!reachedDest && aInt <= 0.2) {
                      if (!shownToast) {
                        showInfoToast(context,
                            "Kompaktor menghampiri laluan tugas dan dalam lingkungan 200m",
                            height: 16);
                        shownToast = true;
                      } else {
                        if (aInt < 90) {
                          reachedDest = true;
                        }
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
