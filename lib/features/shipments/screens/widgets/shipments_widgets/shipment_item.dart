import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../../common/styles/custom_textstyle.dart';
import '../../../../../common/widgets/custom_sized_box.dart';
import '../../../../../utils/constants/colors.dart';

class ShipmentItem extends StatelessWidget {
  final void Function()? onTap;

  const ShipmentItem({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 6.w),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.only(right: 3.w),
          height: 22.h,
          width: 80.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.sp),
            color: TColors.white,
            boxShadow: [
              BoxShadow(
                color: TColors.black.withOpacity(0.25),
                blurRadius: 8,
                spreadRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 17.h,
                width: 15.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.sp),
                  image: DecorationImage(
                    image: AssetImage("assets/images/normal.png"),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 2.h, right: 5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'shipment.shipmentContents',
                        style: CustomTextStyle.headlineTextStyle.apply(
                            fontSizeFactor: 0.7, fontWeightDelta: 2),
                      ),
                    ),
                    CustomSizedBox.textSpacingVertical(),
                    Text(
                      'gfjsjlkfs',
                      style: CustomTextStyle.greyTextStyle,
                    ),
                    CustomSizedBox.textSpacingVertical(),
                    Row(
                      children: [
                        Image(
                          image: AssetImage('assets/images/Subtract (1).png'),
                          height: 5.h,
                          width: 5.w,
                        ),
                        SizedBox(width: 2.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'shipment.senderCity',
                              style: CustomTextStyle.headlineTextStyle
                                  .apply(fontSizeFactor: 0.6),
                            ),
                            Text(
                              'shipment.createdAt'.split(' ')[0],
                              style: CustomTextStyle.greyTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 2.w),
                      child: Image(
                          image: AssetImage("assets/images/Line 15.png"),
                          height: 2.h,
                          width: 1.2.w),
                    ),
                    Row(
                      children: [
                        Image(
                          image: AssetImage('assets/images/Subtract (2).png'),
                          height: 5.h,
                          width: 5.w,
                        ),
                        SizedBox(width: 2.w),
                        FittedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'shipment.recipientCity',
                                style: CustomTextStyle.headlineTextStyle
                                    .apply(fontSizeFactor: 0.6),
                              ),
                              Text(
                                ' shipment.estimated',
                                style: CustomTextStyle.greyTextStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
