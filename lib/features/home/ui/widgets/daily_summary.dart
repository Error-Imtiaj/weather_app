import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/features/home/controller/home_controller.dart';

class DailySummary extends StatelessWidget {
  final HomeController controller;
  const DailySummary({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return  Column(
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
        );
      
  }
}