// ignore_for_file: use_build_context_synchronously

import 'package:fluttertoast/fluttertoast.dart';
import 'package:rider/common/color_extension.dart';
import 'package:rider/common/custom_button.dart';
import 'package:rider/common/size.dart';
import 'package:rider/controllers/navigating_controller.dart';
import 'package:rider/controllers/order_controller.dart';
import 'package:rider/models/address_model.dart';
import 'package:rider/models/order_model.dart';
import 'package:rider/models/single_restaurant_model.dart';
import 'package:rider/others/customer_message.dart';
import 'package:rider/others/delivery_status_and_fee.dart';
import 'package:rider/others/oder_content_and_customer_name.dart';
import 'package:rider/others/restaurant_and_delivery_address.dart';
import 'package:rider/others/restaurant_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rider/views/home/widget/order_delivery_response.dart';

class OrderDetailsBody extends StatelessWidget {
  const OrderDetailsBody({
    super.key,
    required this.orderRestaurant,
    required this.orderDelivery,
    required this.order,
  });

  final SingleRestaurantModel? orderRestaurant;
  final AddressModel? orderDelivery;
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final riderId = box.read("userid");
    final controller = Get.put(OrderController());
    final navigationController = Get.put(NavigationController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30.h,
        ),
        RestaurantDetails(orderRestaurant: orderRestaurant),
        SizedBox(
          height: 5.h,
        ),
        Divider(color: Tcolor.Location_Text_Sheet_colour, thickness: 0.5.sp),
        SizedBox(
          height: 5.h,
        ),
        RestaurntAndDeliveryAddress(
            orderRestaurant: orderRestaurant, orderDelivery: orderDelivery),
        SizedBox(
          height: 20.h,
        ),
        OderContentAndCustomerName(order: order),
        DeliveryStatusAndFee(order: order),
        CustomerMessage(order: order),
        SizedBox(
          height: 50.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 30.w, right: 30.w),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            CustomButton(
              title: "IGNORE",
              showArrow: false,
              btnColor: Colors.transparent,
              border: Border.all(
                color: Tcolor.Primary_New,
              ),
              btnWidth: width / 2.5,
              raduis: 6.r,
              textColor: Tcolor.Text,
              fontSize: 24.sp,
              fontWeight: FontWeight.w500,
              onTap: () async {
                  var statusCode = await controller.rejectOrder(
                      order.id, riderId);
                  if (statusCode == 200) {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true, // Allows full customization
                        backgroundColor: Colors.transparent,
                        builder: (context) {
                          return SizedBox(
                            child: OrderDeliveryResponse(
                              onTap: () {
                                navigationController
                                  .changeTab(1); 
                              },
                              order: order,
                              orderDelivery: orderDelivery,
                              orderRestaurant: orderRestaurant,
                              src: "assets/img/accepted_pickup.png",
                              text1: "IGNORE CONFIRMED!",
                              text2: "You've successfully ignore",
                              text3: "this order",
                            ),
                          );
                        });
                  } else {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true, // Allows full customization
                        backgroundColor: Colors.transparent,
                        builder: (context) {
                          return SizedBox(
                            child: OrderDeliveryResponse(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              order: order,
                              src: "assets/img/declined_pickup.png",
                              text1: "Error",
                              text2: "Sorry, Something went wrong",
                              text3: "",
                            ),
                          );
                        });
                  }
              },
            ),
            CustomButton(
              title: "CONFIRM",
              showArrow: false,
              btnColor: Tcolor.Primary_New,
              btnWidth: width / 2.5,
              raduis: 6.r,
              textColor: Tcolor.Text,
              fontSize: 24.sp,
              fontWeight: FontWeight.w500,
              onTap: () async {
                var statusCode =
                    await controller.acceptOrder(order.id, riderId);
                if (statusCode == 200) {
                  controller.startStreamingLocation(order.id, riderId);
      //             Fluttertoast.showToast(
      //   msg: "stream location",
      //   gravity: ToastGravity.TOP,
      //   timeInSecForIosWeb: 3,
      // );
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true, // Allows full customization
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return SizedBox(
                          child: OrderDeliveryResponse(
                            onTap: () {
                              print("jksdjf");
                              navigationController
                                  .changeTab(1); // Navigate to Trips tab
                            },
                            order: order,
                            orderDelivery: orderDelivery,
                            orderRestaurant: orderRestaurant,
                            src: "assets/img/accepted_pickup.png",
                            text1: "PICK UP CONFIRMED!",
                            text2: "Proceed to pick up point to pick",
                            text3: "up the package",
                          ),
                        );
                      });
                } else {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true, // Allows full customization
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return SizedBox(
                          child: OrderDeliveryResponse(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            order: order,
                            src: "assets/img/declined_pickup.png",
                            text1: "Error",
                            text2: "Sorry, Something went wrong",
                            text3: "for the pick up.",
                          ),
                        );
                      });
                }
              }, // Disable tap if data is not ready
            )
          ]),
        )
      ],
    );
  }
}



// hi I'm havin a problem with my chopnow rider flutter app. what i want is that when the rider is assigned from the app, the current location is been streamed with the socket_io continually to the backed and stored in redis. the backend server is currently on my pc, so the redis is been stored on my pc. the issue I'm having now is that when the rider as being assigned, it seems that the location of the rider is ot beein streamed in realtime. I'll drop my flutter and node codes so that you can help me check: my socket_io.js: const { Server } = require("socket.io");const redisClient = require("./redisClients"); // make sure you import redislet io;function initSocket(server) {io = new Server(server, {cors: { origin: "*" },});io.on("connection", (socket) => {console.log("Socket connected: ", socket.id); code Codedownloadcontent_copyexpand_less    // rider joins an order
// socket.on("rider:join", ({ orderId, riderId }) => {
//   socket.join(`order_${orderId}`);
//   io.to(socket.id).emit("rider:join", { orderId });
//   console.log(`Rider ${riderId} joined order ${orderId}`);
// });

// // Rider sends live location
// socket.on("rider:location", async ({ orderId, riderId, lat, lng }) => {
//   const locationData = { riderId, orderId, lat, lng, timestamp: Date.now() };
//   console.log("Saving location for order:", orderId, "data:", locationData);


//   await redisClient.set(
//     `order:${orderId}:location`,
//     JSON.stringify(locationData)
//   );
//   await redisClient.rPush(
//     `order:${orderId}:locationHistory`,
//     JSON.stringify(locationData)
//   );

//   const history = await redisClient.lRange(
//     `order:${orderId}:locationHistory`,
//     -20,
//     -1
//   );
//   const locationHistory = history.map((h) => JSON.parse(h));

//   io.to(`order_${orderId}`).emit("rider:locationUpdate", locationData);
//   io.to(`order_${orderId}`).emit("rider:locationHistory", locationHistory);
// });

// // Customer/Restaurant subscribes
// socket.on("order:subscribe", ({ orderId }) => {
//   socket.join(`order_${orderId}`);
//   console.log(`Client subscribed to order ${orderId}`);
// });

// // Rider leaves after delivery
// socket.on("rider:leave", ({ orderId, riderId }) => {
//   io.to(`order_${orderId}`).emit("order:delivered", { orderId, riderId });
//   console.log(`Rider ${riderId} left order ${orderId}`);
// });

// socket.on("disconnect", () => {
//   console.log("Socket disconnected: ", socket.id);
// });
//   });}function getIO() {if (!io) throw new Error("Socket.io not initialized!");return io;}module.exports = { initSocket, getIO }; mi index.js: const http = require('http')const { Server } = require('socket.io')const mongoose = require('mongoose') const server = http.createServer(app);//attach socket.io to serverinitSocket(server); and this is the controller where the rider is assigned to the code: async function assignRiderToOrder(req, res) {try {const { orderId, userId, riderFcm } = req.params; code Codedownloadcontent_copyexpand_lessIGNORE_WHEN_COPYING_STARTIGNORE_WHEN_COPYING_END    if (!orderId || !userId) {
//         return res.status(400).json({ status: false, message: "Order ID and User ID are required." });
//     }

//     const order = await Order.findById(orderId);
//     if (!order) {
//         return res.status(404).json({ status: false, message: "Order not found." });
//     }
//     if (order.riderAssigned == true) {
//         return res.status(404).json({ status: false, message: "Order as already been assFigned." });
//     }

//     order.driverId = userId;
//     order.riderAssigned = true
//     order.riderStatus = "RA"
//     order.riderFcm = riderFcm
//     await order.save();

//     console.log(order.customerFcm)
//     console.log(riderFcm)
//     try {
//         if (order.customerFcm) {

//             await pushNotificationController.sendPushNotification(order.customerFcm, "Rider Assigned", "Woohoo! 🎉 A rider has been assigned to your order!", order);
//             await pushNotificationController.sendPushNotification(riderFcm, "Rider Assigned", "Woohoo! 🎉 you've been assigned to this order", order);
//         }

//     } catch (e) {
//         console.log(`error ${e}`)
//     }
    
//     console.log("socket io conection")

//     const io = getIO();
//     const order_Id = order._id
//     const rider_Id = order.driverId 
// io.to(`order_${order._id}`).emit("order:assigned", { order_Id, rider_Id})

//     res.status(200).json({ status: true, message: "Rider assigned successfully.", data: order });
// } catch (error) {
//     console.log(error)
//     res.status(500).json({ status: false, message: "Server error", error: error.message });
    
// }
//   }; now to my flutter app: this is my LocationStreamingSocketIo.dart: class LocationStreamingSocketIo {late IO.Socket? socket;void initSocket(String orderId, String riderId) {socket = IO.io(appBaseUrl,IO.OptionBuilder().setTransports(["websocket"]).disableAutoConnect().build()); code Codedownloadcontent_copyexpand_lessIGNORE_WHEN_COPYING_STARTIGNORE_WHEN_COPYING_END    socket!.connect();

// socket!.onConnect((_) {
//   print("✅ Socket connected");
//   socket!.emit("rider:join", {"orderId": orderId, "riderId": riderId});

//   socket!.on("rider:locationUpdate", (data) {
//     print("📍 Location update from server: $data");
//   });

//   Fluttertoast.showToast(
//     msg: "starting to stream location",
//     gravity: ToastGravity.TOP,
//     timeInSecForIosWeb: 3,
//   );
// });

// socket!.onDisconnect((_) {
//   print("❌ Socket disconnected");
// });
//   }void sendLocation(String orderId, String riderId, double lat, double lng) {if(socket != null && socket!.connected) {print("Sending rider location: $orderId, $riderId, $lat, $lng");socket!.emit("rider:location", {"orderId": orderId,"riderId": riderId,"lat": lat,"lng": lng});}}void disconnect() {socket!.disconnect();}}and this is the function to stream the location: LocationStreamingSocketIo streamSocket = LocationStreamingSocketIo();Future<void> startStreamingLocation(String orderId, String riderId) async{streamSocket.initSocket(orderId, riderId); code Codedownloadcontent_copyexpand_lessIGNORE_WHEN_COPYING_STARTIGNORE_WHEN_COPYING_END    Geolocator.getPositionStream(
//   locationSettings: const LocationSettings(
//     accuracy: LocationAccuracy.high,
//     distanceFilter: 5
//   ),

// ).listen((Position position) {
//   double lat = position.latitude;
//   double lng = position.longitude;
//   print("📡 Sending location: $lat, $lng");

//   streamSocket.sendLocation(orderId, riderId, lat, lng);
// });
//   } and I'm calling it her in the ui when assigning rider is successful:   onTap: () async {var statusCode =await controller.acceptOrder(order.id, riderId);if (statusCode == 200) {controller.startStreamingLocation(order.id, riderId); can you find the issue


// hi I'm havin a problem with my chopnow rider flutter app. what i want is that when the rider is assigned from the app, the current location is been streamed with the socket_io continually to the backed and stored in redis. the backend server is currently on my pc, so the redis is been stored on my pc. the issue I'm having now is that when the rider as being assigned, it seems that the location of the rider is ot beein streamed in realtime. I'll drop my flutter and node codes so that you can help me check. I'll be dropping the code one after the other and then tell you when to find the issue