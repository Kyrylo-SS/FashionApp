import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:testdf/common/services/storage.dart';
import 'package:testdf/common/utils/kcolors.dart';
import 'package:testdf/common/utils/kstrings.dart';
import 'package:testdf/common/widgets/app_style.dart';
import 'package:testdf/common/widgets/reusable_text.dart';
import 'package:testdf/common/widgets/shimmers/list_shimmer.dart';
import 'package:testdf/const/constants.dart';
import 'package:testdf/const/resource.dart';
import 'package:testdf/src/auth/views/login_screen.dart';
import 'package:testdf/src/cart/controllers/cart_notifier.dart';
import 'package:testdf/src/cart/hooks/fetch_cart.dart';
import 'package:testdf/src/cart/widgets/cart_tile.dart';

class CartPage extends HookWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final results = fetchCart();
    final carts = results.cart;
    final isLoading = results.isLoading;
    final refetch = results.refetch;
    final error = results.error;
    String? accessToken = Storage().getString('accessToken');

    if (accessToken == null) {
      return const LoginScreen();
    }

    if (isLoading) {
      return const Scaffold(body: ListShimmer());
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ReusableText(
          text: AppText.kCart,
          style: appStyle(15, Kolors.kPrimary, FontWeight.bold),
        ),
      ),
      body:
          carts.isEmpty
              ? Center(
                child: Image.asset(
                  R.ASSETS_IMAGES_EMPTY_PNG,
                  height: ScreenUtil().screenHeight * .3,
                ),
              )
              : ListView(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                children: List.generate(carts.length, (i) {
                  final cart = carts[i];
                  return CartTile(
                    cart: cart,
                    onDelete: () {
                      context.read<CartNotifier>().deleteCart(cart.id, refetch);
                    },
                    refetch: refetch,
                  );
                }),
              ),
      bottomNavigationBar: Consumer<CartNotifier>(
        builder: (context, cartNotifier, child) {
          return GestureDetector(
            onTap: () {
              context.push('/checkout');
            },
            child:
                cartNotifier.selectedCartItemsId.isNotEmpty
                    ? Container(
                      padding: EdgeInsets.fromLTRB(8.w, 0, 8.w, 90.h),
                      height: 130.h,
                      decoration: BoxDecoration(
                        color: Kolors.kPrimaryLight,
                        borderRadius: kRadiusTop,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ReusableText(
                              text: "Click To Checkout",
                              style: appStyle(
                                15,
                                Kolors.kWhite,
                                FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ReusableText(
                              text:
                                  "\$ ${cartNotifier.totalPrice.toStringAsFixed(2)}",
                              style: appStyle(
                                15,
                                Kolors.kWhite,
                                FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    : const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
