import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/screens/auth/login.dart';
import 'package:shopsmart_users/screens/inner_screen.dart/orders/orders_screen.dart';
import 'package:shopsmart_users/screens/inner_screen.dart/viewed_recently.dart';
import 'package:shopsmart_users/screens/inner_screen.dart/wishlist.dart';
import 'package:shopsmart_users/services/assets_manger.dart';
import 'package:shopsmart_users/services/my_app_functions.dart';
import 'package:shopsmart_users/widgets/appnametextwidget.dart';
import 'package:shopsmart_users/widgets/subtitle_text.dart';

import '../providers/theme_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.shoppingcart),
        ),
        title: AppNameTextWidget(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: false,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: SubtitleText(
                label: "Please Login to continuehave unlimited access",
              ),
            ),
          ),
          Visibility(
            visible: true,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).cardColor,
                      border: Border.all(
                          color: Theme.of(context).colorScheme.surface,
                          width: 3),
                      image: DecorationImage(
                        image: (NetworkImage(
                            "https://cdn.pixabay.com/photo/2023/02/18/11/00/icon-7797704_640.png")),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SubtitleText(
                        label: "Alaeddin Aichouche",
                        weight: FontWeight.bold,
                      ),
                      SubtitleText(label: "Mobile Developer")
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SubtitleText(
                  label: "General",
                  weight: FontWeight.bold,
                  size: 16,
                ),
                Listtilewidget(
                  image: AssetsManager.ordersvg,
                  title: "All orders",
                  onTap: () {
                    Navigator.pushNamed(context, OrdersScreen.routName);
                  },
                ),
                Listtilewidget(
                  image: AssetsManager.wishlist,
                  title: "Wishlist",
                  onTap: () {
                    Navigator.pushNamed(context, Wishlist.routName);
                  },
                ),
                Listtilewidget(
                  image: AssetsManager.recent,
                  title: "Viewed recently",
                  onTap: () {
                    Navigator.pushNamed(context, ViewedRecently.routName);
                  },
                ),
                Listtilewidget(
                  image: AssetsManager.adresse,
                  title: "Address",
                  onTap: () {},
                ),
                Divider(
                  thickness: 0.3,
                ),
                SizedBox(
                  height: 16,
                ),
                SubtitleText(
                  label: "Settings",
                  weight: FontWeight.bold,
                  size: 16,
                ),
                SwitchListTile(
                  title: Text(
                      themeProvider.isDarkMode ? "Dark Mode" : "Light Mode"),
                  value: themeProvider.isDarkMode,
                  onChanged: (value) {
                    themeProvider.setDarkMode(value);
                  },
                  secondary: Image.asset(
                    AssetsManager.theme,
                    height: 30,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                SubtitleText(
                  label: "Others",
                  weight: FontWeight.bold,
                  size: 16,
                ),
                Listtilewidget(
                  image: AssetsManager.privacy,
                  title: "Privacy & Policy",
                  onTap: () {},
                ),
              ],
            ),
          ),
          Center(
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: user == null ? Colors.green : Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                if (user == null) {
                  Navigator.pushNamed(context, LoginScreen.routName);
                } else {
                  MyAppFunctions.showErrorOrWarningDialog(
                      context: context,
                      fct: () async {
                        await FirebaseAuth.instance.signOut();
                        if (!mounted) {
                          return;
                        }
                        Navigator.pushNamed(context, LoginScreen.routName);
                      },
                      title: "Are you sure you want sign out",
                      isError: false);
                }
              },
              label: Text(
                user == null ? "Login" : "Logout",
                style: TextStyle(color: Colors.white),
              ),
              icon: Icon(
                user == null ? IconlyLight.login : IconlyLight.logout,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Listtilewidget extends StatelessWidget {
  const Listtilewidget(
      {super.key,
      required this.image,
      required this.title,
      required this.onTap});
  final String image;
  final String title;

  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTap();
      },
      leading: Image.asset(
        image,
        height: 30,
      ),
      title: SubtitleText(
        label: title,
        size: 16,
      ),
      trailing: Icon(IconlyLight.arrowRight2),
    );
  }
}
