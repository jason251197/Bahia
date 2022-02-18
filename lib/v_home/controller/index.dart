library home_controller;

import 'dart:math';

import 'package:appclientes/service/logger/logger.dart';
import 'package:appclientes/service/services.dart';
import 'package:appclientes/shared/components/app_bar/controller/app_bar_state.dart';
import 'package:appclientes/shared/components/app_button_switch/switch_option.dart';
import 'package:appclientes/shared/constants/colors.dart';
import 'package:appclientes/shared/helpers/converter.dart';
import 'package:appclientes/v_cart/controller/index.dart';
import 'package:appclientes/v_home/views/food_view.dart';
import 'package:appclientes/v_home/views/restaurant_view.dart';
import 'package:appclientes/shared/constants/params.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

part 'events/home_events.dart';

part 'repo/home_repo.dart';
part 'models/home_model_local.dart';
part 'models/home_model_product.dart';
part 'models/home_model_filter.dart';
part 'models/home_model_category.dart';
part 'models/home_model_favourite.dart';
part 'state/home_state_category.dart';
part 'state/home_state_filter.dart';
part 'state/home_state_locals.dart';
part 'state/home_state_products.dart';
part 'state/home_state_reload.dart';
part 'state/home_state_favourite.dart';
