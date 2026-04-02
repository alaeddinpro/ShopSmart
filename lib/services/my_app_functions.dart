import 'package:flutter/material.dart';
import 'package:shopsmart_users/services/assets_manger.dart';
import 'package:shopsmart_users/widgets/subtitle_text.dart';

class MyAppFunctions {
  static Future<void> showErrorOrWarningDialog(
      {required BuildContext context,
      required Function fct,
      required String title,
      bool isError = true}) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  isError ? AssetsManager.error : AssetsManager.warning,
                  height: 60,
                  width: 60,
                ),
                SizedBox(
                  height: 16,
                ),
                SubtitleText(
                  label: title,
                  size: 14,
                  maxLines: 3,
                  weight: FontWeight.w600,
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                      visible: !isError,
                      child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: SubtitleText(
                            label: "Cancel",
                            color: Colors.green,
                          )),
                    ),
                    TextButton(
                        onPressed: () {
                          fct();
                          Navigator.pop(context);
                        },
                        child: SubtitleText(
                          label: "OK",
                          color: Colors.red,
                        ))
                  ],
                )
              ],
            ),
          );
        });
  }

  static Future<void> imagePickerDialog({
    required BuildContext context,
    required Function cameraFunct,
    required Function galleryFunct,
    required Function removeFunct,
  }) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: SubtitleText(label: "Choose option")),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  TextButton.icon(
                    onPressed: () {
                      cameraFunct();
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(Icons.camera),
                    label: const Text("Camera"),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      galleryFunct();
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(Icons.browse_gallery),
                    label: const Text("Gallery"),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      removeFunct();
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(Icons.remove_circle_outline),
                    label: const Text("Remove"),
                  )
                ],
              ),
            ),
          );
        });
  }
}
