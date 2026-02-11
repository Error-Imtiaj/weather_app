import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:weather_app/features/home/controller/home_controller.dart';
import 'package:weather_app/features/home/ui/screens/home_page_shimmer.dart';
import 'package:weather_app/features/home/ui/widgets/small_card.dart';
import 'package:weather_app/features/home/ui/widgets/weekly_box.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    controller.fetchWeatherByLocation();
    return Scaffold(
      backgroundColor: Colors.white70,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.w),
          child: SingleChildScrollView(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const HomeShimmer();
              } else {
                return _mainBody();
              }
            }),
          ),
        ),
      ),
    );
  }

  Column _mainBody() {
    return Column(
      children: [
        // PARIS NAME
        // PARIS NAME / HEADER ROW
        Row(
          children: [
            // Leading Menu Icon
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: Icon(
                Iconsax.align_horizontally,
                color: Colors.black,
                size: 32.r, // Slightly adjusted size for better balance
              ),
              onPressed: () {},
            ),

            // Middle City Title - Use Expanded to handle long text
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Obx(
                  () => Text(
                    controller.city.value,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow:
                        TextOverflow.ellipsis, // This handles the long text
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            // Trailing Toggle Button
            ElevatedButton(
              onPressed: () {
                controller.isFarenheight.value =
                    !controller.isFarenheight.value;
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(60.w, 35.h), // Consistent sizing
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                backgroundColor: Colors.black,
                elevation: 0,
              ),
              child: Text(
                !controller.isFarenheight.value ? "C" : "F",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Gap(20.h),

        // FRIDAY
        Container(
          width: 160.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Center(
            child: Obx(
              () => Text(
                controller.currentDate.value,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Gap(8),

        // SUNNY
        Obx(
          () => Text(
            controller.condition.value,
            style: GoogleFonts.poppins(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        //   Gap(8),

        // DEGREE
        Obx(
          () => Text(
            controller.isFarenheight.value
                ? "${controller.temp.value.toStringAsFixed(1)}°"
                : "${controller.farenheight.value.toStringAsFixed(1)}°",
            style: GoogleFonts.lexend(fontSize: 110.sp),
          ),
        ),

        // DAILY SUMMARY
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // title
            Text(
              "Daily Summary",
              style: GoogleFonts.poppins(
                fontSize: 22.sp,
                color: Colors.black,
                fontWeight: FontWeight.w800,
              ),
            ),

            // sub text
            Obx(
              () => Text(
                controller.dailySummary,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        Gap(16),

        // CARD
        Container(
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
        ),
        Gap(16),

        // WEEKLY FORECAST
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Weekly Forecast",
              style: GoogleFonts.poppins(
                fontSize: 22.sp,
                color: Colors.black,
                fontWeight: FontWeight.w800,
              ),
            ),
            Icon(Icons.east, color: Colors.black, weight: 200.r),
          ],
        ),
        Gap(16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Obx(
            () => Row(
              children: controller.dailyForecasts.map((day) {
                return Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: WeeklyBox(
                    degree: !controller.isFarenheight.value
                        ? "${controller.getTemperatureInFarenheight(day.temp).round()}°"
                        : "${day.temp.round()}°",
                    iconData: _mapIcon(day.icon),
                    date: day.date,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  IconData _mapIcon(String condition) {
    switch (condition.toLowerCase()) {
      case "clear":
        return Icons.wb_sunny_outlined;
      case "clouds":
        return Icons.cloud_outlined;
      case "rain":
        return Icons.beach_access_outlined;
      case "snow":
        return Icons.ac_unit;
      default:
        return Icons.wb_cloudy_outlined;
    }
  }
}
