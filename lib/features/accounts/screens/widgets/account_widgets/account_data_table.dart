import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../../common/styles/custom_textstyle.dart';
import '../../../../../utils/constants/colors.dart';

class AccountDataTable extends StatelessWidget {
  final List<Map<String, String>> data;

  AccountDataTable({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: TColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(15.sp),
        border: Border.all(
          color: TColors.darkerGrey.withOpacity(0.5),
          width: 2.0,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.sp),
        child: Table(
          border: TableBorder(
            horizontalInside: BorderSide(
              color: TColors.darkerGrey.withOpacity(0.5),
              width: 1.0,
            ),
            verticalInside: BorderSide(
              color: TColors.darkerGrey.withOpacity(0.5),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(15.sp),
          ),
          columnWidths: {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(1),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: TColors.white,
              ),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 3.h),
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'اليوم',
                        style: CustomTextStyle.primaryTextStyle
                            .apply(fontSizeFactor: 1.1),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 3.h),
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'إيرادتي',
                        style: CustomTextStyle.primaryTextStyle
                            .apply(fontSizeFactor: 1.1),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 3.h),
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'مستحقاتي',
                        style: CustomTextStyle.primaryTextStyle
                            .apply(fontSizeFactor: 1.1),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ...data.map((item) {
              return TableRow(
                decoration: BoxDecoration(
                  color: TColors.white,
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.h),
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          item['date']!,
                          style: CustomTextStyle.primaryTextStyle.apply(
                              color: TColors.darkerGrey, fontSizeFactor: 1.1),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.h),
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          item['revenue']!,
                          style: CustomTextStyle.primaryTextStyle.apply(
                              color: TColors.darkerGrey, fontSizeFactor: 1.1),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.h),
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          item['dues']!,
                          style: CustomTextStyle.primaryTextStyle.apply(
                              color: TColors.darkerGrey, fontSizeFactor: 1.1),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
