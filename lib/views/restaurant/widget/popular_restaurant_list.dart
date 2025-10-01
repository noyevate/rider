import 'package:rider/common/color_extension.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:rider/models/restaurant_model.dart';
import 'package:rider/views/restaurant/restaurants.dart';
import 'package:rider/views/restaurant/subwidget/popular_restaurant_list_subwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:rider/common/size.dart';

class PopularRestaurantList extends StatelessWidget {
  const PopularRestaurantList({super.key, required this.popularRestaurants});
  final List<RestaurantModel> popularRestaurants;

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

                        // Navigator.pop(context);
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
                      title: "Popular restaurants",
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
                    crossAxisCount: 2, 
                    crossAxisSpacing: 1.w, 
                    mainAxisSpacing: 30.h, 
                    childAspectRatio: 4.5 / 2.5,
                  ),
                  itemCount: popularRestaurants.length,
                  itemBuilder: (context, index) {
                    var popularRestaurant = popularRestaurants[index];
                    return Padding(
                        padding: EdgeInsets.only(left: 30.w, right: 30.w),
                        child: PopularRestaurantListSubwidget(
                          restaurant: popularRestaurant,
                        ));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
