import 'package:rider/common/color_extension.dart';
import 'package:rider/common/format_date.dart';
import 'package:rider/common/format_time.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:rider/common/shorten_address.dart';
import 'package:rider/controllers/hompage_controller.dart';
import 'package:rider/models/address_model.dart';
import 'package:rider/models/single_restaurant_model.dart';
import 'package:rider/models/trip_history_model.dart';
import 'package:rider/shimer/text_shimer.dart';
import 'package:rider/views/trips/widget/subwidgets/trip_history_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class HistoryTile extends HookWidget {
  const HistoryTile({
    super.key,
    required this.trip,
  });
  final TripHistoryModel trip;

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomepageController());

    final tripRestaurant = useState<SingleRestaurantModel?>(null);
    final tripDelivery = useState<AddressModel?>(null);

    useEffect(() {
      Future.microtask(() async {
        final restaurant =
            await homeController.fetchResturant(trip.restaurantId);
        tripRestaurant.value = restaurant;
      });
      return null; // No cleanup needed
    }, [trip.restaurantId]);

    useEffect(() {
      Future.microtask(() async {
        final orderAddress =
            await homeController.fetchAddress(trip.deliveryAddress);
        tripDelivery.value = orderAddress;
      });
      return null; // No cleanup needed
    }, [trip.deliveryAddress]);

    return GestureDetector(
      onTap:  tripDelivery.value != null && tripRestaurant.value != null ? (){
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
          TripHistoryDetail(restaurant: tripRestaurant.value, order: trip, orderDelivery: tripDelivery.value, trip: trip,)
        ));
        
      } : null,
      child: SizedBox(
        height: 130.h,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                homeController.isLoading || tripDelivery.value == null || tripRestaurant.value == null ? TextShimer() :  SizedBox(
                  width: 450.w,
                  child: ReuseableText(
                    title: "Delivery to ${shortenAddress(tripDelivery.value!.address.addressLine1)}... from ${tripRestaurant.value!.title} ",
                    style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                        color: Tcolor.Text),
                      overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  children: [
                    RatingBarIndicator(
                      itemCount: 5,
                      rating: trip.riderRating != null ? trip.riderRating!.rating : 0,
                      unratedColor: Tcolor.TEXT_Placeholder,
                      itemSize: 26.sp,
                      itemBuilder: (context, i) {
                        return Icon(
                          HeroiconsSolid.star,
                          size: 20.sp,
                          color: Tcolor.Primary_New,
                        );
                      },
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    ReuseableText(
                      title: trip.riderRating != null ?"(${trip.riderRating!.rating})" : "(0.0)",
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: Tcolor.Text),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                Row(
                  children: [
                    Icon(
                      HeroiconsMini.calendar,
                      color: Color(0xff545454),
                      size: 20.sp,
                      weight: 10,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    ReuseableText(
                      title: formatDate(trip.updatedAt.toString()),
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff545454)),
                    ),
                  ],
                ),
                SizedBox(
                  width: 10.w,
                ),
                Row(
                  children: [
                    Icon(
                      HeroiconsOutline.clock,
                      color: Color(0xff545454),
                      size: 18.sp,
                      weight: 10,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    ReuseableText(
                      title: formatTime(trip.updatedAt.toString()),
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff545454)),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            Divider(color: Tcolor.Location_Text_Sheet_colour, thickness: 0.5.sp),
            SizedBox(
              height: 15.h,
            ),
          ],
        ),
      ),
    );
  }
}
