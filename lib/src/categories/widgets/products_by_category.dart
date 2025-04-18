import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:testdf/common/services/storage.dart';
import 'package:testdf/common/widgets/login_bottom_sheet.dart';
import 'package:testdf/common/widgets/shimmers/list_shimmer.dart';
import 'package:testdf/const/resource.dart';
import 'package:testdf/src/categories/controllers/category_notifier.dart';
import 'package:testdf/src/categories/hook/fetch_products_by_category.dart';
import 'package:testdf/src/products/widgets/staggered_tile_widget.dart';

class ProductsByCategory extends HookWidget {
  const ProductsByCategory({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    final results = fetchProductsByCategory(
      context.read<CategoryNotifier>().id,
    );
    final products = results.products;
    final isLoading = results.isLoading;
    final error = results.error;

    if (isLoading) {
      return const Scaffold(body: ListShimmer());
    }

    return products.isEmpty
        ? Center(
          child: Image.asset(
            R.ASSETS_IMAGES_EMPTY_PNG,
            height: ScreenUtil().screenHeight * .3,
          ),
        )
        : Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.h),
          child: StaggeredGrid.count(
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            crossAxisCount: 4,
            children: List.generate(products.length, (i) {
              final double mainAxissCellCount = (i % 2 == 0 ? 2.17 : 2.4);
              final product = products[i];
              return StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: mainAxissCellCount,
                child: StaggeredTileWidget(
                  onTap: () {
                    if (accessToken == null) {
                      loginBottomSheet(context);
                    } else {}
                  },
                  i: i,
                  product: product,
                ),
              );
            }),
          ),
        );
  }
}
