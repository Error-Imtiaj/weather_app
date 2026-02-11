import 'package:get/get.dart';
import 'package:weather_app/core/services/location_service.dart';
import 'package:weather_app/core/services/weather_service.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;

  // Current weather
  RxString city = "".obs;
  RxString subLocality = "".obs;
  RxDouble temp = 0.0.obs;
  RxDouble farenheight = 0.0.obs;
  RxString condition = "".obs;
  RxString description = "".obs;

  RxInt humidity = 0.obs;
  RxDouble windSpeed = 0.0.obs;
  RxInt visibility = 0.obs;

  // Date
  RxString currentDate = "".obs;
  RxBool isFarenheight = false.obs;

  // Daily forecast (5 days)
  RxList<DailyForecast> dailyForecasts = <DailyForecast>[].obs;

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true; // 👈 start loading immediately
    fetchWeatherByLocation();
  }

  Future<void> fetchWeatherByLocation() async {
    try {
      isLoading.value = true;

      final position = await LocationService.getCurrentLocation();
      // --- NEW: Get City from Geocoding Service instead of API ---
      final cityName = await LocationService.getCityFromCoords(
        position.latitude,
        position.longitude,
      );
      city.value = cityName;

      /// CURRENT WEATHER
      final current = await WeatherService.getCurrentWeather(
        lat: position.latitude,
        lon: position.longitude,
      );
      print(cityName);

      //  city.value = current["name"];
      temp.value = current["main"]["temp"].toDouble();
      farenheight.value = getTemperatureInFarenheight(temp.value);
      condition.value = current["weather"][0]["main"];
      description.value = current["weather"][0]["description"];

      humidity.value = current["main"]["humidity"];
      windSpeed.value = current["wind"]["speed"].toDouble();
      visibility.value = (current["visibility"] / 1000).round();

      currentDate.value = DateFormat("dd, MMMM, yyyy").format(DateTime.now());

      /// FORECAST
      final forecast = await WeatherService.getForecast(
        lat: position.latitude,
        lon: position.longitude,
      );

      _processForecast(forecast["list"]);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  double getTemperatureInFarenheight(double celsius) {
    return (celsius * 9 / 5) + 32;
  }

  /// Group 3-hour forecast into daily data
  void _processForecast(List list) {
    final Map<String, List> grouped = {};

    for (var item in list) {
      final date = DateFormat(
        "yyyy-MM-dd",
      ).format(DateTime.parse(item["dt_txt"]));
      grouped.putIfAbsent(date, () => []).add(item);
    }

    dailyForecasts.value = grouped.entries.take(5).map((entry) {
      final temps = entry.value
          .map((e) => e["main"]["temp"].toDouble())
          .toList();

      return DailyForecast(
        date: DateFormat("dd MMM").format(DateTime.parse(entry.key)),
        temp: temps.reduce((a, b) => a + b) / temps.length,
        icon: entry.value.first["weather"][0]["main"],
      );
    }).toList();
  }

  /// Human readable summary
  String get dailySummary =>
      "Today will be ${description.value} with a temperature around "
      "${temp.value.round()}°C. Winds at ${windSpeed.value} km/h and "
      "humidity of ${humidity.value}%.";
}

class DailyForecast {
  final String date;
  final double temp;
  final String icon;

  DailyForecast({required this.date, required this.temp, required this.icon});
}
