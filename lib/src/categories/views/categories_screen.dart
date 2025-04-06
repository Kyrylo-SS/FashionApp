import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:testdf/common/utils/kcolors.dart';
import 'package:testdf/common/utils/kstrings.dart';
import 'package:testdf/common/widgets/app_style.dart';
import 'package:testdf/common/widgets/back_button.dart';
import 'package:testdf/common/widgets/reusable_text.dart';
import 'package:testdf/const/constants.dart';
import 'package:testdf/src/categories/controllers/category_notifier.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        centerTitle: true,
        title: ReusableText(
          text: AppText.kCategories,
          style: appStyle(16, Kolors.kPrimary, FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, i) {
          final category = categories[i];
          return ListTile(
            onTap: () {
              context.read<CategoryNotifier>().setCategory(
                category.title,
                category.id,
              );
              context.push('/category');
            },
            leading: CircleAvatar(
              backgroundColor: Kolors.kSecondaryLight,
              radius: 18,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: SvgPicture.network(category.imageUrl),
              ),
            ),

            title: ReusableText(
              text: category.title,
              style: appStyle(12, Kolors.kGray, FontWeight.normal),
            ),
            trailing: const Icon(
              MaterialCommunityIcons.chevron_double_right,
              size: 18,
            ),
          );
        },
      ),
    );
  }
}
