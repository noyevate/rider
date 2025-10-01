import 'package:rider/common/reusable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key, required this.title, required this.icon, this.onTap,
  });
  final String title;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: 30.w, right: 30.w),
        color: Colors.transparent,
        child: Row(
          children: [
            Icon(icon, size: 36.sp, color: Color.fromRGBO(29, 53, 87, 0.73),),
            
            Padding(
              padding: EdgeInsets.only(left: 30.w),
              child: ReuseableText(
                    title: title,
                    style: TextStyle(
                      color: Color.fromRGBO(29, 53, 87, 0.73),
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
