import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:testdf/common/utils/kcolors.dart';
import 'package:testdf/common/widgets/app_style.dart';
import 'package:testdf/common/widgets/reusable_text.dart';
import 'package:testdf/src/cart/controllers/cart_notifier.dart';

class UpdateButton extends StatelessWidget {
  const UpdateButton({super.key, this.onUpdate});

  final void Function()? onUpdate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onUpdate,
      onLongPress: () {
        context.read<CartNotifier>().clearSelected();
      },
      child: Container(
        width: 65.w,
        height: 18.h,
        decoration: BoxDecoration(
          color: Kolors.kPrimary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: ReusableText(
            text: 'Update',
            style: appStyle(11, Kolors.kWhite, FontWeight.normal),
          ),
        ),
      ),
    );
  }
}
