import 'package:flutter/material.dart';
import 'package:main/src/ui/ui_sizes.dart';

class CustomFlatButton extends StatelessWidget {
  final Function() onPressed;
  final Widget text;
  final Color color, textColor;

  const CustomFlatButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = Colors.white,
    this.textColor = Colors.deepPurple,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(color),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        ),
      ),
      onPressed: () {
        onPressed();
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(UiSizes.sm.value),
        child: text,
      ),
    );
  }
}

class CustomGradientButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final GestureTapCallback onPressed;
  final double width;
  final double height;

  const CustomGradientButton({
    Key? key,
    required this.child,
    required this.onPressed,
    required this.gradient,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        boxShadow: const [BoxShadow(offset: Offset(0.0, 1.5), blurRadius: 1.5)],
        borderRadius: BorderRadius.circular(35),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(onTap: onPressed, child: Center(child: child)),
      ),
    );
  }
}
