import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../../common/styles/custom_textstyle.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../models/contact_info_model.dart';
import 'contact_details.dart';

class ContactCard extends StatelessWidget {
  final List<ContactInfo> contactInfoList;

  ContactCard({required this.contactInfoList});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 6.h),
          decoration: BoxDecoration(
            color: TColors.white,
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
          child: Column(
            children: [
              SizedBox(height: 7.h),
              Text(
                'يرجى التواصل مع الإدارة عبر',
                style: CustomTextStyle.primaryTextStyle.apply(fontSizeFactor: 1.4, fontWeightDelta: 4),
              ),
              SizedBox(height: 4.h),
              ...contactInfoList.map((contact) => Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child: ContactDetail(
                  icon: getIconForContactType(contact.type),
                  detail: contact.value,
                  type: contact.type,
                ),
              )),
            ],
          ),
        ),
        Positioned(
          top: -7.h,
          left: 0,
          right: 0,
          child: CircleAvatar(
            radius: 15.w,
            backgroundColor: TColors.primary,
            child: Icon(Icons.headset_mic_outlined, color: TColors.white, size: 18.w),
          ),
        ),
      ],
    );
  }

  IconData getIconForContactType(String type) {
    switch (type) {
      case 'phone':
        return Icons.local_phone_outlined;
      case 'whatsapp':
        return Icons.messenger;
      case 'telegram':
        return Icons.telegram;
      case 'facebook':
        return Icons.facebook;
      case 'website':
        return Icons.web_outlined;
      case 'instagram':
        return Icons.camera_alt_outlined;
      case 'email':
        return Icons.email_outlined;
      default:
        return Icons.contact_page;
    }
  }
}
