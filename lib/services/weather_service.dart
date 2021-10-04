import 'package:injectable/injectable.dart';
import 'package:weather/weather.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'i_weather_service.dart';

@Injectable(as: IWeatherService)
class WeatherService implements IWeatherService {

  late WeatherFactory weatherFactory;

  WeatherService() {
    final key = env['WEATHER_API_KEY'];
    weatherFactory = WeatherFactory(key!);
  }

  @override
  Future<Weather> getCurrentWeather(double latitude, double longitude) async {
    return await weatherFactory.currentWeatherByLocation(latitude, longitude);
  }

  @override
  Future<List<Weather>> getFiveDayWeatherForecast(double latitude, double longitude) async {
    return await weatherFactory.fiveDayForecastByLocation(latitude, longitude);
  }
}