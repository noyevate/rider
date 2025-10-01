import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileAppBar extends StatefulWidget {
  final double rating;
  final int notificationCount;
  final String date;

  const ProfileAppBar({
    super.key,
    
    required this.rating,
    required this.notificationCount,
    required this.date,
  });

  @override
  State<ProfileAppBar> createState() => _ProfileAppBarState();
}

class _ProfileAppBarState extends State<ProfileAppBar> {
  
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      height: 280.h,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFD09603), Color(0xFFFFB800)],
          begin: Alignment.topLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Stack(
        children: [

          

            Positioned(
            bottom: 0.h,
            right: 90.w,
            child: Container(
              height: 150.h,
              width: 150.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
          colors: [Color(0xFFD09603), Color(0xFFFFB800)],
          begin: Alignment.topLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.all(Radius.circular(100.r))                

              ),
            ),
          ),

          Positioned(
            bottom: 150.h,
            right: 40.w,
            child: Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
          colors: [Color(0xFFD09603), Color(0xFFFFB800)],
          begin: Alignment.topLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.all(Radius.circular(100.r))                

              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 80.h),
             
              SizedBox(height: 10.h),
              Divider(
                color: Colors.transparent,
              ),
              SizedBox(height: 10.h),
              
            ],
          ),
        ],
      ),
    );
  }

}


