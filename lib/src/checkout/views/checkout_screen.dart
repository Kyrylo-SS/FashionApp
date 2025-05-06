import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:testdf/common/utils/kcolors.dart';
import 'package:testdf/common/utils/kstrings.dart';
import 'package:testdf/common/widgets/app_style.dart';
import 'package:testdf/common/widgets/back_button.dart';
import 'package:testdf/common/widgets/reusable_text.dart';
import 'package:testdf/src/cart/controllers/cart_notifier.dart';
import 'package:testdf/src/checkout/widgets/checkout_tile.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(
          onTap: () {
            context.pop();
          },
        ),
        centerTitle: true,
        title: ReusableText(
          text: AppText.kCheckout,
          style: appStyle(16, Kolors.kPrimary, FontWeight.bold),
        ),
      ),
      body: Consumer<CartNotifier>(
        builder: (context, cartNotifier, child) {
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            children: [
              SizedBox(height: 10.h),
              SizedBox(
                height: ScreenUtil().screenHeight * 0.5,
                child: Column(
                  children: List.generate(
                    cartNotifier.selectedCartItems.length,
                    (i) {
                      return CheckoutTile(
                        cart: cartNotifier.selectedCartItems[i],
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
