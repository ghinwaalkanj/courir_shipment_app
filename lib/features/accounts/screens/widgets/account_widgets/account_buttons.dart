import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../../common/styles/custom_textstyle.dart';
import '../../../../../utils/constants/colors.dart';

class AccountButtons extends StatelessWidget {
  final VoidCallback onPayPressed;
  final VoidCallback onDistributeIncomePressed;

  AccountButtons({
    required this.onPayPressed,
    required this.onDistributeIncomePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPayPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: TColors.primary,
            minimumSize: Size(double.infinity, 6.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.sp),
            ),
          ),
          child: Text(
            'دفع مستحقاتي',
            style: CustomTextStyle.primaryTextStyle
                .apply(fontSizeFactor: 1.3, color: TColors.white),
          ),
        ),
        SizedBox(height: 2.h),
        OutlinedButton(
          onPressed: onDistributeIncomePressed,
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: TColors.primary, width: 2),
            minimumSize: Size(double.infinity, 6.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.sp),
            ),
          ),
          child: Text(
            'توزيع الدخل',
            style: CustomTextStyle.primaryTextStyle
                .apply(fontSizeFactor: 1.3),
          ),
        ),
      ],
    );
  }
}
