import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/services/storage_service.dart';

class SettingsController extends GetxController {
  var isNotificationsEnabled = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadNotificationPreference();
  }

  void toggleNotifications(bool value) async {
    isNotificationsEnabled.value = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('notificationsEnabled', value);
    if (value) {
      FirebaseMessaging.instance.subscribeToTopic(
          "courier${await SharedPreferencesHelper.getInt('user_id')}");
      FirebaseMessaging.instance.subscribeToTopic("courier");
    } else {
      FirebaseMessaging.instance.unsubscribeFromTopic(
          "courier${await SharedPreferencesHelper.getInt('user_id')}");
      FirebaseMessaging.instance.unsubscribeFromTopic("courier");
    }
  }

  void _loadNotificationPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? notificationsEnabled = prefs.getBool('notificationsEnabled');
    if (notificationsEnabled != null) {
      isNotificationsEnabled.value = notificationsEnabled;
    }
  }
}
