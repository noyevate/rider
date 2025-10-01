
import 'package:rider/common/color_extension.dart';
import 'package:rider/views/onboarding/walk_through.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 7), () {
      Get.off(() => const WalkThrough(), transition: Transition.fadeIn, duration: const Duration(milliseconds: 700));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Tcolor.Primary_New,
      body: Center(
        child: Container(
          height: 150.h,
          width: 300.w,
          decoration: BoxDecoration(
            
            color: Colors.black,
            borderRadius: BorderRadius.circular(100.r)

          ),
          child: Center(child: Image.asset("assets/img/chopnow_logo.png", height: 100.h, width: 200.w,)),
        ),
      ),
    );
  }
}