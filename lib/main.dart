import 'package:courir_shipment_app/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:courir_shipment_app/features/onboarding/screen/onboarding_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/integration/crud.dart';
import 'core/services/InternetController.dart';
import 'features/auth/controller/is_block_controller.dart';
import 'features/auth/screen/block_screen.dart';
import 'features/auth/screen/login_screen.dart';
import 'features/onboarding/controller/onboarding_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
          home: Obx(() {
            if (blockStatusController.isLoading.value) {
              return Scaffold(body:Center(child: CircularProgressIndicator()),);
            } else if (blockStatusController.isBlocked.value) {
              return BlockedScreen();
            } else if (prefs.getBool('isAuth') == true) {
              return NavigationMenu();
            } else {
              return prefs.getBool('isFirstTime') == false ? LoginScreen() : OnBoardingScreen();
            }
          }),
        );
      },
    );
  }
}
