part of '../address_card.dart';

class Place {
  Place({
    this.htmlAttributions,
    this.result,
    this.status,
  });

  List<dynamic> htmlAttributions;
  Result result;
  String status;

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        htmlAttributions: json["html_attributions"] == null
            ? null
            : List<dynamic>.from(json["html_attributions"].map((x) => x)),
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "html_attributions": htmlAttributions == null
            ? null
            : List<dynamic>.from(htmlAttributions.map((x) => x)),
        "result": result == null ? null : result.toJson(),
        "status": status == null ? null : status,
      };
}

class Result {
  Result({
    this.formattedAddress,
    this.geometry,
    this.name,
  });

  String formattedAddress;
  Geometry geometry;
  String name;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        formattedAddress: json["formatted_address"] == null
            ? null
            : json["formatted_address"],
        geometry: json["geometry"] == null
            ? null
            : Geometry.fromJson(json["geometry"]),
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "formatted_address": formattedAddress == null ? null : formattedAddress,
        "geometry": geometry == null ? null : geometry.toJson(),
        "name": name == null ? null : name,
      };
}

class Geometry {
  Geometry({this.location});

  LocationG location;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        location: json["location"] == null
            ? null
            : LocationG.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "location": location == null ? null : location.toJson(),
      };
}

class LocationG {
  LocationG({
    this.lat,
    this.lng,
  });

  double lat;
  double lng;

  factory LocationG.fromJson(Map<String, dynamic> json) => LocationG(
        lat: json["lat"] == null ? null : json["lat"].toDouble(),
        lng: json["lng"] == null ? null : json["lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat == null ? null : lat,
        "lng": lng == null ? null : lng,
      };
}
