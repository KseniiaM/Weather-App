import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/i_location_service.dart';
import 'package:weather_app/services/i_weather_service.dart';

@injectable
class WeatherViewModel extends ChangeNotifier {
  final IWeatherService _weatherService;
  final ILocationService _locationService;

  WeatherModel? _currentWeather;
  List<WeatherModel>? _weatherForNextDays;
  bool _isDarkTheme = false;

  ThemeMode themeMode = ThemeMode.system;

  WeatherModel? get currentWeather {
    return _currentWeather;
  }

  List<WeatherModel> get weatherForNextDays {
    return _weatherForNextDays ?? List.empty();
  }

  bool get isDarkTheme {
    return _isDarkTheme;
  }

  set isDarkTheme(bool value) {
    _isDarkTheme = value;
    themeMode = value ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  WeatherViewModel(this._weatherService, this._locationService);

  Future getLatestWeather() async {
    final locationData = await _locationService.getCurrentLocation();

    if (locationData == null) {
      //do stuff to read data from DB
    }

    _currentWeather = await _weatherService
        .getCurrentWeather(locationData!);

    _weatherForNextDays =
        await _weatherService.getFiveDayWeatherForecast(locationData);

    notifyListeners();
  }
}
