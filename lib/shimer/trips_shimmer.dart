import 'package:rider/common/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class TripsShimmer extends StatelessWidget {
  const TripsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(255, 241, 240, 240),
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 400.h,
        width: width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r)),
      ),
    );
  }
}
