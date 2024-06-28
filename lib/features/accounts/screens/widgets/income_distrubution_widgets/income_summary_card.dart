import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../../common/styles/custom_textstyle.dart';
import '../../../../../utils/constants/colors.dart';

class IncomeSummaryCard extends StatelessWidget {
  final RxBool isDetailVisible;
  final String summaryText;
  final bool isFittedBoxVisible;


  IncomeSummaryCard({required this.isDetailVisible, required this.summaryText, required this.isFittedBoxVisible});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.w,
      height: 8.h,
      padding: EdgeInsets.fromLTRB(4.w, 1.h, 4.w, 1.h),
      decoration: BoxDecoration(
        color: TColors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 3,
            spreadRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child:isFittedBoxVisible
          ? FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_drop_down, color: TColors.primary, size: 8.w),
              onPressed: () {
                isDetailVisible.value = !isDetailVisible.value;
              },
            ),
            Text(
              summaryText,
              style: CustomTextStyle.primaryTextStyle
                  .apply(fontSizeFactor: 1.4, color: TColors.primary),
            ),
          ],
        ),
      ): Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_drop_down, color: TColors.primary, size: 8.w),
            onPressed: () {
              isDetailVisible.value = !isDetailVisible.value;
            },
          ),
          Text(
            summaryText,
            style: CustomTextStyle.primaryTextStyle
                .apply(fontSizeFactor: 1.4, color: TColors.primary),
          ),
        ],
      ),
    );
  }
}
