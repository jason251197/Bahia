part of '../index.dart';

class LocalModel {
  LocalModel(
      {this.id,
      this.localCode,
      this.localName,
      this.localPhone,
      this.catCode,
      this.imagePath,
      this.maxPickupTime,
      this.distance,
      this.geolocationCode,
      this.latitude,
      this.longitude,
      this.openingTime,
      this.endOpeningTime,
      this.reopeningTime,
      this.endReopeningTime,
      this.urlInstagram,
      this.type,
      this.typeCurrency,
      this.sales,
      this.isClosed,
      this.address,
      this.idFavorito});

  int id;
  String localCode;
  String localName;
  String localPhone;
  String catCode;
  String imagePath;
  String maxPickupTime;
  String distance;
  String geolocationCode;
  num latitude;
  num longitude;
  String openingTime;
  String endOpeningTime;
  String reopeningTime;
  String endReopeningTime;
  String urlInstagram;
  String typeCurrency;
  int type;
  String sales;
  bool isClosed;
  String address;
  int idFavorito;

  get isOpening => openingTime is String && endOpeningTime is String;

  get isClosing => reopeningTime is String && endReopeningTime is String;

  String get schedule =>
      isOpening && isClosing ? "$openingTime a $endReopeningTime hrs" : "";

  get hasInitSchedule => openingTime is String && endOpeningTime is String;

  String get initSchedule =>
      hasInitSchedule ? "$openingTime a $endOpeningTime Hrs" : '';

  get doInitSchedule {
    try {
      return initSchedule.isNotEmpty ? initSchedule : openingTime ?? '';
    } catch (_) {}

    return '-';
  }

  get doValidateSchedule {
    try {
      return validSchedule.isNotEmpty ? validSchedule : openingTime ?? '';
    } catch (_) {}

    return '-';
  }

  get doValidateSchedule2 {
    try {
      if (isClosed) {
        return "Cerrado";
      } else {
        if (openingTime == null ||
            endOpeningTime == null ||
            openingTime.isEmpty ||
            endOpeningTime.isEmpty) {
          return endSchedule;
        } else {
          return initSchedule;
        }
      }
    } catch (_) {}

    return '-';
  }

  get hasEndSchedule => reopeningTime is String && endReopeningTime is String;
  get endSchedule =>
      hasEndSchedule ? "$reopeningTime a $endReopeningTime Hrs" : '';

  get currency => typeCurrency ?? '';

  String get validSchedule => schedule.isEmpty ? initSchedule : schedule;

  factory LocalModel.fromJson(Map<String, dynamic> json) => LocalModel(
        // id: json["id"],
        id: Random.secure().nextInt(1000),
        localCode: json["local_code"],
        localName: json["local_name"],
        localPhone: json["local_phone"],
        typeCurrency: json["type_currency"],
        catCode: json["cat_code"],
        imagePath: json["image_path_local"] ?? json["image_path"] ?? '',
        maxPickupTime: json["max_pickup_time"],
        distance: json["distance"],
        openingTime: json["opening_time"],
        endOpeningTime: json["end_opening_time"],
        reopeningTime: json["reopening_time"],
        endReopeningTime: json["end_reopening_time"],
        urlInstagram: json["url_instagram"],
        type: json["type"],
        sales: json["sales"],
        isClosed: json["isClosed"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        idFavorito: json["idFavorito"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "local_code": localCode,
        "local_name": localName,
        "local_phone": localPhone,
        "cat_code": catCode,
        "image_path": imagePath,
        "max_pickup_time": maxPickupTime,
        "distance": distance,
        "opening_time": openingTime,
        "end_opening_time": endOpeningTime,
        "reopening_time": reopeningTime,
        "end_reopening_time": endReopeningTime,
        "url_instagram": urlInstagram,
        "type": type,
        "isClosed": isClosed,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "idFavorito": idFavorito,
      };

  Map<String, dynamic> getProductsRequest(codCli) => {
        "entity": {
          "local_code": localCode ?? '',
          "codeclient": codCli ?? '',
          "geolocation_code": geolocationCode,
          // "current_location": currentLocation,
          "latitude": latitude ?? 0,
          "longitude": longitude ?? 0,
          // "page_number": 1
        }
      };
}
