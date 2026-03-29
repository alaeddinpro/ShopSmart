import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_admin/models/dashboard_btn_model.dart';
import 'package:shopsmart_admin/widgets/dashboard_button_widget.dart';
import '../providers/theme_provider.dart';
import '../services/assets_manager.dart';
import '../widgets/title_text.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/DashboardScreen';
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const TitlesTextWidget(label: "Dashboard Screen"),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.shoppingCart),
        ),
        actions: [
          IconButton(
            onPressed: () {
              themeProvider.setDarkTheme(
                themeValue: !themeProvider.getIsDarkTheme,
              );
            },
            icon: Icon(
              themeProvider.getIsDarkTheme ? Icons.light_mode : Icons.dark_mode,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(
            DashboardBtnModel.getDashboardBtnList(context).length,
            (index) => DashboardButtonWidget(
              text: DashboardBtnModel.getDashboardBtnList(context)[index].title,
              imagePath: DashboardBtnModel.getDashboardBtnList(
                context,
              )[index].image,
              onTap: DashboardBtnModel.getDashboardBtnList(
                context,
              )[index].onTap,
            ),
          ),
        ),
      ),
    );
  }
}
