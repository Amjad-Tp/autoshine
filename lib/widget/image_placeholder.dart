import 'package:autoshine/values/colors.dart';
import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;

  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(child: CircularProgressIndicator(color: deepAmber));
      },
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          'assets/images/placeholder.png',
          width: width,
          height: height,
          fit: fit,
        );
      },
    );
  }
}
