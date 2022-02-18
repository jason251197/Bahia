part of '../address_card.dart';

/// Check if location service is enabled and working and ask for permissions.
///
class LocationService {
  static Future<PermissionStatus> initLocationService() async {
    final location = Location();
    PermissionStatus permissionStatus;
    if (await hasActiveLocation(location)) {
      permissionStatus = await location.hasPermission();
      if (permissionStatus != PermissionStatus.granted) {
        permissionStatus = await location.requestPermission();
        //if (permissionStatus != PermissionStatus.granted)//comentado por APPSTORE
          //await DialogService.localizationError;//comentado por APPSTORE
      }
    }
    return permissionStatus;
  }

  static Future<bool> get hasLocationAccess async =>
      await initLocationService() == PermissionStatus.granted;

  static Future<bool> hasActiveLocation([Location location]) async {
    if (location is! Location) location = Location();
    var serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        await DialogService.simpleDialog('Para mejorar la experiencia necesitamos permisos de tu ubicación.');
      }
    }
    return serviceEnabled;
  }
}
