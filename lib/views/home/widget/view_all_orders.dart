import 'package:rider/common/color_extension.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:rider/views/home/home_page.dart';
import 'package:rider/views/home/widget/order_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

class ViewAllOrders extends StatelessWidget {
  const ViewAllOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Tcolor.BACKGROUND_Regaular,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(90.h),
          child: Column(
            children: [
              SizedBox(
                height: 60.h,
              ),
              Container(
                padding: EdgeInsets.only(left: 30.w),
                height: 70.h,
                color: Tcolor.BACKGROUND_Regaular,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 0, // Align the icon to the left
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage()
                      ));
                        },
                        child: Container(
                          height: 62.h,
                          width: 62.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Tcolor.White,
                          ),
                          child: Icon(
                            HeroiconsMini.chevronLeft,
                            color: Tcolor.Text,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: ReuseableText(
                        title: "View all",
                        style: TextStyle(
                          color: Tcolor.Text,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),),
          body: SingleChildScrollView(
            child: Padding(
                    padding: EdgeInsets.only(left: 30.w, right: 30.w),
                    child: OrderList(),
                  ),
          ),
      
    );
  }
}