import 'package:courir_shipment_app/common/styles/custom_textstyle.dart';
import 'package:courir_shipment_app/common/widgets/app_bar.dart';
import 'package:courir_shipment_app/features/accounts/screens/income_distribution_screen.dart';
import 'package:courir_shipment_app/features/accounts/screens/paying_my_dues_screen.dart';
import 'package:courir_shipment_app/features/accounts/screens/widgets/account_widgets/account_buttons.dart';
import 'package:courir_shipment_app/features/accounts/screens/widgets/account_widgets/account_data_table.dart';
import 'package:courir_shipment_app/features/accounts/screens/widgets/account_widgets/account_summary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
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
          child: FutureBuilder(
            future: controller.fetchEarnings4Days(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        TImages.loading,
                        height: 20.h,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'جاري تحميل الحسابات',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: TColors.darkGrey,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        TImages.no_connection,
                        height: 20.h,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'يبدو أننا نواجه خطأ فني. يرجى المحاولة لاحقًا.',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: TColors.darkGrey,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
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
                      total: double.parse(controller.earnings4DaysResponse.value.totalAdminIncome),
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
            },
          ),
        ),
      ),
    );
  }
}
