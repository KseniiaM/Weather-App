import 'package:weather_app/models/weather_model.dart';

abstract class IDatabaseService {

  Future insertWeatherItems(List<WeatherModel> weatherModels);
  Future insertWeather(WeatherModel weatherModel);
  Future<List<WeatherModel>> getWeather();
  Future deleteAllStoredWeather();
}