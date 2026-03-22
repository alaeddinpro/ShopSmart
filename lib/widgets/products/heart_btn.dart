import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class HeartBtn extends StatefulWidget {
  const HeartBtn(
      {super.key,
      this.backgroundcolor = Colors.transparent,
      this.sizeicon = 20});
  final Color backgroundcolor;
  final double sizeicon;
  @override
  State<HeartBtn> createState() => _HeartBtnState();
}

class _HeartBtnState extends State<HeartBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: widget.backgroundcolor, shape: BoxShape.circle),
        child: IconButton(
            style: IconButton.styleFrom(elevation: 10),
            onPressed: () {},
            icon: Icon(
              IconlyLight.heart,
              size: widget.sizeicon,
            )));
  }
}
