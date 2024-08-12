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
        currentTemperature.value = data['main']['temp'].toString();
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
          'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=minutely&appid=$apiKey&units=metric',
        ),
      );
      log("${response.statusCode}");
      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        hourlyForecast.value = data['hourly'].sublist(0, 5);
        dailyForecast.value = data['daily'].sublist(0, 5);
      } else {
        Get.snackbar('Error', 'Unable to fetch forecast data');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
