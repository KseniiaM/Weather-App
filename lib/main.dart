import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dot_env;
import 'package:weather_app/injection.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/viewmodels/weather_viewmodel.dart';
import 'package:weather_app/views/home_view.dart';

Future main() async {
  await dot_env.load(fileName: '.env');
  configureDependencies();
  runApp(ChangeNotifierProvider<WeatherViewModel>(
    create: (context) => getIt<WeatherViewModel>(),
      child:MyApp())
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      themeMode: Provider.of<WeatherViewModel>(context).themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: HomeView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
