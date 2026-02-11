import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class WeeklyBox extends StatelessWidget {
  final String degree;
  final IconData iconData;
  final String date;
  const WeeklyBox({super.key, required this.degree, required this.iconData, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 65.w,
      height: 100.h,
      // padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.black, width: 2.w),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // DEGREE
          Text(
           degree,
            style: GoogleFonts.poppins(
              fontSize: 18.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Gap(8.h),
          Icon(iconData, color: Colors.black, size: 24.r),
          Gap(8.h),
          // dATE
          Text(
            date,
            style: GoogleFonts.poppins(
              fontSize: 12.sp,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
