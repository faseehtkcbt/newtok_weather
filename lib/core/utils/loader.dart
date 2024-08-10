import 'package:flutter/material.dart';
import '../color_pallette/app_pallette.dart';

class Loader extends StatefulWidget {
  const Loader({super.key});

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppPellete.textWhiteColor),
      child:  CircularProgressIndicator(
        color: AppPellete.themeColor,
      ),
    );
  }
}
