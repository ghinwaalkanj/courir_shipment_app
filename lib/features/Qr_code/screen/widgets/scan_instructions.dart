import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/styles/custom_textstyle.dart';
import '../../../../common/widgets/custom_sized_box.dart';
import '../../../../utils/constants/colors.dart';

class ScanInstructions extends StatelessWidget {
  const ScanInstructions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 7.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'امسح الرمز لتسليم الشحنة!',
            style: CustomTextStyle.headlineTextStyle.apply(
              color: TColors.primary,
              fontSizeFactor: 1.1,
            ),
            textAlign: TextAlign.center,
          ),
          CustomSizedBox.textSpacingVertical(),
          CustomSizedBox.textSpacingVertical(),
          Text(
            'سيبدأ عملية التوصيل للعميل بمجرد مسح المندوب رمز ال QR الظاهر لديك.',
            style: CustomTextStyle.greyTextStyle
                .apply(fontWeightDelta: 0, fontSizeFactor: 0.88),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
