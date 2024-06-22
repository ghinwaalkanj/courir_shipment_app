import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../common/styles/custom_textstyle.dart';
import '../../../../../common/widgets/custom_sized_box.dart';

class AboutSectionContent extends StatelessWidget {
  final String content;

  const AboutSectionContent({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          content,
          style: CustomTextStyle.greyTextStyle.apply(
            fontSizeFactor: 1.0,
            fontWeightDelta: 0,
          ),
          textAlign: TextAlign.justify,
        ),
        CustomSizedBox.itemSpacingVertical(height: 1.h),
      ],
    );
  }
}
