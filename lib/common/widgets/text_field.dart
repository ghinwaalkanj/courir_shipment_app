import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../utils/constants/colors.dart';

class TTextField extends StatelessWidget {
  final String hintText;
  final Icon? suffixIcon;
  final TextEditingController? controller;
  final Icon? prefixIcon;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final bool showPrefix;
  final bool isPhone;
  final bool isNationalID;
  final String? errorText;

  const TTextField({
    Key? key,
    required this.hintText,
    this.suffixIcon,
    this.controller,
    this.prefixIcon,
    this.keyboardType,
    this.onChanged,
    this.showPrefix = true,
    this.isPhone = false,
    this.isNationalID = false,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 88.w,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 11.sp,
                fontWeight: isPhone || isNationalID ? FontWeight.bold : FontWeight.normal,
                textBaseline: TextBaseline.alphabetic,
              ),
              controller: controller,
              onChanged: (value) {
                if (isNationalID && value.length > 10) {
                  controller?.text = value.substring(0, 10);
                  controller?.selection = TextSelection.fromPosition(
                    TextPosition(offset: controller!.text.length),
                  );
                }
                if (onChanged != null) {
                  onChanged!(controller!.text);
                }
              },
              decoration: InputDecoration(
                hintText: hintText,
                hintTextDirection: TextDirection.rtl,
                hintStyle: TextStyle(
                  fontSize: 9.sp,
                  color: TColors.darkGrey,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Cairo',
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: TColors.primary, width: 2.0),
                  borderRadius: BorderRadius.circular(18.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 2.0),
                  borderRadius: BorderRadius.circular(18.0),
                ),
                suffixIcon: suffixIcon,
                suffixIconColor: TColors.primary,
                prefixIcon: prefixIcon,
                prefixIconColor: TColors.primary,
                suffixText: isPhone ? ' 7 962+ ' : null,
                suffixStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                errorStyle: TextStyle(
                  fontFamily: 'Cairo',
                ),
                helperStyle: TextStyle(
                  fontFamily: 'Cairo',
                ),
                prefixStyle: TextStyle(
                  fontSize: 11.sp,
                  color: Colors.black,
                  fontFamily: 'Cairo',
                ),
              ),
              keyboardType: keyboardType,
              textDirection: isPhone ? TextDirection.ltr : TextDirection.rtl,
              maxLength: isPhone ? 8 : isNationalID ? 10 : null,
              buildCounter: (BuildContext context, {int? currentLength, int? maxLength, bool? isFocused}) => null,
            ),
            if (errorText != null && errorText!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  errorText!,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 9.sp,
                    fontFamily: 'Cairo',
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
