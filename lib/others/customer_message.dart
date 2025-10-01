import 'package:rider/common/color_extension.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:rider/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomerMessage extends StatelessWidget {
  const CustomerMessage({
    super.key,
    required this.order,
  });

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30.w, right: 30.w),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReuseableText(
                title: "Customer message",
                style: TextStyle(
                  color: Tcolor.TEXT_Placeholder,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              ReuseableText(
                  title: order.notes.isEmpty ? "No notes" : order.notes,
                  style: TextStyle(
                    color: Tcolor.Text,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
