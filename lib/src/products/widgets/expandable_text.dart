import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:testdf/common/utils/kcolors.dart';
import 'package:testdf/common/widgets/app_style.dart';
import 'package:testdf/src/products/controllers/product_notifier.dart';

class ExpandableText extends StatelessWidget {
  const ExpandableText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          textAlign: TextAlign.justify,
          maxLines: !context.watch<ProductNotifier>().description ? 3 : 10,
          style: appStyle(13, Kolors.kGray, FontWeight.normal),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                context.read<ProductNotifier>().setDescription();
              },
              child: Text(
                !context.watch<ProductNotifier>().description
                    ? 'Veiw More'
                    : 'View Less',
                style: appStyle(11, Kolors.kPrimaryLight, FontWeight.normal),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
