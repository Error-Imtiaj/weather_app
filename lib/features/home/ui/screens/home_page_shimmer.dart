import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white70, // Warm amber base
      highlightColor: Colors.white, // Soft highlight
      child: Column(
        children: [
          // Top row (Align Horizontally Icon + City/Button)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _circle(40.r),
              Row(
                children: [
                  _rect(width: 80.w, height: 20.h),
                  Gap(20.w),
                  _rect(width: 80.w, height: 35.h, radius: 4.r), // Button
                ],
              ),
            ],
          ),
          Gap(25.h),

          // Date pill
          _rect(width: 160.w, height: 40.h, radius: 20.r),
          Gap(25.h),

          // Condition text
          _rect(width: 100.w, height: 18.h),
          Gap(25.h),

          // Big Temperature Degree
          _rect(width: 180.w, height: 110.h, radius: 12.r),
          Gap(25.h),
          // Daily summary section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _rect(width: 160.w, height: 22.h),
              Gap(15.h),
              _rect(width: double.infinity, height: 14.h),
              Gap(10.h),
              _rect(width: double.infinity, height: 14.h),
            ],
          ),
          Gap(30.h),

          // Info Box (Wind, Humidity, Visibility)
          _rect(width: double.infinity, height: 100.h, radius: 20.r),
          Gap(30.h),

          // Weekly forecast title row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _rect(width: 160.w, height: 22.h),
              _circle(24.r), // East Icon
            ],
          ),
          Gap(30.h),

          // Weekly forecast horizontal list
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(4, (index) => Padding(
                padding: EdgeInsets.only(right: 15.w),
                child: _rect(width: 80.w, height: 100.h, radius: 18.r),
              )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _rect({double? width, double? height, double radius = 8}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  Widget _circle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}