import 'package:rider/common/color_extension.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

enum IconType { svg, image }

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({
    super.key,
    this.color,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  final Color? color;
  final int selectedIndex;
  final Function(int, {bool isSameTab}) onItemTapped;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(50.r)),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Tcolor.White,
          borderRadius: BorderRadius.vertical(top: Radius.circular(50.r)),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 16,
              offset: Offset(0, 4),
              blurStyle: BlurStyle.outer,
              spreadRadius: 2,
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 25.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildNavItem(
              context,
              iconData: HeroiconsOutline.home,
              label: 'Home',
              index: 0,
              onPressed: () => _handleTap(0),
            ),
            _buildNavItem(
              context,
              iconPath: "assets/img/motor_helment_nav_bar.png",
              iconPath2: "assets/img/motor-helmet-selected.png",
              iconType: IconType.image,
              label: 'Trips',
              index: 1,
              onPressed: () => _handleTap(1),
            ),
            
            SizedBox(width: 60.w), // Space for FloatingActionButton
            _buildNavItem(
              context,
              iconPath: "assets/img/restaurant_inactive_bottombar.png",
              iconPath2: "assets/img/restaurant_active_bottombar.png",
              iconType: IconType.image,
              label: 'Restaurants',
              index: 3,
              onPressed: () => _handleTap(3),
            ),
            _buildNavItem(
              context,
              iconData: HeroiconsOutline.user,
              label: 'Profile',
              index: 4,
              onPressed: () => _handleTap(4),
            ),
          ],
        ),
      ),
    );
  }

  void _handleTap(int index) {
    if (index == selectedIndex) {
      onItemTapped(index, isSameTab: true); // Reset navigation if same tab
    } else {
      onItemTapped(index, isSameTab: false);
    }
  }

  Widget _buildNavItem(
    BuildContext context, {
    String? iconPath,
    String? iconPath2,
    IconData? iconData,
    required String label,
    IconType? iconType,
    required int index,
    required VoidCallback onPressed,
  }) {
    assert(iconPath != null || iconData != null || iconPath2 != null,
        'Either iconPath or iconData must be provided');
    assert(iconType != null || iconData != null,
        'iconType must be provided if using iconPath');

    bool isSelected = selectedIndex == index;
    Color itemColor = isSelected ? Tcolor.Primary : Tcolor.TEXT_Label;

    Widget iconWidget;
    if (iconPath != null && iconType != null && iconPath2 != null) {
      switch (iconType) {
        case IconType.svg:
          iconWidget = SvgPicture.asset(
            isSelected ? iconPath2 : iconPath,
            width: 24.w,
            height: 24.h,
            colorFilter: ColorFilter.mode(itemColor, BlendMode.srcIn),
          );
          break;
        case IconType.image:
          iconWidget = Image.asset(
            isSelected ? iconPath2 : iconPath,
            width: 35.w,
            height: 35.h,
          );
          break;
      }
    } else {
      iconWidget = Icon(
        iconData,
        color: itemColor,
        size: 30.sp,
      );
    }

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 105.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 30.w,
              height: 30.h,
              child: FittedBox(
                fit: BoxFit.contain,
                child: iconWidget,
              ),
            ),
            if (isSelected)
              Container(
                margin: EdgeInsets.only(top: 20.h),
                width: 10.w,
                height: 10.h,
                decoration: BoxDecoration(
                  color: Tcolor.Primary,
                  shape: BoxShape.circle,
                ),
              ),
            if (!isSelected)
              Padding(
                padding: EdgeInsets.only(top: 4.h),
                child: ReuseableText(
                  title: label,
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: itemColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
