import 'package:courir_shipment_app/features/home/screens/qrsearch_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../../common/widgets/serch_text_field.dart';
import '../../../../utils/constants/colors.dart';
import '../../../common/styles/custom_textstyle.dart';
import '../../../common/widgets/app_bar.dart';
import '../../../common/widgets/custom_sized_box.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FocusNode focusNode = FocusNode();
    final TextEditingController searchController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNode.requestFocus();
    });

    return Scaffold(
      backgroundColor: TColors.bg,
      appBar: TAppBar(
        title: 'نتائج البحث',
        showBackArrow: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    TSearchFormField(
                      iscearch: true,
                      hintText: 'ابحث عن الشحنة',
                      controller: searchController,
                      focusNode: focusNode,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          // controller.searchShipment(value);
                        }
                      },
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    CircularContainer(
                      onTap: (){
                        Get.to(BarcodeSearchScreen());
                      },
                      icon: Icons.qr_code_scanner,
                      color: TColors.primary,
                    ),
                  ],
                ),
                      Column(
                      children: [
                        Center(
                          child: Image(
                            image: AssetImage(
                                "assets/gifs/sammy-line-sailor-on-mast-looking-through-telescope.gif"),
                          ),
                        ),
                        CustomSizedBox.itemSpacingVertical(height: 0.5.h),
                        Text(
                          'لا توجد شحنة',
                          style: CustomTextStyle.headlineTextStyle,
                        ),
                        CustomSizedBox.textSpacingVertical(),
                        Text(
                          'حاول البحث عن شحنة أخرى',
                          style: CustomTextStyle.headlineTextStyle.apply(
                              color: TColors.darkGrey, fontWeightDelta: -1),
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
