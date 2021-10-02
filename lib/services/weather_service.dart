import 'package:weather/weather.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherService {

  late WeatherFactory weatherFactory;

  WeatherService() {
    final key = env['WEATHER_API_KEY'];
    weatherFactory = WeatherFactory(key!);
  }

  Future<Weather> getCurrentWeather(String cityName) async {
    return await weatherFactory.currentWeatherByCityName(cityName);
  }

  Future<List<Weather>> getFiveDayWeatherForecast(String cityName) async {
    return await weatherFactory.fiveDayForecastByCityName(cityName);
  }
}