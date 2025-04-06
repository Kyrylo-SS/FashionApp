import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:testdf/common/utils/kcolors.dart';
import 'package:testdf/common/widgets/app_style.dart';
import 'package:testdf/common/widgets/back_button.dart';
import 'package:testdf/common/widgets/reusable_text.dart';
import 'package:testdf/const/constants.dart';
import 'package:testdf/src/products/controllers/product_notifier.dart';
import 'package:testdf/src/products/widgets/expandable_text.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductNotifier>(
      builder: (context, productNotifier, child) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                expandedHeight: 350.h,
                collapsedHeight: 65.h,
                floating: false,
                pinned: true,
                leading: const AppBackButton(),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: GestureDetector(
                      onTap: () {},
                      child: const CircleAvatar(
                        backgroundColor: Kolors.kSecondaryLight,
                        child: Icon(
                          AntDesign.heart,
                          color: Kolors.kRed,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  background: SizedBox(
                    height: 415.h,
                    child: ImageSlideshow(
                      indicatorColor: Kolors.kPrimaryLight,
                      onPageChanged: (p) {},
                      autoPlayInterval: 15000,
                      isLoop:
                          productNotifier.product!.imageUrls.length > 1
                              ? true
                              : false,
                      children: List.generate(
                        productNotifier.product!.imageUrls.length,
                        (i) {
                          return CachedNetworkImage(
                            placeholder: placeholder,
                            errorWidget: errorWidget,
                            height: 415.h,
                            imageUrl: productNotifier.product!.imageUrls[i],
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 10.h)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ReusableText(
                        text:
                            productNotifier.product!.clothesType.toUpperCase(),
                        style: appStyle(13, Kolors.kGray, FontWeight.w600),
                      ),
                      Row(
                        children: [
                          const Icon(
                            AntDesign.star,
                            color: Kolors.kGold,
                            size: 14,
                          ),
                          SizedBox(width: 5.w),
                          ReusableText(
                            text: productNotifier.product!.ratings
                                .toStringAsFixed(1),
                            style: appStyle(
                              13,
                              Kolors.kGray,
                              FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 10.h)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ReusableText(
                    text: productNotifier.product!.title,
                    style: appStyle(18, Kolors.kDark, FontWeight.w600),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: ExpandableText(
                    text: productNotifier.product!.description,
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
