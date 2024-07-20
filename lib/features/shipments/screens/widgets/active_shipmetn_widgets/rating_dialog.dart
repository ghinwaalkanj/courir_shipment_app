import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../../common/styles/custom_textstyle.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../personalization/controller/rating_controller.dart';

class RatingDialog extends StatelessWidget {
  final TextEditingController commentController = TextEditingController();
  final Function(double, String) onSubmit;
  double rating = 0.0;

  RatingDialog({required this.onSubmit});

  void _submit(BuildContext context) {
    if (rating == 0.0 ) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please provide a rating.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      onSubmit(rating, commentController.text);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Directionality(
        textDirection: TextDirection.rtl,
        child: Text(
          'قيم الشحنة',
          style: CustomTextStyle.primaryTextStyle.apply(fontSizeDelta: 5),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (value) {
                rating = value;
              },
            ),
            SizedBox(height: 20),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextField(
                controller: commentController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                  labelText: 'اكتب تعليقا',
                ),
                maxLines: 3,
              ),
            ),
          ],
        ),
      ),
      actions: [
        Container(
          width: 75.w,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: TColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () => _submit(context),
            child: Text(
              'تأكيد',
              style: CustomTextStyle.primaryTextStyle.apply(color: TColors.white, fontSizeDelta: 2.5),
            ),
          ),
        ),
      ],
    );
  }
}
