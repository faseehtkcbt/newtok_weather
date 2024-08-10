import 'package:flutter/material.dart';

import '../color_pallette/app_pallette.dart';
import '../constants/constants.dart';
import 'app_text.dart';

class AppbarTitle extends StatelessWidget {
  final String title;
  const AppbarTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage(Constants.iconImage),
        ),
        const SizedBox(
          width: 10,
        ),
        AppText(
          text: title,
          textStyle: Theme.of(context).textTheme.titleMedium,
          textColor: AppPellete.themeColor,
        )
      ],
    );
  }
}
