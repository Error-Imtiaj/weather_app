import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class SmallCard extends StatelessWidget {
  final String title;
  final String subtext;
  final IconData iconData;
  const SmallCard({super.key, required this.title, required this.subtext, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TIME

        // ICON
        Icon(iconData, color: Colors.yellow, size: 30.r),
        Gap(8.h),

        // DEGREE
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 20.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gap(2),
        Text(
          subtext,
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
