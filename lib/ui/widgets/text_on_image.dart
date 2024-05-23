import 'package:flutter/material.dart';

import '../../core/configs/constants/app_icons.dart';
import '../../core/configs/theme/app_text_styles.dart';

class TextOnImage extends StatelessWidget {
  const TextOnImage({
    super.key,
    required this.text,
    required this.isRelocated,
  });
  final String text;
  final bool isRelocated;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        switch (isRelocated) {
          true => AppIcons.battery_bin,
          false => AppIcons.house_hold,
        }(size: 150),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              '%$text',
              style: AppTextStyles.title_high(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ],
    );
  }
}
