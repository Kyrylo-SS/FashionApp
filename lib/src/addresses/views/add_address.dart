import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:testdf/common/utils/kcolors.dart';
import 'package:testdf/common/utils/kstrings.dart';
import 'package:testdf/common/widgets/app_style.dart';
import 'package:testdf/common/widgets/back_button.dart';
import 'package:testdf/common/widgets/custom_button.dart';
import 'package:testdf/common/widgets/error_modal.dart';
import 'package:testdf/common/widgets/reusable_text.dart';
import 'package:testdf/const/constants.dart';
import 'package:testdf/src/addresses/contollers/address_notifier.dart';
import 'package:testdf/src/addresses/models/create_address_model.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final TextEditingController _addressContoller = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(),
        centerTitle: true,
        title: ReusableText(
          text: AppText.kAddShipping,
          style: appStyle(16, Kolors.kPrimary, FontWeight.bold),
        ),
      ),
      body: Consumer<AddressNotifier>(
        builder: (context, addressNotifier, child) {
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            children: [
              SizedBox(height: 20.h),
              _buildtextfield(
                hintText: 'Phone Number',
                keyboard: TextInputType.phone,
                controller: _phoneController,
                onSubmitted: (p) {},
              ),
              SizedBox(height: 20.h),
              _buildtextfield(
                hintText: 'Address',
                keyboard: TextInputType.phone,
                controller: _addressContoller,
                onSubmitted: (p) {},
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(addressNotifier.addressTypes.length, (
                    i,
                  ) {
                    final addressType = addressNotifier.addressTypes[i];
                    return GestureDetector(
                      onTap: () {
                        addressNotifier.setAddressType(addressType);
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 20.w),
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        decoration: BoxDecoration(
                          color:
                              addressNotifier.addressType == addressType
                                  ? Kolors.kPrimaryLight
                                  : Kolors.kWhite,
                          borderRadius: kRadiusAll,
                          border: Border.all(color: Kolors.kPrimary, width: 1),
                        ),
                        child: ReusableText(
                          text: addressType,
                          style: appStyle(
                            12,
                            addressNotifier.addressType == addressType
                                ? Kolors.kWhite
                                : Kolors.kDark,
                            FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: 15.h),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                      text: 'Set this address as default',
                      style: appStyle(14, Kolors.kPrimary, FontWeight.normal),
                    ),
                    CupertinoSwitch(
                      value: addressNotifier.defautlToogle,
                      thumbColor: Kolors.kSecondaryLight,
                      activeColor: Kolors.kPrimary,
                      onChanged: (d) {
                        addressNotifier.setDefault(d);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              CustomButton(
                btnHieght: 35.h,
                radius: 9,
                text: 'S U B M I T',
                onTap: () {
                  if (_addressContoller.text.isNotEmpty &&
                      _phoneController.text.isNotEmpty &&
                      addressNotifier.addressType != '') {
                    CreateAddress address = CreateAddress(
                      lat: 0,
                      lng: 0,
                      isDefault: addressNotifier.defautlToogle,
                      address: _addressContoller.text,
                      phone: _phoneController.text,
                      addressType: addressNotifier.addressType,
                    );
                    String data = createAddressToJson(address);

                    addressNotifier.addAddress(context, data);
                  } else {
                    showErrorPopup(
                      context,
                      'Missing Address Fields',
                      'Error Adding Address',
                      false,
                    );
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class _buildtextfield extends StatelessWidget {
  const _buildtextfield({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.onSubmitted,
    this.keyboard,
    this.readOnly,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboard;
  final void Function(String)? onSubmitted;
  final bool? readOnly;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: TextField(
        keyboardType: keyboard,
        readOnly: readOnly ?? false,
        decoration: InputDecoration(
          hintText: hintText,
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Kolors.kRed, width: 0.5),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Kolors.kPrimary, width: 0.5),
          ),
          focusedErrorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Kolors.kRed, width: 0.5),
          ),
          disabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Kolors.kGray, width: 0.5),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Kolors.kGray, width: 0.5),
          ),
          border: InputBorder.none,
        ),
        controller: controller,
        cursorHeight: 25,
        style: appStyle(12, Colors.black, FontWeight.normal),
        onSubmitted: onSubmitted,
      ),
    );
  }
}
