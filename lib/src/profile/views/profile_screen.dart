import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:testdf/common/services/storage.dart';
import 'package:testdf/common/utils/kcolors.dart';
import 'package:testdf/common/utils/kstrings.dart';
import 'package:testdf/common/widgets/app_style.dart';
import 'package:testdf/common/widgets/custom_button.dart';
import 'package:testdf/common/widgets/help_bottom_sheet.dart';
import 'package:testdf/common/widgets/reusable_text.dart';
import 'package:testdf/src/auth/controllers/auth_notifier.dart';
import 'package:testdf/src/auth/models/profile_model.dart';
import 'package:testdf/src/auth/views/login_screen.dart';
import 'package:testdf/src/entrypoint/controllers/bottom_tab_notifier.dart';
import 'package:testdf/src/profile/widgets/tile_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');

    if (accessToken == null) {
      return const LoginScreen();
    }
    return Scaffold(
      body: Consumer<AuthNotifier>(
        builder: (context, authNotifier, child) {
          ProfileModel? user = authNotifier.getUserData();
          return ListView(
            children: [
              Column(
                children: [
                  SizedBox(height: 50.h),
                  const CircleAvatar(
                    radius: 35,
                    backgroundColor: Kolors.kOffWhite,
                    backgroundImage: NetworkImage(AppText.kProfilePic),
                  ),
                  SizedBox(height: 15.h),
                  ReusableText(
                    text: user!.email,
                    style: appStyle(11, Kolors.kGray, FontWeight.normal),
                  ),
                  SizedBox(height: 7.h),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    decoration: BoxDecoration(
                      color: Kolors.kOffWhite,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ReusableText(
                      text: user!.username,
                      style: appStyle(14, Kolors.kDark, FontWeight.w600),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Container(
                color: Kolors.kOffWhite,
                child: Column(
                  children: [
                    ProfileTileWidget(
                      title: 'My Orders',
                      leading: Octicons.checklist,
                      onTap: () {
                        context.push('/orders');
                      },
                    ),
                    ProfileTileWidget(
                      title: 'Shipping Address',
                      leading: MaterialIcons.location_pin,
                      onTap: () {
                        context.push('/addresses');
                      },
                    ),
                    ProfileTileWidget(
                      title: 'Privacy Policy',
                      leading: MaterialIcons.policy,
                      onTap: () {
                        context.push('/policy');
                      },
                    ),
                    ProfileTileWidget(
                      title: 'Help Center',
                      leading: AntDesign.customerservice,
                      onTap: () => showHelpCenterBottomSheet(context),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: CustomButton(
                  onTap: () {
                    Storage().removeKey('accessToken');
                    context.read<TabIndexNotifier>().setIndex(0);
                    context.go('/home');
                  },
                  text: 'Logout'.toUpperCase(),
                  btnColor: Kolors.kRed,
                  btnWidth: ScreenUtil().screenWidth,
                  btnHieght: 35.h,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
