part of '../index.dart';

class KushkiCard {
  String name;
  String number;
  String ccv;
  String month;
  String year;
  String totalAmount;

  KushkiCard({
    this.name,
    this.number,
    this.ccv,
    this.month,
    this.year,
    this.totalAmount,
  });

  /// Transform private properties into a Map to be sent through a request
  Map<String, dynamic> get toMap => {
        'name': name,
        'number': number,
        'ccv': ccv,
        'month': month,
        'year': year,
        'totalAmount': totalAmount,
      };

  get testCard => {
        'name': "name",
        'number': "4539027568773860",
        'ccv': "123",
        'expiryMonth': "09",
        'expiryYear': "21",
      };
}
