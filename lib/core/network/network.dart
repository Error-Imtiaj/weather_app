import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:dio/dio.dart';

class DioClient {
  //String baseUrl = dotenv.env['BASE_URL'] ?? "https://api.openweathermap.org/data/2.5";
  static Dio create() {
    return Dio(
      BaseOptions(
        baseUrl:
            dotenv.env['BASE_URL'] ?? "https://api.openweathermap.org/data/2.5",
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );
  }
}
