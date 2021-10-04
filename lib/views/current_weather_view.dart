import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/viewmodels/weather_viewmodel.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:weather_app/utils/weather_convert_util.dart';

class CurrentWeatherView extends StatefulWidget {
  @override
  _CurrentWeatherViewState createState() => _CurrentWeatherViewState();
}

class _CurrentWeatherViewState extends State<CurrentWeatherView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherViewModel>(
        builder: (context, weatherViewModel, child) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _getCurrentWeatherDescription(weatherViewModel),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.center,
                  child: Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        BoxedIcon(
                          weatherViewModel.currentWeather!.convertWeatherStateToIcon(),
                          size: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            weatherViewModel.currentWeather!.getWeatherDegreesFormatted(),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 25),
                          ),
                        )
                      ]),
                ),
              ),
            ]));
  }

  String _getCurrentWeatherDescription(WeatherViewModel weatherViewModel) {
    return weatherViewModel.currentWeather == null
        ? 'Loading data'
        : weatherViewModel.currentWeather?.weatherDescription ?? '';
  }
}
