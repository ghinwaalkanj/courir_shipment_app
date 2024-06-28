import 'package:courir_shipment_app/features/auth/screen/widgets/circular_stepper_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../common/styles/custom_textstyle.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.desc,
      required this.currentStep})
      : super(key: key);
  final String title;
  final String subTitle;
  final String desc;
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: TColors.primary,
                      fontFamily: 'Cairo',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  subTitle,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: TColors.darkGrey,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 3.w,
            ),
            CircularStepperIndicatorWidget(
              currentStep: currentStep,
              totalSteps: 4,
            )
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          desc,
          style: CustomTextStyle.greyTextStyle
              .apply(fontWeightDelta: -2, fontSizeDelta: 2),
          textDirection: TextDirection.rtl,
        ),
      ],
    );
  }
}
