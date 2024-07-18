import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
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
                    onTap: () => _handleTap('phone',phoneNumber),
                    child: Container(
                      height: 4.9.h,
                      width: 11.w,
                      decoration: BoxDecoration(
                        color: TColors.primary,
                        borderRadius:
                        BorderRadius.circular(10.sp),
                      ),
                      child: Icon(
                        Icons.phone_outlined,
                        color: TColors.white,
                        size: 22.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 2.w),
                  GestureDetector(
                    onTap: () => _handleTap('whatsapp',phoneNumber), // Add this line
                    child: Container(
                      height: 5.h,
                      width: 12.w,
                      decoration: BoxDecoration(
                        color: TColors.primary,
                        borderRadius:
                        BorderRadius.circular(10.sp),
                      ),
                      child:  Center(
                        child: FaIcon(
                          FontAwesomeIcons.whatsapp,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Container(
                    width: 52.w,
                    padding: EdgeInsets.fromLTRB(2.w, 1.h, 2.w, 1.h),
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

  void _handleTap(String type, String detail) async {
    if (type == 'phone') {
      final Uri launchUri = Uri(
        scheme: 'tel',
        path: detail,
      );
      await launchUrl(launchUri);
    } else if (type == 'whatsapp') {
      final Uri launchUri = Uri(
        scheme: 'https',
        host: 'wa.me',
        path: detail,
      );
      await launchUrl(launchUri);
    }
  }
}