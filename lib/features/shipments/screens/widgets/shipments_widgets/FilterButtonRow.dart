import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import '../../../../../utils/constants/colors.dart';
import 'filter_button.dart';

class FilterButtonRow extends StatelessWidget {
  final int selectedFilterIndex;
  final Function(int) onTap;

  FilterButtonRow({
    required this.selectedFilterIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            CustomFilterButton(
              icon: Iconsax.box,
              label: 'بانتظار قبولها',
              index: 0,
              selectedFilterIndex: selectedFilterIndex,
              onTap: onTap,
            ),
            CustomFilterButton(
              icon: Iconsax.box_time4,
              label: 'قيد التوصيل',
              index: 1,
              selectedFilterIndex: selectedFilterIndex,
              onTap: onTap,
            ),
            CustomFilterButton(
              icon: Iconsax.box_tick,
              label: 'المكتملة',
              index: 2,
              selectedFilterIndex: selectedFilterIndex,
              onTap: onTap,
            ),
            CustomFilterButton(
              icon: Iconsax.box_tick,
              label: 'الملغية',
              index: 3,
              selectedFilterIndex: selectedFilterIndex,
              onTap: onTap,
            ),
            CustomFilterButton(
              icon: Iconsax.box_remove,
              label: 'الراجعة',
              index: 4,
              selectedFilterIndex: selectedFilterIndex,
              onTap: onTap,
            ),
          ],
        ),
      ),
    );
  }
}
