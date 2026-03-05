import 'package:flutter/material.dart';
import 'package:shopsmart_users/consts/app_colors.dart';

class Styles {
  static ThemeData themeData({
    required bool isDarktheme,
    required BuildContext context,
  }) {
    return ThemeData(
      scaffoldBackgroundColor: isDarktheme
          ? AppColors.darkScafoldColor
          : AppColors.lightScaffoldColor,
      cardColor: isDarktheme
          ? Color.fromARGB(255, 13, 6, 37)
          : AppColors.lightCardColor,
      brightness: isDarktheme ? Brightness.dark : Brightness.light,
      appBarTheme: AppBarTheme(
        iconTheme:
            IconThemeData(color: isDarktheme ? Colors.white : Colors.black),
        backgroundColor: isDarktheme
            ? AppColors.darkScafoldColor
            : AppColors.lightScaffoldColor,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        contentPadding: EdgeInsets.all(12),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.transparent),
            borderRadius: BorderRadius.circular(18)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 1, color: isDarktheme ? Colors.white : Colors.black),
            borderRadius: BorderRadius.circular(12)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 1, color: Theme.of(context).colorScheme.error),
            borderRadius: BorderRadius.circular(12)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 1, color: Theme.of(context).colorScheme.error),
            borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
