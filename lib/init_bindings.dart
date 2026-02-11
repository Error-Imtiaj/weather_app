import 'package:get/get.dart';
import 'package:weather_app/features/home/controller/home_controller.dart';

class InitBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(HomeController());
  }
}
