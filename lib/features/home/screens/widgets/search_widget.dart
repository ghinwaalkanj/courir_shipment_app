import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../utils/constants/colors.dart';
import '../qrsearch_screen.dart';
import '../search_screen.dart';

class SearchWidgets extends StatelessWidget {
  const SearchWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        children: [
          TSearchContainer(
            text: "ابحث عن الشحنة",
            onTap: () {
              Get.to(SearchScreen());
            },
          ),
          SizedBox(width: 2.w),
          CircularContainer(
            onTap: () {
              Get.to(BarcodeSearchScreen());
            },
            icon: Icons.qr_code_scanner,
            color: TColors.primary,
          ),
        ],
      ),
    );
  }
}
