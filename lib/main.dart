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
    initialRoute: '/signup',
    routes: {
      '/login': (context) => const LoginScreen(),
      '/signup': (context) => const SignUpScreen(),
      '/weather_details': (context) => const WeatherDetailsScreen(),
      '/weather_forecast_next': (context) => WeatherForecastNext(),
      // '/home': (context) => const HomeScreen(),
    },
  ));
}
