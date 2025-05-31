import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:testdf/common/utils/kcolors.dart';
import 'package:testdf/common/utils/kstrings.dart';
import 'package:testdf/common/widgets/app_style.dart';
import 'package:testdf/common/widgets/back_button.dart';
import 'package:testdf/common/widgets/reusable_text.dart';
import 'package:testdf/common/widgets/shimmers/list_shimmer.dart';
import 'package:testdf/const/constants.dart';
import 'package:testdf/src/addresses/contollers/address_notifier.dart';
import 'package:testdf/src/addresses/hooks/fetch_address_list.dart';
import 'package:testdf/src/addresses/widgets/address_tile.dart';

class ShippingAddressScreen extends HookWidget {
  const ShippingAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final result = fetchAddress();
    final isLoading = result.isLoading;
    final refetch = result.refetch;
    final addresses = result.addresses;

    if (isLoading) {
      return Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: const ListShimmer(),
        ),
      );
    }

    context.read<AddressNotifier>().setRefetch(refetch);

    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        centerTitle: true,
        title: ReusableText(
          text: AppText.kAddresses,
          style: appStyle(16, Kolors.kPrimary, FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        children: List.generate(addresses.length, (i) {
          final address = addresses[i];
          return AddressTile(
            address: address,
            isCheckout: false,
            onDelete: () {
              context.read<AddressNotifier>().deleteAddress(
                context,
                address.id,
                refetch,
              );
            },
            setDefault: () {
              context.read<AddressNotifier>().setAsDefault(
                context,
                address.id,
                refetch,
              );
            },
          );
        }),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          context.push('/addaddress');
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
              text: "Add Address",
              style: appStyle(16, Kolors.kWhite, FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
