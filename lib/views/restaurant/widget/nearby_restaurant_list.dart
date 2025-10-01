import 'package:rider/common/color_extension.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:rider/common/size.dart';
import 'package:rider/models/restaurant_model.dart';
import 'package:rider/views/restaurant/restaurants.dart';
import 'package:rider/views/restaurant/subwidget/nearby_restaurant_subwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class NearbyRestaurantList extends StatelessWidget {
  const NearbyRestaurantList({super.key, required this.nearbyRestaurant});
  final List<RestaurantModel> nearbyRestaurant;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Tcolor.BACKGROUND_Regaular,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.h),
        child: Column(
          children: [
            SizedBox(
              height: 60.h,
            ),
            Container(
              padding: EdgeInsets.only(left: 30.w),
              height: 70.h,
              color: Tcolor.BACKGROUND_Regaular,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 0, // Align the icon to the left
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Restaurants()));
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
                  Center(
                    child: ReuseableText(
                      title: "Nearby Restaurant",
                      style: TextStyle(
                        color: Tcolor.Text,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),

      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Ensures 2 items per row
                  crossAxisSpacing: 1.w, // Adjust spacing between columns
                  mainAxisSpacing: 30.h, // Adjust spacing between rows
                  childAspectRatio: 4.5 / 2.5,
                ), 
                itemCount: nearbyRestaurant.length,
                itemBuilder: (context, index) {
                  
                  var restaurant = nearbyRestaurant[index];
                  return Padding(
                          padding: EdgeInsets.only(left: 30.w, right: 30.w),
                          child: NearbyRestaurantSubwidget(restaurant: restaurant,
                            
                          ));
                }
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}