import 'package:flutter/material.dart';
import 'package:testdf/common/utils/kcolors.dart';

LinearGradient kGradient = const LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
   Kolors.kPrimaryLight,
    Kolors.kWhite,
    Kolors.kPrimary,
  ],
);

LinearGradient kPGradient =  LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Kolors.kPrimaryLight,
    Kolors.kPrimaryLight.withOpacity(0.7),
    Kolors.kPrimary,
  ],
);

LinearGradient kBtnGradient = const LinearGradient(
  begin: Alignment.bottomLeft,
  end: Alignment.bottomRight,
  colors: [
    Kolors.kPrimaryLight,
    Kolors.kWhite,
  ],
);

BorderRadiusGeometry kClippingRadius = const BorderRadius.only(
  topLeft: Radius.circular(20),
  topRight: Radius.circular(20),
);

BorderRadiusGeometry kRadiusAll = BorderRadius.circular(12);

BorderRadiusGeometry kRadiusTop = const BorderRadius.only(
  topLeft: Radius.circular(9),
  topRight: Radius.circular(9),
);

BorderRadiusGeometry kRadiusBottom = const BorderRadius.only(
  bottomLeft: Radius.circular(12),
  bottomRight: Radius.circular(12),
);



Widget Function(BuildContext, String)? placeholder = (p0, p1) => Image.asset(
      'assets/images/placeholder.webp',
      fit: BoxFit.cover,
    );

Widget Function(BuildContext, String, Object)? errorWidget =
    (p0, p1, p3) => Image.asset(
          'assets/images/placeholder.webp',
          fit: BoxFit.cover,
        );

