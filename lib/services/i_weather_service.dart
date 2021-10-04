import 'package:weather/weather.dart';

abstract class IWeatherService {
  Future<Weather> getCurrentWeather(double latitude, double longitude);
  Future<List<Weather>> getFiveDayWeatherForecast(double latitude, double longitude);
}