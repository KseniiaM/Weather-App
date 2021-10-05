import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
            appBar: AppBar(title: Text('Weather App'),
            actions: [
              Switch.adaptive(value: weatherViewModel.isDarkTheme, onChanged: (value) {
                weatherViewModel.isDarkTheme = !weatherViewModel.isDarkTheme;
              })
              ],),
            body: weatherViewModel.currentWeather == null
                ? Center(child: CircularProgressIndicator())
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
    super.initState();
    final viewModel = Provider.of<WeatherViewModel>(context, listen: false);
    viewModel.getLatestWeather();
    var brightness = SchedulerBinding.instance!.window.platformBrightness;
    viewModel.isDarkTheme = brightness == Brightness.dark;
  }
}
