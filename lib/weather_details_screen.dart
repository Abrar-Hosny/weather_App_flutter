// weather_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'settings.dart';
import 'package:weather_app/settings.dart';

class WeatherService {
  final String apiKey = '18feae854691456cb6c114106232710';
  final String baseUrl = 'https://api.weatherapi.com/v1';

  Future<WeatherData> getWeatherData(String city) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/current.json?key=$apiKey&q=$city'),
      );

      if (response.statusCode == 200) {
        return WeatherData.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Location Not Found');
      }
    } catch (e) {
      throw Exception('Location Not Found');
    }
  }
}

class WeatherData {
  final double temperature;
  final String condition;
  final double windSpeed;
  final int humidity;
  final String icon;
  final String location;

  WeatherData({
    required this.temperature,
    required this.condition,
    required this.windSpeed,
    required this.humidity,
    required this.icon,
    required this.location,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      temperature: json['current']['temp_c'],
      condition: json['current']['condition']['text'],
      windSpeed: json['current']['wind_kph'],
      humidity: json['current']['humidity'],
      icon: json['current']['condition']['icon'],
      location: json['location']['name'],
    );
  }
}

class WeatherDetailsScreen extends StatefulWidget {
  const WeatherDetailsScreen({super.key});

  @override
  State<WeatherDetailsScreen> createState() => _WeatherDetailsScreenState();
}

class _WeatherDetailsScreenState extends State<WeatherDetailsScreen> {
  final WeatherService _weatherService = WeatherService();
  WeatherData? _weatherData;
  bool _isLoading = true;
  String _error = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadWeatherData('Alexandria'); // Default city
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadWeatherData(String city) async {
    try {
      setState(() => _isLoading = true);
      final weatherData = await _weatherService.getWeatherData(city);

      setState(() {
        _weatherData = weatherData;
        _isLoading = false;
        _error = '';
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter City'),
        content: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Enter city name',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (_searchController.text.isNotEmpty) {
                _loadWeatherData(_searchController.text);
                Navigator.pop(context);
                _searchController.clear();
              }
            },
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2C1F63), Color(0xFF1B1347)],
          ),
        ),
        child: SafeArea(
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.white))
              : _error.isNotEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Error: Location Not Found',
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () => _showSearchDialog(),
                            child: const Text('Try Again'),
                          ),
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () => _loadWeatherData(
                          _weatherData?.location ?? 'Alexandria'),
                      color: Colors.white,
                      backgroundColor: Color(0xFF2C1F63),
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(20.0),
                        children: [
                          Text(
                            _weatherData?.location ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  'https:${_weatherData?.icon}',
                                  width: 120,
                                  height: 120,
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${_weatherData?.temperature.round()}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 64,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        '°',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 40,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  _weatherData?.condition ?? '',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              WeatherMetric(
                                icon: Icons.air,
                                value: '${_weatherData?.windSpeed.round()}km/h',
                                label: 'Wind',
                              ),
                              WeatherMetric(
                                icon: Icons.water_drop,
                                value: '${_weatherData?.humidity}%',
                                label: 'Humidity',
                              ),
                              const WeatherMetric(
                                icon: Icons.umbrella,
                                value: '0%',
                                label: 'Rain',
                              ),
                            ],
                          ),
                          const SizedBox(height: 100),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.home,
                                    color: Colors.blue, size: 30),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.search,
                                    color: Colors.white54, size: 30),
                                onPressed: _showSearchDialog,
                              ),
                              IconButton(
                                icon: const Icon(Icons.settings,
                                    color: Colors.white54, size: 30),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SettingsScreen(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}

class WeatherMetric extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const WeatherMetric({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white70,
          size: 24,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
