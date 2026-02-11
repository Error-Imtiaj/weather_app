import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:weather_app/features/home/ui/screens/home_page.dart';
import 'package:weather_app/init_bindings.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          initialBinding: InitBindings(),
          debugShowCheckedModeBanner: false,
          title: 'Weather App',
         // theme: ThemeData(primarySwatch: Colors.blue),
          home: child,
        );
      },
      child: HomePage(),
    );
  }
}
