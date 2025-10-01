import 'package:rider/common/color_extension.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerificationWaitPage extends StatelessWidget {
  const VerificationWaitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: Image.asset("assets/img/checkers.png",height: 200.h, width: 200.w, )),
            SizedBox(
              height: 30.h,
            ),
            ReuseableText(
              title: "Your accout verification is processing...",
              style: TextStyle(
                color: Tcolor.TEXT_Label,
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
                wordSpacing: 2.sp,
              ),
            ),
           

          ],
        ),
      ),
    );
  }
}