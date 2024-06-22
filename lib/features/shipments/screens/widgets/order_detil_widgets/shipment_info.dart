import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../../common/styles/custom_textstyle.dart';
import '../../../../../utils/constants/colors.dart';

class ShipmentInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
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
              children: [
                Icon(Icons.local_shipping, color: TColors.primary),
                SizedBox(width: 2.w),
                Text(
                  '25,000 ل.س',
                  style: CustomTextStyle.primaryTextStyle.apply(
                    fontSizeFactor: 1.5,
                    color: TColors.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                Icon(Icons.location_on, color: TColors.primary, size: 5.w),
                SizedBox(width: 2.w),
                Text(
                  'جبلة - قلعة صلاح الدين',
                  style: CustomTextStyle.primaryTextStyle.apply(
                    fontSizeFactor: 1.1,
                    color: TColors.darkerGrey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoIcon(Icons.event, '25/05/2024'),
                _buildInfoIcon(Icons.local_shipping, '10 طرود'),
                _buildInfoIcon(Icons.local_shipping, '150 كغ'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoIcon(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: TColors.primary, size: 5.w),
        SizedBox(width: 1.w),
        Text(
          text,
          style: CustomTextStyle.primaryTextStyle.apply(
            fontSizeFactor: 1.1,
            color: TColors.darkerGrey,
          ),
        ),
      ],
    );
  }
}
