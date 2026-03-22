import 'package:flutter/material.dart';
import 'package:shopsmart_users/screens/search_screen.dart';
import 'package:shopsmart_users/widgets/subtitle_text.dart';

class CtgRoundedWidget extends StatelessWidget {
  const CtgRoundedWidget({super.key, required this.image, required this.name});
  final String image, name;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, SearchScreen.routName, arguments: name);
      },
      child: Column(
        children: [
          Image.asset(
            image,
            height: 50,
            width: 50,
          ),
          SubtitleText(
            label: name,
            size: 14,
            weight: FontWeight.bold,
          )
        ],
      ),
    );
  }
}
