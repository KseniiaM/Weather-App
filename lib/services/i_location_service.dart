import 'package:location/location.dart';

abstract class ILocationService {
  Future<LocationData?> getCurrentLocation();
  Future<String?> getCityNameFromCoordinates(LocationData locationData);
}