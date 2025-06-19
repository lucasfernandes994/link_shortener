import 'package:flutter/material.dart';
import 'package:main/src/ui/ui_sizes.dart';

class UiKitTextStyle {
  static _UiKitTextStyleFactory style = _UiKitTextStyleFactory();
}

class _UiKitTextStyleFactory {
  TextStyle xsmall({Color? color, FontWeight? weight}) => TextStyle(
    color: color ?? Colors.white,
    fontSize: UiSizes.xs.value,
    fontWeight: weight ?? FontWeight.normal,
  );

  TextStyle small({Color? color, FontWeight? weight}) => TextStyle(
    color: color ?? Colors.white,
    fontSize: UiSizes.sm.value,
    fontWeight: weight ?? FontWeight.normal,
  );

  TextStyle large({Color? color, FontWeight? weight}) => TextStyle(
    color: color ?? Colors.white,
    fontSize: UiSizes.lg.value,
    fontWeight: weight ?? FontWeight.normal,
  );
}
