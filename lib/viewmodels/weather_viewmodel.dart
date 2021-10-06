import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/i_database_service.dart';
import 'package:weather_app/services/i_location_service.dart';
import 'package:weather_app/services/i_weather_service.dart';

@injectable
class WeatherViewModel extends ChangeNotifier {
  final IWeatherService _weatherService;
  final ILocationService _locationService;
  final IDatabaseService _databaseService;

  WeatherModel? _currentWeather;
  List<WeatherModel>? _weatherForNextDays;
  bool _isDarkTheme = false;

  ThemeMode themeMode = ThemeMode.system;
  bool isWeatherLoadingFailed = false;

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

  WeatherViewModel(
      this._weatherService, this._locationService, this._databaseService);

  Future getLatestWeather() async {
    isWeatherLoadingFailed = false;
    var locationData = await _locationService.getCurrentLocation();

    if (locationData == null) {
      await readWeatherFromDb();
    } else {
      await readWeatherDataForLocation(locationData);
    }

    notifyListeners();
  }

  Future readWeatherFromDb() async {
    try {
      var storedWeather = await _databaseService.getWeather();

      if (storedWeather.isEmpty) {
        isWeatherLoadingFailed = true;
        return;
      }

      _currentWeather = storedWeather
          .firstWhere((element) => element.time.day == DateTime.now().day);

      _weatherForNextDays = storedWeather
          .where((element) => element.time.day >= DateTime.now().day)
          .toList();
    }
    on Exception catch (_) {
      isWeatherLoadingFailed = true;
    }
  }

  Future readWeatherDataForLocation(LocationData locationData) async {
    try {
      _currentWeather = await _weatherService.getCurrentWeather(locationData);

      _weatherForNextDays =
          await _weatherService.getFiveDayWeatherForecast(locationData);

      if (_currentWeather != null && _weatherForNextDays != null) {
        await _databaseService.deleteAllStoredWeather();
        await _databaseService.insertWeatherItems(_weatherForNextDays!);
        await _databaseService.insertWeather(_currentWeather!);

      } else {
        throw Exception('no weather data loaded!');
      }
    } on Exception catch (_) {
      isWeatherLoadingFailed = true;
    }
  }
}
