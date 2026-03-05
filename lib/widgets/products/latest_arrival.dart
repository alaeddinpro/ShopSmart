import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shopsmart_users/consts/app_constants.dart';
import 'package:shopsmart_users/widgets/subtitle_text.dart';

class LatestArrival extends StatelessWidget {
  const LatestArrival({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {},
        child: SizedBox(
          width: size.width * 0.45,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FancyShimmerImage(
                  imageUrl: AppConstants.ImageUrl,
                  height: size.height * 0.12,
                  width: size.width * 0.20,
                ),
              ),
              SizedBox(width: 8),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4),
                    SubtitleText(
                      label: "Title",
                      weight: FontWeight.w600,
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {}, icon: Icon(IconlyLight.heart)),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.add_shopping_cart)),
                        ],
                      ),
                    ),
                    FittedBox(
                      child: SubtitleText(
                        label: "100.00\$",
                        weight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
