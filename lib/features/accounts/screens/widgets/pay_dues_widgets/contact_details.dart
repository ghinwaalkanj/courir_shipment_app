import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../common/styles/custom_textstyle.dart';
import '../../../../../utils/constants/colors.dart';

class ContactDetail extends StatelessWidget {
  final IconData icon;
  final String detail;

  ContactDetail({
    required this.icon,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 2.h),
          decoration: BoxDecoration(
            border: Border.all(color: TColors.primary, width: 2),
            borderRadius: BorderRadius.circular(15.sp),
          ),
          child: Icon(icon, color: TColors.primary, size: 8.w),
        ),
        SizedBox(height: 2.h),
        Container(
          width: 65.w,
          padding: EdgeInsets.fromLTRB(4.w, 2.5.h, 4.w, 2.5.h),
          decoration: BoxDecoration(
            border: Border.all(color: TColors.primary, width: 2),
            borderRadius: BorderRadius.circular(15.sp),
          ),
          child: Center(
            child: Text(
              detail,
              style: CustomTextStyle.primaryTextStyle.apply(fontSizeFactor: 1.2),
            ),
          ),
        ),
      ],
    );
  }
}
