import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_icons/weather_icons.dart';

extension WeatherExtensions on WeatherModel {

  IconData convertWeatherStateToIcon() {

    switch (weatherDescription) {
      case 'Thunderstorm':
        return WeatherIcons.thunderstorm;
      case 'Rain':
        return WeatherIcons.rain;
      case 'Snow':
        return WeatherIcons.snow;
      case 'Clear':
        return WeatherIcons.day_sunny;
      case 'Clouds':
        return WeatherIcons.cloud;
      case 'fog':
        return WeatherIcons.fog;
      default:
        return WeatherIcons.day_sunny_overcast;
    }
  }

  String getWeatherDateFormatted() {
    return DateFormat('E, h a').format(time);
  }

  String getWeatherDegreesFormatted() {
    final temperatureFixed = temperature.toStringAsFixed(1);

    return '$temperatureFixed \u00B0';
  }
}