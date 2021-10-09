import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/src/core/models/weather_models.dart';

class WeatherServices {
  Future<Weather>? getCurrentWeather(String? location) async {
    var endpoint = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$location&appid=83da5eacf5117c44c5df3c27b2066970");

    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);

    Weather weather = Weather.fromJson(body);

    return weather;
  }
}