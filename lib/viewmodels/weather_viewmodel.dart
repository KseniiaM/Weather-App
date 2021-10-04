import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/services/i_location_service.dart';
import 'package:weather_app/services/i_weather_service.dart';

@injectable
class WeatherViewModel extends ChangeNotifier {
  final IWeatherService _weatherService;
  final ILocationService _locationService;

  Weather? _currentWeather;
  List<Weather>? _weatherForNextDays;
  String? _cityName;

  Weather? get currentWeather {
    return _currentWeather;
  }

  List<Weather> get weatherForNextDays {
    return _weatherForNextDays ?? List.empty();
  }

  String get cityName {
    return _cityName ?? 'Unknown';
  }

  WeatherViewModel(this._weatherService, this._locationService);

  Future<Weather?> getLatestWeather() async {
    final locationData = await _locationService.getCurrentLocation();
    if (locationData == null
        || locationData.latitude == null
        || locationData.longitude == null) {
      throw Exception('Not able to read location data!');
    }

    _currentWeather = await _weatherService
        .getCurrentWeather(locationData.latitude!, locationData.longitude!);

    _weatherForNextDays =
        await _weatherService.getFiveDayWeatherForecast(locationData.latitude!, locationData.latitude!);

    _cityName = await _locationService.getCityNameFromCoordinates(locationData);
    notifyListeners();
  }
}
