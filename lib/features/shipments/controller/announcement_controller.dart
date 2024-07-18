import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/Announcement_response_model.dart';

class AnnouncementController extends GetxController {
  final TextEditingController announcementTextController = TextEditingController();

  Future<AnnouncementResponse?> submitAnnouncement({
    required int shipmentId,
    required int deliveryId,
    required String announcementText,
  }) async {
    var request = http.MultipartRequest('POST', Uri.parse('https://api.wasenahon.com/Kwickly/delivery/shipments/add_announcements.php'));
    request.fields.addAll({
      'shipment_id': shipmentId.toString(),
      'delivery_id': deliveryId.toString(),
      'announcements_text': announcementText,
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      return AnnouncementResponse.fromJson(json.decode(responseData));
    } else {
      print(response.reasonPhrase);
      return null;
    }
  }
}
