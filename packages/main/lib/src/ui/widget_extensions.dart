import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget padding({Key? key, required EdgeInsetsGeometry padding}) {
    return Padding(key: key, padding: padding, child: this);
  }

  Widget onTap({
    Key? key,
    GestureTapCallback? onTap,
    GestureTapCallback? onDoubleTap,
    GestureTapCallback? onLongPress,
  }) {
    return InkWell(
      key: key,
      child: this,
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
    );
  }
}
