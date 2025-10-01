// ignore_for_file: library_private_types_in_public_api

import 'package:rider/common/color_extension.dart';
import 'package:rider/common/custom_nav_bar.dart';
import 'package:rider/controllers/navigating_controller.dart';
import 'package:rider/views/home/home_page.dart';
import 'package:rider/views/map/maps.dart';
import 'package:rider/views/profile/profile.dart';
import 'package:rider/views/restaurant/restaurants.dart';
import 'package:rider/views/trips/trips.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});

//   @override
//   _MainScreenState createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {

//   final NavigationController navigationController = Get.put(NavigationController());
//   int _selectedIndex = 0;

//    @override
//   void initState() {
//     super.initState();
//     // Check if there is an argument passed for the selected index
//     final args = Get.arguments;
//     if (args != null && args is int) {
//       _selectedIndex = args;
//     }
//   }

//   final List<Widget> pageList = const [
//     HomePage(),
//     Trips(),
//     Maps(),
//     Restaurants(),
//     Profile(),
//   ];

//   void _onNavItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: pageList[_selectedIndex],
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: CustomBottomNav(
//               selectedIndex: _selectedIndex,
//               onItemTapped: _onNavItemTapped,
//             ),
//           ),
//           Positioned(
//             bottom: 10.sp, // Adjust the bottom margin to align with your bottom nav
//             left: 0,
//             right: 0,
//             child: Center(
//               child: SizedBox(
//                 height: 80.h,
//                 width: 80.h,
//                 child: FloatingActionButton(
//                   onPressed: () {
//                     setState(() {
//                       _selectedIndex = 2; // Set index to CartPage
//                     });
//                   },
//                   backgroundColor: Color.fromRGBO(255, 184, 0, 1),
//                   shape: const CircleBorder(),
//                   child: Icon(
//                     HeroiconsMini.shoppingBag,
//                     color: Tcolor.TEXT_Label,
//                     size: 50.sp,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final NavigationController navigationController = Get.put(NavigationController());

  // Create a map of navigator keys
  final Map<int, GlobalKey<NavigatorState>> navigatorKeys = {
    0: GlobalKey<NavigatorState>(),
    1: GlobalKey<NavigatorState>(),
    2: GlobalKey<NavigatorState>(),
    3: GlobalKey<NavigatorState>(),
    4: GlobalKey<NavigatorState>(),
  };

  final List<Widget Function(Key)> pageList = [
    (key) => HomePage(key: key),
    (key) => Trips(key: key),
    (key) => Maps(key: key),
    (key) => Restaurants(key: key),
    (key) => Profile(key: key),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Tcolor.BACKGROUND_Regaular,
      body: Obx(() {
        return Stack(
          children: List.generate(pageList.length, (index) {
            return Offstage(
              offstage: navigationController.selectedIndex.value != index,
              child: Navigator(
                key: navigatorKeys[index],
                onGenerateRoute: (routeSettings) {
                  return MaterialPageRoute(
                    builder: (_) => pageList[index](UniqueKey()), // 💡 UniqueKey forces rebuild
                  );
                },
              ),
            );
            
          }),
          
        );
      }),
      bottomNavigationBar: Stack(
        children: [
          Obx(
            () => CustomBottomNav(
              selectedIndex: navigationController.selectedIndex.value,
              onItemTapped: (index, {bool isSameTab = false}) {
                if (isSameTab) {
                  setState(() {
                    navigatorKeys[index] = GlobalKey<NavigatorState>(); // 🔥 Forces rebuild
                  });
                } else {
                  navigationController.changeTab(index);
                }
              },
            ),
          ),
          Positioned(
            bottom: 5,
            left: MediaQuery.of(context).size.width / 2 - 30,
            right: 140,
            child: SizedBox(
              height: 80.h,
              width: 80.h,
              child: Center(
                child: FloatingActionButton(
                  onPressed: () {
                    navigationController.isFabSelected.toggle();
                    navigationController.changeTab(2); // Switch to Maps tab
                  },
                  backgroundColor: const Color.fromRGBO(255, 184, 0, 1),
                  shape: const CircleBorder(),
                  child: Image.asset("assets/img/map-pin.png"),
                ),
              ),
            ),
          ),
        ],
      ),

      

      
    );
  }
}



// Positioned(
//             bottom: 5,
//             left: MediaQuery.of(context).size.width / 2 - 30,
//             right: 140,
//             child: SizedBox(
//               height: 80.h,
//               width: 80.h,
//               child: Center(
//                 child: FloatingActionButton(
//                   onPressed: () {
//                     navigationController.isFabSelected.toggle();
//                     navigationController.changeTab(2); // Switch to Maps tab
//                   },
//                   backgroundColor: const Color.fromRGBO(255, 184, 0, 1),
//                   shape: const CircleBorder(),
//                   child: Image.asset("assets/img/map-pin.png"),
//                 ),
//               ),
//             ),
//           ),