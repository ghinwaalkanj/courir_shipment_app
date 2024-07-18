import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/rating_model.dart';

class RatingController extends GetxController {
  final TextEditingController commentController = TextEditingController();
  var rating = 0.0.obs;

  Future<RatingResponse?> submitRating({
    required int shipmentId,
    required int raterId,
    required int rateeId,
    required double rating,
    required String comment,
  }) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://api.wasenahon.com/Kwickly/merchant/shipments/rate_delivery.php')
    );

    request.fields.addAll({
      'shipment_id': shipmentId.toString(),
      'rater_id': raterId.toString(),
      'ratee_id': rateeId.toString(),
      'rating': rating.toString(),
      'comment': comment,
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      print(responseData);
      print(RatingResponse.fromJson(json.decode(responseData)));
      return RatingResponse.fromJson(json.decode(responseData));
    } else {
      print(response.reasonPhrase);
      print(response.statusCode);

      return null;
    }
  }
}
