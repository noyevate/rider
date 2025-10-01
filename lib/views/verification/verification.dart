// ignore_for_file: deprecated_member_use

import 'package:rider/common/color_extension.dart';
import 'package:rider/views/verification/widget/add_picture.dart';
import 'package:rider/views/verification/widget/bank_verification.dart';
import 'package:rider/views/verification/widget/verification_details.dart';
import 'package:rider/views/verification/widget/workdays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerificationView extends StatefulWidget {
  const VerificationView({super.key});

  @override
  State<VerificationView> createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  @override
  void initState() {
    super.initState();

    // Listen to page changes to track the current page index
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  Future<bool> _onWillPop() async {
    if (currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeIn,
      );
      return false; // Prevent default back navigation
    }
    return true; // Allow default back navigation
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Container(
          color: Tcolor.White,
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            pageSnapping: false,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 30.w, right: 30.w),
                child: VerificationDetails(
                  next: () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeIn,
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30.w, right: 30.w),
                child: BankVerification(
                  next: () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeIn,
                    );
                  },
                  back: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeIn,
                    );
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 30.w, right: 30.w),
                child: WorkDays(
                  next: () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeIn,
                    );
                  },
                  back: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeIn,
                    );
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 30.w, right: 30.w),
                child: AddPicture(
                  next: () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeIn,
                    );
                  },
                  back: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeIn,
                    );
                  },
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}


// class _VerificationViewState extends State<VerificationView> {
//   final PageController _pageController = PageController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: Tcolor.White,
//         child: PageView(
//           controller: _pageController,
//           physics: const AlwaysScrollableScrollPhysics(),
//           pageSnapping: false,
//           children: [
//             Padding(
//               padding: EdgeInsets.only(left: 30.w, right: 30.w),
//               child: VerificationDetails(
//                 next: () {
//                   _pageController.nextPage(
//                       duration: const Duration(milliseconds: 800),
//                       curve: Curves.easeIn);
//                 },
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: 30.w, right: 30.w),
//               child: BankVerification(
//                 next: () {
//                   _pageController.nextPage(
//                       duration: const Duration(milliseconds: 800),
//                       curve: Curves.easeIn);
//                 },
//                 back: () {
//                   _pageController.nextPage(
//                       duration: const Duration(milliseconds: 800),
//                       curve: Curves.easeIn);
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

