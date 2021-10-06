// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'services/database_service.dart' as _i4;
import 'services/i_database_service.dart' as _i3;
import 'services/i_location_service.dart' as _i5;
import 'services/i_weather_service.dart' as _i7;
import 'services/location_service.dart' as _i6;
import 'services/weather_service.dart' as _i8;
import 'viewmodels/weather_viewmodel.dart'
    as _i9; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.IDatabaseService>(() => _i4.DatabaseService());
  gh.factory<_i5.ILocationService>(() => _i6.LocationService());
  gh.factory<_i7.IWeatherService>(
      () => _i8.WeatherService(get<_i5.ILocationService>()));
  gh.factory<_i9.WeatherViewModel>(() => _i9.WeatherViewModel(
      get<_i7.IWeatherService>(),
      get<_i5.ILocationService>(),
      get<_i3.IDatabaseService>()));
  return get;
}
