import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:weather_app/features/home/controller/home_controller.dart';

class TopBar extends StatelessWidget {
  final HomeController controller;
  const TopBar({super.key, required this.controller, });

  @override
  Widget build(BuildContext context) {
    return  Row(
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
        )
       ;
  }
}