import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';
import '../../../../../common/styles/custom_textstyle.dart';
import '../../../../../common/widgets/custom_sized_box.dart';
import '../../../../../utils/constants/colors.dart';

class ShipmentItem extends StatelessWidget {
  final String shipmentName;
  final String shipmentNumber;
  final String? courierEarnings;
  final String senderCity;
  final String shipmentDate;
  final String recipientCity;
  final String estimatedDate;
  final void Function()? onTap;

  const ShipmentItem({
    required this.shipmentName,
    required this.shipmentNumber,
    required this.senderCity,
    required this.shipmentDate,
    required this.recipientCity,
    required this.estimatedDate,
    this.onTap, this.courierEarnings,
  });

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
                height: 12.h,
                width: 12.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.sp),
                  image: DecorationImage(
                    image: AssetImage('assets/images/normal.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 2.h, right: 3.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        shipmentName,
                        style: CustomTextStyle.headlineTextStyle.apply(
                          fontSizeFactor: 0.7,
                          fontWeightDelta: 2,
                        ),
                      ),
                    ),
                    CustomSizedBox.textSpacingVertical(),
                    Text(
                      shipmentNumber,
                      style: CustomTextStyle.greyTextStyle,
                    ),
                    CustomSizedBox.textSpacingVertical(),
                    FittedBox(
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Image(
                                image: AssetImage(
                                    'assets/images/Subtract (1).png'),
                                height: 5.h,
                                width: 5.w,
                              ),
                              SizedBox(width: 2.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    senderCity,
                                    style: CustomTextStyle.headlineTextStyle
                                        .apply(fontSizeFactor: 0.6),
                                  ),
                                  Text(
                                    shipmentDate.split(' ')[0],
                                    style: CustomTextStyle.greyTextStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Row(
                            children: [
                              Image(
                                image: AssetImage(
                                    'assets/images/Subtract (2).png'),
                                height: 5.h,
                                width: 5.w,
                              ),
                              SizedBox(width: 2.w),
                              FittedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      recipientCity,
                                      style: CustomTextStyle.headlineTextStyle
                                          .apply(fontSizeFactor: 0.6),
                                    ),
                                    Text(
                                      estimatedDate.split(' ')[0],
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
                    SizedBox(
                      height: 2.h,
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                          Text(
                            'إيرادك :',
                            style: CustomTextStyle.primaryTextStyle
                                .apply(color: TColors.black),
                          ),
                          SizedBox(width: 26.w,),
                          Text(
                            courierEarnings??'',
                            style: CustomTextStyle.primaryTextStyle
                                .apply(fontSizeFactor: 1.3),
                            textDirection: TextDirection.ltr,
                          ),
                        ],
                      ),
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
