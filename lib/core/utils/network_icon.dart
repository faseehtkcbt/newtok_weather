import 'package:flutter/material.dart';

class NetworkIcon extends StatelessWidget {
  final String url;
  final double radius;
  const NetworkIcon({super.key, required this.radius, required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius,
      width: radius,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover)),
    );
  }
}
