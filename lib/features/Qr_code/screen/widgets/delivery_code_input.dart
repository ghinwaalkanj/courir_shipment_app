import 'package:courir_shipment_app/common/widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/styles/custom_textstyle.dart';
import '../../../../utils/constants/colors.dart';

class DeliveryCodeInput extends StatelessWidget {
  final String shipmentNumber;

  const DeliveryCodeInput({Key? key, required this.shipmentNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        children: [
          CustomSizedBox.textSpacingVertical(),
          Container(
            height: 5.h,
            width: 80.w,
            decoration: BoxDecoration(
              color: TColors.white,
              borderRadius: BorderRadius.circular(10.sp),
            ),
            child: Center(
              child: Text(
                '#$shipmentNumber',
                style: CustomTextStyle.headlineTextStyle.apply(
                  color: TColors.primary,
                  fontSizeFactor: 1.1,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
