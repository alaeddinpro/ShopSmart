import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/consts/app_constants.dart';
import 'package:shopsmart_users/providers/products_provider.dart';

import 'package:shopsmart_users/services/assets_manger.dart';
import 'package:shopsmart_users/widgets/appnametextwidget.dart';
import 'package:shopsmart_users/widgets/products/ctg_rounded_widget.dart';
import 'package:shopsmart_users/widgets/products/latest_arrival.dart';
import 'package:shopsmart_users/widgets/subtitle_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productsProvider = Provider.of<ProductsProvider>(context);
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AssetsManager.shoppingcart),
          ),
          title: AppNameTextWidget(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: size.height * 0.25,
                child: Swiper(
                  autoplay: true,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      AppConstants.images[index],
                      fit: BoxFit.fill,
                    );
                  },
                  itemCount: AppConstants.images.length,
                  pagination: SwiperPagination(
                    builder: DotSwiperPaginationBuilder(
                      color: Colors.white,
                      activeColor: Colors.blue,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Visibility(
                  visible: true,
                  // productsProvider.getProducts.isNotEmpty,
                  child: SubtitleText(
                      label: "Latest Arrival", weight: FontWeight.bold)),
              SizedBox(height: 16),
              Visibility(
                visible: true,
                // productsProvider.getProducts.isNotEmpty,
                child: SizedBox(
                  height: size.height * 0.2,
                  child: ListView.builder(
                      itemCount: productsProvider.getProducts.length < 10
                          ? productsProvider.getProducts.length
                          : 10,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                            value: productsProvider.getProducts.toList()[index],
                            child: LatestArrival());
                      }),
                ),
              ),
              SubtitleText(label: "Categories", weight: FontWeight.bold),
              SizedBox(height: 16),
              SizedBox(
                height: size.height * 0.2,
                child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    children:
                        List.generate(AppConstants.categoris.length, (index) {
                      return CtgRoundedWidget(
                          image: AppConstants.categoris[index].image,
                          name: AppConstants.categoris[index].name);
                    })),
              )
            ]),
          ),
        ));
  }
}
