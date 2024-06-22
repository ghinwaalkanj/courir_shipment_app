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

class AccountsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> accountData = [
      {'date': '5/10/2024', 'revenue': '50,000', 'dues': '10,000'},
      {'date': '6/10/2024', 'revenue': '58,000', 'dues': '12,000'},
      {'date': '7/10/2024', 'revenue': '40,000', 'dues': '5,000'},
      {'date': '8/10/2024', 'revenue': '62,000', 'dues': '15,000'},
    ];
    return Scaffold(
      backgroundColor: TColors.bg,
      appBar: TAppBar(title: 'الحسابات'),
      body: Padding(
        padding: EdgeInsets.fromLTRB(8.w, 4.h, 8.w, 3.h),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              AccountDataTable(data: accountData),
              SizedBox(height: 4.h),
              AccountSummary(
                total: 42.000,
              ),
              SizedBox(height: 8.h),
              AccountButtons(
                onDistributeIncomePressed: () {
                  Get.to(IncomeDistributionScreen());
                },
                onPayPressed: () {
                  Get.to(PayDuesScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
