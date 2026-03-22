import 'package:flutter/material.dart';
import 'package:shopsmart_users/widgets/subtitle_text.dart';

class Cartbottomsheetwidget extends StatelessWidget {
  const Cartbottomsheetwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(color: Colors.grey, width: 0.25),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: SizedBox(
          height: kBottomNavigationBarHeight + 10,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SubtitleText(label: "Total(6 products/9 items)"),
                  SubtitleText(
                    label: "100.00\$",
                    color: Colors.blue,
                    weight: FontWeight.bold,
                  )
                ],
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text("Checkout"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
