import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'weather_details_screen.dart';
<<<<<<< HEAD:lib/settings_screen.dart
import 'weather_forecast_next.dart';
=======
import '/services/auth_service.dart';
import '/login_screen.dart'; 
>>>>>>> b26844a58510f36a3ca6791a96809e9939d80602:lib/settings.dart

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
<<<<<<< HEAD:lib/settings_screen.dart
=======
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = true;
  final _authService = AuthService();

  Future<void> _handleSignOut() async {
    try {
      await _authService.signOut();
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error signing out: ${e.toString()}')),
        );
      }
    }
  }

  @override
>>>>>>> b26844a58510f36a3ca6791a96809e9939d80602:lib/settings.dart
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF2C1F63) : Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'Settings',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: isDarkMode
                              ? [Colors.blue.shade400, Colors.purple.shade400]
                              : [Colors.blue.shade200, Colors.purple.shade200],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Me',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? Colors.white.withOpacity(0.1)
                      : Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
<<<<<<< HEAD:lib/settings_screen.dart
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dark Mode',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    Switch(
                      value: isDarkMode,
                      onChanged: (value) {
                        themeProvider.toggleTheme(value);
                      },
                      activeColor: Colors.blue,
                    ),
=======
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.logout, color: Colors.white),
                      title: const Text(
                        'Sign Out',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: _handleSignOut,
                    ),
                    // You can add more settings options here
>>>>>>> b26844a58510f36a3ca6791a96809e9939d80602:lib/settings.dart
                  ],
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.home, size: 30),
                      color: isDarkMode ? Colors.white54 : Colors.black54,
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => const WeatherDetailsScreen(),
                          ),
                        );
                      },
                    ),
                    IconButton(
<<<<<<< HEAD:lib/settings_screen.dart
                      icon: const Icon(Icons.article, size: 30),
                      color: isDarkMode ? Colors.white54 : Colors.black54,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>  WeatherForecastNext(),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.settings, size: 30),
                      color: isDarkMode ? Colors.blue : Colors.black,
                      onPressed: () {},
                    ),
=======
                      icon: const Icon(Icons.settings,
                          color: Colors.white, size: 30),
                      onPressed: () {
                        // Already on settings screen
                      },
                    ),
>>>>>>> b26844a58510f36a3ca6791a96809e9939d80602:lib/settings.dart
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
