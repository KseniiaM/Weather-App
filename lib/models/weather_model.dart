import 'package:uuid/uuid.dart';

class WeatherModel {
  late String id;
  String weatherDescription;
  double temperature;
  String cityName;
  DateTime time;

  WeatherModel(this.weatherDescription, this.temperature, this.cityName, this.time)
  {
    id = Uuid().v4();
  }
}