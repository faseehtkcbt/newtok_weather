import 'package:flutter/material.dart';

import '../color_pallette/app_pallette.dart';
import 'app_text.dart';

void showAppSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
        backgroundColor: AppPellete.themeColor,
        content: AppText(
          text: content,
          textSize: 13,
          maxLines: 3,
          textStyle: Theme.of(context).textTheme.bodyMedium,
          textColor: Colors.white,
        )));
}
