import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_widget/google_maps_widget.dart';
import 'package:location/location.dart';

//import files
import '../../widgets/alert/toast.dart';

class TrackUserLocation extends StatefulWidget {
  const TrackUserLocation({Key? key}) : super(key: key);

  @override
  State<TrackUserLocation> createState() => _TrackUserLocationState();
}

class _TrackUserLocationState extends State<TrackUserLocation> {
  final mapsWidgetController = GlobalKey<GoogleMapsWidgetState>();

  bool shownToast = false;

  bool reachedDest = false;

  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                child: GoogleMapsWidget(
                  apiKey: "AIzaSyC6dxJRHz9I2_nWGXFyDFAF3TuMObeS1Qk",
                  key: mapsWidgetController,
                  sourceLatLng: sourceLocation,
                  destinationLatLng: destination,
                  myLocationEnabled: true,
                  zoomGesturesEnabled: true,
                  ///////////////////////////////////////////////////////
                  //////////////    OPTIONAL PARAMETERS    //////////////
                  ///////////////////////////////////////////////////////

                  routeWidth: 2,
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
