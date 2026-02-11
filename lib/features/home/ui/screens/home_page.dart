import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:weather_app/features/home/controller/home_controller.dart';
import 'package:weather_app/features/home/ui/screens/home_page_shimmer.dart';
import 'package:weather_app/features/home/ui/widgets/black_section.dart';
import 'package:weather_app/features/home/ui/widgets/daily_summary.dart';
import 'package:weather_app/features/home/ui/widgets/top_bar.dart';
import 'package:weather_app/features/home/ui/widgets/weekly_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final HomeController controller = Get.put(HomeController());

  late AnimationController _pageAnimController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();

    _pageAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fadeAnim = CurvedAnimation(
      parent: _pageAnimController,
      curve: Curves.easeOut,
    );

    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _pageAnimController,
        curve: Curves.easeOut,
      ),
    );

    _pageAnimController.forward();
  }

  @override
  void dispose() {
    _pageAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(179, 255, 255, 255),
      body: SafeArea(
        child: RefreshIndicator.adaptive(
          onRefresh: () async {
            _pageAnimController.reset();
            await controller.fetchWeatherByLocation();
            _pageAnimController.forward();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.w),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const HomeShimmer();
                }
                return FadeTransition(
                  opacity: _fadeAnim,
                  child: SlideTransition(
                    position: _slideAnim,
                    child: _mainBody(),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Column _mainBody() {
    return Column(
      children: [
        /// TOP BAR
        TopBar(controller: controller),
        Gap(20.h),

        /// DATE
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

        /// CONDITION
        Obx(
          () => Text(
            controller.condition.value,
            style: GoogleFonts.poppins(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        /// TEMPERATURE (ANIMATED)
        Obx(
          () => AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (child, animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: Text(
              controller.isFarenheight.value
                  ? "${controller.temp.value.toStringAsFixed(1)}°"
                  : "${controller.farenheight.value.toStringAsFixed(1)}°",
              key: ValueKey(controller.isFarenheight.value),
              style: GoogleFonts.lexend(fontSize: 110.sp),
            ),
          ),
        ),

        /// DAILY SUMMARY (FADE + SLIDE)
        AnimatedOpacity(
          opacity: 1,
          duration: const Duration(milliseconds: 600),
          child: AnimatedSlide(
            offset: Offset.zero,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOut,
            child: DailySummary(controller: controller),
          ),
        ),
        Gap(16),

        /// BLACK INFO CARD
        AnimatedOpacity(
          opacity: 1,
          duration: const Duration(milliseconds: 700),
          child: AnimatedSlide(
            offset: Offset.zero,
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeOut,
            child: BlackSection(controller: controller),
          ),
        ),
        Gap(16),

        /// WEEKLY FORECAST HEADER
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

        /// WEEKLY FORECAST LIST (ANIMATED)
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Obx(
            () => Row(
              children: controller.dailyForecasts.map((day) {
                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: Opacity(
                        opacity: value,
                        child: child,
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 12.w),
                    child: WeeklyBox(
                      degree: !controller.isFarenheight.value
                          ? "${controller.getTemperatureInFarenheight(day.temp).round()}°"
                          : "${day.temp.round()}°",
                      iconData: _mapIcon(day.icon),
                      date: day.date,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        Gap(30.h),
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