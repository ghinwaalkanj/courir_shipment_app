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
        child: DataTable(
          columnSpacing: 12.w,
          dataRowHeight: 8.h,
          headingRowHeight: 6.h,
          columns: [
            DataColumn(
              label: Expanded(
                child: Center(
                  child: Text(
                    'اليوم',
                    style: CustomTextStyle.primaryTextStyle
                        .apply(fontSizeFactor: 1.1),
                  ),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Center(
                  child: Text(
                    'إيرادتي',
                    style: CustomTextStyle.primaryTextStyle
                        .apply(fontSizeFactor: 1.1),
                  ),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Center(
                  child: Text(
                    'مستحقاتي',
                    style: CustomTextStyle.primaryTextStyle
                        .apply(fontSizeFactor: 1.1),
                  ),
                ),
              ),
            ),
          ],
          rows: data.map((item) {
            return DataRow(cells: [
              DataCell(
                Center(
                  child: Text(
                    item['date']!,
                    style: CustomTextStyle.primaryTextStyle.apply(
                        color: TColors.darkerGrey, fontSizeFactor: 1.1),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              DataCell(
                Center(
                  child: Text(
                    item['revenue']!,
                    style: CustomTextStyle.primaryTextStyle.apply(
                        color: TColors.darkerGrey, fontSizeFactor: 1.1),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              DataCell(
                Center(
                  child: Text(
                    item['dues']!,
                    style: CustomTextStyle.primaryTextStyle.apply(
                        color: TColors.darkerGrey, fontSizeFactor: 1.1),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}
