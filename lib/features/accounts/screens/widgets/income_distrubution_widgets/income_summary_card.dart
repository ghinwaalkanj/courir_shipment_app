import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../../common/styles/custom_textstyle.dart';
import '../../../../../utils/constants/colors.dart';

class IncomeSummaryCard extends StatelessWidget {
  final RxBool isDetailVisible;
  final String summaryText;

  IncomeSummaryCard({required this.isDetailVisible, required this.summaryText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(4.w, 1.h, 4.w, 1.h),
      decoration: BoxDecoration(
        color: TColors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
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
    );
  }
}
