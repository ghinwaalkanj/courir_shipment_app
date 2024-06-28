import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/constants/colors.dart';

class ActiveShipmentsButton extends StatelessWidget {
  final void Function()? onPressed;
  final int count;

  const ActiveShipmentsButton({
    super.key,
    required this.count,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.5.h, left: 5.w, right: 5.w, bottom: 2.h),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: count > 0 ? TColors.primary : TColors.darkerGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          minimumSize: Size(100.w, 7.h),
        ),
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            'الشحنات النشطة ($count)',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 12.sp,
              color:count>0? TColors.white:TColors.darkerGrey,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
