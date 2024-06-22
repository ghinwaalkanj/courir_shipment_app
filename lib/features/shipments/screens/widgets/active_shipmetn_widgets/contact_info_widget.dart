import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../../common/styles/custom_textstyle.dart';
import '../../../../../utils/constants/colors.dart';

class ContactInfoWidget extends StatelessWidget {
  const ContactInfoWidget({
    super.key, required this.name, required this.phoneNumber,
  });
  final String name;
  final String phoneNumber;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10.h,
      child: Container(
        margin: EdgeInsets.only(left: 5.w, right: 5.w),
        height: 15.h,
        width: 90.w,
        decoration: BoxDecoration(
          color: TColors.white,
          borderRadius: BorderRadius.circular(10.sp),
          boxShadow: [
            BoxShadow(
              color: TColors.darkGrey.withOpacity(0.4),
              spreadRadius: 5,
              blurRadius: 12,
              offset:
              Offset(5, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(
              left: 5.w, top: 1.5.h, right: 5.w, bottom: 1.5.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    name,
                    style: CustomTextStyle.headlineTextStyle
                        .apply(
                        color: TColors.primary,
                        fontSizeFactor: 0.9),
                  ),
                  SizedBox(width: 2.w),
                  Image(
                    height: 5.h,
                    width: 7.w,
                    image: AssetImage(
                      'assets/images/Group (2).png',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              Row(
                children: [
                  GestureDetector(
                    child: Container(
                      height: 5.5.h,
                      width: 13.w,
                      decoration: BoxDecoration(
                        color: TColors.primary,
                        borderRadius:
                        BorderRadius.circular(10.sp),
                      ),
                      child: Icon(
                        Icons.phone_outlined,
                        color: TColors.white,
                        size: 25.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Container(
                    width: 65.w,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                          color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        phoneNumber,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
