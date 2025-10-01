import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class OrderShimmer extends StatelessWidget {
  const OrderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(255, 241, 240, 240),
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50.h,
                  width: 200.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r)),
                ),
                Container(
                  height: 30.h,
                  width: 200.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r)),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                Container(
                  height: 100.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r)),
                ),
                SizedBox(width: 30.w,),
                Container(
                  height: 50.h,
                  width: 300.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r)),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 80.h,
                  width: 200.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r)),
                ),
                Container(
                  height: 80.h,
                  width: 200.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
