import 'package:courir_shipment_app/features/home/screens/home_screen.dart';
import 'package:courir_shipment_app/features/home/screens/search_screen.dart';
import 'package:courir_shipment_app/features/personalization/screen/settings_screen.dart';
import 'package:courir_shipment_app/features/shipments/screens/my_shipments_screen.dart';
import 'package:courir_shipment_app/features/shipments/screens/new_shipments_screen.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'features/accounts/screens/accounts_screen.dart';

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 2.obs;
  final screens = [
    SettingsScreen(),
    NewShipmentsScreen(),
    HomeScreen(),
    MyShipmentsScreen(),
    AccountsScreen(),
  ];
  final outlineIcons = [
    Iconsax.setting,
    Iconsax.shopping_cart,
    Iconsax.home_24,
    Iconsax.truck_fast,
    Iconsax.chart,
  ];
  List bottomnavigationbaritems = [
    'الإعدادات',
    'طلبات جديدة',
    'الرئيسية',
    'شحناتي',
    'الحسابات',
  ];
}
