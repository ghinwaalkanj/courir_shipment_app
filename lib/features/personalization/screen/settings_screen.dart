import 'package:courir_shipment_app/common/styles/custom_textstyle.dart';
import 'package:courir_shipment_app/common/widgets/custom_list_tile.dart';
import 'package:courir_shipment_app/features/accounts/screens/accounts_screen.dart';
import 'package:courir_shipment_app/features/accounts/screens/income_distribution_screen.dart';
import 'package:courir_shipment_app/features/auth/screen/add_delivery_areas_screen.dart';
import 'package:courir_shipment_app/features/personalization/screen/privacy_policy_screen.dart';
import 'package:courir_shipment_app/features/personalization/screen/profile_screen.dart';
import 'package:courir_shipment_app/features/personalization/screen/truck_info_screen.dart';
import 'package:courir_shipment_app/features/personalization/screen/widgets/section_title.dart';
import 'package:courir_shipment_app/features/personalization/screen/widgets/settings_widgets/setting_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import '../../../common/widgets/app_bar.dart';
import '../../../common/widgets/custom_sized_box.dart';
import '../../../utils/constants/colors.dart';
import 'about_screen.dart';
import 'add_delivery_cities_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: 'الإعدادات',
        showBackArrow: false,
      ),
      backgroundColor: TColors.bg,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.only(top: 0, left: 4.w, right: 4.w, bottom: 5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(title: 'الحساب'),
                CustomSettingsSection(
                  children: [
                    CustomListTile(
                      title: 'المعلومات الشخصية',
                      icon: Iconsax.profile_circle,
                      onTap: () {
                        Get.to(() => ProfileScreen());
                      },
                    ),
                    CustomListTile(
                      title: 'مناطق التوصيل',
                      icon: Iconsax.map,
                      onTap: () {
                        Get.to(() => AddDeliveryCitiesScreen());
                      },
                    ),
                    CustomListTile(
                      title: 'معلومات المركبة',
                      icon: Iconsax.truck,
                      onTap: () {
                        Get.to(() => TruckInfoScreen());
                      },
                    ),
                  ],
                ),
                CustomSizedBox.itemSpacingVertical(),
                const SectionTitle(title: 'الحسابات و المعاملات'),
                CustomSettingsSection(children: [
                  CustomListTile(
                    title: 'الحسابات',
                    icon: Icons.bar_chart_sharp,
                    onTap: () {
                      Get.to(AccountsScreen());
                    },
                  ),
                  CustomListTile(
                    title: 'توزيع الدخل',
                    icon: Icons.bar_chart_sharp,
                    onTap: () {
                      Get.to(IncomeDistributionScreen());
                    },
                  ),
                ]),
                CustomSizedBox.itemSpacingVertical(),
                const SectionTitle(title: 'معلومات عامة'),
                CustomSettingsSection(
                  children: [
                    CustomListTile(
                      title: 'حول التطبيق',
                      icon: Icons.info_outline_rounded,
                      onTap: () {
                        Get.to(AboutAppScreen());
                      },
                    ),
                    CustomListTile(
                      title: 'سياسة الخصوصية',
                      icon: Icons.privacy_tip_outlined,
                      onTap: () {
                        Get.to(PrivacyPolicyScreen());
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
