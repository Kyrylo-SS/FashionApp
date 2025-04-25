import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:testdf/common/services/storage.dart';
import 'package:testdf/common/utils/kcolors.dart';
import 'package:testdf/common/utils/kstrings.dart';
import 'package:testdf/common/widgets/app_style.dart';
import 'package:testdf/common/widgets/back_button.dart';
import 'package:testdf/common/widgets/email_textfield.dart';
import 'package:testdf/common/widgets/login_bottom_sheet.dart';
import 'package:testdf/common/widgets/reusable_text.dart';
import 'package:testdf/const/resource.dart';
import 'package:testdf/src/products/widgets/staggered_tile_widget.dart';
import 'package:testdf/src/search/controllers/search_notifier.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(
          onTap: () {
            context.read<SearchNotifier>().clear();
            context.push('/home');
          },
        ),
        title: ReusableText(
          text: AppText.kSearch,
          style: appStyle(15, Kolors.kPrimary, FontWeight.bold),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: EmailTextField(
              controller: _searchController,
              radius: 30,
              hintText: AppText.kSearch,
              prefixIcon: GestureDetector(
                onTap: () {
                  if (_searchController.text.isNotEmpty) {
                    context.read<SearchNotifier>().searchFunction(
                      _searchController.text,
                    );
                  }
                },
                child: const Icon(AntDesign.search1, color: Kolors.kPrimary),
              ),
            ),
          ),
        ),
      ),
      body: Consumer<SearchNotifier>(
        builder: (context, searchNotifier, child) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: ListView(
              children: [
                searchNotifier.results.isNotEmpty
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReusableText(
                          text: AppText.kSearchResults,
                          style: appStyle(13, Kolors.kPrimary, FontWeight.w600),
                        ),
                        ReusableText(
                          text: searchNotifier.searchKey,
                          style: appStyle(13, Kolors.kPrimary, FontWeight.w600),
                        ),
                      ],
                    )
                    : const SizedBox.shrink(),
                SizedBox(height: 10.h),
                searchNotifier.results.isNotEmpty
                    ? StaggeredGrid.count(
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      crossAxisCount: 4,
                      children: List.generate(searchNotifier.results.length, (
                        i,
                      ) {
                        final double mainAxissCellCount =
                            (i % 2 == 0 ? 2.17 : 2.4);
                        final product = searchNotifier.results[i];
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
                    )
                    : Center(
                      child: Image.asset(
                        R.ASSETS_IMAGES_EMPTY_PNG,
                        height: ScreenUtil().screenHeight * .3,
                      ),
                    ),
              ],
            ),
          );
        },
      ),
    );
  }
}
