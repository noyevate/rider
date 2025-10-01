import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class RestaurantShimer extends StatelessWidget {
  const RestaurantShimer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(255, 241, 240, 240),
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Container(
              height: 300.h,
              width: 200.w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r)),
            ),
            SizedBox(width: 30.w,),
    
            // Container(
            //   height: 300.h,
            //   width: 200.w,
            //   decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(10.r)),
            // ),
            
          ],
        ),
      ),
    );
  }
}
