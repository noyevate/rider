import 'package:rider/common/color_extension.dart';
import 'package:rider/common/profile_app_bar.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:rider/others/profile_tile.dart';
import 'package:rider/views/profile/profile_delivery_history/delivery_history.dart';
import 'package:rider/views/profile/profile_document/profile_document.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';

import '../../controllers/profile_controllers.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final profileController = Get.put(ProfileController());
     var firstName = box.read("first_name");
    var lastName = box.read("last_name");
    var userImageUrl = box.read("userImagUrl");
    var rating = box.read('rating');
    var ratingCount = box.read("rating_count");    
     profileController.userImageUrl_.value  = userImageUrl;

    return Container(
      color: Tcolor.White,
      child: Stack(
        children: [
          Column(
            children: [
              ProfileAppBar(
                rating: rating,
                notificationCount: 3,
                date: '',
              ),
              SizedBox(
                height: 250.h,
              ),
              ProfileTile(
                title: 'Documents',
                icon: HeroiconsOutline.documentText,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileDocument()));
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              Divider(
                color: Color.fromRGBO(217, 217, 217, 1),
                thickness: 0.7,
              ),
              SizedBox(
                height: 10.h,
              ),
              ProfileTile(
                title: 'Delivery History',
                icon: MaterialIcons.history,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileDeliveryHistory()),
                  );

                },
              ),
              SizedBox(
                height: 10.h,
              ),
              Divider(
                color: Color.fromRGBO(217, 217, 217, 1),
                thickness: 0.7,
              ),
              SizedBox(
                height: 10.h,
              ),
              ProfileTile(
                title: 'Support/FAQ',
                icon: HeroiconsMini.questionMarkCircle,
                onTap: () {},
              ),
              SizedBox(
                height: 10.h,
              ),
              Divider(
                color: Color.fromRGBO(217, 217, 217, 1),
                thickness: 0.7,
              ),
              SizedBox(
                height: 10.h,
              ),
              ProfileTile(
                title: 'Logout',
                icon: HeroiconsOutline.arrowRightOnRectangle,
                onTap: () {},
              ),
            ],
          ),
          Positioned(
            bottom: 850.h,
            right: 250.w,
            child: Column(
              children: [

                
                Container(
                  decoration: BoxDecoration(
                      color: Colors.amberAccent,
                      borderRadius: BorderRadius.circular(20.r)),
                  height: 200.h,
                  width: 200.w,
                  child: Obx(() => ClipRRect(
                                    borderRadius: BorderRadius.circular(20.r),
                                    child: Image.network(
                                      profileController.userImageUrl_.value,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Container(
                                          color: Colors.grey[
                                              300], // Background color for placeholder
                                          child: Icon(Icons.person,
                                              size: 40,
                                              color: Color(
                                                  0xFFD09603)), // Fallback icon
                                        );
                                      },
                                    ),
                                  ),),
                  
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  children: [
                    ReuseableText(
                      title: "${firstName} ${lastName}",
                      style: TextStyle(
                        color: Tcolor.TEXT_Body,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Image.asset(
                      "assets/img/motor-helmet-selected.png",
                      height: 32.sp,
                      width: 32.sp,
                    ),
                  ],
                ),
                Row(
                  children: [
                    RatingBarIndicator(
                      itemCount: 5,
                      rating: rating,
                      unratedColor: Color.fromRGBO(255, 184, 0, 0.41),
                      itemSize: 24.sp,
                      itemBuilder: (context, i) {
                        return Icon(
                          HeroiconsSolid.star,
                          size: 24.sp,
                          color: Color.fromRGBO(255, 184, 0, 1),
                        );
                      },
                    ),
                    ReuseableText(
                      title: "(${ratingCount.toString()})",
                      style: TextStyle(
                        color: Tcolor.Text,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                ReuseableText(
                  title: "Rider",
                  style: TextStyle(
                    color: Color.fromRGBO(35, 35, 35, 0.62),
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
