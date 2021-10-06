class WeatherModel {
  int? id;
  String weatherDescription;
  double temperature;
  String cityName;
  late DateTime time;

  WeatherModel(this.weatherDescription, this.temperature, this.cityName, this.time);

  WeatherModel.db(this.id, this.weatherDescription, this.temperature, this.cityName, String time) {
    this.time = DateTime.tryParse(time) ?? DateTime.now();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'weather_description': weatherDescription,
      'temperature': temperature,
      'city_name' : cityName,
      'time' : time.toIso8601String()
    };
  }
}