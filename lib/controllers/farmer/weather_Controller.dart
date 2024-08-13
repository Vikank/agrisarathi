import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherController extends GetxController {
  var currentTemperature = ''.obs;
  var weatherIcon = ''.obs;
  var weatherDescription = ''.obs;
  var precipitation = ''.obs;
  var humidity = ''.obs;
  var windSpeed = ''.obs;

  var hourlyForecast = [].obs;
  var dailyForecast = [].obs;

  var loading = false.obs;

  final String apiKey = '4675f25ce2863825d057505230a4cca0';

  void fetchWeatherDetails(String districtName) async {
    loading.value = true;
    try {
      final response = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$districtName&appid=$apiKey&units=metric',
        ),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        log("sdwedew$data");
        currentTemperature.value = data['main']['temp'].round().toString();
        weatherDescription.value = data['weather'][0]['description'];
        precipitation.value = data['clouds']['all'].toString() + '%';
        humidity.value = data['main']['humidity'].toString() + '%';
        windSpeed.value = data['wind']['speed'].toString() + 'km/h';
        String iconCode = data['weather'][0]['icon'];
        weatherIcon.value = 'http://openweathermap.org/img/wn/$iconCode@2x.png';

        // Fetch hourly and daily forecast
        await fetchHourlyAndDailyForecast(data['coord']['lat'], data['coord']['lon']);
      } else {
        Get.snackbar('Error', 'Unable to fetch weather data');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      loading.value = false;
    }
  }

  Future<void> fetchHourlyAndDailyForecast(double lat, double lon) async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$apiKey&units=metric',
        ),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        // Parsing hourly data (Next 5 instances)
        hourlyForecast.value = data['list'].sublist(0, 5);

        // Parsing daily data
        var groupedDaily = <String, Map<String, dynamic>>{};
        for (var entry in data['list']) {
          String date = DateTime.parse(entry['dt_txt']).toIso8601String().split('T')[0];
          if (!groupedDaily.containsKey(date)) {
            groupedDaily[date] = {
              'temp': entry['main']['temp'],
              'icon': entry['weather'][0]['icon'],
              'date': date,
            };
          }
        }
        dailyForecast.value = groupedDaily.values.toList().sublist(0, 5);

      } else {
        print('Error: Status Code ${response.statusCode}');
        print('Response: ${response.body}');
        Get.snackbar('Error', 'Unable to fetch forecast data');
      }
    } catch (e) {
      print('Exception: $e');
      Get.snackbar('Error', e.toString());
    }
  }
}
