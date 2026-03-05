import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/consts/theme_data.dart';
import 'package:shopsmart_users/root_screen.dart';
import 'package:shopsmart_users/screens/home_screen.dart';

import 'providers/theme_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ThemeProvider())],
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
          );
        },
      ),
    );
  }
}
