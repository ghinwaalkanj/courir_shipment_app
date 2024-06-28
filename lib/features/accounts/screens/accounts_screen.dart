import 'package:courir_shipment_app/common/styles/custom_textstyle.dart';
import 'package:courir_shipment_app/common/widgets/app_bar.dart';
import 'package:courir_shipment_app/features/accounts/screens/income_distribution_screen.dart';
import 'package:courir_shipment_app/features/accounts/screens/paying_my_dues_screen.dart';
import 'package:courir_shipment_app/features/accounts/screens/widgets/account_widgets/account_buttons.dart';
import 'package:courir_shipment_app/features/accounts/screens/widgets/account_widgets/account_data_table.dart';
import 'package:courir_shipment_app/features/accounts/screens/widgets/account_widgets/account_summary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../utils/constants/colors.dart';
import '../controller/get_earnings_4_days_controller.dart';

class AccountsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Earnings4DaysController controller = Get.put(Earnings4DaysController());

    return Scaffold(
      backgroundColor: TColors.bg,
      appBar: TAppBar(title: 'الحسابات'),
      body: Padding(
        padding: EdgeInsets.fromLTRB(8.w, 4.h, 8.w, 3.h),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Obx(() {
            if (controller.isLoading.value) {
              return Center(child: CircularProgressIndicator(color: TColors.primary));
            } else {
              List<Map<String, String>> accountData = controller.earnings4DaysResponse.value.data.map((dayEarnings) {
                return {
                  'date': dayEarnings.date,
                  'revenue': dayEarnings.totalCourierIncome.toString(),
                  'dues': dayEarnings.totalAdminIncome.toString(),
                };
              }).toList();

              return Column(
                children: [
                  AccountDataTable(data: accountData),
                  SizedBox(height: 4.h),
                  AccountSummary(
                    total: controller.earnings4DaysResponse.value.totalCourierIncome.toDouble(),
                  ),
                  Spacer(),
                  AccountButtons(
                    onDistributeIncomePressed: () {
                      Get.to(IncomeDistributionScreen());
                    },
                    onPayPressed: () {
                      Get.to(PayDuesScreen());
                    },
                  ),
                ],
              );
            }
          }),
        ),
      ),
    );
  }
}
