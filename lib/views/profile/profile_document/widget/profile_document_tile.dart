import 'package:rider/common/color_extension.dart';
import 'package:rider/common/reusable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileDocumentTile extends StatelessWidget {
  const ProfileDocumentTile({
    super.key, required this.name, required this.title, this.onTap, required this.name_1,
  });
  final String name;
  final String title;
  final String name_1;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 39.w, right: 30.w),
      child: Container(
        height: 120.h,
        padding: EdgeInsets.only(
            top: 10.h, bottom: 10.h, left: 10.w, right: 10.w),
        color: Tcolor.White,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child:
                        Image.network(
                                      name,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(name_1);
                                      },
                                    ),
                        
                  ),
                  SizedBox(width: 20.w,),
                  ReuseableText(
                    title: title,
                    style: TextStyle(
                      color: Color.fromRGBO(29, 53, 87, 0.73),
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
      
              Container(
                height: 56.h,
                width: 170.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Color.fromRGBO(240, 240, 240, 1)
                ),
                child: Material(
                  color: Colors.transparent, 
                  borderRadius: BorderRadius.circular(10.r),

                  child: InkWell(
                    borderRadius: BorderRadius.circular(10.r),
                    highlightColor: Colors.black26,
                    onTap: onTap,
                    child: Center(
                      child: ReuseableText(
                          title: "UPDATE",
                          style: TextStyle(
                            color: Color.fromRGBO(29, 53, 87, 0.73),
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}



// Container(
//                   width: 110.w,
//                   height: 56.h,
//                   decoration: BoxDecoration(
//                     color: Colors.transparent,
//                     borderRadius: BorderRadius.circular(18.r),
//                     border: Border.all(color: Colors.transparent),
//                   ),
//                   child: Material(
//                     color: Colors
//                         .transparent, // Keeps the decoration color visible
//                     borderRadius: BorderRadius.circular(18.r),
//                     child: InkWell(
//                       borderRadius: BorderRadius.circular(18.r),
//                       // splashColor: const Color.fromARGB(
//                       //     255, 218, 213, 213), // The dark shade effect
//                       highlightColor:
//                           Colors.black26, // Lighter highlight effect
//                       onTap: () {
//                         Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => NearbyRestaurantList(nearbyRestaurant: nearbyRestaurant,)));
//                       },
//                       child: Center(
//                         child: ReuseableText(
//                           title: "See All...",
//                           style: TextStyle(
//                             fontWeight: FontWeight.w400,
//                             fontSize: 22.sp,
//                             color: Color.fromRGBO(146, 50, 255, 0.9),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),