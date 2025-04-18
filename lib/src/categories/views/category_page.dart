import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testdf/common/services/storage.dart';
import 'package:testdf/common/utils/kcolors.dart';
import 'package:testdf/common/widgets/app_style.dart';
import 'package:testdf/common/widgets/back_button.dart';
import 'package:testdf/common/widgets/reusable_text.dart';
import 'package:testdf/src/categories/controllers/category_notifier.dart';
import 'package:testdf/src/categories/widgets/products_by_category.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        centerTitle: true,
        title: ReusableText(
          text: context.read<CategoryNotifier>().category,
          style: appStyle(16, Kolors.kPrimary, FontWeight.bold),
        ),
      ),
      body: ProductsByCategory(),
    );
  }
}
