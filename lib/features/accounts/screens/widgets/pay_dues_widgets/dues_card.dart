import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sizer/sizer.dart';

import '../../../../../common/styles/custom_textstyle.dart';
import '../../../../../utils/constants/colors.dart';

class DuesCard extends StatelessWidget {
  final String duesAmount;
  final double percentage;
  final String requiredAmount;

  DuesCard({
    required this.duesAmount,
    required this.percentage,
    required this.requiredAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            padding: EdgeInsets.fromLTRB(4.w, 1.h, 4.w, 1.h),
            decoration: BoxDecoration(
              color: TColors.primary,
              borderRadius: BorderRadius.circular(15.sp),
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
              children: [
                CircularPercentIndicator(
                  radius: 40,
                  lineWidth: 5.0,
                  percent: percentage / 100,
                  center: new Text("$percentage%",style: CustomTextStyle.primaryTextStyle.apply(color: TColors.white),),
                  progressColor: TColors.white,
                ),
                SizedBox(width:4.w ,),
                Column(
                  children: [
                    Text(
                      'مستحقاتك هي',
                      style: CustomTextStyle.primaryTextStyle.apply(fontSizeFactor: 1.2,color: TColors.white),
                    ),
                    Text(
                      '$duesAmount JD',
                      style: CustomTextStyle.primaryTextStyle
                          .apply(fontSizeFactor: 1.8, color: TColors.white,),
                      textDirection: TextDirection.ltr,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 2.h),
        Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            children: [
              Icon(Icons.info_outline,color: TColors.primary,),
              SizedBox(width: 2.w,),
              Text(
                ' يرجى دفع مستحقاتك قبل بلوغ مبلغ $requiredAmount JD',
                style: CustomTextStyle.greyTextStyle.apply(fontSizeFactor: 0.9,color: TColors.primary),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),

      ],
    );
  }
}
