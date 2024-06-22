// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:sizer/sizer.dart';
//
// class FirstPageContent extends StatelessWidget {
//   Future<void> _initializeMap() async {
//     await Future.delayed(Duration(seconds: 1));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.only(
//             bottom: MediaQuery.of(context).viewInsets.bottom,
//             top: 3.h,
//             left: 6.w,
//             right: 6.w,
//           ),
//           child: HeaderWidget(
//             title: 'في الطريق إلى التاجر',
//             subTitle: 'التالي :  استلام الشحنة',
//             currentStep: 1,
//           ),
//         ),
//         SizedBox(
//           height: 3.h,
//         ),
//         SizedBox(
//           height: 55.h,
//           child: FutureBuilder(
//             future: _initializeMap(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError) {
//                 return Center(child: Text('Error loading map'));
//               } else {
//                 return GoogleMap(
//                   zoomControlsEnabled: false,
//                   initialCameraPosition: CameraPosition(
//                     target: LatLng(37.7749, -122.4194),
//                     zoom: 12,
//                   ),
//                 );
//               }
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
