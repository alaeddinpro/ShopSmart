import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shopsmart_users/consts/app_constants.dart';
import 'package:shopsmart_users/widgets/subtitle_text.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({super.key});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {},
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: FancyShimmerImage(
                imageUrl: AppConstants.ImageUrl,
                height: size.height * 0.22,
                width: double.infinity,
              ),
            ),
            SizedBox(height: 6),
            Row(
              children: [
                Flexible(
                  flex: 3,
                  child: SubtitleText(
                    label: "Product Name",
                    maxLines: 2,
                  ),
                ),
                Flexible(
                    child: IconButton(
                        onPressed: () {}, icon: Icon(IconlyLight.heart)))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SubtitleText(
                  label: "100.00\$",
                  weight: FontWeight.w600,
                ),
                Material(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: InkWell(
                      onTap: () {},
                      splashColor: Colors.blueAccent,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Icon(
                          Icons.add_shopping_cart_outlined,
                          color: Colors.white,
                        ),
                      )),
                )
              ],
            ),
            SizedBox(
              height: 6,
            )
          ],
        ),
      ),
    );
  }
}
