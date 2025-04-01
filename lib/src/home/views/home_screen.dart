import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:testdf/src/home/widgets/custom_app_bar.dart';
import 'package:testdf/src/home/widgets/home_header.dart';
import 'package:testdf/src/home/widgets/home_slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(110),
        child: CustomAppBar(),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        children: [
          SizedBox(height: 20.h),
          const HomeSlider(),
          SizedBox(height: 20.h),
          const HomeHeader(),
        ],
      ),
    );
  }
}
