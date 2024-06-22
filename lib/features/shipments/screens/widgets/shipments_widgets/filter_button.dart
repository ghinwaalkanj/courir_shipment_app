import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../common/styles/custom_textstyle.dart';
import '../../../../../utils/constants/colors.dart';

class CustomFilterButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final int selectedFilterIndex;
  final Function(int) onTap;

  CustomFilterButton({
    required this.icon,
    required this.label,
    required this.index,
    required this.selectedFilterIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isActive = index == selectedFilterIndex;
    return GestureDetector(
      onTap: () {
        onTap(index);
      },
      child: Padding(
        padding: EdgeInsets.only(right: 2.w, left: 2.w),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: isActive
                  ? TColors.primary
                  : TColors.grey.withOpacity(0.5),
              radius: 4.h,
              child: Icon(icon,
                  color: isActive ? Colors.white : TColors.black,
                  size: 4.h),
            ),
            SizedBox(height: 1.h),
            Text(
              label,
              textAlign: TextAlign.center,
              style: CustomTextStyle.greyTextStyle.apply(
                  color: isActive ? TColors.primary : TColors.black,
                  fontSizeFactor: 0.8),
            ),
          ],
        ),
      ),
    );
  }
}
