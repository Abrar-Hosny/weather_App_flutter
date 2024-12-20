import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1B35),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Top bar with iPhone info
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'iPhone 14 Plus - 6',
                    style: TextStyle(color: Colors.white70),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.signal_cellular_alt, color: Colors.white70, size: 16),
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: const Text('●', style: TextStyle(color: Colors.white70)),
                      ),
                      const Icon(Icons.wifi, color: Colors.white70, size: 16),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // Weather Icon
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Icon(
                      Icons.cloud,
                      size: 60,
                      color: Colors.white,
                    ),
                    Positioned(
                      right: 20,
                      top: 20,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.yellow,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 25,
                      child: Row(
                        children: List.generate(
                          3,
                              (index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            child: const Icon(
                              Icons.water_drop,
                              color: Colors.blue,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Temperature and condition
              const Text(
                '20°',
                style: TextStyle(
                  fontSize: 72,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Thunderstorm',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 40),

              // Weather metrics
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildMetric(Icons.air, 'Wind', '15Km/h'),
                  _buildMetric(Icons.water_drop, 'Humidity', '30%'),
                  _buildMetric(Icons.umbrella, 'Rain', '40%'),
                ],
              ),
              const SizedBox(height: 40),

              // Forecast cards
              Row(
                children: [
                  Expanded(child: _buildForecastCard('3:00 PM', '19°', 0.5)),
                  const SizedBox(width: 20),
                  Expanded(child: _buildForecastCard('3:00 PM', '19°', 0.5)),
                ],
              ),

              const Spacer(),

              // Bottom navigation
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.home, color: Colors.blue[400], size: 30),
                  const Icon(Icons.search, color: Colors.white54, size: 30),
                  const Icon(Icons.settings, color: Colors.white54, size: 30),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetric(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.white70),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(color: Colors.white70),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildForecastCard(String time, String temp, double windPercentage) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            time,
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 8),
          Text(
            temp,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.air, color: Colors.white70, size: 16),
              const SizedBox(width: 4),
              Text(
                '${(windPercentage * 100).toInt()}%',
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }
}