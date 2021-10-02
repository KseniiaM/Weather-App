import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_icons/weather_icons.dart';

extension WeatherExtensions on Weather {

  IconData convertWeatherStateToIcon() {
    if (weatherMain == null) {
      return WeatherIcons.day_sunny_overcast;
    }

    switch (weatherMain) {
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
    return DateFormat('E, h a').format(date ?? DateTime.now());
  }

  String getWeatherDegreesFormatted() {
    final temperatureFixed = temperature?.celsius?.toStringAsFixed(1);
    if (temperatureFixed == null) {
      return '';
    }

    return '$temperatureFixed \u00B0';
  }
}