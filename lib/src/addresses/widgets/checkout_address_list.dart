import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:testdf/common/widgets/shimmers/list_shimmer.dart';
import 'package:testdf/src/addresses/hooks/fetch_address_list.dart';
import 'package:testdf/src/addresses/widgets/select_address_tile.dart';

class CheckoutAddressList extends HookWidget {
  const CheckoutAddressList({super.key});

  @override
  Widget build(BuildContext context) {
    final result = fetchAddress();
    final isLoading = result.isLoading;
    final addresses = result.addresses;
    final refetch = result.refetch;

    if (isLoading) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: const ListShimmer(),
      );
    }

    return ListView(
      children: List.generate(addresses.length, (i) {
        return SelectAddressTile(address: addresses[i]);
      }),
    );
  }
}
