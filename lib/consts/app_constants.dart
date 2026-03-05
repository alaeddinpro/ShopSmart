import 'package:shopsmart_users/models/categoris.dart';
import 'package:shopsmart_users/services/assets_manger.dart';

class AppConstants {
  static const String ImageUrl =
      "https://m.media-amazon.com/images/G/01/zappos/2026/nicole/HP-VISNAV-MERRELL-432x540._FMwebp_.jpg";

  static final List<String> images = [
    AssetsManager.banner1,
    AssetsManager.banner2,
  ];
  static List<Categoris_Model> categoris = [
    Categoris_Model(id: "1", image: AssetsManager.books, name: "Books"),
    Categoris_Model(id: "2", image: AssetsManager.cosmetics, name: "Cosmetics"),
    Categoris_Model(
        id: "3", image: AssetsManager.electronics, name: "Electronics"),
    Categoris_Model(id: "4", image: AssetsManager.fashion, name: "Fashion"),
    Categoris_Model(id: "5", image: AssetsManager.mobiles, name: "Mobiles"),
    Categoris_Model(id: "6", image: AssetsManager.pc, name: "Pc"),
    Categoris_Model(id: "7", image: AssetsManager.shoes, name: "Shoes"),
    Categoris_Model(id: "8", image: AssetsManager.watch, name: "Watches"),
  ];
}
