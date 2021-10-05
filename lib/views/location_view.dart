import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/viewmodels/weather_viewmodel.dart';

class LocationView extends StatefulWidget {
  @override
  _LocationViewState createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherViewModel>(
      builder: (context, weatherViewModel, child) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.location_on,
            ),
          ),
          Text(
            weatherViewModel.currentWeather!.cityName,
            style: Theme.of(context).textTheme.headline6,
          )
        ]),
      ),
    );
  }
}
