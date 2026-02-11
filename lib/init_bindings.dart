import 'package:get/get.dart';
import 'package:weather_app/features/home/controller/home_controller.dart';
import 'package:weather_app/features/splash/controller/splash_scontroller.dart';

class InitBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(HomeController());
    Get.put(SplashController());
  }
}
