import 'dart:convert';

import 'package:appclientes/service/logger/logger.dart';
import 'package:intl/intl.dart';

//final oCcy = new NumberFormat("#,##0.00", "en_US");
final oCcy = new NumberFormat.currency(locale: 'eu', symbol: '',decimalDigits: 0);

class AppConverter {
  static const USD = "\$";
  static const COP = "COP";
  static const COP_SYMBOL = "\$";

  static String toJson(dynamic variable) {
    return json.encode(variable);
  }

  static dynamic toObject(String variable) {
    return json.decode(variable);
  }

  static String removeEmpty(String value) {
    return value.replaceAll(new RegExp(r"\s+"), "");
  }

  static String numToMoney(num value, [String currency = USD, String sp = ""]) {
    try {
      return "$currency$sp${oCcy.format(value)}";
    } catch (err) {
      Logger.err("numToMoney", err);
    }
    return "${USD}0.00";
  }

  static String numToMoneyCOP(num value) {
    try {
      return "${oCcy.format(value)}";
    } catch (err) {
      Logger.err("numToMoney", err);
    }
    return "0.00";
  }
}
