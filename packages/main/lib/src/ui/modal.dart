import 'package:flutter/material.dart';
import 'package:main/src/ui/ui_kit_text_style.dart';
import 'package:main/src/ui/ui_sizes.dart';

import 'button.dart';

void showModal({
  required BuildContext context,
  required String title,
  required String message,
  required String primaryButtonText,
  Function? onPrimaryButtonTap,
  bool allowDismiss = true,
  bool isHtml = false,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        content: Container(
          padding: EdgeInsets.all(UiSizes.sm.value),
          width: double.infinity,
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: UiSizes.sm.value),
              Text(
                title,
                style: UiKitTextStyle.style.large(color: Colors.black),
              ),
              SizedBox(height: UiSizes.lg.value),
              Text(
                message,
                textAlign: TextAlign.center,
                style: UiKitTextStyle.style.small(color: Colors.black54),
              ),
              SizedBox(height: UiSizes.lg.value),
              CustomFlatButton(
                text: Text(
                  primaryButtonText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: UiSizes.sm.value,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  onPrimaryButtonTap?.call();
                  if (allowDismiss) {
                    Navigator.of(context).pop();
                  }
                },
              ),
              SizedBox(height: UiSizes.lg.value),
            ],
          ),
        ),
      );
    },
  );
}
