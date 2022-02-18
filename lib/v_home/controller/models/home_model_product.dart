part of '../index.dart';

class ProductModel {
  ProductModel(
      {this.productCode,
      this.productName,
      this.realPrice,
      this.discountRate,
      this.finalPrice,
      this.priceBackgroundColor,
      this.stock,
      this.isComplement,
      this.stateProduct,
      this.id,
      this.localCode,
      this.localName,
      this.catCode,
      this.imagePath,
      this.maxPickupTime,
      this.maxDeliveyTime,
      this.minDeliveyTime,
      this.distance,
      this.isClosed,
      this.openingTime,
      this.endOpeningTime,
      this.reopeningTime,
      this.endReopeningTime,
      this.type,
      this.typeCurrency,
      this.localPhone,
      this.urlInstagram,
      this.description,
      this.discount,
      this.deliveryPrice,
      this.imagePathLocal,
      this.sales,
      this.flagPickup,
      this.flagDelivery,
      this.address,
      this.latitude,
      this.longitude,
      this.maxBuyTime,
      this.idFavorito});

  String productCode;
  String productName;
  num realPrice;
  num discountRate;
  num finalPrice;
  String priceBackgroundColor;
  int stock;
  bool isComplement;
  bool stateProduct;
  int id;
  num deliveryPrice;
  String localCode;
  String localName;
  String catCode;
  String imagePath;
  String maxPickupTime;
  String maxDeliveyTime;
  String minDeliveyTime;
  String distance;
  bool isClosed;
  String openingTime;
  String endOpeningTime;
  String reopeningTime;
  String endReopeningTime;
  String typeCurrency;
  String localPhone;
  String urlInstagram;
  String description;
  String discount;
  String imagePathLocal;
  String sales;
  bool flagPickup;
  bool flagDelivery;
  int type;
  String address;
  num latitude;
  num longitude;
  String maxBuyTime;
  int idFavorito;

  get isOpening => openingTime is String && endOpeningTime is String;

  get isClosing => reopeningTime is String && endReopeningTime is String;

  get schedule =>
      isOpening && isClosing ? "$openingTime a $endReopeningTime hrs" : "";
  get scheduleOn => isOpening ? "$openingTime a $endOpeningTime hrs" : '';
  get scheduleOff => isClosing ? "$reopeningTime a $endReopeningTime hrs" : '';

  get price => "$currency" + AppConverter.numToMoneyCOP(finalPrice);

  get initialPrice => "$currency" + AppConverter.numToMoneyCOP(realPrice);

  get currency => typeCurrency ?? '';

  get hasInitSchedule => openingTime is String && endOpeningTime is String;
  get initSchedule =>
      hasInitSchedule ? "$openingTime a $endOpeningTime Hrs" : '';

  get doInitSchedule {
    try {
      return initSchedule.isNotEmpty ? initSchedule : openingTime ?? '';
    } catch (_) {}

    return '-';
  }

  get hasEndSchedule => reopeningTime is String && endReopeningTime is String;
  get endSchedule =>
      hasEndSchedule ? "$reopeningTime a $endReopeningTime Hrs" : '';

  get baseDiscount => (discountRate.toString() + "%");

  Color get background =>
      HexColor.fromHex(priceBackgroundColor ?? "#1D90F5") ?? AppColors.black;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        productCode: json["product_code"],
        productName: json["product_name"],
        realPrice: json["real_price"],
        typeCurrency: json["type_currency"],
        discountRate: json["discount_rate"].toDouble(),
        discount: json["discount"] ?? '',
        finalPrice: json["final_price"].toDouble(),
        priceBackgroundColor: json["price_background_color"],
        stock: json["stock"],
        isComplement: json["is_complement"],
        stateProduct: json["state_product"],
        deliveryPrice: json["price_delivery"],
        imagePathLocal: json["image_path_local"],
        flagPickup: json["flag_pickup"],
        flagDelivery: json["flag_delivery"],
        // id: json["id"],
        id: Random.secure().nextInt(1000),
        localCode: json["local_code"],
        localName: json["local_name"],
        catCode: json["cat_code"],
        imagePath: json["image_path"],
        maxPickupTime: json["max_pickup_time"],
        maxDeliveyTime: json["max_delivery_time"],
        minDeliveyTime: json["min_delivery_time"],
        distance: json["distance"],
        isClosed: json["isClosed"] ?? false,
        openingTime: json["opening_time"],
        endOpeningTime: json["end_opening_time"],
        reopeningTime: json["reopening_time"],
        endReopeningTime: json["end_reopening_time"],
        type: json["type"],
        urlInstagram: json["url_instagram"],
        localPhone: json["local_phone"],
        description: json["description"] ?? '',
        sales: json["sales"],
        address: json["address"] ?? '',
        latitude: json["latitude"],
        longitude: json["longitude"],
        maxBuyTime: json["max_buy_time"],
        idFavorito: json["idFavorito"],
      );

  Map<String, dynamic> toJson() => {
        "product_code": productCode,
        "product_name": productName,
        "real_price": realPrice,
        "discount_rate": discountRate,
        "final_price": finalPrice,
        "price_background_color": priceBackgroundColor,
        "stock": stock,
        "image_path_local": imagePathLocal,
        "is_complement": isComplement,
        "state_product": stateProduct,
        "id": id,
        "local_code": localCode,
        "local_name": localName,
        "cat_code": catCode,
        "image_path": imagePath,
        "max_pickup_time": maxPickupTime,
        "max_delivery_time": maxDeliveyTime,
        "min_delivery_time": minDeliveyTime,
        "distance": distance,
        "isClosed": isClosed,
        "opening_time": openingTime,
        "end_opening_time": endOpeningTime,
        "reopening_time": reopeningTime,
        "end_reopening_time": endReopeningTime,
        "sales": sales,
        "type": type,
        "flag_pickup": flagPickup,
        "flag_delivery": flagDelivery,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "max_buy_time": maxBuyTime,
        "idFavorito": idFavorito,
      };
}
