import 'package:get/get.dart';
import 'package:weather_app/features/home/ui/screens/home_page.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.off(() => HomePage()); // removes splash from stack
  }
}