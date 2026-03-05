import 'package:flutter/material.dart';

class SubtitleText extends StatelessWidget {
  const SubtitleText({
    super.key,
    required this.label,
    this.size = 18,
    this.color,
    this.weight = FontWeight.normal,
    this.maxLines,
  });
  final String label;
  final double? size;
  final FontWeight? weight;
  final Color? color;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: color, fontSize: size, fontWeight: weight),
    );
  }
}
