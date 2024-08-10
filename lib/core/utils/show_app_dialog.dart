import 'package:flutter/material.dart';

import '../color_pallette/app_pallette.dart';
import '../constants/constants.dart';
import 'app_text.dart';

void showAppDialog(BuildContext context, String title, String content,
    void Function() okFunction, void Function() cancelFunction) {
  showDialog(
      context: context,
      builder: (context) => Dialog(
            child: Container(
              padding: const EdgeInsets.all(20),
              height: 300,
              child: Column(
                children: [
                  AppText(
                      text: title,
                      textStyle: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    Constants.alertGif,
                    height: 100,
                    width: 100,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: AppText(
                          maxLines: 4,
                          textSize: 15,
                          text: content,
                          textStyle: Theme.of(context).textTheme.bodyMedium),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: okFunction,
                        child: AppText(
                            text: 'Ok',
                            textColor: AppPellete.errorColor,
                            textSize: 15,
                            textStyle: Theme.of(context).textTheme.bodyMedium),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: cancelFunction,
                        child: AppText(
                            text: 'Cancel',
                            textColor: AppPellete.themeColor,
                            textSize: 15,
                            textStyle: Theme.of(context).textTheme.bodyMedium),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ));
}
