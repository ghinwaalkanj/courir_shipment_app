import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../utils/constants/colors.dart';

class SloganText extends StatelessWidget {
  const SloganText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 32.5.h,
      left: 10.w,
      child: Text(
        'سرعة وثقة في كل شحنة',
        style: TextStyle(
          fontSize: 12.sp,
          color: TColors.textPrimary,
          fontFamily: 'Cairo',
        ),
      ),
    );
  }
}
