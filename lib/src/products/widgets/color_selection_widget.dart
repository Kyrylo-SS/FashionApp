import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:testdf/common/utils/kcolors.dart';
import 'package:testdf/common/widgets/app_style.dart';
import 'package:testdf/common/widgets/reusable_text.dart';
import 'package:testdf/const/constants.dart';
import 'package:testdf/src/products/controllers/colors_sizes_notifier.dart';
import 'package:testdf/src/products/controllers/product_notifier.dart';

class ColorSelectionWidget extends StatelessWidget {
  const ColorSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ColorSizesNotifier>(
      builder: (context, controller, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            context.read<ProductNotifier>().product!.colors.length,
            (i) {
              String c = context.read<ProductNotifier>().product!.colors[i];
              return GestureDetector(
                onTap: () {
                  controller.setColor(c);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  margin: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    borderRadius: kRadiusAll,
                    color:
                        c == controller.color
                            ? Kolors.kPrimary
                            : Kolors.kGrayLight,
                  ),
                  child: ReusableText(
                    text: c,
                    style: appStyle(16, Kolors.kWhite, FontWeight.normal),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
