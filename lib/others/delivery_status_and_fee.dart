import 'package:rider/common/color_extension.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:rider/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeliveryStatusAndFee extends StatelessWidget {
  const DeliveryStatusAndFee({
    super.key,
    required this.order,
  });

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30.w, right: 30.w),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReuseableText(
                    title: "Payment ",
                    style: TextStyle(
                      color: Tcolor.TEXT_Placeholder,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    width: 280.w,
                    height: 100.h,
                    child: ReuseableText(
                      title: order.paymentStatus,
                      style: TextStyle(
                        color: Tcolor.Text,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReuseableText(
                    title: "Fee",
                    style: TextStyle(
                      color: Tcolor.TEXT_Placeholder,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    width: 300.w,
                    height: 100.h,
                    child: ReuseableText(
                      title: "#${order.deliveryFee}",
                      style: TextStyle(
                        color: Tcolor.Text,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // SizedBox(
          //   height: 100.h,
          // )
        ],
      ),
    );
  }
}
