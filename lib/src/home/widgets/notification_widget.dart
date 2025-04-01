import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:testdf/common/services/storage.dart';
import 'package:testdf/common/utils/kcolors.dart';
import 'package:testdf/common/widgets/login_bottom_sheet.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (Storage().getString('accessToken') == null) {
          loginBottomSheet(context);
        } else {
          GoRouter.of(context).go('/notifications');
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 12).copyWith(top: 20),
        child: CircleAvatar(
          backgroundColor: Kolors.kGray.withOpacity(.2),
          child: const Badge(
            label: Text('4'),
            child: Icon(Ionicons.notifications, color: Kolors.kPrimary),
          ),
        ),
      ),
    );
  }
}
