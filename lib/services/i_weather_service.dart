import 'package:location/location.dart';
import 'package:weather_app/models/weather_model.dart';

abstract class IWeatherService {
  Future<WeatherModel> getCurrentWeather(LocationData locationData);
  Future<List<WeatherModel>> getFiveDayWeatherForecast(LocationData locationData);
}