import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../utils/constants/colors.dart';

class QRCodeDisplay extends StatelessWidget {
  final String shipmentNumber;

  const QRCodeDisplay({Key? key, required this.shipmentNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 25.h,
        width: 25.h,
        padding: EdgeInsets.all(1.h),
        decoration: BoxDecoration(
          color: TColors.white,
        ),
        child: QrImageView(
          data: shipmentNumber,
          version: QrVersions.auto,
          size: 20.h,
        ),
      ),
    );
  }
}
