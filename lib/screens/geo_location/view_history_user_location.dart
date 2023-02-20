import 'dart:async';

import 'package:eswm/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_widget/google_maps_widget.dart';

import '../../utils/icon/custom_icon.dart';

class ViewHistoryUserLocation extends StatefulWidget {
  final String? vehicleId;

  const ViewHistoryUserLocation({Key? key, this.vehicleId}) : super(key: key);

  @override
  ViewHistoryUserLocationState createState() => ViewHistoryUserLocationState();
}

class ViewHistoryUserLocationState extends State<ViewHistoryUserLocation> {
// created controller to display Google Maps
  final Completer<GoogleMapController> _controller = Completer();

//on below line we have set the camera position
  static const CameraPosition _kGoogle = CameraPosition(
    target: LatLng(3.138011, 101.6295288),
    zoom: 20,
  );

  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};

// list of locations to display polylines
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
  void initState() {
    super.initState();

    // declared for loop for various locations
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
        width: 6,
        color: Colors.green,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SafeArea(
        child: GoogleMap(
          //given camera position
          initialCameraPosition: _kGoogle,
          // on below line we have given map type
          mapType: MapType.normal,
          // specified set of markers below
          // markers: _markers,
          // on below line we have enabled location
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          // on below line we have enabled compass location
          compassEnabled: true,
          // on below line we have added polylines
          polylines: _polyline,
          // displayed google map
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
