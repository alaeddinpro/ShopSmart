import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/consts/app_constants.dart';
import 'package:shopsmart_users/models/order_model.dart';
import 'package:shopsmart_users/providers/order_provider.dart';
import 'package:shopsmart_users/screens/cart/quantity_btm_widget.dart';
import 'package:shopsmart_users/widgets/products/heart_btn.dart';
import 'package:shopsmart_users/widgets/subtitle_text.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({super.key, required this.orderModel});
  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final orderprovider = Provider.of<OrderProvider>(context);
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: FancyShimmerImage(
                imageUrl: orderModel.imageUrl,
                height: size.height * 0.15,
                width: size.width * 0.3,
              ),
            ),
            SizedBox(
              width: size.width * 0.02,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SubtitleText(label: orderModel.productId, size: 16),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.clear,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SubtitleText(
                        label: "Price : ${orderModel.price}",
                        color: Colors.blue,
                      ),
                      Spacer(),
                    ],
                  ),
                  SubtitleText(
                    label: 'Qty: ${orderModel.quantity}',
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
