import 'package:injectable/injectable.dart';
import 'package:location/location.dart';
import 'package:weather/weather.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/i_location_service.dart';
import 'i_weather_service.dart';

@Injectable(as: IWeatherService)
class WeatherService implements IWeatherService {

  late WeatherFactory _weatherFactory;
  final ILocationService _locationService;

  WeatherService(this._locationService) {
    final key = env['WEATHER_API_KEY'];
    _weatherFactory = WeatherFactory(key!);
  }

  @override
  Future<WeatherModel> getCurrentWeather(LocationData locationData) async {

    CheckLocationData(locationData);

    final currentWeather = await _weatherFactory.currentWeatherByLocation(locationData.latitude!, locationData.longitude!);

    return await _convertWeatherToModel(currentWeather, locationData);
  }

  @override
  Future<List<WeatherModel>> getFiveDayWeatherForecast(LocationData locationData) async {

    CheckLocationData(locationData);

    final weatherForNextDays = await _weatherFactory
        .fiveDayForecastByLocation(locationData.latitude!, locationData.longitude!);

    return Stream.fromIterable(weatherForNextDays)
                 .asyncMap((item) => _convertWeatherToModel(item, locationData))
                 .toList();
  }

  Future<WeatherModel> _convertWeatherToModel(Weather weather, LocationData locationData) async {

    final cityName = await _locationService.getCityNameFromCoordinates(locationData);

    return WeatherModel(
        weather.weatherMain ?? '',
        weather.temperature?.celsius ?? 0.0,
        cityName ?? 'Unknown',
        weather.date ?? DateTime.now());
  }

  void CheckLocationData(LocationData locationData) {
    if (locationData.latitude == null|| locationData.longitude == null) {
      throw Exception('Not able to read location data!');
    }
  }
}