import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/viewmodels/weather_viewmodel.dart';
import 'package:weather_app/views/current_weather_view.dart';
import 'package:weather_app/views/location_view.dart';
import 'package:weather_app/views/weather_for_days_list.dart';

class HomeView extends StatefulWidget {
  @override
  _State createState() => _State();
}

Future<void> getWeatherPressed(
    WeatherViewModel weatherViewModel, BuildContext context) {
  return weatherViewModel.getLatestWeather();
}

class _State extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherViewModel>(
        builder: (context, weatherViewModel, child) => Scaffold(
            appBar: AppBar(title: Text('Weather App')),
            body: weatherViewModel.currentWeather == null
                ? CircularProgressIndicator()
                : RefreshIndicator(
                    onRefresh: () =>
                        getWeatherPressed(weatherViewModel, context),
                    child: Card(
                        elevation: 5,
                        child: ListView(children: [
                          LocationView(),
                          CurrentWeatherView(),
                          WeatherForDaysList(),
                        ])))));
  }

  @override
  void initState() {
    Provider.of<WeatherViewModel>(context, listen: false).getLatestWeather();
  }
}
