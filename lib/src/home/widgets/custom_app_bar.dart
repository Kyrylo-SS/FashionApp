import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:testdf/common/utils/kcolors.dart';
import 'package:testdf/common/widgets/app_style.dart';
import 'package:testdf/common/widgets/reusable_text.dart';
import 'package:testdf/src/home/widgets/notification_widget.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          ReusableText(
            text: 'Location',
            style: appStyle(12, Kolors.kGray, FontWeight.normal),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(Ionicons.location, size: 16, color: Kolors.kPrimary),
              SizedBox(
                width: ScreenUtil().screenWidth * 0.7,
                child: Text(
                  'Please select a location',
                  maxLines: 1,
                  style: appStyle(14, Kolors.kDark, FontWeight.w500),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [NotificationWidget()],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(55.h),
        child: GestureDetector(
          onTap: () {
            GoRouter.of(context).go('/search');
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    height: 40.h,
                    width: ScreenUtil().screenWidth - 80,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Kolors.kGrayLight),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 8.w),
                        const Icon(
                          Ionicons.search,
                          size: 20,
                          color: Kolors.kPrimaryLight,
                        ),
                        SizedBox(width: 14.w),
                        ReusableText(
                          text: 'Search Products',
                          style: appStyle(14, Kolors.kGray, FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 40.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                    color: Kolors.kPrimary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    FontAwesome.sliders,
                    color: Kolors.kWhite,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
