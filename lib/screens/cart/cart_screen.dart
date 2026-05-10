import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/providers/products_provider.dart';
import 'package:shopsmart_users/screens/cart/bottom_checkout.dart';
import 'package:shopsmart_users/screens/cart/cart_widget.dart';
import 'package:shopsmart_users/screens/loading%20manager.dart';
import 'package:shopsmart_users/services/assets_manger.dart';
import 'package:shopsmart_users/services/my_app_functions.dart';
import 'package:shopsmart_users/widgets/subtitle_text.dart';
import 'package:uuid/uuid.dart';
import '../../providers/cart_provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/empty_bag.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    // final productsProvider = Provider.of<ProductsProvider>(context);

    final cartProvider = Provider.of<CartProvider>(context);
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      body: cartProvider.getCartItems.isEmpty
          ? EmptyBag(
              imagePath: AssetsManager.shoppingbasket,
              title: "Your cart is empty",
              subtitle:
                  "Looks like you haven't added anything to your cart yet",
              buttonText: "Shop Now",
            )
          : Scaffold(
              appBar: AppBar(
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(AssetsManager.shoppingcart),
                ),
                title: SubtitleText(
                  label: "Cart (${cartProvider.getCartItems.length})",
                  size: 24,
                  weight: FontWeight.bold,
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        MyAppFunctions.showErrorOrWarningDialog(
                            isError: false,
                            context: context,
                            fct: cartProvider.clearCartFromfirebase,
                            title: "Clear Cart");
                      },
                      icon: const Icon(
                        IconlyBold.delete,
                        color: Colors.red,
                      ))
                ],
              ),
              body: LoadingManager(
                isLoading: _isLoading,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: cartProvider.getCartItems.length,
                        itemBuilder: (context, index) {
                          return ChangeNotifierProvider.value(
                              value: cartProvider.getCartItems.values
                                  .toList()[index],
                              child: CartWidget());
                        },
                      ),
                    ),
                    SizedBox(height: kBottomNavigationBarHeight),
                  ],
                ),
              ),
              bottomNavigationBar: Cartbottomsheetwidget(
                function: () async {
                  await placeord(
                    cartProvider: cartProvider,
                    productProvider: productsProvider,
                    userProvider: userProvider,
                  );
                },
              ),
            ),
    );
  }

  Future<void> placeord({
    required CartProvider cartProvider,
    required ProductsProvider productProvider,
    required UserProvider userProvider,
  }) async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user == null) {
      return;
    }
    final uid = user.uid;
    try {
      setState(() {
        _isLoading = true;
      });
      cartProvider.getCartItems.forEach((key, value) async {
        final getcurrentProduct = productProvider.findById(value.productId);
        final orderId = const Uuid().v4();
        await FirebaseFirestore.instance.collection('orders').doc(orderId).set({
          'orderId': orderId,
          'productId': value.productId,
          'productTitle': getcurrentProduct!.productTitle,
          'quantity': value.quantity,
          'price':
              double.parse(getcurrentProduct.productPrice) * value.quantity,
          'total':
              cartProvider.getTotalPrice(productsProvider: productProvider),
          'imageUrl': getcurrentProduct.productImage,
          'userName': userProvider.getUserModel!.userName,
          'userId': user.uid,
          'orderDate': Timestamp.now(),
        });
      });
      await cartProvider.clearCartFromfirebase();
      cartProvider.clearLocalCart();
    } catch (e) {
      MyAppFunctions.showErrorOrWarningDialog(
        context: context,
        title: e.toString(),
        fct: () {},
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
