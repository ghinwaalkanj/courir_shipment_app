import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';
import '../../../../../common/widgets/custom_sized_box.dart';
import '../../../../../utils/constants/colors.dart';

class TraderRankingWidget extends StatelessWidget {
  final double rankingPercentage;
  final int totalShipments;
  final String rating;

  TraderRankingWidget({
    required this.rankingPercentage,
    required this.totalShipments,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 11.h,
              width: 11.h,
              child: CircularProgressIndicator(
                value: rankingPercentage / 10,
                color: TColors.primary,
                backgroundColor: TColors.buttonDisabled,
                strokeWidth: 8.0,
              ),
            ),
            Column(
              children: [
                rankingPercentage == 1.0
                    ? Image.asset(
                  'assets/images/first.png',
                  height: 7.h,
                )
                    : rankingPercentage == 2.0
                    ? Image.asset(
                  'assets/images/second.png',
                  height: 7.h,
                )
                    : Image.asset(
                  'assets/images/third.png',
                  height: 7.h,
                ),
                SizedBox(height: 1.h),
              ],
            ),
          ],
        ),
        CustomSizedBox.itemSpacingVertical(),
        Text(
          '$totalShipments شحنة مكتملة ',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
            color: TColors.primary,
            fontFamily: 'Cairo',
          ),
        ),
        CustomSizedBox.itemSpacingVertical(),
        Directionality(
          textDirection: TextDirection.ltr,
          child: RatingBarIndicator(
            rating:double.parse(rating),
            itemBuilder: (context, index) => Icon(
              Icons.star,
              color: TColors.primary,
            ),
            itemCount: 5,
            itemSize: 20.sp,
            direction: Axis.horizontal,
          ),
        ),
      ],
    );
  }
}
