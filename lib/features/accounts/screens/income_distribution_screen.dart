import 'package:courir_shipment_app/features/accounts/screens/widgets/income_distrubution_widgets/income_detailed_card.dart';
import 'package:courir_shipment_app/features/accounts/screens/widgets/income_distrubution_widgets/income_summary_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../../../common/styles/custom_textstyle.dart';
import '../../../common/widgets/app_bar.dart';
import '../../../utils/constants/colors.dart';
import '../controller/daily_income_controller.dart';
import '../controller/weekly_income_controller.dart';

class IncomeDistributionScreen extends StatelessWidget {
  final RxBool isDaily = true.obs;
  final RxBool isDetailVisible = true.obs;

  @override
  Widget build(BuildContext context) {
    final DailyIncomeController dailyController =
        Get.put(DailyIncomeController());
    final WeeklyIncomeController weeklyController =
        Get.put(WeeklyIncomeController());

    return Scaffold(
      backgroundColor: TColors.bg,
      appBar: TAppBar(
        title: 'توزيع الدخل',
        showBackArrow: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 4.w),
        child: Obx(() {
          if (dailyController.isLoading.value ||
              weeklyController.isLoading.value) {
            return Center(
                child: CircularProgressIndicator(color: TColors.primary));
          } else {
            return Column(
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 1.h),
                          child: Text('يومي',
                              style: CustomTextStyle.primaryTextStyle),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 1.h),
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
                isDaily.value
                    ? IncomeSummaryCard(
                        isDetailVisible: isDetailVisible,
                        summaryText:
                            '(${dailyController.dailyIncomeResponse.value.totalIncome} JD) ${dailyController.dailyIncomeResponse.value.date.split(' ')[0]}',
                        isFittedBoxVisible: false,
                      )
                    : IncomeSummaryCard(
                        isDetailVisible: isDetailVisible,
                        summaryText:
                            '(${weeklyController.weeklyIncomeResponse.value.totalIncome} JD) ${weeklyController.weeklyIncomeResponse.value.endDate} <- ${weeklyController.weeklyIncomeResponse.value.startDate}',
                        isFittedBoxVisible: true,
                      ),
                SizedBox(height: 2.h),
                Expanded(
                  child: Obx(
                    () => isDaily.value
                        ? ListView.builder(
                            itemCount: dailyController
                                .dailyIncomeResponse.value.shipments.length,
                            itemBuilder: (context, index) {
                              final shipment = dailyController
                                  .dailyIncomeResponse.value.shipments[index];
                              final acceptedTime =
                                  shipment.acceptedAt.split(' ')[1];
                              return Obx(
                                () => isDetailVisible.value
                                    ? IncomeDetailCard(
                                        orderNumber:
                                            '${shipment.recipientAddress} - ${shipment.shipmentNumber}',
                                        deliveryTime:
                                            acceptedTime.substring(0, 5),
                                        deliveryAmount:
                                            double.parse(shipment.shipmentFee)
                                                .toStringAsFixed(0),
                                        incomeAmount:
                                            double.parse(shipment.courierIncome)
                                                .toStringAsFixed(0),
                                      )
                                    : SizedBox.shrink(),
                              );
                            },
                          )
                        : ListView.builder(
                            itemCount: weeklyController
                                .weeklyIncomeResponse.value.shipments.length,
                            itemBuilder: (context, index) {
                              final shipment = weeklyController
                                  .weeklyIncomeResponse.value.shipments[index];
                              final acceptedTime =
                                  shipment.acceptedAt.split(' ')[1];
                              return Obx(
                                () => isDetailVisible.value
                                    ? IncomeDetailCard(
                                        orderNumber:
                                            '${shipment.recipientAddress} - ${shipment.shipmentNumber}',
                                        deliveryTime:
                                            acceptedTime.substring(0, 5),
                                        deliveryAmount:
                                            double.parse(shipment.shipmentFee)
                                                .toStringAsFixed(0),
                                        incomeAmount:
                                            double.parse(shipment.courierIncome)
                                                .toStringAsFixed(0),
                                      )
                                    : SizedBox.shrink(),
                              );
                            },
                          ),
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
