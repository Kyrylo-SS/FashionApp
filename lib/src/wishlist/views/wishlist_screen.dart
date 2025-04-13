import 'package:flutter/material.dart';
import 'package:testdf/common/services/storage.dart';
import 'package:testdf/common/utils/kcolors.dart';
import 'package:testdf/common/utils/kstrings.dart';
import 'package:testdf/common/widgets/app_style.dart';
import 'package:testdf/common/widgets/reusable_text.dart';
import 'package:testdf/src/auth/views/login_screen.dart';
import 'package:testdf/src/products/widgets/explore_products.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');

    if (accessToken == null) {
      return const LoginScreen();
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: ReusableText(
          text: AppText.kWishlist,
          style: appStyle(16, Kolors.kPrimary, FontWeight.bold),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: ExploreProducts(),
      ),
    );
  }
}
