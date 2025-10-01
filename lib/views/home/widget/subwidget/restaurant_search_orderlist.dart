import 'package:rider/common/reusable_text_widget.dart';
import 'package:rider/hooks/fetch_all_order_hook.dart';
import 'package:rider/models/order_model.dart';
import 'package:rider/shimer/order_shimmer.dart';
import 'package:rider/views/home/widget/subwidget/restaurant_search_order_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/color_extension.dart';


class RestaurantSearchOrderlist extends HookWidget {
  const RestaurantSearchOrderlist( {super.key});



  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchNewOrder("Placed", "Completed", "67a03fc6d174fb655800ef88");
    final List<OrderModel> orders = hookResult.data ?? [];
    final bool isLoading = hookResult.isLoading;
    final Exception? error = hookResult.error;
    print("new orders.length: ${orders.length}");
    return isLoading
        ? OrderShimmer()
        : orders.isEmpty
            ? Center(
                child: ReuseableText(
                    title: "no orders yet...",
                    style: TextStyle(
                        color: Tcolor.TEXT_Placeholder,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500)),
              )
            : Column(
              children: List.generate(orders.length, (i) {
                var order = orders[i];
                return Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: RestaurantSearchOrderTile(order: order),
                );
              }),
            );
  }
}
