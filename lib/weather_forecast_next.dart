import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'app_colors.dart'; // Import the AppColors class

class WeatherForecastNext extends StatefulWidget {
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
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.gradientStart,
                AppColors.gradientEnd,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  onSubmitted: updateCity,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Enter city name',
                    labelStyle: TextStyle(color: Colors.white70),
                    suffixIcon: Icon(Icons.search, color: Colors.white70),
                  ),
                ),
                SizedBox(height: 20),
                if (isLoading)
                  Center(child: CircularProgressIndicator())
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
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  else
                    Expanded(
                      child: ListView(
                        children: [
                          Text(
                            'Today',
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ),
                          SizedBox(height: 20),
                          buildHourlyForecast(),
                          SizedBox(height: 30),
                          Text(
                            'Next Forecast',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          buildNextDaysForecast(),
                        ],
                      ),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHourlyForecast() {
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
              style: TextStyle(color: Colors.white),
            ),
            Image.network('https:${data['condition']['icon']}', width: 40),
            Text(
              '$time',
              style: TextStyle(color: Colors.white70),
            ),
            Text(
              '$condition',
              style: TextStyle(color: Colors.white54),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget buildNextDaysForecast() {
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
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            'Sunrise: $sunrise, Sunset: $sunset\n$condition',
            style: TextStyle(color: Colors.white70),
          ),
          trailing: Text(
            '${data['day']['avgtemp_c']}°C',
            style: TextStyle(color: Colors.white),
          ),
          leading: Image.network('https:${data['day']['condition']['icon']}', width: 40),
        );
      }).toList(),
    );
  }
}
