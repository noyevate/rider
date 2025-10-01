import 'package:rider/common/color_extension.dart';
import 'package:rider/common/custom_appbar.dart';
import 'package:rider/common/date_of_year.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:rider/common/search_textfield.dart';
import 'package:rider/common/shorten_address.dart';
import 'package:rider/common/size.dart';
import 'package:rider/controllers/navigating_controller.dart';
import 'package:rider/controllers/search_controller.dart';
import 'package:rider/others/homepage_icons_widget.dart';
import 'package:rider/services/distance.dart';
import 'package:rider/views/home/widget/order_list.dart';
import 'package:rider/views/home/widget/restaurant_orders.dart';
import 'package:rider/views/home/widget/view_all_orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NavigationController navigationController = Get.find();
  final RestaurantSearchController searchController =
      Get.put(RestaurantSearchController());
  TextEditingController _search = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _isSearchFocused = false;
  LatLng? _currentPosition = null;
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    _determinePosition();

    // Add listener to update _isSearchFocused whenever focus changes
    _searchFocusNode.addListener(() {
      setState(() {
        _isSearchFocused = _searchFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final distanceCalculator = Distance();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(250.h),
        child: Container(
          height: 280.h,
          color: _isSearchFocused
              ? const Color.fromARGB(255, 180, 175, 175).withOpacity(0.8)
              : Tcolor.BACKGROUND_Regaular,
          child: CustomAppBar(
            rating: 5.5,
            notificationCount: 3,
            date: getFormattedDate(),
          ),
        ),
      ),
      backgroundColor: Tcolor.BACKGROUND_Regaular,
      body: GestureDetector(
        behavior: HitTestBehavior
            .translucent, // Ensures taps are registered even on empty areas
        onTap: () {
          debugPrint('GestureDetector tapped');
          _searchFocusNode.unfocus();
          _search.text = "";
        },
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 40.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w),
                  child: SearchTextfield(
                    focusNode: _searchFocusNode,
                    controller: _search,
                    onChanged: (value) {
                      debugPrint('SearchTextfield onChanged: $value');
                      // Future.delayed(Duration(milliseconds: 100), () {
                      //   _searchFocusNode.requestFocus();
                      // });
                    },
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                      child: Column(children: [
                    SizedBox(
                      height: 40.h,
                    ),
                    Container(
                      height: 222.5.h,
                      width: width,
                      color: Tcolor.White,
                      padding: EdgeInsets.only(left: 30.w, right: 30.w),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            HomepageIconsWidget(
                              imagePath: "assets/img/storefront.png",
                              title1: 'Restaurant',
                              height1: 40.h,
                              width1: 40.w,
                              color1: Tcolor.ERROR_Light_1,
                            ),
                            HomepageIconsWidget(
                              imagePath: "assets/img/rides.png",
                              title1: 'Rides',
                              height1: 56.h,
                              width1: 56.w,
                              color1: Tcolor.ERROR_Light_1_1,
                            ),
                            HomepageIconsWidget(
                              imagePath: "assets/img/food.png",
                              title1: 'Food',
                              height1: 49.h,
                              width1: 49.w,
                              color1: Tcolor.ERROR_Light_1_2,
                            ),
                            HomepageIconsWidget(
                              imagePath: "assets/img/snacks.png",
                              title1: 'Snacks',
                              height1: 47.h,
                              width1: 47.w,
                              color1: Tcolor.ERROR_Light_1_3,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Divider(
                      color: Color.fromRGBO(208, 208, 208, 1),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30.w, right: 30.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReuseableText(
                              title: "Available Requests",
                              style: TextStyle(
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Tcolor.TEXT_Body)),
                          Container(
                            width: 110.w,
                            height: 56.h,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(18.r),
                              border: Border.all(color: Colors.transparent),
                            ),
                            child: Material(
                              color: Colors
                                  .transparent, // Keeps the decoration color visible
                              borderRadius: BorderRadius.circular(18.r),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(18.r),
                                splashColor: const Color.fromARGB(255, 218, 213,
                                    213), // The dark shade effect
                                highlightColor:
                                    Colors.black26, // Lighter highlight effect
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ViewAllOrders()));
                                },
                                child: Center(
                                  child: ReuseableText(
                                    title: "View all",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 28.sp,
                                      color: Tcolor.TEXT_Placeholder,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30.w, right: 30.w),
                      child: OrderList(),
                    ),
                    SizedBox(
                      height: 150.h,
                    ),
                  ])),
                ),
              ],
            ),
            if (_isSearchFocused)
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  debugPrint('Overlay tapped');
                  _searchFocusNode.unfocus();
                  _search.text = "";
                  searchController.searchResults.clear();
                },
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  color: const Color.fromARGB(255, 180, 175, 175)
                      .withOpacity(0.8), // Semi-transparent white
                ),
              ),
            Positioned(
              top: 40.h,
              left: 30.w,
              right: 30.w,
              child: Opacity(
                opacity: _isSearchFocused ? 1 : 0, // Control visibility
                child: IgnorePointer(
                  ignoring:
                      !_isSearchFocused, // Disable interaction when not focused
                  child: Container(
                    // height: height,
                    width: width,
                    color: Tcolor.White,
                    child: Column(
                      children: [
                        SearchTextfield(
                          focusNode: _searchFocusNode,
                          controller: _search,
                          onChanged: (value) {
                            searchController.fetchSearchResults(value);
                            print(" value: $value");
                          },
                        ),
                        // SizedBox(
                        //   height: 10.h,
                        // ),
                        Obx(() => searchController.isLoading.value
                            ? CircularProgressIndicator()
                            : searchController.searchResults.isNotEmpty
                                ? SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: List.generate(
                                          searchController.searchResults.length,
                                          (index) {
                                        final restaurant = searchController
                                            .searchResults[index];
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    HomePageRestuarantOrders(
                                                  restaurant: restaurant,
                                                ),
                                              ),
                                            );

                                            _search.text = "";
                                            searchController.searchResults
                                                .clear();
                                            _searchFocusNode.unfocus();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 30.w, right: 30.w),
                                            color: Tcolor.White,
                                            width: width,
                                            height: 104.h,
                                            child: Row(
                                              children: [
                                                ReuseableText(
                                                    title:
                                                        "${restaurant.title}, ",
                                                    style: TextStyle(
                                                        color: Tcolor.Text,
                                                        fontSize: 32.sp)),
                                                ReuseableText(
                                                  title:
                                                      "${shortenCharacters(restaurant.coords.address)}...",
                                                  style: TextStyle(
                                                      color: Tcolor.Text,
                                                      fontSize: 32.sp),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  )
                                : SizedBox()),
                      ],
                    ),
                  ),
                ),
              ),
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
    // final controller = Get.put(UserLocationController());
    Position position = await Geolocator.getCurrentPosition(
        // ignore: deprecated_member_use
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      box.write("presentLat", position.latitude);
      box.write("presentLng", position.longitude);

      print("latitue: lat = ${box.read("presentLat")}");
    });
  }
}
