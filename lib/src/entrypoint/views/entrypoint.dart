import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:testdf/common/utils/kcolors.dart';
import 'package:testdf/src/cart/views/cart_screen.dart';
import 'package:testdf/src/entrypoint/controllers/bottom_tab_notifier.dart';
import 'package:testdf/src/home/views/home_screen.dart';
import 'package:testdf/src/profile/views/profile_screen.dart';
import 'package:testdf/src/wishlist/views/wishlist_screen.dart';

class AppEntryPoint extends StatelessWidget {
  AppEntryPoint({super.key});

  List<Widget> pageList = [
    const HomePage(),
    const WishlistPage(),
    const CartPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<TabIndexNotifier>(
      builder:
          (context, tabIndexNotifier, child) => Scaffold(
            body: Stack(
              children: [
                pageList[tabIndexNotifier.index],
                Align(
                  alignment: Alignment.bottomCenter,
                  child: BottomNavigationBar(
                    selectedFontSize: 12,
                    elevation: 0,
                    backgroundColor: Kolors.kOffWhite,
                    showSelectedLabels: true,
                    showUnselectedLabels: false,
                    unselectedIconTheme: const IconThemeData(
                      color: Colors.black38,
                    ),
                    currentIndex: tabIndexNotifier.index,
                    selectedItemColor: Kolors.kPrimary,
                    unselectedItemColor: Kolors.kGray,
                    onTap: (i) {
                      tabIndexNotifier.setIndex(i);
                    },
                    items: [
                      BottomNavigationBarItem(
                        icon:
                            tabIndexNotifier.index == 0
                                ? const Icon(
                                  AntDesign.home,
                                  color: Kolors.kPrimary,
                                  size: 28,
                                )
                                : Icon(AntDesign.home, size: 28),
                        label: "Home",
                      ),
                      BottomNavigationBarItem(
                        icon:
                            tabIndexNotifier.index == 1
                                ? const Icon(
                                  Ionicons.heart,
                                  color: Kolors.kPrimary,
                                  size: 28,
                                )
                                : Icon(Ionicons.heart_outline),
                        label: "WishList",
                      ),
                      BottomNavigationBarItem(
                        icon:
                            tabIndexNotifier.index == 2
                                ? const Badge(
                                  label: Text("9"),
                                  child: Icon(
                                    MaterialCommunityIcons.shopping,
                                    color: Kolors.kPrimary,
                                    size: 28,
                                  ),
                                )
                                : const Badge(
                                  label: Text("9"),
                                  child: Icon(
                                    MaterialCommunityIcons.shopping_outline,
                                  ),
                                ),
                        label: "Cart",
                      ),
                      BottomNavigationBarItem(
                        icon:
                            tabIndexNotifier.index == 3
                                ? const Icon(
                                  EvilIcons.user,
                                  color: Kolors.kPrimary,
                                  size: 32,
                                )
                                : Icon(EvilIcons.user),
                        label: "Profile",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
