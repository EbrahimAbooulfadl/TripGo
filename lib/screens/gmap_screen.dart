import 'dart:collection';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:untitled/constatns/constants.dart';
import 'package:geolocator/geolocator.dart';

class GMap extends StatefulWidget {
  double lang;
  double lat;

  GMap(this.lat, this.lang);
  static final LatLng _kMapCenter = LatLng(30.0444, 31.2357);

  static final CameraPosition _kInitialPosition =
      CameraPosition(target: _kMapCenter, zoom: 11.0, tilt: 0, bearing: 0);

  @override
  State<GMap> createState() => _GMapState();
}

late double currentlat;
late double currentlang;

class _GMapState extends State<GMap> {
  void getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('location service disabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('permission denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('denied forever');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double clat = position.latitude;
    double clang = position.longitude;
    currentlat = clat;
    currentlang = clang;

    print('hoa da el location $position');
  }

  void markeradd() async {
    _markers.add(Marker(
        markerId: MarkerId("0"), position: LatLng(widget.lat, widget.lang)));
    _markers.add(Marker(
        markerId: MarkerId("1"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        position: LatLng(currentlat, currentlang)));
    dir.add(LatLng(widget.lat, widget.lang));
    dir.add(LatLng(currentlat, currentlang));
  }

  Set<Marker> _markers = HashSet<Marker>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {});
  }

  List<LatLng> dir = [];

  @override
  Widget build(BuildContext context) {
    getLocation();
    markeradd();
    setState(() {});

    print(_markers.length);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWidgetColor,
        leading: GestureDetector(
            onTap: () {
              setState(() {
                getLocation();
              });
            },
            child: Icon(Icons.gps_fixed_sharp)),
        title: Text(
          'Here is the location to your destination',
          style: kLabelTextStyle.copyWith(
              fontSize: 17, color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      body: GoogleMap(
        polylines: {
          Polyline(
              polylineId: const PolylineId('as'),
              color: kWidgetColor,
              width: 5,
              points: dir),
        },
        initialCameraPosition: CameraPosition(
            target: LatLng(widget.lat, widget.lang),
            zoom: 11.0,
            tilt: 0,
            bearing: 0),
        markers: _markers,
      ),
    );
  }
}
