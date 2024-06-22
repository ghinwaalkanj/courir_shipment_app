import 'package:courir_shipment_app/features/accounts/screens/widgets/income_distrubution_widgets/income_detailed_card.dart';
import 'package:courir_shipment_app/features/accounts/screens/widgets/income_distrubution_widgets/income_summary_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../../../common/styles/custom_textstyle.dart';
import '../../../common/widgets/app_bar.dart';
import '../../../utils/constants/colors.dart';

class IncomeDistributionScreen extends StatelessWidget {
  final RxBool isDaily = true.obs;
  final RxBool isDetailVisible = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.bg,
      appBar: TAppBar(
        title: 'توزيع الدخل',
        showBackArrow: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          children: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: Obx(
                () => ToggleButtons(
                  borderColor: TColors.primary,
                  fillColor: TColors.primary.withOpacity(0.1),
                  borderWidth: 2,
                  selectedBorderColor: TColors.primary,
                  selectedColor: TColors.primary,
                  borderRadius: BorderRadius.circular(10.sp),
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                      child:
                          Text('يومي', style: CustomTextStyle.primaryTextStyle),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                      child: Text('أسبوعي',
                          style: CustomTextStyle.primaryTextStyle),
                    ),
                  ],
                  isSelected: [isDaily.value, !isDaily.value],
                  onPressed: (int index) {
                    isDaily.value = index == 0;
                  },
                ),
              ),
            ),
            SizedBox(height: 4.h),
            IncomeSummaryCard(
              isDetailVisible: isDetailVisible,
              summaryText: '( 50,000 SYP ) 2024-5-10',
            ),
            SizedBox(height: 2.h),
            Expanded(
              child: Obx(
                () => isDaily.value
                    ? ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return Obx(
                            () => isDetailVisible.value
                                ? IncomeDetailCard(
                                    orderNumber: 'زاهرة جديدة - 87645131',
                                    deliveryTime: '1:13 pm',
                                    deliveryAmount: '12,000',
                                    incomeAmount: '10,000',
                                  )
                                : SizedBox.shrink(),
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          'الدخل الأسبوعي',
                          style: CustomTextStyle.primaryTextStyle.apply(
                              fontSizeFactor: 1.5, color: TColors.primary),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
