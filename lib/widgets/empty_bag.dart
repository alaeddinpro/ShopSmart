import 'package:flutter/material.dart';
import 'package:shopsmart_users/widgets/subtitle_text.dart';

class EmptyBag extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String buttonText;
  const EmptyBag(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.subtitle,
      required this.buttonText});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: size.height * 0.05),
          Image.asset(
            imagePath,
            width: double.infinity,
            height: size.height * 0.3,
          ),
          SizedBox(height: size.height * 0.03),
          SubtitleText(
            label: title,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SubtitleText(
              label: subtitle,
              weight: FontWeight.w300,
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16)),
            child: Text(
              buttonText,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
