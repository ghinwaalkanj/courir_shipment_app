import 'package:courir_shipment_app/features/personalization/screen/add_delivery_cities_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../common/styles/custom_textstyle.dart';
import '../../../../utils/constants/colors.dart';
import '../../controller/home_controller.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
    this.title,
    this.showBackArrow = false,
    this.leadingIcon,
    this.actions,
    this.leadingOnPressed,
    this.onTap,
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final VoidCallback? onTap;

  @override
  _HomeAppBarState createState() => _HomeAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(25.h);
}

class _HomeAppBarState extends State<HomeAppBar> {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.sp),
        child: Container(
          height: 17.h,
          decoration: BoxDecoration(
            color: TColors.white,
          ),
          child: Stack(
            children: [
              AppBar(
                automaticallyImplyLeading: false,
                title: Padding(
                  padding: EdgeInsets.only(right: 2.5.w, left: 2.5.w, top: 2.5.h),
                  child: widget.title,
                ),
                leading: widget.showBackArrow
                    ? IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: widget.leadingOnPressed,
                )
                    : null,
                actions: widget.actions != null
                    ? widget.actions!
                    .map((action) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: action,
                ))
                    .toList()
                    : null,
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
              Positioned(
                bottom: 2.5.h,
                right: 7.w,
                child: GestureDetector(
                  onTap: () {
                    Get.to(AddDeliveryCitiesScreen());
                  },
                  child: Row(
                    children: [
                      Obx(() => Text(
                        '${controller.cityNum.value}  محافظة ',
                        style: CustomTextStyle.headlineTextStyle,
                        textDirection: TextDirection.rtl,
                      )),
                      SizedBox(width: 2.w),
                      Icon(Icons.keyboard_arrow_down_rounded),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 1.8.h,
                left: 7.w,
                child: Obx(() => Row(
                  children: [
                    Text(
                      controller.isOnline.value ? 'متصل' : 'غير متصل',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 10.sp,
                        color: TColors.grey,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Switch(
                      value: controller.isOnline.value,
                      onChanged: (value) {
                        controller.toggleOnlineStatus(value);
                      },
                      activeColor: TColors.primary,
                    ),
                  ],
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
