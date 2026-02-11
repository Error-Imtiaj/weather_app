import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:weather_app/features/home/controller/home_controller.dart';
import 'package:weather_app/features/home/ui/widgets/small_card.dart';

class BlackSection extends StatelessWidget {
  final HomeController controller;
  const BlackSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return   Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Obx(
                () => SmallCard(
                  title: "${controller.windSpeed.value} km/h",
                  subtext: "wind",
                  iconData: Icons.wind_power_outlined,
                ),
              ),

              Obx(
                () => SmallCard(
                  title: "${controller.humidity.value}%",
                  subtext: "humidity",
                  iconData: Icons.water_drop_outlined,
                ),
              ),

              Obx(
                () => SmallCard(
                  title: "${controller.visibility.value} km",
                  subtext: "visibility",
                  iconData: Icons.remove_red_eye_outlined,
                ),
              ),
            ],
          ),
        );
      
  }
}