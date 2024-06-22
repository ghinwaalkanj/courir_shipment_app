import 'package:courir_shipment_app/features/accounts/screens/widgets/pay_dues_widgets/contact_card.dart';
import 'package:courir_shipment_app/features/accounts/screens/widgets/pay_dues_widgets/dues_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sizer/sizer.dart';

import '../../../common/styles/custom_textstyle.dart';
import '../../../common/widgets/app_bar.dart';
import '../../../utils/constants/colors.dart';

class PayDuesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.bg,
      appBar: TAppBar(
        title: 'دفع مستحقاتي',
        showBackArrow: true,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(4.w, 4.h, 4.w,4.h),
        child: Column(
          children: [
            DuesCard(
              duesAmount: '42,000',
              percentage: 50,
              requiredAmount: '85,000',
            ),
            SizedBox(height: 12.h),
            ContactCard(
              phoneNumber: '+963 987 136 547',
              website: 'www.shippment.org',
            ),

          ],
        ),
      ),
    );
  }
}



