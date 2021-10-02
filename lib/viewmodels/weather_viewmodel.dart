import 'package:flutter/cupertino.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherViewModel extends ChangeNotifier {

  late WeatherService _weatherService;
  Weather? _currentWeather;
  List<Weather>? _weatherForNextDays;

  Weather? get currentWeather {
    return _currentWeather;
  }

  List<Weather> get weatherForNextDays {
    return _weatherForNextDays ?? List.empty();
  }

  WeatherViewModel() {
    _weatherService = WeatherService();
  }

  Future<Weather?> getLatestWeather() async {
    _currentWeather = await _weatherService.getCurrentWeather('Lviv');
    _weatherForNextDays = await _weatherService.getFiveDayWeatherForecast('Lviv');
    notifyListeners();
  }
}