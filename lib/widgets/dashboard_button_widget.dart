import 'package:flutter/material.dart';
import 'package:shopsmart_admin/services/assets_manager.dart';
import 'package:shopsmart_admin/widgets/subtitle_text.dart';

class DashboardButtonWidget extends StatelessWidget {
  const DashboardButtonWidget({
    super.key,
    required this.text,
    required this.imagePath,
    required this.onTap,
  });
  final String text, imagePath;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(imagePath, height: 65, width: 65),
              const SizedBox(height: 12),
              SubtitleTextWidget(label: text),
            ],
          ),
        ),
      ),
    );
  }
}
