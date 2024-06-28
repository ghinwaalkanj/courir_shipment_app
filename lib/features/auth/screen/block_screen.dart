import 'package:courir_shipment_app/common/styles/custom_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BlockedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/images/photo_2024-06-25_17-35-26.jpg'),
            ),
            SizedBox(height: 2.h,),
            Text('تم حظرك من استخدام التطبيق',style: CustomTextStyle.primaryTextStyle,),
          ],
        ),
      ),
    );
  }
}
