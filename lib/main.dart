import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:weather_app/injection.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/viewmodels/weather_viewmodel.dart';
import 'package:weather_app/views/home_view.dart';

Future main() async {
  await DotEnv.load(fileName: '.env');
  configureDependencies();
  runApp(ChangeNotifierProvider<WeatherViewModel>(
    create: (context) => WeatherViewModel(),
      child:MyApp())
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData.dark(),
      home: HomeView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
