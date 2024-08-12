import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/farmer/weather_Controller.dart';

class WeatherDetailScreen extends StatelessWidget {
  final String districtName;
  final WeatherController weatherController = Get.put(WeatherController());

  WeatherDetailScreen({required this.districtName});

  @override
  Widget build(BuildContext context) {
    weatherController.fetchWeatherDetails(districtName);

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
        leading: BackButton(),
      ),
      body: Obx(() {
        if (weatherController.loading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      weatherController
                          .weatherDescription.value.capitalizeFirst!,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${weatherController.currentTemperature.value}°C',
                          style: TextStyle(fontSize: 32)),
                      Image.network(
                        weatherController.weatherIcon.value,
                        width: 64,
                        height: 64,
                      ),
                    ],
                  ),
                  Text(
                      'Precipitation: ${weatherController.precipitation.value}'),
                  Text('Humidity: ${weatherController.humidity.value}'),
                  Text('Wind: ${weatherController.windSpeed.value}'),
                  SizedBox(height: 16),
                  Text("Today's Weather",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: weatherController.hourlyForecast.map((hour) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                  '${DateTime.fromMillisecondsSinceEpoch(hour['dt'] * 1000).hour} am'),
                              Image.network(
                                'http://openweathermap.org/img/wn/${hour['weather'][0]['icon']}@2x.png',
                                width: 32,
                                height: 32,
                              ),
                              Text('${hour['temp']}°C'),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text("Next 5 Day's Weather",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: weatherController.dailyForecast.length,
                    itemBuilder: (context, index) {
                      var day = weatherController.dailyForecast[index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                '${DateTime.fromMillisecondsSinceEpoch(day['dt'] * 1000).day} ${DateTime.fromMillisecondsSinceEpoch(day['dt'] * 1000).month}',
                              ),
                              Image.network(
                                'http://openweathermap.org/img/wn/${day['weather'][0]['icon']}@2x.png',
                                width: 32,
                                height: 32,
                              ),
                              Text('${day['temp']['day']}°C'),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
