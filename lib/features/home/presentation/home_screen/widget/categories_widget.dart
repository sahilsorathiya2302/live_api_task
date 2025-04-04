import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:milk_ride_live_wc/core/constants/app_string.dart';
import 'package:milk_ride_live_wc/core/constants/argument_key.dart';
import 'package:milk_ride_live_wc/core/routes/app_routes_names.dart';
import 'package:milk_ride_live_wc/core/theme/app_border_radius.dart';
import 'package:milk_ride_live_wc/core/theme/app_colors.dart';
import 'package:milk_ride_live_wc/core/theme/app_size_box_extension.dart';
import 'package:milk_ride_live_wc/features/home/domain/entities/cetegories.dart';

import '../../../../../core/ui_component/custom_view_button.dart';
import 'main_title_widget.dart';

class CategoriesWidget extends StatefulWidget {
  final int customerId;
  final List<Categories>? state;
  const CategoriesWidget({super.key, required this.customerId, this.state});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainTitleWidget(
          title: AppString.categories,
          onPressed: () {
            Get.toNamed(AppRoutesNames.viewCategories,
                arguments: {ArgumentKey.customerId: widget.customerId});
          },
        ),
        10.height,
        SizedBox(
          height: 130.h,
          child: ListView.builder(
            itemCount: widget.state?.length ?? 0,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final categories = widget.state![index];
              return GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutesNames.categoryProduct, arguments: {
                    ArgumentKey.categoryId: categories.id,
                    ArgumentKey.customerId: widget.customerId
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(left: 15.w),
                  width: 120,
                  decoration: BoxDecoration(
                      color: AppColors.primaryLightColor,
                      borderRadius: BorderRadius.circular(AppBorderRadius.r10)),
                  child: Column(
                    children: [
                      5.height,
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppBorderRadius.r5),
                        child: Image.network(
                          categories.imageUrl ??
                              "https://via.placeholder.com/80",
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Spacer(),
                      CustomViewButton(
                        text: categories.name.toString(),
                      ),
                      10.height,
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
