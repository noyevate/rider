import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rider/common/size.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class LocationStreamingSocketIo {
  late IO.Socket? socket;
  StreamSubscription<Position>? _positionStreamSubscription;

  void initSocket(String orderId, String riderId) {
    socket = IO.io(
        appBaseUrl,
        IO.OptionBuilder()
            .setTransports(["websocket"])
            .disableAutoConnect()
            .build());
    socket!.connect();

    socket!.onConnect((_) {
      print("✅ Socket connected");
      // When connected, tell the server the rider wants to join the order room
      socket!.emit("rider:join", {"orderId": orderId, "riderId": riderId});
    });

    // Listen for the 'rider:join' confirmation from the server
    socket!.on("rider:join", (data) {
      print("✅ Rider successfully joined room for order: ${data['orderId']}");
      
      // NOW it is safe to start streaming the location
      _startGeolocatorStream(orderId, riderId);
    });

    socket!.on("order:delivered", (_) {
    print("✅ Received 'order:delivered' event from server. Stopping stream.");
    Fluttertoast.showToast(msg: "Order marked as delivered. Stopping location stream.");
    disconnect(); // This cleans everything up!
  });

    socket!.on("rider:locationUpdate", (data) {
      print("📍 Location update from server: $data");
    });

    socket!.onDisconnect((_) {
      print("❌ Socket disconnected");
      _stopGeolocatorStream();
    });
  }

  // This new private method will handle the location stream
  void _startGeolocatorStream(String orderId, String riderId) {
    // Ensure we don't start multiple streams
    if (_positionStreamSubscription != null) return;

    Fluttertoast.showToast(
      msg: "Starting to stream location",
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 3,
    );

    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5, // Meters
      ),
    ).listen((Position position) {
      double lat = position.latitude;
      double lng = position.longitude;
      print("📡 Sending location: $lat, $lng");
      sendLocation(orderId, riderId, lat, lng);
    });
  }

  void _stopGeolocatorStream() {
    _positionStreamSubscription?.cancel();
    _positionStreamSubscription = null;
  }

  void sendLocation(String orderId, String riderId, double lat, double lng) {
    if (socket != null && socket!.connected) {
      print("Sending rider location: $orderId, $riderId, $lat, $lng");
      socket!.emit("rider:location", {
        "orderId": orderId,
        "riderId": riderId,
        "lat": lat,
        "lng": lng
      });
    }
  }

  void disconnect() {
    _stopGeolocatorStream();
    socket?.disconnect();
  }
}