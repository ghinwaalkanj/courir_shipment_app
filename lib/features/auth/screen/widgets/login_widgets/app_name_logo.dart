import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppNameLogo extends StatelessWidget {
  const AppNameLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 31.h,
      right: 10.w,
      child: Image(
        height: 5.h,
        image: AssetImage(
          "assets/images/kwickly.png",
        ),
      ),
    );
  }
}
