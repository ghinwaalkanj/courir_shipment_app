import 'package:courir_shipment_app/features/home/screens/widgets/active_shipment_button.dart';
import 'package:courir_shipment_app/features/home/screens/widgets/app_bar.dart';
import 'package:courir_shipment_app/features/home/screens/widgets/search_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../utils/constants/colors.dart';
import '../../shipments/screens/active_shipments_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.bg,
      appBar: HomeAppBar(
        title: Text(
          'الموقع الحالي',
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
                height: 55.h,
                child: FutureBuilder(
                  future: _initializeMap(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error loading map'));
                    } else {
                      return GoogleMap(
                        zoomControlsEnabled: false,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(37.7749, -122.4194),
                          zoom: 12,
                        ),
                      );
                    }
                  },
                ),
              ),
              ActiveShipmentsButton(
                onPressed: () {
                  Get.to(ActiveShipmentsScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _initializeMap() async {
    await Future.delayed(Duration(seconds: 1));
  }
}
