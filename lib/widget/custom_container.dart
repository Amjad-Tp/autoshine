import 'package:autoshine/values/colors.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final BoxDecoration? decoration;
  final Alignment? alignment;

  const CustomContainer({
    super.key,
    this.height,
    this.width,
    required this.child,
    this.padding,
    this.decoration,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      height: height,
      width: width,
      padding: padding,
      decoration:
          decoration ??
          BoxDecoration(
            color: whiteColor,
            borderRadius: borderRadius,
            boxShadow: shadow,
          ),
      child: child,
    );
  }
}
