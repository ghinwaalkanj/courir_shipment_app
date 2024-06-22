import 'package:courir_shipment_app/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:courir_shipment_app/features/onboarding/screen/onboarding_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/integration/crud.dart';
import 'features/auth/screen/login_screen.dart';
import 'features/onboarding/controller/onboarding_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  Get.put(Crud());
  Get.put(OnBoardingController());

  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  const MyApp({Key? key, required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: NavigationMenu(),
          // prefs.getBool('isFirstTime') == false
          //     ? LoginScreen()
          //     : OnBoardingScreen(),
        );
      },
    );
  }
}
