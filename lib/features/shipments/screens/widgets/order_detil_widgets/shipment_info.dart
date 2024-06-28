import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart' as intl;
import 'package:sizer/sizer.dart';
import '../../../../../common/styles/custom_textstyle.dart';
import '../../../../../utils/constants/colors.dart';

class ShipmentInfo extends StatelessWidget {
  final String price;
  final String date;
  final String quantity;
  final String weight;
  final String delivery;

  ShipmentInfo({
    required this.price,
    required this.date,
    required this.quantity,
    required this.weight,
    required this.delivery,
  });

  @override
  Widget build(BuildContext context) {
    String formattedDate = _formatDate(date);

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
                  '$price د.أ',
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
                Icon(Iconsax.box, color: TColors.primary),
                SizedBox(width: 2.w),
                Text(
                  '$delivery د.أ',
                  style: CustomTextStyle.primaryTextStyle.apply(
                    fontSizeFactor: 1.5,
                    color: TColors.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoIcon(Icons.event, formattedDate),
                _buildInfoIcon(Icons.local_shipping, '$quantity طرود'),
                _buildInfoIcon(Icons.local_shipping, '$weight كغ'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String dateTime) {
    DateTime parsedDate = DateTime.parse(dateTime);
    return intl.DateFormat('yyyy-MM-dd').format(parsedDate);
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
