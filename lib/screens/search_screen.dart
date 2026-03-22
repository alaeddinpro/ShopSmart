import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/models/products_model..dart';
import 'package:shopsmart_users/providers/products_provider.dart';
import 'package:shopsmart_users/widgets/products/product_widget.dart';
import 'package:shopsmart_users/widgets/subtitle_text.dart';

import '../services/assets_manger.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  static const String routName = "searchscreen";
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.dispose();
    super.dispose();
  }

  List<ProductsModel> productListSearch = [];
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    String? passedCategory =
        ModalRoute.of(context)!.settings.arguments as String?;
    List<ProductsModel> productList = passedCategory == null
        ? productsProvider.products
        : productsProvider.findbycategory(categoryName: passedCategory);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(AssetsManager.shoppingcart),
            ),
            title: SubtitleText(
              label: passedCategory ?? "Search products",
              size: 24,
              weight: FontWeight.bold,
            ),
          ),
          body: productList.isEmpty
              ? Center(child: SubtitleText(label: "No Product found"))
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(height: 16),
                      TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: "Search",
                          prefixIcon: Icon(IconlyLight.search),
                          suffixIcon: GestureDetector(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                _searchController.clear();
                              },
                              child: Icon(Icons.clear)),
                        ),
                        onChanged: (value) {
                          setState(() {
                            productListSearch = productsProvider.searchQuery(
                                searchtext: _searchController.text);
                          });
                        },
                        onSubmitted: (value) {
                          setState(() {
                            productListSearch = productsProvider.searchQuery(
                                searchtext: _searchController.text);
                          });
                        },
                      ),
                      SizedBox(height: 16),
                      if (_searchController.text.isNotEmpty &&
                          productListSearch.isEmpty) ...[
                        const Center(
                          child: SubtitleText(label: "No Products found"),
                        )
                      ],
                      Expanded(
                        child: DynamicHeightGridView(
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          builder: (context, index) {
                            return ProductWidget(
                                productId: _searchController.text.isNotEmpty
                                    ? productListSearch[index].productId
                                    : productList[index].productId);
                          },
                          itemCount: _searchController.text.isNotEmpty
                              ? productListSearch.length
                              : productList.length,
                          crossAxisCount: 2,
                        ),
                      )
                    ],
                  ),
                )),
    );
  }
}
