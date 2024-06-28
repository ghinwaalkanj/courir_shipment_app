import 'package:courir_shipment_app/features/home/screens/widgets/active_shipment_button.dart';
import 'package:courir_shipment_app/features/home/screens/widgets/app_bar.dart';
import 'package:courir_shipment_app/features/home/screens/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../utils/constants/colors.dart';
import '../../shipments/screens/active_shipments_screen.dart';
import '../controller/home_controller.dart';
import '../controller/map_controller.dart';
import '../../shipments/controller/my_shipments_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    final MapController mapController = Get.put(MapController());
    final MyShipmentsController myShipmentsController = Get.put(MyShipmentsController());

    return Scaffold(
      backgroundColor: TColors.bg,
      appBar: HomeAppBar(
        title: Text(
          'مناطق التوصيل',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 12.sp,
            color: TColors.grey,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 2.h, left: 5.w, right: 5.w, bottom: 1.h),
                child: const SearchWidgets(),
              ),
              SizedBox(height: 2.h),
              SizedBox(
                height: 53.h,
                child: FutureBuilder(
                  future: mapController.initialize(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return Obx(() {
                        if (homeController.center.value == null) {
                          return Center(child: Text(''));
                        }
                        return GoogleMap(
                          zoomControlsEnabled: false,
                          zoomGesturesEnabled: true,
                          onMapCreated: mapController.onMapCreated,
                          initialCameraPosition: CameraPosition(
                            target: mapController.selectedLocation.value = homeController.center.value!,
                            zoom: 20,
                          ),
                          circles: {
                            Circle(
                              circleId: CircleId('delivery_area'),
                              center: homeController.center.value!,
                              radius: 2000,
                              fillColor: TColors.error.withOpacity(0.3),
                              strokeColor: TColors.error,
                              strokeWidth: 1,
                            ),
                          },
                        );
                      });
                    }
                  },
                ),
              ),
              FutureBuilder(
                future: myShipmentsController.fetchMyShipments(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return Obx(() {
                      int activeShipmentsCount = myShipmentsController.getActiveShipmentsCount();
                      return ActiveShipmentsButton(
                        count: activeShipmentsCount,
                        onPressed: activeShipmentsCount > 0
                            ? () {
                          Get.to(ActiveShipmentsScreen());
                        }
                            : null,
                      );
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
