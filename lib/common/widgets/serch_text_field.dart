import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import 'custom_sized_box.dart';

class TSearchFormField extends StatelessWidget {
  const TSearchFormField({
    super.key,
    required this.hintText,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
    this.onTap,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.iscearch = false,
    this.focusNode,
  });

  final String hintText;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final bool? iscearch;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 78.w,
        height: 5.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 2.w,
            ),
            CustomSizedBox.itemSpacingHorizontal(),
            Expanded(
              child: TextFormField(
                keyboardType: iscearch! ? TextInputType.number : TextInputType.name,
                onChanged: onChanged,
                onFieldSubmitted: onSubmitted,
                controller: controller,
                focusNode: focusNode,
                decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: TColors.darkGrey.withOpacity(0.7),
                    fontFamily: 'Cairo',
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 1.35.h),
                ),
                style: TextStyle(
                  color: TColors.darkGrey,
                  fontFamily: 'Cairo',
                  fontSize: 11.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
