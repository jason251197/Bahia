library address_card;

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';

import 'dart:math';
import 'package:appclientes/cache/cache.dart';
import 'package:appclientes/service/api/api_service.dart';
import 'package:appclientes/service/dialog/dialog_service.dart';
import 'package:appclientes/service/logger/logger.dart';
import 'package:appclientes/service/services.dart';
import 'package:appclientes/shared/common.dart';
import 'package:appclientes/shared/keys/global_keys.dart';
import 'package:appclientes/v_gmap/gmap_view.dart';
import 'package:appclientes/shared/components/app_card/app_card.dart';
import 'package:appclientes/v_localization/controller/models/address_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:appclientes/v_cart/controller/index.dart';
import 'package:appclientes/v_localization/controller/localization_controller.dart';

part 'model/g_address_latlong.dart';
part 'model/g_address_suggestion.dart';
part 'utils/address_concat.dart';
part 'service/location_service.dart';
part 'service/address_repository.dart';

part 'components/address_card.dart';
part 'model/address_point.dart';
part 'model/address_model.dart';

part 'service/g_address_suggestion.dart';
