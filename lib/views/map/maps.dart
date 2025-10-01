// import 'package:rider/common/custom_appbar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class Maps extends StatelessWidget {
//   const Maps({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//           preferredSize: Size.fromHeight(250.h),
//           child: const CustomAppBar(
            
//             rating: 5.5,
//             notificationCount: 3,
//             date: '',
//           )),
//     );
//   }
// }



import 'dart:async';

import 'package:rider/common/color_extension.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {

  late GoogleMapController mapController;
 LatLng? _currentPosition = null;

 final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  @override
  void initState() {
    super.initState();
    
    _determinePosition();
  }

 

  

  // Marker for Delivery Point
  final Marker _deliveryPoint = Marker(
    markerId: const MarkerId('deliveryPoint'),
    position: const LatLng(9.94809, 7.44744),
    infoWindow: const InfoWindow(title: 'Delivery Point'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentPosition != null ? Stack(
        children: [
          // Google Map
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _currentPosition!,
              zoom: 14.0,
            ),
            markers: {_deliveryPoint},
            zoomControlsEnabled: true,
                    minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                    onMapCreated: (GoogleMapController controller) =>
                        _mapController.complete(controller)
            
          ),

          // Floating Card with TextFields and Button
          Positioned(
            top: 100,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Origin TextField
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.location_on, color: Colors.green),
                      hintText: 'Where you are',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Destination TextField
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.location_on, color: Colors.red),
                      hintText: 'Choose Destination',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Start Trip Button
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Implement Start Trip functionality
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade300,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text(
                      'START TRIP',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ) : Center(
                    child: ReuseableText(
                        title: "waiting for rider location...",
                        style: TextStyle(
                            color: Tcolor.TEXT_Placeholder,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w500)),
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
    
  }
}


  // Future<void> getPolylinePoints() async {
  //   // Check that all required locations are set
  //   if (_currentPosition == null ||
  //       pickUpLocation == null ||
  //       deliveryLocation == null) {
  //     print("One or more locations are null. Cannot draw polylines.");
  //     return;
  //   }

  //   // Initialize a list to store all polyline coordinates
  //   List<LatLng> polylineCoordinates1 = [];
  //   List<LatLng> polylineCoordinates2 = [];

  //   // Initialize PolylinePoints
  //   PolylinePoints polylinePoints = PolylinePoints();

  //   // Draw polyline from _currentPosition to pickUpLocation
  //   PolylineRequest request1 = PolylineRequest(
  //     origin:
  //         PointLatLng(_currentPosition!.latitude, _currentPosition!.longitude),
  //     destination:
  //         PointLatLng(pickUpLocation!.latitude, pickUpLocation!.longitude),
  //     mode: TravelMode.driving,
  //   );

  //   PolylineResult result1 = await polylinePoints.getRouteBetweenCoordinates(
  //       request: request1, googleApiKey: googleApiKey);

  //   if (result1.points.isNotEmpty) {
  //     result1.points.forEach((PointLatLng point) {
  //       polylineCoordinates1.add(LatLng(point.latitude, point.longitude));
  //     });
  //     generatePolylineFromPoint(
  //         polylineCoordinates1, "poly1"); // Assign a unique ID for this route
  //   } else {
  //     print(
  //         "Error fetching polyline for _currentPosition to pickUpLocation: ${result1.errorMessage}");
  //   }

  //   // Draw polyline from pickUpLocation to deliveryLocation
  //   PolylineRequest request2 = PolylineRequest(
  //     origin: PointLatLng(pickUpLocation!.latitude, pickUpLocation!.longitude),
  //     destination:
  //         PointLatLng(deliveryLocation!.latitude, deliveryLocation!.longitude),
  //     mode: TravelMode.driving,
  //   );

  //   PolylineResult result2 = await polylinePoints.getRouteBetweenCoordinates(
  //       request: request2, googleApiKey: googleApiKey);

  //   if (result2.points.isNotEmpty) {
  //     result2.points.forEach((PointLatLng point) {
  //       polylineCoordinates2.add(LatLng(point.latitude, point.longitude));
  //     });
  //     generatePolylineFromPoint(
  //         polylineCoordinates2, "poly2"); // Assign a unique ID for this route
  //   } else {
  //     print(
  //         "Error fetching polyline for pickUpLocation to deliveryLocation: ${result2.errorMessage}");
  //   }
  // }

  // void generatePolylineFromPoint(
  //     List<LatLng> polylineCoordinates, String polylineId) async {
  //   PolylineId id = PolylineId(polylineId);
  //   Polyline polyline = Polyline(
  //     polylineId: id,
  //     color: Tcolor.MapRoute,
  //     points: polylineCoordinates,
  //     width: 5,
  //   );

  //   setState(() {
  //     polylines[id] = polyline;
  //   });
  // }

