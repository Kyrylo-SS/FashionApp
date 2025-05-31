import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:testdf/common/utils/kcolors.dart';
import 'package:testdf/common/widgets/app_style.dart';
import 'package:testdf/common/widgets/change_address_modal.dart';
import 'package:testdf/common/widgets/reusable_text.dart';
import 'package:testdf/const/constants.dart';
import 'package:testdf/src/addresses/contollers/address_notifier.dart';
import 'package:testdf/src/addresses/models/addresses_model.dart';

class AddressTile extends StatelessWidget {
  const AddressTile({
    super.key,
    required this.address,
    required this.isCheckout,
    this.setDefault,
    this.onDelete,
  });

  final AddressModel address;
  final bool isCheckout;
  final void Function()? setDefault;
  final void Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressNotifier>(
      builder: (context, addressNotifier, child) {
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const CircleAvatar(
            radius: 26,
            backgroundColor: Kolors.kSecondaryLight,
            child: Icon(
              MaterialIcons.location_pin,
              color: Kolors.kPrimary,
              size: 30,
            ),
          ),
          title: ReusableText(
            text:
                addressNotifier.address == null
                    ? address.addressType.toUpperCase()
                    : addressNotifier.address!.addressType.toUpperCase(),
            style: appStyle(13, Kolors.kDark, FontWeight.w400),
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReusableText(
                text:
                    addressNotifier.address == null
                        ? address.address
                        : addressNotifier.address!.address,
                style: appStyle(12, Kolors.kGray, FontWeight.w400),
              ),
              ReusableText(
                text:
                    addressNotifier.address == null
                        ? address.phone
                        : addressNotifier.address!.phone,
                style: appStyle(12, Kolors.kGray, FontWeight.w400),
              ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  if (isCheckout) {
                    changeAddressBottomSheet(context);
                  } else {
                    address.isDefault ? () {} : setDefault!();
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  decoration: BoxDecoration(
                    borderRadius: kRadiusAll,
                    color:
                        isCheckout
                            ? Kolors.kPrimary
                            : addressNotifier.address == null
                            ? address.isDefault == true
                                ? Colors.green
                                : Kolors.kGrayLight
                            : addressNotifier.address!.isDefault != true
                            ? Colors.green
                            : Kolors.kGrayLight,
                  ),
                  child: ReusableText(
                    text:
                        isCheckout
                            ? "Change"
                            : addressNotifier.address == null
                            ? address.isDefault != true
                                ? "Set default"
                                : "Default"
                            : addressNotifier.address!.isDefault != true
                            ? "Set default"
                            : "Default",
                    style: appStyle(12, Kolors.kWhite, FontWeight.w400),
                  ),
                ),
              ),

              isCheckout || address.isDefault
                  ? const SizedBox.shrink()
                  : GestureDetector(
                    onTap: onDelete,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      decoration: BoxDecoration(
                        color: Kolors.kRed,
                        borderRadius: kRadiusAll,
                      ),
                      child: ReusableText(
                        text: "Delete",
                        style: appStyle(12, Kolors.kWhite, FontWeight.w400),
                      ),
                    ),
                  ),
            ],
          ),
        );
      },
    );
  }
}
