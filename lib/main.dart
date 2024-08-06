import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:courir_shipment_app/features/auth/screen/id_upload_screen.dart';
import 'package:courir_shipment_app/features/auth/screen/personal_info_screen.dart';
import 'package:courir_shipment_app/features/auth/screen/vehicle_info_screen.dart';
import 'package:courir_shipment_app/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:courir_shipment_app/features/onboarding/screen/onboarding_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/integration/crud.dart';
import 'core/services/InternetController.dart';
import 'features/auth/controller/is_block_controller.dart';
import 'features/auth/screen/add_delivery_areas_screen.dart';
import 'features/auth/screen/block_screen.dart';
import 'features/auth/screen/login_screen.dart';
import 'features/onboarding/controller/onboarding_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'features/onboarding/screen/splash_screen.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await AwesomeNotifications().initialize(
      'resource://drawable/ic_stat_icon',
      [
        NotificationChannel(
            channelKey: 'alerts',
            channelName: 'Alerts',
            channelDescription: 'Notification tests as alerts',
            playSound: true,
            onlyAlertOnce: true,
            groupAlertBehavior: GroupAlertBehavior.Children,
            importance: NotificationImportance.High,
            defaultPrivacy: NotificationPrivacy.Private,
            defaultColor: Colors.green,
            ledColor: Colors.green)
      ],
      debug: true);

  NotificationSettings settings =
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: true,
    criticalAlert: true,
    provisional: true,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((message) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'alerts',
        title: message.notification!.title!,
        body: message.notification!.body!,
      ),
    );
  });

  final prefs = await SharedPreferences.getInstance();
  Get.put(Crud());
  Get.put(OnBoardingController());
  final InternetController internetController = Get.put(InternetController());
  final BlockStatusController blockStatusController = Get.put(BlockStatusController());
  runApp(MyApp(prefs: prefs, blockStatusController: blockStatusController, internetController: internetController));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  final BlockStatusController blockStatusController;
  final InternetController internetController;

  const MyApp({Key? key, required this.prefs, required this.blockStatusController, required this.internetController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    internetController.checkConnection();
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home:  MyCustomSplashScreen(),
        );
      },
    );
  }
}

