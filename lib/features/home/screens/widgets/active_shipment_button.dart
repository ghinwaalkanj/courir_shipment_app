import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/constants/colors.dart';

class ActiveShipmentsButton extends StatelessWidget {
  const ActiveShipmentsButton({
    super.key, this.onPressed,
  });
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 1.5.h, left: 5.w, right: 5.w, bottom: 2.h),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: TColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          minimumSize: Size(100.w, 7.h),

        ),
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            'الشحنات النشطة (1)',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 12.sp,
              color: TColors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
