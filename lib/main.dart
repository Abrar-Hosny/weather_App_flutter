import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'signup_screen.dart';
import 'weather_details_screen.dart';
import 'weather_forecast_next.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/signup',
    routes: {
      '/login': (context) => SafeArea(child: const LoginScreen()),
      '/signup': (context) => SafeArea(child: const SignUpScreen()),
      '/weather_details': (context) => SafeArea(child: const WeatherDetailsScreen()),
      '/weather_forecast_next': (context) => SafeArea(child: WeatherForecastNext()),
    },
  ));
}
