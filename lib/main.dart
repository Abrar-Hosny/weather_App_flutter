import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:provider/provider.dart';
import 'theme.dart';
import 'providers/theme_provider.dart';
import 'settings_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeProvider.themeMode,
      home: const SettingsScreen(),
    );
  }
}
=======
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
>>>>>>> b26844a58510f36a3ca6791a96809e9939d80602
