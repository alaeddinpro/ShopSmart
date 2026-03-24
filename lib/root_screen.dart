import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/screens/cart/cart_screen.dart';
import 'package:shopsmart_users/screens/home_screen.dart';
import 'package:shopsmart_users/screens/profile_screen.dart';
import 'package:shopsmart_users/screens/search_screen.dart';

import 'providers/cart_provider.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});
  static const routName = "/RootScreen";
  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late List<Widget> screens;
  int currentScreen = 0;
  late PageController pageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    screens = [
      HomeScreen(),
      SearchScreen(),
      CartScreen(),
      ProfileScreen(),
    ];
    pageController = PageController(initialPage: currentScreen);
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentScreen,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 10,
        height: kBottomNavigationBarHeight,
        onDestinationSelected: (index) {
          setState(() {
            currentScreen = index;
          });
          pageController.jumpToPage(index);
        },
        destinations: [
          NavigationDestination(
            icon: Icon(IconlyLight.home),
            selectedIcon: Icon(IconlyBold.home),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(IconlyLight.search),
            selectedIcon: Icon(IconlyBold.search),
            label: "Search",
          ),
          NavigationDestination(
            icon: Badge(
                backgroundColor: Colors.blue,
                label: Text("${cartProvider.getCartItems.length}"),
                child: Icon(IconlyLight.bag2)),
            selectedIcon: Icon(IconlyBold.bag2),
            label: "Cart",
          ),
          NavigationDestination(
            icon: Icon(IconlyLight.profile),
            selectedIcon: Icon(IconlyBold.profile),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
