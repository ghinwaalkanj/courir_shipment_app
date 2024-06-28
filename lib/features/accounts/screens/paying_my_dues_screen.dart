import 'package:courir_shipment_app/features/accounts/screens/widgets/pay_dues_widgets/contact_card.dart';
import 'package:courir_shipment_app/features/accounts/screens/widgets/pay_dues_widgets/dues_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../common/styles/custom_textstyle.dart';
import '../../../common/widgets/app_bar.dart';
import '../../../utils/constants/colors.dart';
import '../controller/get_earnings_4_days_controller.dart';
import '../controller/contact_info_controller.dart'; // Add this line
import '../models/contact_info_model.dart'; // Add this line

class PayDuesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Earnings4DaysController earningsController = Get.put(Earnings4DaysController());
    final ContactInfoController contactController = Get.put(ContactInfoController()); // Add this line

    return Scaffold(
      backgroundColor: TColors.bg,
      appBar: TAppBar(
        title: 'دفع مستحقاتي',
        showBackArrow: true,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(4.w, 4.h, 4.w, 4.h),
        child: Obx(() {
          if (earningsController.isLoading.value || contactController.isLoading.value) { // Add contactController loading
            return Center(child: CircularProgressIndicator(color: TColors.primary));
          } else {
            double totalIncome = earningsController.earnings4DaysResponse.value.totalAdminIncome.toDouble();
            double maxEarningsLimit = double.parse(earningsController.earnings4DaysResponse.value.maxEarningsLimit);

            double percentage = maxEarningsLimit > 0 ? (totalIncome / maxEarningsLimit).clamp(0, 1) * 100 : 0;

            return Column(
              children: [
                DuesCard(
                  duesAmount: totalIncome.toStringAsFixed(0),
                  percentage: percentage.toPrecision(0),
                  requiredAmount: maxEarningsLimit.toStringAsFixed(0),
                ),
                SizedBox(height: 12.h),
                ContactCard(
                  contactInfoList: contactController.contactInfoList, // Pass contactInfoList here
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
