import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:testdf/common/services/storage.dart';
import 'package:testdf/common/utils/kcolors.dart';
import 'package:testdf/common/utils/kstrings.dart';
import 'package:testdf/common/widgets/app_style.dart';
import 'package:testdf/common/widgets/back_button.dart';
import 'package:testdf/common/widgets/reusable_text.dart';
import 'package:testdf/const/constants.dart';
import 'package:testdf/src/addresses/contollers/address_notifier.dart';
import 'package:testdf/src/addresses/hooks/fetch_default.dart';
import 'package:testdf/src/addresses/widgets/address_block.dart';
import 'package:testdf/src/cart/controllers/cart_notifier.dart';
import 'package:testdf/src/checkout/models/check_out_model.dart';
import 'package:testdf/src/checkout/views/payment.dart';
import 'package:testdf/src/checkout/widgets/checkout_tile.dart';

class CheckoutPage extends HookWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    String? accesstoken = Storage().getString('accessToken');
    final result = fetchDefaultAddress();
    final address = result.address;
    final isLoading = result.isLoading;
    return context.watch<CartNotifier>().paymentUrl.contains(
          'https://checkout.stripe.com',
        )
        ? const PaymentWebView()
        : Scaffold(
          appBar: AppBar(
            leading: AppBackButton(
              onTap: () {
                context.read<AddressNotifier>().clearAddress();
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
                  isLoading
                      ? const SizedBox.shrink()
                      : AddressBlock(address: address),

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

          bottomNavigationBar: Consumer<CartNotifier>(
            builder: (context, cartNotifier, child) {
              return GestureDetector(
                onTap: () {
                  if (address == null) {
                    context.push('/addresses');
                  } else {
                    List<CartItem> checkoutItems = [];

                    for (var item in cartNotifier.selectedCartItems) {
                      CartItem data = CartItem(
                        name: item.product.title,
                        id: item.product.id,
                        price: item.product.price.roundToDouble(),
                        cartQuantity: item.quantity,
                        size: item.size,
                        color: item.color,
                      );

                      checkoutItems.add(data);
                    }

                    CreateCheckout data = CreateCheckout(
                      address:
                          context.read<AddressNotifier>().address == null
                              ? address.id
                              : context.read<AddressNotifier>().address!.id,
                      accesstoken: accesstoken.toString(),
                      fcm: '',
                      totalAmount: cartNotifier.totalPrice,
                      cartItems: checkoutItems,
                    );

                    String c = createCheckoutToJson(data);

                    cartNotifier.createCheckout(c);
                  }
                },
                child: Container(
                  height: 80,
                  width: ScreenUtil().screenWidth,
                  decoration: BoxDecoration(
                    color: Kolors.kPrimaryLight,
                    borderRadius: kRadiusTop,
                  ),
                  child: Center(
                    child: ReusableText(
                      text:
                          address == null
                              ? "Please select an address"
                              : "Continue to Payment",
                      style: appStyle(16, Kolors.kWhite, FontWeight.w600),
                    ),
                  ),
                ),
              );
            },
          ),
        );
  }
}
