import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/core/network/network.dart';

class WeatherService {
  static final Dio _dio = DioClient.create();
  static final String apiKey = dotenv.env['OPEN_API']!;

  static Future<Map<String, dynamic>> getCurrentWeather({
    required double lat,
    required double lon,
  }) async {
    final response = await _dio.get(
      "/weather",
      queryParameters: {
        "lat": lat,
        "lon": lon,
        "units": "metric",
        "appid": apiKey,
      },
    );
    return response.data;
  }

  static Future<Map<String, dynamic>> getForecast({
    required double lat,
    required double lon,
  }) async {
    final response = await _dio.get(
      "/forecast",
      queryParameters: {
        "lat": lat,
        "lon": lon,
        "units": "metric",
        "appid": apiKey,
      },
    );
    return response.data;
  }
}
