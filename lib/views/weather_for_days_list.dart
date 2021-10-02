import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/viewmodels/weather_viewmodel.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:weather_app/utils/weather_convert_util.dart';

class WeatherForDaysList extends StatefulWidget {
  @override
  _WeatherForDaysListState createState() => _WeatherForDaysListState();
}

class _WeatherForDaysListState extends State<WeatherForDaysList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherViewModel>(
        builder: (context, weatherViewModel, child) =>
            weatherViewModel.weatherForNextDays.isEmpty
                ? Container()
                : Container(
                    height: 100,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: weatherViewModel.weatherForNextDays.length,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(weatherViewModel
                                        .weatherForNextDays[index]
                                        .getWeatherDateFormatted()),
                                    BoxedIcon(weatherViewModel
                                        .weatherForNextDays[index]
                                        .convertWeatherStateToIcon()),
                                    Text(weatherViewModel
                                        .weatherForNextDays[index]
                                        .getWeatherDegreesFormatted())
                                  ]));
                        }),
                  ));
  }
}
