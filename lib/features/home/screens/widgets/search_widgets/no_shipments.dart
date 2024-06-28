import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../../common/styles/custom_textstyle.dart';
import '../../../../../utils/constants/colors.dart';

class NoShipmentsWidget extends StatelessWidget {
  const NoShipmentsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child:SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/gifs/sammy-line-sailor-on-mast-looking-through-telescope.gif',
              height: 50.h,
              width: 50.h,
            ),
            SizedBox(height: 2.h),
            Text(
              'لا توجد شحنة',
              style: CustomTextStyle.headlineTextStyle.apply(
                fontSizeFactor: 0.8,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              'حاول البحث عن شحنة أخرى',
              style: CustomTextStyle.headlineTextStyle.apply(
                color: TColors.darkGrey,
                fontWeightDelta: -1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
