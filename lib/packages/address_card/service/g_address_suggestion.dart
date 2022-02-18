part of '../address_card.dart';

class GProvider {
  static const _idty = "GProvider";
  static void log(value) => Logger.log(_idty, [value]);
  static void sentryLog(value) => Logger.log(_idty, [value], useSentry: true);

  static const STATUS_OK = 'OK';
  static const STATUS_ERROR = 'error_message';
  static const STATUS = 'status';
  static const FORMATED_ADDRESS = 'formatted_address';

  static bool isSuccess(Response response) => response.statusCode == 200;
  GProvider();

  /// [SETTINGS]
  static const apiKey = '&key=AIzaSyAH1GG0SrNldeE_d7wMirMCYKiuH08lPkU';
  static const core = 'https://maps.googleapis.com/maps/api';
  static const language = '&language=es';
  //static const country = '&components=country:co';
  static const country = '&components=country:co|country:pe';

  /// [PREDICTIONS]
  static const predictions = '$core/place/autocomplete/json?input=';
  static const predictionParams = '&types=geocode$language$country$apiKey';

  /// [FIND FROM PLACE]
  static const find = '$core/place/findplacefromtext/json?input=';
  static const findParams =
      '&inputtype=textquery&fields=formatted_address,geometry$language$apiKey';

  /// [DETAILS]
  static const details = '$core/place/details/json?place_id=';
  static const detailsParam =
      '&types=geocode,$FORMATED_ADDRESS$language$apiKey';

  /// [GEOCODE]
  static const latlong = '$core/geocode/json?latlng=';
  static const latlongParam = '$language$apiKey';

  static Future<List<Suggestion>> fetchSuggestions(String input) async {
    if (await AppConnectivity.check()) {
      input = input.replaceAll('#', '');
      final request = Uri.encodeFull('$predictions$input$predictionParams');
      final response = await Client().get(request);

      log(request);
      if (isSuccess(response)) {
        final result = json.decode(response.body);
        if (result[STATUS] == STATUS_OK) {
          return result['predictions']
              .map<Suggestion>(
                  (p) => Suggestion(p['place_id'], p['description']))
              .toList();
        }
      }
    }
    return [];
  }

  static Future<Position> getPlaceFromText(String text) async {
    final request = '$find$text$findParams';
    final response = await Client().get(request).timeout(Duration(seconds: 10));

    if (isSuccess(response)) {
      final result = json.decode(response.body);
      if (result[STATUS] == STATUS_OK) {
        final place = Candidates.fromJson(result);
        if (place.candidates is List && place.candidates.length == 1) {
          final lat = place?.candidates?.first?.geometry?.location?.lat;
          final long = place?.candidates?.first?.geometry?.location?.lng;
          if (text == place.candidates.first.formattedAddress)
            return Position(latitude: lat, longitude: long);
        }
      }
    }
    return null;
  }

  static Future<Position> getPlaceDetailFromId(String placeId) async {
    final request = '$details$placeId$detailsParam';
    final response = await Client().get(request).timeout(Duration(seconds: 10));

    if (isSuccess(response)) {
      final result = json.decode(response.body);
      if (result[STATUS] == STATUS_OK) {
        final place = Place.fromJson(result);
        final lat = place?.result?.geometry?.location?.lat;
        final long = place?.result?.geometry?.location?.lng;
        return Position(latitude: lat, longitude: long);
      }
    }
    return null;
  }

  static Future<String> getFromCoordenates(num lat, num long) async {
    final param = '$lat,$long';
    final request = Uri.encodeFull('$latlong$param$latlongParam');
    final response = await Client().get(request).timeout(Duration(seconds: 4));

    if (isSuccess(response)) {
      final result = json.decode(response.body);
      log(result);

      if (result[STATUS] == STATUS_OK) {
        try {
          /// [results][0] is the closest prediction option selected by api
          final address = result["results"][0][FORMATED_ADDRESS];
          log(address);
          return address;
        } catch (err) {
          log(err);
        }
      } else {
        sentryLog(result);
      }
    }
    return '';
  }
}
