import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'app_colors.dart';
import 'settings_screen.dart';
import 'weather_details_screen.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';

class WeatherForecastNext extends StatefulWidget {
  const WeatherForecastNext({Key? key}) : super(key: key);

  @override
  _WeatherForecastNextState createState() => _WeatherForecastNextState();
}

class _WeatherForecastNextState extends State<WeatherForecastNext> {
  final String apiKey = '18feae854691456cb6c114106232710';
  final String baseUrl = 'https://api.weatherapi.com/v1';
  String city = 'Alexandria';
  Map<String, dynamic>? weatherData;
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    try {
      final url = Uri.parse('$baseUrl/forecast.json?key=$apiKey&q=$city&days=5&aqi=no&alerts=no');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          weatherData = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Could not fetch data. Please try again later.';
      });
    }
  }

  void updateCity(String newCity) {
    setState(() {
      city = newCity;
    });
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return MaterialApp(
      theme: ThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isDarkMode
                  ? [const Color(0xFF2C1F63), const Color(0xFF1B1347)]
                  : [Colors.white, Colors.white],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  onSubmitted: updateCity,
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Enter city name',
                    labelStyle: TextStyle(
                      color: isDarkMode ? Colors.white70 : Colors.black54,
                    ),
                    suffixIcon: Icon(
                      Icons.search,
                      color: isDarkMode ? Colors.white70 : Colors.black54,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: isDarkMode ? Colors.white30 : Colors.black26,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: isDarkMode ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                if (isLoading)
                  CircularProgressIndicator(
                    color: isDarkMode ? Colors.white : Colors.black87,
                  )
                else if (errorMessage != null)
                  Center(
                    child: Text(
                      errorMessage!,
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  )
                else if (weatherData == null)
                    Center(
                      child: Text(
                        'No data available',
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black87,
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: ListView(
                        children: [
                          Text(
                            'Today',
                            style: TextStyle(
                              fontSize: 24,
                              color: isDarkMode ? Colors.white : Colors.black87,
                            ),
                          ),
                          SizedBox(height: 20),
                          buildHourlyForecast(isDarkMode),
                          SizedBox(height: 30),
                          Text(
                            'Next Forecast',
                            style: TextStyle(
                              fontSize: 20,
                              color: isDarkMode ? Colors.white : Colors.black87,
                            ),
                          ),
                          buildNextDaysForecast(isDarkMode),
                        ],
                      ),
                    ),
              ],
            ),
          ),
        ),
        bottomNavigationBar:
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
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) =>  SettingsScreen(),
                    ),
                  );},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHourlyForecast(bool isDarkMode) {
    List<dynamic> hourly = weatherData!['forecast']['forecastday'][0]['hour'].sublist(0, 6);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: hourly.map((data) {
        var time = data['time'].toString().split(' ')[1];
        var condition = data['condition']['text'];
        return Column(
          children: [
            Text(
              '${data['temp_c']}°C',
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
            Image.network('https:${data['condition']['icon']}', width: 40),
            Text(
              '$time',
              style: TextStyle(
                color: isDarkMode ? Colors.white70 : Colors.black54,
              ),
            ),
            Text(
              '$condition',
              style: TextStyle(
                color: isDarkMode ? Colors.white54 : Colors.black45,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget buildNextDaysForecast(bool isDarkMode) {
    List<dynamic> daily = weatherData!['forecast']['forecastday'];
    return Column(
      children: daily.map((data) {
        var day = data['date'];
        var condition = data['day']['condition']['text'];
        var sunrise = data['astro']['sunrise'];
        var sunset = data['astro']['sunset'];
        return ListTile(
          title: Text(
            '$day',
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black87,
            ),
          ),
          subtitle: Text(
            'Sunrise: $sunrise, Sunset: $sunset\n$condition',
            style: TextStyle(
              color: isDarkMode ? Colors.white70 : Colors.black54,
            ),
          ),
          trailing: Text(
            '${data['day']['avgtemp_c']}°C',
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black87,
            ),
          ),
          leading: Image.network('https:${data['day']['condition']['icon']}', width: 40),
        );
      }).toList(),
    );
  }
}