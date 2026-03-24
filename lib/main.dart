import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/consts/theme_data.dart';
import 'package:shopsmart_users/providers/cart_provider.dart';
import 'package:shopsmart_users/providers/products_provider.dart';
import 'package:shopsmart_users/providers/viewed_provider.dart';
import 'package:shopsmart_users/providers/wishlist_provider.dart';
import 'package:shopsmart_users/root_screen.dart';
import 'package:shopsmart_users/screens/auth/forget_password.dart';
import 'package:shopsmart_users/screens/auth/login.dart';
import 'package:shopsmart_users/screens/auth/register.dart';
import 'package:shopsmart_users/screens/inner_screen.dart/orders/orders_screen.dart';
import 'package:shopsmart_users/screens/inner_screen.dart/product_details.dart';
import 'package:shopsmart_users/screens/inner_screen.dart/viewed_recently.dart';
import 'package:shopsmart_users/screens/inner_screen.dart/wishlist.dart';
import 'package:shopsmart_users/screens/search_screen.dart';

import 'providers/theme_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
        ChangeNotifierProvider(create: (_) => ViewedProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'ShopSmart',
            theme: Styles.themeData(
              isDarktheme: themeProvider.isDarkMode,
              context: context,
            ),
            home: const RootScreen(),
            routes: {
              RootScreen.routName: (context) => RootScreen(),
              ProductDetails.routName: (context) => ProductDetails(),
              Wishlist.routName: (context) => Wishlist(),
              ViewedRecently.routName: (context) => ViewedRecently(),
              RegisterScreen.routName: (context) => RegisterScreen(),
              LoginScreen.routName: (context) => LoginScreen(),
              OrdersScreen.routName: (context) => OrdersScreen(),
              ForgetPassword.routName: (context) => ForgetPassword(),
              SearchScreen.routName: (context) => SearchScreen(),
            },
          );
        },
      ),
    );
  }
}
