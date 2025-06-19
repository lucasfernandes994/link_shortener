import 'package:flutter/material.dart';

class UiDecotation {
  static _UiDecotationFactory input = _UiDecotationFactory();

  static _UiBackgroundDecotationFactory background =
      _UiBackgroundDecotationFactory();
}

class _UiDecotationFactory {
  Decoration primary() {
    return BoxDecoration(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
        bottomLeft: Radius.circular(16.0),
        bottomRight: Radius.circular(16.0),
      ),
      border: Border.all(
        color: Colors.deepPurple, //                   <--- border color
        width: 1,
        style: BorderStyle.solid,
      ),
    );
  }
}

class _UiBackgroundDecotationFactory {
  Decoration dark() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomRight,
        colors: [
          Colors.black,
          Colors.black,
          Colors.black,
          Colors.black,
          Color.fromARGB(255, 52, 0, 121),
          Color.fromARGB(255, 114, 3, 255),
        ],
      ),
    );
  }

  Decoration body({
    BoxBorder? border = null,
    BorderRadiusGeometry? borderRadius = null,
  }) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.black,
          Colors.black,
          // DARK
          Color.fromARGB(255, 35, 12, 61),
          Color.fromARGB(255, 59, 10, 118),
          Color.fromARGB(255, 87, 8, 184),
          Color.fromARGB(255, 108, 5, 235),
          Color.fromARGB(255, 114, 3, 255),
          //COLOR
          Color.fromARGB(255, 129, 3, 238),
          Color.fromARGB(255, 120, 4, 203),
          Color.fromARGB(255, 113, 5, 163),
          Color.fromARGB(255, 117, 7, 137),
          Color.fromARGB(255, 142, 9, 135),
        ],
      ),
      border: border,
      borderRadius: borderRadius,
    );
  }
}
