import 'dart:async';

import 'package:rider/common/color_extension.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:rider/common/size.dart';
import 'package:rider/models/address_model.dart';
import 'package:rider/models/order_model.dart';
import 'package:rider/models/single_restaurant_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class MapRoute extends StatefulWidget {
  const MapRoute(
      {super.key,
      this.orderRestaurant,
      this.orderDelivery,
      required this.order});

  final SingleRestaurantModel? orderRestaurant;
  final AddressModel? orderDelivery;
  final OrderModel order;

  @override
  State<MapRoute> createState() => _MapRouteState();
}

class _MapRouteState extends State<MapRoute> {
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  Map<PolylineId, Polyline> polylines = {};

  LatLng? _currentPosition = null;

  LatLng? pickUpLocation;

  LatLng? deliveryLocation;

  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  BitmapDescriptor? presentIcon;
  BitmapDescriptor? pickUpIcon;
  BitmapDescriptor? deliveryIcon;

  BitmapDescriptor? presentIcon1;
  BitmapDescriptor? pickUpIcon1;
  BitmapDescriptor? deliveryIcon1;

  @override
  void initState() {
    super.initState();
    if (widget.orderRestaurant != null && widget.orderDelivery != null) {
      pickUpLocation = LatLng(
        widget.orderRestaurant!.coords.latitude,
        widget.orderRestaurant!.coords
            .longitude, // Ensure you use correct longitude
      );

      deliveryLocation = LatLng(
        widget.orderDelivery!.address.latitude,
        widget.orderDelivery!.address
            .longitude, // Ensure you use correct longitude
      );
    }
    _loadCustomIcons();
    _determinePosition();
  }

  Future<void> _loadCustomIcons() async {
    presentIcon = await BitmapDescriptor.asset(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/img/me_point.png',
        height: 100.h, width: 100.w);

    pickUpIcon = await BitmapDescriptor.asset(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/img/pickup_point.png',
        height: 100.h,
        width: 100.w);

    deliveryIcon = await BitmapDescriptor.asset(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/img/delivery_point.png',
        height: 100.h,
        width: 100.w);

    // _addMarkers();
  }

  void _addMarkers() {
    _markers.add(Marker(
      markerId: MarkerId('rider_location'),
      position: _currentPosition!,
      icon: presentIcon ?? BitmapDescriptor.defaultMarker,
    ));

    if (pickUpLocation != null) {
      _markers.add(Marker(
        markerId: MarkerId('pickUpLocation'),
        position: pickUpLocation!,
        icon: pickUpIcon ?? BitmapDescriptor.defaultMarker,
      ));
    }

    _markers.add(Marker(
      markerId: MarkerId('deliveryLocation'),
      position: deliveryLocation!,
      icon: deliveryIcon ?? BitmapDescriptor.defaultMarker,
    ));

    setState(() {}); // Update the UI after adding markers and polyline
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Tcolor.BACKGROUND_Regaular,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [],
        ),
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: _currentPosition != null
            ? Stack(
                children: [
                  GoogleMap(
                    mapToolbarEnabled: true,
                  
                    initialCameraPosition: CameraPosition(
                      zoom: 15,
                      target: _currentPosition!,
                    ),
                    markers: _markers,
                    polylines: Set<Polyline>.of(polylines.values),
                    zoomControlsEnabled: true,
                    minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                    onMapCreated: (GoogleMapController controller) =>
                        _mapController.complete(controller),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 30.w, top: 20.h),
                      child: Positioned(
                        left: 0, // Align the icon to the left
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 62.h,
                            width: 62.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Tcolor.White,
                            ),
                            child: Icon(
                              HeroiconsMini.chevronLeft,
                              color: Tcolor.Text,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            : Stack(
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 30.w, top: 20.h),
                      child: Positioned(
                        left: 0, // Align the icon to the left
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 62.h,
                            width: 62.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Tcolor.White,
                            ),
                            child: Icon(
                              HeroiconsMini.chevronLeft,
                              color: Tcolor.Text,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                Center(
                    child: ReuseableText(
                        title: "waiting for rider location...",
                        style: TextStyle(
                            color: Tcolor.TEXT_Placeholder,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w500)),
                  ),
              ],
            ),
      ),
    );
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    _getCurrentLocation();
  }

  Future _getCurrentLocation() async {
    // final controller = Get.put(RiderLocationController());
    Position position = await Geolocator.getCurrentPosition(
        // ignore: deprecated_member_use
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });

    print(_currentPosition);
    _addMarkers();
    getPolylinePoints();
  }

  Future<void> getPolylinePoints() async {
    // Check that all required locations are set
    if (_currentPosition == null ||
        pickUpLocation == null ||
        deliveryLocation == null) {
      print("One or more locations are null. Cannot draw polylines.");
      return;
    }

    // Initialize a list to store all polyline coordinates
    List<LatLng> polylineCoordinates1 = [];
    List<LatLng> polylineCoordinates2 = [];

    // Initialize PolylinePoints
    PolylinePoints polylinePoints = PolylinePoints();

    // Draw polyline from _currentPosition to pickUpLocation
    PolylineRequest request1 = PolylineRequest(
      origin:
          PointLatLng(_currentPosition!.latitude, _currentPosition!.longitude),
      destination:
          PointLatLng(pickUpLocation!.latitude, pickUpLocation!.longitude),
      mode: TravelMode.driving,
    );

    PolylineResult result1 = await polylinePoints.getRouteBetweenCoordinates(
        request: request1, googleApiKey: googleApiKey);

    if (result1.points.isNotEmpty) {
      result1.points.forEach((PointLatLng point) {
        polylineCoordinates1.add(LatLng(point.latitude, point.longitude));
      });
      generatePolylineFromPoint(
          polylineCoordinates1, "poly1"); // Assign a unique ID for this route
    } else {
      print(
          "Error fetching polyline for _currentPosition to pickUpLocation: ${result1.errorMessage}");
    }

    // Draw polyline from pickUpLocation to deliveryLocation
    PolylineRequest request2 = PolylineRequest(
      origin: PointLatLng(pickUpLocation!.latitude, pickUpLocation!.longitude),
      destination:
          PointLatLng(deliveryLocation!.latitude, deliveryLocation!.longitude),
      mode: TravelMode.driving,
    );

    PolylineResult result2 = await polylinePoints.getRouteBetweenCoordinates(
        request: request2, googleApiKey: googleApiKey);

    if (result2.points.isNotEmpty) {
      result2.points.forEach((PointLatLng point) {
        polylineCoordinates2.add(LatLng(point.latitude, point.longitude));
      });
      generatePolylineFromPoint(
          polylineCoordinates2, "poly2"); // Assign a unique ID for this route
    } else {
      print(
          "Error fetching polyline for pickUpLocation to deliveryLocation: ${result2.errorMessage}");
    }
  }

  void generatePolylineFromPoint(
      List<LatLng> polylineCoordinates, String polylineId) async {
    PolylineId id = PolylineId(polylineId);
    Polyline polyline = Polyline(
      polylineId: id,
      color: Tcolor.MapRoute,
      points: polylineCoordinates,
      width: 5,
    );

    setState(() {
      polylines[id] = polyline;
    });
  }
}
