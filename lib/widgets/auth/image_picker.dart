import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:image_picker/image_picker.dart';

class Imagepicker extends StatelessWidget {
  const Imagepicker({super.key, this.pickedimage, required this.function});
  final XFile? pickedimage;
  final Function function;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: pickedimage == null
                ? Container(
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(16)),
                  )
                : Image.file(
                    File(pickedimage!.path),
                    fit: BoxFit.fill,
                  ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Material(
            color: Colors.lightBlueAccent,
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child: InkWell(
                onTap: () {
                  function();
                },
                splashColor: Colors.blueAccent,
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Icon(
                    IconlyLight.camera,
                    color: Colors.white,
                  ),
                )),
          ),
        )
      ],
    );
  }
}
