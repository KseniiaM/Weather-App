// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'services/i_location_service.dart' as _i3;
import 'services/i_weather_service.dart' as _i5;
import 'services/location_service.dart' as _i4;
import 'services/weather_service.dart' as _i6;
import 'viewmodels/weather_viewmodel.dart'
    as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.ILocationService>(() => _i4.LocationService());
  gh.factory<_i5.IWeatherService>(() => _i6.WeatherService());
  gh.factory<_i7.WeatherViewModel>(() => _i7.WeatherViewModel(
      get<_i5.IWeatherService>(), get<_i3.ILocationService>()));
  return get;
}
