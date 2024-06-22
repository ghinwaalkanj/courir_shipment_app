import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../../common/styles/custom_textstyle.dart';

class AccountSummary extends StatelessWidget {
  final double total;
  const AccountSummary({super.key, required this.total});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          'مستحقاتك هي',
          style: CustomTextStyle.primaryTextStyle
              .apply(fontSizeFactor: 1.1),
        ),
        SizedBox(
          width: 40.w,
        ),
        Text(
          '$total JD',
          style: CustomTextStyle.primaryTextStyle
              .apply(fontSizeFactor: 1.1),
        ),
      ],
    );
  }
}
