import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 🔥 REQUIRED
  await dotenv.load(fileName: ".env"); // 🔥 REQUIRED

  // 🔍 TEMP DEBUG (REMOVE LATER)
  print("API_KEY = ${dotenv.env['API_KEY']}");
  print("BASE_URL = ${dotenv.env['BASE_URL']}");

  runApp(const WeatherApp());
}
