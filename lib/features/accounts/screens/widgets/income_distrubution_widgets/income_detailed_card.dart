import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../common/styles/custom_textstyle.dart';
import '../../../../../utils/constants/colors.dart';

class IncomeDetailCard extends StatelessWidget {
  final String orderNumber;
  final String deliveryTime;
  final String deliveryAmount;
  final String incomeAmount;

  IncomeDetailCard({
    required this.orderNumber,
    required this.deliveryTime,
    required this.deliveryAmount,
    required this.incomeAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding: EdgeInsets.fromLTRB(4.w, 3.h, 4.w, 5.h),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    orderNumber,
                    style: CustomTextStyle.primaryTextStyle
                        .apply(fontSizeFactor: 1.3, color: TColors.primary),
                  ),
                  Text(
                    deliveryTime,
                    style: CustomTextStyle.greyTextStyle,
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'توصيل',
                    style: CustomTextStyle.greyTextStyle.apply(
                      fontSizeFactor: 1.1,
                    ),
                  ),
                  Text(
                    '$deliveryAmount JD',
                    style: CustomTextStyle.primaryTextStyle.apply(
                      fontSizeFactor: 1.2,
                      color: TColors.primary,
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'إيراداتك من هذا الطلب',
                    style: CustomTextStyle.greyTextStyle.apply(
                      fontSizeFactor: 1.1,
                    ),
                  ),
                  Text(
                    '$incomeAmount JD',
                    style: CustomTextStyle.primaryTextStyle.apply(
                      fontSizeFactor: 1.2,
                      color: TColors.primary,
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
