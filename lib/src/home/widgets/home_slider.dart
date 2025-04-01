import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:testdf/common/utils/kcolors.dart';
import 'package:testdf/const/constants.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeSlider extends StatelessWidget {
  const HomeSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: kRadiusAll,
      child: Stack(
        children: [
          SizedBox(
            height: ScreenUtil().screenHeight * 0.16,
            width: ScreenUtil().screenWidth,
            child: ImageSlideshow(
              indicatorColor: Kolors.kPrimaryLight,
              onPageChanged: (p) {},
              autoPlayInterval: 5000,
              isLoop: true,
              children: List.generate(images.length, (i) {
                return CachedNetworkImage(
                  placeholder: placeholder,
                  errorWidget: errorWidget,
                  imageUrl: images[i],
                  fit: BoxFit.cover,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

List<String> images = [
  "https://www.appnova.com/wp-content/uploads/2024/10/An-Essential-Guide-to-Fashion-eCommerce-Top-Trends-Winning-Strategies-and-More1.jpg",
  "https://www.appnova.com/wp-content/uploads/2024/10/An-Essential-Guide-to-Fashion-eCommerce-Top-Trends-Winning-Strategies-and-More1.jpg",
  "https://www.appnova.com/wp-content/uploads/2024/10/An-Essential-Guide-to-Fashion-eCommerce-Top-Trends-Winning-Strategies-and-More1.jpg",
];
