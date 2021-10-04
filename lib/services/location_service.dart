import 'package:injectable/injectable.dart';
import 'package:weather_app/services/i_location_service.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geo;

@Injectable(as: ILocationService)
class LocationService implements ILocationService {

  @override
  Future<LocationData?> getCurrentLocation() async {
    final location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    await location.changeSettings(accuracy: LocationAccuracy.low);

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    return await location.getLocation();
  }

  @override
  Future<String?> getCityNameFromCoordinates(LocationData locationData) async {
    final placemarks = await geo.placemarkFromCoordinates(locationData.latitude!, locationData.longitude!);
    return placemarks[0].locality;
  }
}